# Performance Comparison Guide

This guide explains how to use this repository to compare performance between Hydroflow/DFIR, Timely Dataflow, and Differential Dataflow implementations.

## Overview

This repository maintains the complete benchmark suite that was originally part of the main Hydro repository. The benchmarks allow for direct performance comparisons between different dataflow frameworks.

## Quick Start

### Running All Benchmarks

```bash
# Run all benchmarks with default settings
cargo bench -p benches

# Run with more iterations for higher confidence
CRITERION_SAMPLE_SIZE=100 cargo bench -p benches
```

### Running Specific Benchmarks

```bash
# Run a single benchmark
cargo bench -p benches --bench reachability

# Run multiple specific benchmarks
cargo bench -p benches --bench join --bench arithmetic
```

### Running Quick Tests

```bash
# Run benchmarks in quick mode (fewer iterations)
cargo bench -p benches -- --quick
```

## Understanding Benchmark Results

### Output Location

After running benchmarks, Criterion generates detailed reports:
- **HTML Reports**: `target/criterion/<benchmark_name>/report/index.html`
- **Raw Data**: `target/criterion/<benchmark_name>/`
- **Comparison Data**: Stored for historical comparison

### Reading Results

Each benchmark output shows:
1. **Time Measurements**: Mean, median, and standard deviation
2. **Statistical Analysis**: Confidence intervals and outliers
3. **Comparison**: Performance vs. previous runs (if available)
4. **Plots**: Visual representation of performance distribution

Example output:
```
reachability/dfir      time:   [12.345 ms 12.456 ms 12.567 ms]
                       change: [-2.3% -1.1% +0.5%] (p = 0.23 > 0.05)
                       No change in performance detected.

reachability/timely    time:   [15.678 ms 15.789 ms 15.901 ms]
                       change: [-1.5% +0.2% +1.8%] (p = 0.87 > 0.05)
                       No change in performance detected.
```

## Available Benchmarks

### 1. Arithmetic (`arithmetic.rs`)
Compares basic arithmetic operations across frameworks.

**Purpose**: Measures overhead of different dataflow frameworks for simple computations.

**Implementations**:
- DFIR/Hydroflow
- Timely Dataflow

**Usage**:
```bash
cargo bench -p benches --bench arithmetic
```

### 2. Fan-In (`fan_in.rs`)
Tests performance when multiple sources feed into a single operator.

**Purpose**: Measures merge/combine operation efficiency.

**Usage**:
```bash
cargo bench -p benches --bench fan_in
```

### 3. Fan-Out (`fan_out.rs`)
Tests performance when a single source broadcasts to multiple destinations.

**Purpose**: Measures data distribution efficiency.

**Usage**:
```bash
cargo bench -p benches --bench fan_out
```

### 4. Fork-Join (`fork_join.rs`)
Tests fork-join parallel patterns.

**Purpose**: Measures parallel execution and synchronization overhead.

**Usage**:
```bash
cargo bench -p benches --bench fork_join
```

### 5. Futures (`futures.rs`)
Tests async/futures integration performance.

**Purpose**: Measures async runtime integration overhead.

**Usage**:
```bash
cargo bench -p benches --bench futures
```

### 6. Identity (`identity.rs`)
Tests simple data passthrough operations.

**Purpose**: Measures baseline framework overhead.

**Usage**:
```bash
cargo bench -p benches --bench identity
```

### 7. Join (`join.rs`)
Tests relational join operations.

**Purpose**: Measures join algorithm efficiency and data matching performance.

**Usage**:
```bash
cargo bench -p benches --bench join
```

### 8. Micro Operations (`micro_ops.rs`)
Tests individual operator performance in isolation.

**Purpose**: Provides fine-grained performance metrics for specific operators.

**Usage**:
```bash
cargo bench -p benches --bench micro_ops
```

### 9. Reachability (`reachability.rs`)
Tests graph reachability algorithms using real graph data.

**Purpose**: Measures performance on iterative graph algorithms with real-world data.

**Data Files**:
- `reachability_edges.txt`: Graph edge list (~521KB, 55,000+ edges)
- `reachability_reachable.txt`: Expected reachable nodes (~38KB)

**Usage**:
```bash
cargo bench -p benches --bench reachability
```

### 10. Symmetric Hash Join (`symmetric_hash_join.rs`)
Tests symmetric hash join implementation.

**Purpose**: Measures performance of bidirectional streaming joins.

**Usage**:
```bash
cargo bench -p benches --bench symmetric_hash_join
```

### 11. Upcase (`upcase.rs`)
Tests string transformation operations.

**Purpose**: Measures data transformation overhead.

**Usage**:
```bash
cargo bench -p benches --bench upcase
```

### 12. Words Diamond (`words_diamond.rs`)
Tests diamond topology with text processing.

**Purpose**: Measures complex dataflow topology performance with real text data.

**Data Files**:
- `words_alpha.txt`: English word list (~3.7MB, 370,000+ words)

**Usage**:
```bash
cargo bench -p benches --bench words_diamond
```

## Performance Comparison Workflow

### 1. Baseline Measurement

First, establish baseline performance:

```bash
# Run all benchmarks to establish baseline
cargo bench -p benches

# Results are saved in target/criterion/
```

### 2. Code Changes

After making changes to the main Hydro repository:

```bash
# Update dependencies if needed
# (Update paths or versions in benches/Cargo.toml if using the main repo as a dependency)

# Re-run benchmarks
cargo bench -p benches
```

### 3. Compare Results

Criterion automatically compares results with previous runs:
- Green indicators: Performance improvement
- Red indicators: Performance regression
- White indicators: No significant change

### 4. Detailed Analysis

For detailed analysis, open HTML reports:

```bash
# Open the main report
open target/criterion/report/index.html

# Or open specific benchmark report
open target/criterion/reachability/report/index.html
```

## Advanced Usage

### Filtering Benchmarks

```bash
# Run only benchmarks matching a pattern
cargo bench -p benches -- reachability

# Run multiple patterns
cargo bench -p benches -- "join|reachability"
```

### Customizing Benchmark Parameters

Edit the benchmark files to adjust:
- Input data size
- Number of iterations
- Warmup time
- Measurement time

Example from `reachability.rs`:
```rust
criterion
    .measurement_time(Duration::from_secs(10))
    .warm_up_time(Duration::from_secs(3))
    .sample_size(50)
```

### Comparing Specific Implementations

Each benchmark typically has multiple implementations:
```bash
# Results will show comparisons like:
# - reachability/dfir
# - reachability/timely
# - reachability/differential
```

### Saving Baseline for Comparison

```bash
# Save current results as baseline
cargo bench -p benches -- --save-baseline my-baseline

# Compare against saved baseline
cargo bench -p benches -- --baseline my-baseline
```

## Performance Metrics

### Key Metrics to Monitor

1. **Throughput**: Items processed per second
2. **Latency**: Time per operation
3. **Memory Usage**: Peak memory consumption
4. **CPU Usage**: CPU time and utilization
5. **Scalability**: Performance with varying data sizes

### Statistical Significance

Criterion uses statistical analysis to determine:
- Whether performance changes are significant (p < 0.05)
- Confidence intervals for measurements
- Outlier detection and handling

## Troubleshooting

### Benchmarks Taking Too Long

```bash
# Use quick mode for faster iterations
cargo bench -p benches -- --quick

# Or reduce sample size
CRITERION_SAMPLE_SIZE=20 cargo bench -p benches
```

### Inconsistent Results

1. Close other applications to reduce system noise
2. Run on a dedicated machine if possible
3. Use longer measurement times:
   ```bash
   CRITERION_MEASUREMENT_TIME=15 cargo bench -p benches
   ```
4. Check for thermal throttling or power management

### Memory Issues

If benchmarks consume too much memory:
1. Reduce input data size in benchmark files
2. Run benchmarks individually
3. Increase system swap space

## Best Practices

### 1. Consistent Environment

- Run benchmarks on the same machine for comparison
- Close unnecessary applications
- Disable CPU frequency scaling if possible
- Use consistent power settings

### 2. Multiple Runs

- Run benchmarks multiple times to account for variance
- Use sufficient sample sizes (50-100 samples)
- Allow adequate warmup time

### 3. Version Control

- Commit benchmark results with code changes
- Document significant performance changes
- Save baselines for important releases

### 4. Continuous Integration

Consider integrating benchmarks into CI:
```bash
# In CI script
cargo bench -p benches -- --save-baseline ci-baseline
```

## Integration with Main Repository

### Using Local Main Repository

If you have the main Hydro repository locally and want to test changes:

1. Edit `benches/Cargo.toml` to use local path:
   ```toml
   [dev-dependencies]
   dfir_rs = { path = "../../bigweaver-agent-canary-hydro-zeta/dfir_rs", features = ["debugging"] }
   ```

2. Run benchmarks:
   ```bash
   cargo bench -p benches
   ```

### Using Published Versions

To benchmark against published versions:
```toml
[dev-dependencies]
dfir_rs = { version = "0.14.0", features = ["debugging"] }
```

## Interpreting Framework Comparisons

### DFIR/Hydroflow
- **Strengths**: High-level abstractions, compile-time optimizations
- **Use Cases**: Complex dataflow logic, rapid prototyping

### Timely Dataflow
- **Strengths**: Low latency, efficient cyclic dataflows
- **Use Cases**: Streaming computations, iterative algorithms

### Differential Dataflow
- **Strengths**: Incremental computation, efficient updates
- **Use Cases**: Dynamic data, incremental view maintenance

## Reporting Performance Issues

When reporting performance issues, include:
1. Benchmark name and command used
2. Full benchmark output
3. System specifications (CPU, RAM, OS)
4. Rust version (`rustc --version`)
5. Comparison with previous results (if available)

## Resources

- [Criterion.rs Documentation](https://bheisler.github.io/criterion.rs/book/)
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)
- [Hydroflow Documentation](https://hydro.run/)

## Contributing New Benchmarks

To add a new benchmark:

1. Create benchmark file: `benches/benches/new_benchmark.rs`
2. Add to `Cargo.toml`:
   ```toml
   [[bench]]
   name = "new_benchmark"
   harness = false
   ```
3. Implement using Criterion
4. Document the benchmark purpose and methodology
5. Include multiple framework implementations for comparison
6. Add entry to this guide

## Questions?

For questions about:
- **Benchmark Implementation**: Check the benchmark source files
- **Criterion Usage**: See [Criterion.rs book](https://bheisler.github.io/criterion.rs/book/)
- **Performance Issues**: Open an issue in the main repository
