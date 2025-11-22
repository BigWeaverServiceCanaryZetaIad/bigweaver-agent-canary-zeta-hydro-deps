# Benchmarking Guide

Comprehensive guide to running, understanding, and analyzing performance benchmarks for Hydro, timely-dataflow, and differential-dataflow.

## Table of Contents

- [Overview](#overview)
- [Running Benchmarks](#running-benchmarks)
- [Understanding Results](#understanding-results)
- [Benchmark Descriptions](#benchmark-descriptions)
- [Performance Comparison](#performance-comparison)
- [Advanced Usage](#advanced-usage)
- [Best Practices](#best-practices)
- [Troubleshooting](#troubleshooting)

## Overview

This repository contains criterion-based benchmarks comparing multiple dataflow framework implementations:

- **DFIR**: Hydro's Dataflow IR implementation
- **Hydroflow**: Hydro's high-level dataflow API
- **Timely**: Timely-dataflow framework
- **Differential**: Differential-dataflow framework

Each benchmark implements the same workload across these frameworks to enable direct performance comparisons.

## Running Benchmarks

### Basic Commands

```bash
# Run all benchmarks
cargo bench -p benches

# Run specific benchmark
cargo bench -p benches --bench identity

# Run with quick mode (fewer samples, faster)
cargo bench -p benches --bench identity -- --quick

# Run specific test within benchmark
cargo bench -p benches --bench identity -- "identity/dfir_rs"

# Run with custom sample size
cargo bench -p benches --bench identity -- --sample-size 50
```

### Benchmark Suite Commands

```bash
# Run all basic operation benchmarks
cargo bench -p benches --bench identity
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench upcase
cargo bench -p benches --bench micro_ops

# Run all pattern benchmarks
cargo bench -p benches --bench fan_in
cargo bench -p benches --bench fan_out
cargo bench -p benches --bench fork_join

# Run all join benchmarks
cargo bench -p benches --bench join
cargo bench -p benches --bench symmetric_hash_join

# Run all complex benchmarks
cargo bench -p benches --bench reachability
cargo bench -p benches --bench words_diamond

# Run async benchmarks
cargo bench -p benches --bench futures
```

### Performance Baseline

Establish a baseline for future comparisons:

```bash
# Save current performance as baseline
cargo bench -p benches -- --save-baseline my-baseline

# Compare against baseline
cargo bench -p benches -- --baseline my-baseline

# List available baselines
ls target/criterion/*/my-baseline/
```

## Understanding Results

### Console Output Format

```
identity/dfir_rs        time:   [1.2345 µs 1.2456 µs 1.2567 µs]
                        change: [-2.5% -1.8% -1.1%] (p = 0.01 < 0.05)
                        Performance has improved.
```

**Breakdown**:
- **Benchmark name**: `identity/dfir_rs`
- **Time values**: [lower bound, mean, upper bound] of 95% confidence interval
- **Change**: Performance change from previous run (if available)
- **P-value**: Statistical significance (< 0.05 is significant)
- **Performance verdict**: Improved/Regressed/No change

### HTML Reports

Detailed visualizations are in `target/criterion/<benchmark>/report/index.html`:

```bash
# Open report in browser
open target/criterion/identity/report/index.html
```

Reports include:
- **PDF plots**: Probability density function of execution times
- **Line charts**: Performance over time
- **Violin plots**: Distribution visualization
- **Statistics table**: Mean, median, std dev, etc.

### Metrics Explained

| Metric | Description |
|--------|-------------|
| **Mean** | Average execution time |
| **Median** | Middle value (50th percentile) |
| **Std Dev** | Variability in measurements |
| **MAD** | Median Absolute Deviation (robust measure of variability) |
| **Throughput** | Operations per second (if applicable) |

## Benchmark Descriptions

### Basic Operations

#### identity
- **Purpose**: Measures overhead of pass-through operations
- **Workload**: Data flowing through without transformation
- **Tests**: DFIR, Hydroflow, Timely, Differential
- **Use case**: Baseline for framework overhead

#### arithmetic
- **Purpose**: Simple arithmetic operations
- **Workload**: Addition, multiplication on streaming data
- **Tests**: DFIR, Hydroflow, Timely
- **Use case**: Computational overhead comparison

#### upcase
- **Purpose**: String transformation operations
- **Workload**: Converting strings to uppercase
- **Tests**: DFIR, Hydroflow, Timely
- **Use case**: String processing performance

#### micro_ops
- **Purpose**: Micro-level operation performance
- **Workload**: Various fine-grained operations
- **Tests**: DFIR, Hydroflow, Timely, Differential
- **Use case**: Low-level performance analysis

### Dataflow Patterns

#### fan_in
- **Purpose**: Multiple input streams merging to one output
- **Workload**: Combining data from multiple sources
- **Tests**: DFIR, Hydroflow, Timely
- **Use case**: Data aggregation patterns

#### fan_out
- **Purpose**: Single input splitting to multiple outputs
- **Workload**: Broadcasting or partitioning data
- **Tests**: DFIR, Hydroflow, Timely
- **Use case**: Data distribution patterns

#### fork_join
- **Purpose**: Parallel processing with fork-join pattern
- **Workload**: Split work, process in parallel, rejoin
- **Tests**: DFIR, Hydroflow, Timely
- **Use case**: Parallel computation patterns

### Join Operations

#### join
- **Purpose**: Basic join operation performance
- **Workload**: Joining two data streams
- **Tests**: DFIR, Hydroflow, Timely, Differential
- **Use case**: Relational join performance

#### symmetric_hash_join
- **Purpose**: Symmetric hash join implementation
- **Workload**: Hash-based join algorithm
- **Tests**: DFIR, Hydroflow
- **Use case**: Specialized join performance

### Complex Algorithms

#### reachability
- **Purpose**: Graph reachability algorithm
- **Workload**: Computing reachable nodes in a graph
- **Data**: 521KB edge data, 38KB reachable node data
- **Tests**: DFIR, Hydroflow, Timely, Differential
- **Use case**: Iterative graph algorithms

#### words_diamond
- **Purpose**: Diamond pattern with word processing
- **Workload**: Complex multi-path processing
- **Data**: 3.7MB word list
- **Tests**: DFIR, Hydroflow, Timely
- **Use case**: Complex dataflow patterns

### Async Operations

#### futures
- **Purpose**: Async/await and futures performance
- **Workload**: Asynchronous operation handling
- **Tests**: DFIR, Hydroflow
- **Use case**: Async programming patterns

## Performance Comparison

### Reading Comparisons

When comparing frameworks, consider:

1. **Absolute Performance**: Raw execution time
2. **Relative Performance**: Ratio between implementations
3. **Scaling Characteristics**: How performance changes with data size
4. **Consistency**: Variance and standard deviation
5. **Resource Usage**: Memory and CPU utilization

### Example Analysis

```
identity/dfir_rs        time:   [1.2456 µs ...]
identity/timely         time:   [2.3567 µs ...]
```

**Analysis**:
- DFIR is ~1.9x faster than Timely for identity operation
- This indicates lower framework overhead in DFIR
- Consider context: Different frameworks have different trade-offs

### Fair Comparisons

For fair comparisons:
- ✅ Run on same hardware
- ✅ Use same Rust version
- ✅ Ensure similar system load
- ✅ Compare multiple runs
- ✅ Consider statistical significance
- ❌ Don't compare different workloads
- ❌ Don't cherry-pick results
- ❌ Don't ignore variance

## Advanced Usage

### Custom Benchmark Parameters

Modify benchmark behavior by editing benchmark files:

```rust
// In any benchmark file
fn criterion_benchmark(c: &mut Criterion) {
    let mut group = c.benchmark_group("my_benchmark");
    
    // Configure sample size
    group.sample_size(100);
    
    // Configure warm-up time
    group.warm_up_time(Duration::from_secs(5));
    
    // Configure measurement time
    group.measurement_time(Duration::from_secs(10));
    
    // Your benchmark code
    group.bench_function("test", |b| {
        b.iter(|| {
            // Code to benchmark
        });
    });
    
    group.finish();
}
```

### Profiling Integration

Profile benchmarks to find hotspots:

```bash
# Build with profiling enabled
cargo build --release -p benches

# Run with profiler (example using perf on Linux)
perf record --call-graph dwarf target/release/deps/identity-*
perf report

# Or use cargo-flamegraph
cargo install flamegraph
cargo flamegraph --bench identity -p benches
```

### Custom Data Sizes

Modify benchmarks to test different data sizes:

```rust
// Example: Test with different input sizes
for size in [100, 1000, 10000, 100000] {
    group.bench_with_input(
        BenchmarkId::new("dfir_rs", size),
        &size,
        |b, &size| {
            b.iter(|| {
                // Benchmark with 'size' elements
            });
        }
    );
}
```

### Comparing Git Commits

Compare performance across commits:

```bash
# Benchmark current commit
cargo bench -p benches -- --save-baseline current

# Checkout different commit
git checkout feature-branch

# Compare against baseline
cargo bench -p benches -- --baseline current
```

## Best Practices

### Before Benchmarking

1. **Close unnecessary applications** to reduce system noise
2. **Disable CPU frequency scaling** if possible:
   ```bash
   # Linux example
   sudo cpupower frequency-set --governor performance
   ```
3. **Ensure consistent system state** (similar background load)
4. **Use release builds** (benchmarks automatically use release)

### During Benchmarking

1. **Don't use the system** for other intensive tasks
2. **Run multiple times** to ensure consistency
3. **Monitor system resources** for anomalies
4. **Save baselines** for important comparisons

### After Benchmarking

1. **Review HTML reports** for detailed analysis
2. **Check statistical significance** before concluding
3. **Document findings** with context
4. **Archive important baselines** for future reference

### Benchmark Development

When creating new benchmarks:

1. **Test all frameworks** when applicable
2. **Use realistic workloads** representative of actual use cases
3. **Document what is being measured**
4. **Include appropriate data sizes**
5. **Add to benchmark matrix** in documentation

## Troubleshooting

### Inconsistent Results

**Symptoms**: Large variance, different results across runs

**Solutions**:
- Close background applications
- Increase sample size: `--sample-size 200`
- Increase measurement time in benchmark code
- Check for thermal throttling
- Run on dedicated hardware

### Benchmarks Too Slow

**Symptoms**: Benchmarks take very long time

**Solutions**:
- Use `--quick` flag for faster runs
- Reduce sample size in code
- Run individual benchmarks instead of all
- Use smaller data sizes for development

### Build Failures

**Symptoms**: Compilation errors in benchmarks

**Solutions**:
- Ensure correct Rust version (check `rust-toolchain.toml`)
- Clean and rebuild: `cargo clean && cargo build -p benches`
- Check dependency versions in `Cargo.toml`
- Verify main repository compatibility

### Missing Dependencies

**Symptoms**: "Cannot find crate" errors

**Solutions**:
- For git dependencies: Ensure internet access
- For path dependencies: Verify paths are correct
- Check `Cargo.toml` configuration
- Run `cargo update`

### Permission Errors

**Symptoms**: Build script cannot create files

**Solutions**:
```bash
# Fix permissions
chmod -R u+w benches/benches/

# Check disk space
df -h

# Review build script output
cargo build -p benches --verbose
```

## Benchmark Matrix

Quick reference of which frameworks are tested in each benchmark:

| Benchmark | DFIR | Hydroflow | Timely | Differential |
|-----------|------|-----------|--------|--------------|
| identity | ✅ | ✅ | ✅ | ✅ |
| arithmetic | ✅ | ✅ | ✅ | ❌ |
| upcase | ✅ | ✅ | ✅ | ❌ |
| micro_ops | ✅ | ✅ | ✅ | ✅ |
| fan_in | ✅ | ✅ | ✅ | ❌ |
| fan_out | ✅ | ✅ | ✅ | ❌ |
| fork_join | ✅ | ✅ | ✅ | ❌ |
| join | ✅ | ✅ | ✅ | ✅ |
| symmetric_hash_join | ✅ | ✅ | ❌ | ❌ |
| reachability | ✅ | ✅ | ✅ | ✅ |
| words_diamond | ✅ | ✅ | ✅ | ❌ |
| futures | ✅ | ✅ | ❌ | ❌ |

## Additional Resources

- **Criterion Documentation**: https://bheisler.github.io/criterion.rs/book/
- **Main Hydro Repository**: Related benchmarking information
- **Timely-Dataflow**: https://github.com/TimelyDataflow/timely-dataflow
- **Differential-Dataflow**: https://github.com/TimelyDataflow/differential-dataflow

## Contributing

When adding new benchmarks:

1. Follow existing benchmark structure
2. Test all applicable frameworks
3. Include documentation in benchmark file
4. Update this guide with new benchmark info
5. Add entry to benchmark matrix
6. Submit PR with comprehensive description

## Summary

This guide covered:
- ✅ Running benchmarks (basic and advanced)
- ✅ Understanding results and metrics
- ✅ Detailed benchmark descriptions
- ✅ Performance comparison techniques
- ✅ Best practices for reliable benchmarking
- ✅ Troubleshooting common issues

For questions or issues, consult [MIGRATION_NOTES.md](MIGRATION_NOTES.md) or contact the Hydro team.
