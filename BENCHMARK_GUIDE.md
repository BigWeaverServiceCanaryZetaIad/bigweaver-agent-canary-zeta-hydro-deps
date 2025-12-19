# Benchmark Guide

Complete guide for running and comparing benchmarks between Hydro, Timely, and Differential Dataflow implementations.

## Quick Start

### Run All Benchmarks
```bash
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench -p benches
```

### Run Specific Implementation
```bash
# Timely dataflow benchmarks only
cargo bench -p benches -- timely

# Differential dataflow benchmarks only
cargo bench -p benches -- differential

# Hydro DFIR benchmarks only
cargo bench -p benches -- dfir_rs
```

### Run Individual Benchmark
```bash
# Run a specific benchmark file
cargo bench -p benches --bench micro_ops
cargo bench -p benches --bench words_diamond
cargo bench -p benches --bench symmetric_hash_join
```

## Benchmark Categories

### Complete Implementation Coverage

All 12 benchmarks now include timely and/or differential-dataflow implementations:

| Benchmark | Timely | Differential | Hydro DFIR | Description |
|-----------|--------|--------------|------------|-------------|
| arithmetic | ✅ | | ✅ | Pipeline arithmetic operations |
| fan_in | ✅ | | ✅ | Multiple inputs to single output |
| fan_out | ✅ | | ✅ | Single input to multiple outputs |
| fork_join | ✅ | | ✅ | Fork-join pattern with code generation |
| futures | ✅ | | ✅ | Futures/async operations |
| identity | ✅ | | ✅ | Identity transformation |
| join | ✅ | | ✅ | Join operations |
| micro_ops | ✅ | | ✅ | Micro-operations (map, filter, etc.) |
| reachability | ✅ | ✅ | ✅ | Graph reachability |
| symmetric_hash_join | ✅ | ✅ | ✅ | Symmetric hash join |
| upcase | ✅ | | ✅ | String uppercase transformation |
| words_diamond | ✅ | | ✅ | Diamond pattern word processing |

## Understanding Benchmark Results

### Criterion Output

Criterion provides several metrics for each benchmark:

```
test_name              time:   [123.45 µs 125.67 µs 127.89 µs]
                       change: [-2.3456% +1.2345% +4.5678%] (p = 0.12 > 0.05)
                       No change in performance detected.
```

- **time**: Lower bound, estimate, upper bound (95% confidence interval)
- **change**: Performance change from previous run
- **p-value**: Statistical significance (p < 0.05 indicates significant change)

### HTML Reports

Open the detailed HTML reports:
```bash
# View all benchmark results
open target/criterion/report/index.html

# View specific benchmark
open target/criterion/micro_ops/report/index.html
```

HTML reports include:
- Performance graphs
- Statistical analysis
- Historical comparisons
- Detailed timing distributions

## Performance Comparison Workflow

### 1. Baseline Benchmarks

First, establish a baseline for all implementations:

```bash
# Run all benchmarks to establish baseline
cargo bench -p benches

# Results saved to target/criterion/
```

### 2. Compare Implementations

Run specific implementations to compare:

```bash
# Compare Hydro vs Timely for micro_ops
cargo bench -p benches --bench micro_ops -- "dfir_rs|timely"

# Compare all implementations of symmetric_hash_join
cargo bench -p benches --bench symmetric_hash_join
```

### 3. Cross-Repository Comparison

Compare with the main Hydro repository:

```bash
# In this repository (timely/differential implementations)
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench -p benches --bench micro_ops

# In main repository (Hydro-native only)
cd ../bigweaver-agent-canary-hydro-zeta
cargo bench -p benches --bench micro_ops

# Compare HTML reports from both
```

### 4. Analyze Results

Key metrics to compare:
- **Throughput**: Operations per second
- **Latency**: Time per operation
- **Overhead**: Framework overhead vs raw implementation
- **Scalability**: Performance with different data sizes

## Benchmark Details

### arithmetic.rs
Tests pipeline performance with arithmetic operations:
- **Raw**: Direct vector operations (baseline)
- **Iterator**: Rust iterator chains
- **Timely**: Timely dataflow operators
- **Hydro**: DFIR surface syntax

### micro_ops.rs
Tests individual operator performance:
- **identity**: Pass-through operation
- **map**: Transformation operation
- **flat_map**: One-to-many transformation
- **filter**: Selective pass-through

Implementations: Hydro DFIR and Timely

### words_diamond.rs
Tests diamond pattern (fan-out + fan-in):
- Read words from file
- Branch 1: Format strings (hi/bye)
- Branch 2: Filter by length
- Merge: Count total characters

Implementations: Multiple iterator strategies, Timely, and Hydro

### symmetric_hash_join.rs
Tests join operation performance:
- **no_match**: No overlapping keys
- **match_keys_diff_values**: All keys match, different values
- **match_keys_same_values**: Complete duplicates
- **zipf_keys**: Realistic key distribution

Implementations: Hydro compiled, Timely, and Differential

### reachability.rs
Tests graph algorithms with large dataset:
- Load graph edges (~10K edges)
- Compute reachability from root node
- Compare iterative and fixed-point approaches

Implementations: Hydro scheduled, Timely, and Differential

### futures.rs
Tests async/futures performance:
- **immediately_available**: Futures that resolve immediately
- **delayed**: Futures requiring waking

Implementations: Hydro DFIR and Timely (overhead comparison)

## Advanced Usage

### Custom Benchmark Configuration

Modify benchmark parameters in the source files:

```rust
// In micro_ops.rs
const NUM_INTS: usize = 10_000;  // Adjust data size

// In words_diamond.rs
const OUTPUT: usize = 5_123_595;  // Expected output
```

### Save Baseline for Comparison

```bash
# Save current results as baseline
cargo bench -p benches -- --save-baseline my_baseline

# Compare against saved baseline
cargo bench -p benches -- --baseline my_baseline
```

### Filter Benchmarks by Pattern

```bash
# Run all "identity" benchmarks
cargo bench -p benches -- identity

# Run all "timely" implementations
cargo bench -p benches -- timely

# Run specific benchmark variants
cargo bench -p benches -- "micro/ops/timely"
```

## Troubleshooting

### Long Build Times

Timely and differential-dataflow are large dependencies:
- First build may take 5-10 minutes
- Use `cargo build --release -p benches` to check for errors first
- Incremental builds are much faster

### Benchmark Failures

If benchmarks fail to run:
```bash
# Check compilation
cargo check -p benches

# Run with backtrace for errors
RUST_BACKTRACE=1 cargo bench -p benches --bench micro_ops
```

### Data File Issues

If benchmarks can't find data files:
```bash
# Verify data files exist
ls benches/benches/*.txt

# Run from repository root
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench -p benches
```

## Best Practices

### 1. Consistent Environment
- Close other applications during benchmarking
- Avoid running on battery power (laptops)
- Use consistent CPU governor settings

### 2. Multiple Runs
- Run benchmarks multiple times for reliability
- Criterion automatically runs multiple iterations
- Use `--measurement-time` for longer runs:
  ```bash
  cargo bench -p benches -- --measurement-time 60
  ```

### 3. Warm-up
- First benchmark run may be slower (JIT, caching)
- Consider discarding first run results
- Criterion includes automatic warm-up

### 4. Statistical Significance
- Look for p-values < 0.05 for significant changes
- Small changes (< 5%) may not be meaningful
- Consider measurement noise and variance

## Contributing New Benchmarks

When adding new benchmarks:

1. **Create benchmark file** in `benches/benches/`:
   ```rust
   use criterion::{Criterion, criterion_group, criterion_main};
   use timely::dataflow::operators::*;
   
   fn benchmark_timely(c: &mut Criterion) {
       c.bench_function("my_bench/timely", |b| {
           b.iter(|| {
               timely::example(|scope| {
                   // Your benchmark code
               });
           });
       });
   }
   
   criterion_group!(my_bench, benchmark_timely);
   criterion_main!(my_bench);
   ```

2. **Add to Cargo.toml**:
   ```toml
   [[bench]]
   name = "my_bench"
   harness = false
   ```

3. **Update documentation**:
   - Add entry to README.md
   - Update MIGRATION.md if applicable
   - Include usage examples

4. **Test the benchmark**:
   ```bash
   cargo bench -p benches --bench my_bench
   ```

## References

- [Criterion.rs Documentation](https://bheisler.github.io/criterion.rs/book/)
- [Timely Dataflow Book](https://timelydataflow.github.io/timely-dataflow/)
- [Differential Dataflow Guide](https://timelydataflow.github.io/differential-dataflow/)
- [Hydro Documentation](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)
