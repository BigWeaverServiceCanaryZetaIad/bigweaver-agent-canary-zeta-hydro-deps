# Benchmark Guide

This guide provides detailed information about running and interpreting the timely and differential-dataflow benchmarks in this repository.

## Quick Start

```bash
# Run all benchmarks
cargo bench

# Run a specific benchmark
cargo bench --bench identity

# Run benchmarks with a filter
cargo bench fork
```

## Available Benchmarks

### Core Operation Benchmarks

#### Identity Benchmark (`identity.rs`)
Tests the overhead of passing data through identity operations (no transformation).

**What it measures:**
- Pipeline overhead with multiple stages
- Raw data copying performance
- Hydroflow identity operator performance
- Timely dataflow identity performance

**Usage:**
```bash
cargo bench --bench identity
```

#### Arithmetic Benchmark (`arithmetic.rs`)
Tests arithmetic operations performance.

**What it measures:**
- Simple mathematical operations in pipelines
- Operator chaining overhead

**Usage:**
```bash
cargo bench --bench arithmetic
```

#### Upcase Benchmark (`upcase.rs`)
Tests string transformation performance.

**What it measures:**
- String manipulation operations
- Character-by-character transformations

**Usage:**
```bash
cargo bench --bench upcase
```

### Pattern Benchmarks

#### Fan-In Benchmark (`fan_in.rs`)
Tests merging multiple input streams into one.

**What it measures:**
- Stream merging performance
- Multiple producer handling

**Usage:**
```bash
cargo bench --bench fan_in
```

#### Fan-Out Benchmark (`fan_out.rs`)
Tests splitting one stream into multiple outputs.

**What it measures:**
- Stream splitting performance
- Multiple consumer handling

**Usage:**
```bash
cargo bench --bench fan_out
```

#### Fork-Join Benchmark (`fork_join.rs`)
Tests splitting streams, processing in parallel, and merging results.

**What it measures:**
- Parallel processing patterns
- Stream split-merge overhead

**Usage:**
```bash
cargo bench --bench fork_join
```

### Join and Relational Benchmarks

#### Join Benchmark (`join.rs`)
Tests join operations between two streams.

**What it measures:**
- Binary join performance
- State management for joins

**Usage:**
```bash
cargo bench --bench join
```

#### Symmetric Hash Join Benchmark (`symmetric_hash_join.rs`)
Tests symmetric hash join implementation.

**What it measures:**
- Hash-based join performance
- Memory efficiency of join operations

**Usage:**
```bash
cargo bench --bench symmetric_hash_join
```

### Complex Algorithm Benchmarks

#### Reachability Benchmark (`reachability.rs`)
Tests graph reachability algorithms using differential dataflow.

**What it measures:**
- Iterative computation performance
- Graph algorithm efficiency
- Differential dataflow incremental computation

**Data:** Uses `reachability_edges.txt` and `reachability_reachable.txt`

**Usage:**
```bash
cargo bench --bench reachability
```

#### Words Diamond Benchmark (`words_diamond.rs`)
Tests complex word processing pipelines.

**What it measures:**
- Complex dataflow patterns
- String processing at scale

**Data:** Uses `words_alpha.txt` (370k+ English words)

**Usage:**
```bash
cargo bench --bench words_diamond
```

### Async and System Benchmarks

#### Futures Benchmark (`futures.rs`)
Tests async operation performance.

**What it measures:**
- Async/await overhead
- Future-based dataflow performance

**Usage:**
```bash
cargo bench --bench futures
```

#### Micro-Ops Benchmark (`micro_ops.rs`)
Tests very small operations to measure base overhead.

**What it measures:**
- Minimum operation overhead
- System call costs
- Memory allocation patterns

**Usage:**
```bash
cargo bench --bench micro_ops
```

## Understanding Benchmark Results

### Reading Criterion Output

Criterion provides detailed statistics for each benchmark:

```
identity/hydroflow      time:   [123.45 µs 124.56 µs 125.67 µs]
                        change: [-2.34% -1.23% +0.12%] (p = 0.05 < 0.05)
                        Performance has improved.
```

**Key metrics:**
- **time**: The measured execution time (lower bound, estimate, upper bound)
- **change**: Percentage change from previous run
- **p-value**: Statistical significance (< 0.05 indicates significant change)

### Performance Indicators

- **Green/Improved**: Performance is significantly better than baseline
- **Red/Regressed**: Performance is significantly worse than baseline
- **No change**: Performance is within noise margin

### Noise and Variance

Benchmarks can be affected by:
- System load (other processes)
- CPU frequency scaling
- Memory pressure
- Cache state

For reliable results:
- Close unnecessary applications
- Run multiple times
- Use `--save-baseline` for important comparisons

## Advanced Usage

### Baseline Management

Create named baselines for comparison:

```bash
# Save current performance as baseline
cargo bench -- --save-baseline before-optimization

# Make changes to code...

# Compare against baseline
cargo bench -- --baseline before-optimization
```

### Filtering Benchmarks

Run subsets of benchmarks:

```bash
# All benchmarks with "join" in the name
cargo bench join

# Specific benchmark function within a file
cargo bench --bench identity hydroflow
```

### Benchmark Configuration

Modify benchmark parameters in the source files:

```rust
// Change iteration count
const NUM_INTS: usize = 1_000_000;

// Change operation count
const NUM_OPS: usize = 20;
```

### HTML Reports

Criterion generates detailed HTML reports in `target/criterion/`:

```bash
# Open main report
open target/criterion/report/index.html

# Open specific benchmark report
open target/criterion/identity/report/index.html
```

Reports include:
- Violin plots showing distribution
- Iteration time histograms
- Comparison with previous runs
- Regression analysis

### Profiling Integration

Profile benchmarks for deeper analysis:

```bash
# Using perf (Linux)
cargo bench --bench identity -- --profile-time=10

# Using flamegraph
cargo install flamegraph
cargo flamegraph --bench identity
```

## Performance Tuning Tips

### For Timely Benchmarks

- Adjust worker thread count via environment:
  ```bash
  TIMELY_WORKER_THREADS=4 cargo bench
  ```

- Monitor memory usage:
  ```bash
  /usr/bin/time -v cargo bench --bench reachability
  ```

### For Differential Benchmarks

- Consider batch sizes for incremental computation
- Monitor arrangement sizes
- Check compaction behavior

### General Tips

1. **Warm-up**: Criterion automatically runs warm-up iterations
2. **Sample size**: Increase for more accurate results (slower):
   ```rust
   criterion_group! {
       name = benches;
       config = Criterion::default().sample_size(1000);
       targets = benchmark_identity
   }
   ```
3. **Measurement time**: Increase for longer-running benchmarks:
   ```rust
   config = Criterion::default().measurement_time(Duration::from_secs(60))
   ```

## Troubleshooting

### Benchmark Fails to Compile

Check that sibling repository is present:
```bash
ls -l ../bigweaver-agent-canary-hydro-zeta/
```

### Inconsistent Results

- Ensure system is idle
- Disable CPU frequency scaling (Linux):
  ```bash
  sudo cpupower frequency-set --governor performance
  ```
- Run with higher priority:
  ```bash
  sudo nice -n -20 cargo bench
  ```

### Out of Memory

Reduce benchmark data size:
- Decrease `NUM_INTS`
- Reduce input file size
- Run benchmarks individually

## CI/CD Integration

Example GitHub Actions workflow:

```yaml
name: Benchmarks

on:
  pull_request:
    paths:
      - 'benches/**'
      - 'Cargo.toml'

jobs:
  benchmark:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
        with:
          path: bigweaver-agent-canary-zeta-hydro-deps
      
      - uses: actions/checkout@v3
        with:
          repository: owner/bigweaver-agent-canary-hydro-zeta
          path: bigweaver-agent-canary-hydro-zeta
      
      - uses: actions-rs/toolchain@v1
        with:
          toolchain: stable
      
      - name: Run benchmarks
        working-directory: bigweaver-agent-canary-zeta-hydro-deps
        run: cargo bench --no-fail-fast
      
      - name: Upload results
        uses: actions/upload-artifact@v3
        with:
          name: benchmark-results
          path: bigweaver-agent-canary-zeta-hydro-deps/target/criterion/
```

## References

- [Criterion.rs Documentation](https://bheisler.github.io/criterion.rs/book/)
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)
- [Rust Performance Book](https://nnethercote.github.io/perf-book/)
