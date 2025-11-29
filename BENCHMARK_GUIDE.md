# Benchmark Guide

This guide provides detailed information about running and interpreting the timely and differential-dataflow benchmarks in this repository.

## Table of Contents

- [Quick Start](#quick-start)
- [Available Benchmarks](#available-benchmarks)
- [Running Benchmarks](#running-benchmarks)
- [Understanding Results](#understanding-results)
- [Benchmark Details](#benchmark-details)
- [Performance Analysis](#performance-analysis)
- [Troubleshooting](#troubleshooting)

## Quick Start

```bash
# Clone the repository
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps
cd bigweaver-agent-canary-zeta-hydro-deps

# Run all benchmarks
cargo bench -p benches

# Run a specific benchmark
cargo bench -p benches --bench micro_ops
```

## Available Benchmarks

### 1. Arithmetic (`arithmetic.rs`)
Tests basic arithmetic operations performance across different frameworks.

**Measures:**
- Addition, subtraction, multiplication operations
- Pipeline efficiency
- Data throughput

**Run:**
```bash
cargo bench -p benches --bench arithmetic
```

### 2. Fan-In (`fan_in.rs`)
Benchmarks fan-in patterns where multiple sources converge to a single point.

**Measures:**
- Multi-source aggregation
- Stream merging efficiency
- Backpressure handling

**Run:**
```bash
cargo bench -p benches --bench fan_in
```

### 3. Fan-Out (`fan_out.rs`)
Benchmarks fan-out patterns where a single source distributes to multiple destinations.

**Measures:**
- Broadcasting efficiency
- Multiple consumer handling
- Distribution overhead

**Run:**
```bash
cargo bench -p benches --bench fan_out
```

### 4. Fork-Join (`fork_join.rs`)
Tests fork-join patterns with parallel execution and synchronization.

**Measures:**
- Parallel execution efficiency
- Join synchronization overhead
- Work distribution

**Run:**
```bash
cargo bench -p benches --bench fork_join
```

### 5. Futures (`futures.rs`)
Benchmarks async operation handling with futures.

**Measures:**
- Async execution overhead
- Future composition performance
- Task scheduling efficiency

**Run:**
```bash
cargo bench -p benches --bench futures
```

### 6. Identity (`identity.rs`)
Tests the simplest possible pipeline (identity transformation).

**Measures:**
- Baseline framework overhead
- Pipeline setup cost
- Data passing efficiency

**Run:**
```bash
cargo bench -p benches --bench identity
```

### 7. Join (`join.rs`)
Benchmarks join operations between two streams.

**Measures:**
- Join algorithm efficiency
- State management overhead
- Memory usage patterns

**Run:**
```bash
cargo bench -p benches --bench join
```

### 8. Micro Operations (`micro_ops.rs`)
Tests individual micro-operations to isolate performance characteristics.

**Measures:**
- Individual operator costs
- Composition overhead
- Fine-grained performance metrics

**Run:**
```bash
cargo bench -p benches --bench micro_ops
```

### 9. Reachability (`reachability.rs`)
Graph reachability algorithm benchmark using real graph data.

**Measures:**
- Iterative algorithm performance
- Fixed-point computation
- Graph processing efficiency

**Data Files:**
- `reachability_edges.txt` - Graph edges
- `reachability_reachable.txt` - Expected reachable nodes

**Run:**
```bash
cargo bench -p benches --bench reachability
```

### 10. Symmetric Hash Join (`symmetric_hash_join.rs`)
Benchmarks symmetric hash join implementation.

**Measures:**
- Hash join performance
- Symmetric algorithm efficiency
- State management

**Run:**
```bash
cargo bench -p benches --bench symmetric_hash_join
```

### 11. Upcase (`upcase.rs`)
String uppercase transformation benchmark.

**Measures:**
- String processing throughput
- Map operation efficiency
- Data transformation overhead

**Run:**
```bash
cargo bench -p benches --bench upcase
```

### 12. Words Diamond (`words_diamond.rs`)
Diamond-pattern word processing benchmark.

**Measures:**
- Complex dataflow patterns
- Multiple path efficiency
- Word processing throughput

**Data Files:**
- `words_alpha.txt` - English word list (370K+ words)

**Run:**
```bash
cargo bench -p benches --bench words_diamond
```

## Running Benchmarks

### Basic Usage

```bash
# Run all benchmarks
cargo bench -p benches

# Run specific benchmark
cargo bench -p benches --bench <benchmark_name>

# Run benchmark with filters
cargo bench -p benches --bench micro_ops -- filter_name

# Save baseline for comparison
cargo bench -p benches --bench micro_ops -- --save-baseline my-baseline

# Compare against baseline
cargo bench -p benches --bench micro_ops -- --baseline my-baseline
```

### Advanced Options

```bash
# Increase sample size for more accurate results
cargo bench -p benches --bench micro_ops -- --sample-size 1000

# Reduce warm-up time
cargo bench -p benches --bench micro_ops -- --warm-up-time 1

# Increase measurement time
cargo bench -p benches --bench micro_ops -- --measurement-time 10

# Run with specific number of samples
cargo bench -p benches --bench micro_ops -- --nresamples 10000
```

### Performance Profiling

```bash
# Build with profiling symbols
cargo bench -p benches --bench micro_ops -- --profile-time=5

# Use flamegraph for profiling
cargo install flamegraph
cargo bench -p benches --bench micro_ops --no-run
sudo flamegraph target/release/deps/micro_ops-* --bench
```

## Understanding Results

### Criterion Output

```
arithmetic/hydro/small  time:   [10.234 µs 10.567 µs 10.912 µs]
                        change: [-2.5234% +0.3421% +3.1234%] (p = 0.52 > 0.05)
                        No change in performance detected.
Found 2 outliers among 100 measurements (2.00%)
  2 (2.00%) high mild
```

**Key Metrics:**
- **time**: [lower_bound estimate upper_bound] - 95% confidence interval
- **change**: Percentage change from previous run
- **p-value**: Statistical significance (p < 0.05 indicates significant change)
- **outliers**: Measurements outside expected distribution

### HTML Reports

Open `target/criterion/report/index.html` in a browser to see:
- Detailed statistical analysis
- Performance graphs and charts
- Historical trend data
- PDF plots for each benchmark
- Comparison tables

## Benchmark Details

### Input Sizes

Benchmarks typically test multiple input sizes:
- **small**: ~100-1,000 elements
- **medium**: ~10,000-100,000 elements
- **large**: ~1,000,000+ elements

### Framework Comparisons

Most benchmarks compare:
1. **Hydro (dfir_rs)**: The Hydro framework implementation
2. **Timely**: Pure timely dataflow implementation
3. **Differential**: Differential dataflow implementation (for incremental benchmarks)

### Measurement Strategy

- **Warm-up**: 3 seconds default to stabilize caches
- **Measurement**: 5 seconds default for accurate timing
- **Samples**: 100 iterations for statistical validity
- **Resampling**: 100,000 bootstrap resamples for confidence intervals

## Performance Analysis

### Comparing Frameworks

```bash
# Run all frameworks for a benchmark
cargo bench -p benches --bench arithmetic

# Compare results
open target/criterion/arithmetic/report/index.html
```

Look for:
- Relative performance differences
- Scaling behavior with input size
- Memory usage patterns
- Throughput metrics

### Identifying Regressions

```bash
# Save current performance as baseline
cargo bench -p benches -- --save-baseline main

# After making changes, compare
cargo bench -p benches -- --baseline main

# Review changes
open target/criterion/report/index.html
```

### Optimization Workflow

1. **Baseline**: Run benchmarks and save as baseline
2. **Optimize**: Make code changes
3. **Compare**: Run benchmarks against baseline
4. **Analyze**: Review reports for improvements
5. **Iterate**: Repeat until performance goals met

## Troubleshooting

### Compilation Issues

```bash
# Clean build artifacts
cargo clean

# Update dependencies
cargo update

# Check for version conflicts
cargo tree -p benches
```

### Runtime Errors

```bash
# Run with verbose output
RUST_BACKTRACE=1 cargo bench -p benches --bench micro_ops

# Check data files exist
ls -lh benches/benches/*.txt
```

### Inconsistent Results

```bash
# Increase sample size
cargo bench -p benches --bench micro_ops -- --sample-size 1000

# Increase measurement time
cargo bench -p benches --bench micro_ops -- --measurement-time 10

# Check system load
top  # Ensure no other processes consuming resources
```

### Performance Issues

If benchmarks run too slowly:
1. Reduce input sizes in benchmark code
2. Decrease sample size: `--sample-size 50`
3. Reduce measurement time: `--measurement-time 3`
4. Run specific benchmarks instead of all

### Memory Issues

If benchmarks run out of memory:
1. Reduce input sizes for large benchmarks
2. Run benchmarks individually
3. Increase system swap space
4. Use release mode: `cargo bench` (already default)

## Best Practices

### Before Benchmarking

1. **Close other applications** to reduce system noise
2. **Disable frequency scaling** for consistent CPU performance
3. **Use consistent power settings** (plugged in for laptops)
4. **Run multiple times** to ensure consistency
5. **Document system configuration** for reproducibility

### During Benchmarking

1. **Don't use the computer** while benchmarks run
2. **Monitor system resources** for anomalies
3. **Check for thermal throttling** on extended runs
4. **Save baselines** before making changes

### After Benchmarking

1. **Review HTML reports** for detailed analysis
2. **Check for outliers** that might indicate issues
3. **Compare with historical data** for trends
4. **Document findings** in commit messages
5. **Share results** with the team

## Contributing

When adding new benchmarks:

1. Follow existing benchmark structure
2. Include both framework implementations
3. Test multiple input sizes
4. Document the benchmark purpose
5. Update this guide with new benchmark details

## References

- [Criterion.rs Documentation](https://bheisler.github.io/criterion.rs/book/)
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)
- [Hydro Project](https://github.com/hydro-project/hydro)

## Support

For issues or questions:
1. Check this guide
2. Review benchmark source code comments
3. Check GitHub issues
4. Open a new issue with benchmark results and system info
