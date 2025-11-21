# Benchmark Guide

This guide provides detailed information about the benchmarks in this repository, how to run them, interpret results, and contribute new benchmarks.

## Overview

This repository contains performance comparison benchmarks between:
- **Hydroflow/DFIR** - The Hydro dataflow framework with scheduled and compiled implementations
- **Timely Dataflow** - A low-latency cyclic dataflow computational model
- **Differential Dataflow** - An implementation of differential dataflow computation

## Benchmark Descriptions

### Arithmetic (`arithmetic.rs`)
Tests basic arithmetic operations in a dataflow context. Compares the overhead of each framework for simple computational tasks.

**What it measures:**
- Throughput of arithmetic operations
- Framework overhead for simple computations
- Memory efficiency

### Fan-In (`fan_in.rs`)
Benchmarks patterns where multiple data streams merge into a single stream.

**What it measures:**
- Merge operation efficiency
- Handling of multiple input streams
- Backpressure handling

### Fan-Out (`fan_out.rs`)
Benchmarks patterns where a single data stream is split into multiple outputs.

**What it measures:**
- Split/broadcast operation efficiency
- Data duplication overhead
- Parallel processing capabilities

### Fork-Join (`fork_join.rs`)
Tests the fork-join pattern where data is split, processed in parallel, and merged back together.

**What it measures:**
- Parallel processing efficiency
- Synchronization overhead
- Join operation performance

### Futures (`futures.rs`)
Benchmarks async/await and futures-based operations.

**What it measures:**
- Async operation overhead
- Future composition efficiency
- Runtime scheduling performance

### Identity (`identity.rs`)
Tests the most basic dataflow: passing data through without transformation.

**What it measures:**
- Minimum framework overhead
- Baseline performance
- Memory allocation patterns

### Join (`join.rs`)
Benchmarks relational join operations on data streams.

**What it measures:**
- Join algorithm efficiency
- Memory usage during joins
- Throughput for different data sizes

### Micro Operations (`micro_ops.rs`)
A collection of micro-benchmarks for individual operations like map, filter, fold, etc.

**What it measures:**
- Per-operation overhead
- Composition efficiency
- Optimization effectiveness

### Reachability (`reachability.rs`)
Graph reachability algorithm - a classic dataflow benchmark that tests iteration and fixed-point computation.

**What it measures:**
- Iterative computation efficiency
- Fixed-point detection performance
- Graph algorithm throughput

**Data files:**
- `reachability_edges.txt` - Graph edges
- `reachability_reachable.txt` - Expected reachable nodes

### Symmetric Hash Join (`symmetric_hash_join.rs`)
Tests symmetric hash join implementation, a key operation in stream processing.

**What it measures:**
- Hash join efficiency
- State management overhead
- Scalability with data size

### Upcase (`upcase.rs`)
String transformation benchmark - converts strings to uppercase.

**What it measures:**
- String processing overhead
- Data transformation efficiency
- Memory allocation patterns

### Words Diamond (`words_diamond.rs`)
Diamond-shaped dataflow pattern with word processing.

**What it measures:**
- Complex dataflow pattern efficiency
- String processing at scale
- Multiple path synchronization

**Data files:**
- `words_alpha.txt` - English word list for processing

## Running Benchmarks

### Basic Usage

Run all benchmarks:
```bash
cargo bench -p benchmarks
```

Run a specific benchmark:
```bash
cargo bench -p benchmarks --bench reachability
```

Run benchmarks matching a pattern:
```bash
cargo bench -p benchmarks -- "join"
```

### Advanced Usage

#### Run with specific sample size
```bash
cargo bench -p benchmarks --bench micro_ops -- --sample-size 50
```

#### Save baseline for comparison
```bash
# Run and save current results as baseline
cargo bench -p benchmarks -- --save-baseline main

# Make changes, then compare
cargo bench -p benchmarks -- --baseline main
```

#### Generate verbose output
```bash
cargo bench -p benchmarks --verbose
```

#### Run in release mode with specific optimizations
```bash
RUSTFLAGS="-C target-cpu=native" cargo bench -p benchmarks
```

## Interpreting Results

### Console Output

Criterion provides statistical analysis including:
- **time**: Mean execution time with confidence interval
- **thrpt**: Throughput (if applicable)
- **change**: Performance change compared to previous run (if available)

Example output:
```
reachability/timely     time:   [1.2345 ms 1.2456 ms 1.2567 ms]
                        change: [-2.3456% -1.2345% -0.1234%] (p = 0.03 < 0.05)
                        Performance has improved.
```

### HTML Reports

Detailed HTML reports are generated in `target/criterion/`:
- **index.html**: Overview of all benchmarks
- **{benchmark_name}/report/index.html**: Detailed report for each benchmark
  - Violin plots showing distribution
  - Line charts showing performance over time
  - Statistical analysis
  - Comparison with previous runs

### Performance Comparison

When comparing frameworks:
1. **Lower is better** for time measurements
2. **Higher is better** for throughput
3. Look at the confidence intervals - overlapping intervals may indicate no significant difference
4. Consider the p-value - p < 0.05 typically indicates statistical significance

## Performance Tips

### For Accurate Results

1. **Close unnecessary applications** to reduce system noise
2. **Disable CPU frequency scaling** for consistent results:
   ```bash
   # Linux
   sudo cpupower frequency-set --governor performance
   ```
3. **Run multiple times** and compare results
4. **Use longer sample sizes** for benchmarks with high variance
5. **Warm up the system** by running benchmarks once before measuring

### System Requirements

For best benchmark accuracy:
- At least 8 GB RAM
- Multi-core CPU (4+ cores recommended)
- SSD storage
- Linux or macOS (Windows results may vary)

## Adding New Benchmarks

### Step 1: Create Benchmark File

Create a new file in `benchmarks/benches/my_benchmark.rs`:

```rust
use criterion::{Criterion, criterion_group, criterion_main};
use dfir_rs::dfir_syntax;
use differential_dataflow::input::Input;
// ... other imports

fn benchmark_timely(c: &mut Criterion) {
    c.bench_function("my_benchmark/timely", |b| {
        b.iter(|| {
            // Timely implementation
        });
    });
}

fn benchmark_differential(c: &mut Criterion) {
    c.bench_function("my_benchmark/differential", |b| {
        b.iter(|| {
            // Differential implementation
        });
    });
}

fn benchmark_hydroflow(c: &mut Criterion) {
    c.bench_function("my_benchmark/hydroflow", |b| {
        b.iter(|| {
            // Hydroflow implementation
        });
    });
}

criterion_group!(benches, benchmark_timely, benchmark_differential, benchmark_hydroflow);
criterion_main!(benches);
```

### Step 2: Add to Cargo.toml

Add the benchmark entry to `benchmarks/Cargo.toml`:

```toml
[[bench]]
name = "my_benchmark"
harness = false
```

### Step 3: Test Your Benchmark

```bash
cargo bench -p benchmarks --bench my_benchmark
```

### Step 4: Document

Update this guide with:
- Description of what the benchmark measures
- Any special data files required
- Expected performance characteristics

## Best Practices

### Benchmark Design

1. **Test one thing at a time** - Isolate the operation being measured
2. **Use realistic data** - Synthetic data should reflect real-world patterns
3. **Include warmup** - Allow JIT compilation and caching to stabilize
4. **Measure what matters** - Focus on operations that impact real applications
5. **Compare apples to apples** - Ensure implementations are semantically equivalent

### Code Quality

1. **Document assumptions** - Explain any simplifications or assumptions
2. **Handle errors** - Don't let errors skew results
3. **Use black_box** - Prevent compiler from optimizing away code:
   ```rust
   use criterion::black_box;
   black_box(result);
   ```
4. **Avoid I/O in hot path** - Pre-load data, measure computation only
5. **Be consistent** - Use same patterns across benchmarks

### Performance Analysis

1. **Profile before optimizing** - Use profilers to find bottlenecks
2. **Test on target hardware** - Results vary by CPU, memory, etc.
3. **Consider memory usage** - Not just speed, but also memory footprint
4. **Look for regressions** - Track performance over time
5. **Understand variance** - High variance may indicate measurement issues

## Continuous Benchmarking

### CI/CD Integration

The repository includes a GitHub Actions workflow (`.github/workflows/benchmark.yml`) that:
- Runs benchmarks on schedule (weekly)
- Runs on manual trigger
- Runs on commits with `[ci-bench]` tag
- Stores results as artifacts
- Compares PR performance with main branch

### Triggering CI Benchmarks

#### Manual Trigger
Use GitHub Actions UI to manually run benchmarks.

#### On Commit
Include `[ci-bench]` in commit message:
```bash
git commit -m "Optimize join operation [ci-bench]"
```

#### On Pull Request
Benchmarks automatically run and compare with main branch.

## Troubleshooting

### Common Issues

#### Out of Memory
- Reduce data size
- Increase system memory
- Check for memory leaks

#### High Variance
- Close background applications
- Disable frequency scaling
- Increase sample size
- Check for thermal throttling

#### Compilation Errors
- Ensure rust toolchain is correct: `rustc --version`
- Update dependencies: `cargo update`
- Clean build: `cargo clean`

#### Benchmark Hangs
- Check for deadlocks
- Add timeouts
- Simplify test case

### Getting Help

1. Check existing benchmarks for examples
2. Review Criterion.rs documentation: https://bheisler.github.io/criterion.rs/book/
3. Consult Hydroflow documentation
4. Check Timely/Differential documentation

## Performance Expectations

### Relative Performance

General performance characteristics (actual results depend on workload):

**Latency (single item processing):**
1. Hydroflow/DFIR (optimized, compiled)
2. Timely Dataflow
3. Differential Dataflow (higher overhead due to incremental computation)

**Throughput (batch processing):**
1. Timely Dataflow (highly optimized for throughput)
2. Hydroflow/DFIR (competitive, especially with compilation)
3. Differential Dataflow (optimized for incremental updates)

**Memory Usage:**
1. Hydroflow/DFIR (often more memory efficient)
2. Timely Dataflow
3. Differential Dataflow (maintains state for incremental computation)

### When to Use Each Framework

**Hydroflow/DFIR:**
- Low-latency requirements
- Simple to moderate dataflow complexity
- Memory-constrained environments
- When compilation time is acceptable

**Timely Dataflow:**
- High-throughput batch processing
- Complex cyclic dataflows
- When you need fine-grained control
- Distributed computing scenarios

**Differential Dataflow:**
- Incremental computation
- Changing datasets
- Real-time updates
- When maintaining computation state is valuable

## References

- [Criterion.rs Book](https://bheisler.github.io/criterion.rs/book/)
- [Hydroflow Documentation](https://hydro.run/)
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)
- [Rust Performance Book](https://nnethercote.github.io/perf-book/)

## Contributing

Contributions are welcome! Please:
1. Follow existing benchmark patterns
2. Document your benchmarks thoroughly
3. Test on multiple systems if possible
4. Include performance expectations
5. Update this guide with your benchmark description

## License

Apache-2.0
