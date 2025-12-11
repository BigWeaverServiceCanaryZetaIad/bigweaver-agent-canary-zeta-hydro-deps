# Performance Comparison Guide

This guide explains how to run performance comparisons between Hydro/DFIR (in the main repository) and timely-dataflow/differential-dataflow (in this repository).

## Overview

Performance benchmarks are split across two repositories:

1. **bigweaver-agent-canary-zeta-hydro-deps** (this repository)
   - Contains benchmarks that compare DFIR against timely and differential-dataflow
   - Includes the external dependencies (timely-master, differential-dataflow-master)
   - Benchmarks: arithmetic, fan_in, fan_out, fork_join, identity, join, reachability, upcase

2. **bigweaver-agent-canary-hydro-zeta** (main repository)
   - Contains DFIR-only benchmarks
   - No external dataflow dependencies
   - Benchmarks: futures, micro_ops, symmetric_hash_join, words_diamond

## Prerequisites

- Rust toolchain (1.70+ recommended)
- Git access to both repositories
- At least 4GB free disk space for dependencies and build artifacts
- Stable system environment for consistent benchmark results

## Setup

### 1. Clone Both Repositories

```bash
# Clone this repository (deps)
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps

# Clone main repository (in a separate directory)
cd ..
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git
```

### 2. Build Dependencies

```bash
# Build deps repository
cd bigweaver-agent-canary-zeta-hydro-deps
cargo build --release

# Build main repository
cd ../bigweaver-agent-canary-hydro-zeta
cargo build --release
```

## Running Benchmarks

### Quick Comparison

To run a complete comparison across both repositories:

```bash
# In deps repository - run timely/differential benchmarks
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench

# In main repository - run DFIR benchmarks
cd ../bigweaver-agent-canary-hydro-zeta
cargo bench -p benches
```

### Specific Benchmark Comparisons

#### Arithmetic Operations

```bash
# Timely vs DFIR comparison
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench --bench arithmetic

# Results: target/criterion/arithmetic/
```

#### Join Operations

```bash
# Timely join benchmark
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench --bench join

# DFIR symmetric hash join benchmark
cd ../bigweaver-agent-canary-hydro-zeta
cargo bench -p benches --bench symmetric_hash_join

# Compare: Both use similar join patterns
```

#### Reachability (Graph Processing)

```bash
# Differential-dataflow reachability
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench --bench reachability

# This uses differential-dataflow's incremental computation
# Results: target/criterion/reachability/
```

## Analyzing Results

### Viewing HTML Reports

Both repositories use criterion which generates HTML reports:

```bash
# Deps repository reports
open bigweaver-agent-canary-zeta-hydro-deps/target/criterion/report/index.html

# Main repository reports
open bigweaver-agent-canary-hydro-zeta/target/criterion/report/index.html
```

### Interpreting Results

Each benchmark report includes:

1. **Time per iteration** - Lower is better
2. **Throughput** - Higher is better
3. **Statistical analysis** - Confidence intervals, outliers
4. **Trend analysis** - Performance changes over multiple runs
5. **Comparison with baseline** - If previously run

### Key Metrics to Compare

When comparing DFIR vs timely/differential:

1. **Latency** - Time to process a single operation
2. **Throughput** - Operations per second
3. **Memory usage** - Via system monitoring tools
4. **Scalability** - Performance with varying input sizes

## Fair Comparison Guidelines

To ensure fair comparisons:

### 1. System Conditions

- Close unnecessary applications
- Disable CPU frequency scaling: `sudo cpupower frequency-set --governor performance`
- Ensure sufficient free memory
- Run on the same hardware
- Minimize background processes

### 2. Benchmark Configuration

Both repositories use:
- Same criterion version (0.5.0)
- Same tokio version (1.29.0)
- Same optimization level (release mode)
- Same number of iterations (criterion default)

### 3. Input Data

- Use identical input sizes
- Use same random seeds where applicable
- Use same data distributions

### 4. Multiple Runs

```bash
# Run each benchmark 3-5 times
for i in {1..5}; do
    cargo bench --bench arithmetic
done
```

Criterion will track performance trends across runs.

## Common Benchmarks Explained

### arithmetic.rs
Compares pipeline throughput for simple arithmetic operations:
- **DFIR**: Uses dfir_syntax! macro
- **Timely**: Uses timely dataflow operators
- **Comparison**: Both implement a 20-stage pipeline of +1 operations

### fan_in.rs / fan_out.rs
Tests merging and splitting data streams:
- **Fan-in**: Multiple sources → single sink
- **Fan-out**: Single source → multiple sinks
- **Metrics**: Throughput and synchronization overhead

### fork_join.rs
Tests split-process-merge pattern:
- Even/odd filtering with multiple stages
- Reunion of split streams
- Generated code (see build.rs)

### identity.rs
Baseline benchmark - data passing with no transformation:
- Measures pure framework overhead
- Minimal computation
- Focus on data movement costs

### join.rs
Stream join operations:
- Co-partitioned key-value streams
- Join coordination overhead
- Memory usage patterns

### reachability.rs
Graph algorithm using differential-dataflow:
- Incremental graph reachability
- Uses actual graph data (reachability_edges.txt)
- Tests incremental computation capabilities

### upcase.rs
String transformation benchmark:
- Simple map operation (uppercase)
- Tests string handling overhead
- Minimal logic complexity

## Advanced Comparisons

### Custom Benchmark Runs

Filter specific benchmark variants:

```bash
# Run only DFIR variants
cargo bench dfir

# Run only timely variants
cargo bench timely

# Run only differential variants
cargo bench differential
```

### Baseline Comparisons

Save a baseline for future comparison:

```bash
# Save current run as baseline
cargo bench --save-baseline my-baseline

# Compare against baseline
cargo bench --baseline my-baseline
```

### Profiling

For deeper analysis:

```bash
# Profile with perf
cargo bench --bench arithmetic --profile-time 10

# Profile with flamegraph
cargo flamegraph --bench arithmetic
```

## Continuous Integration

For automated comparisons:

```bash
#!/bin/bash
# ci-benchmark.sh

set -e

# Run deps benchmarks
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench --no-fail-fast 2>&1 | tee ../deps-bench.log

# Run main benchmarks
cd ../bigweaver-agent-canary-hydro-zeta
cargo bench -p benches --no-fail-fast 2>&1 | tee ../main-bench.log

# Generate comparison report
# (Add custom script to parse and compare results)
```

## Troubleshooting

### Compilation Issues

**Problem**: Cannot find dfir_rs or sinktools

**Solution**: Ensure git credentials are configured and you have access to the main repository:
```bash
git config --global credential.helper store
# Test access
git ls-remote https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git
```

### Inconsistent Results

**Problem**: Benchmark results vary significantly between runs

**Solutions**:
1. Increase sample size: Edit Cargo.toml criterion configuration
2. Ensure system is idle during benchmarks
3. Disable CPU frequency scaling
4. Check for thermal throttling
5. Use more iterations: `cargo bench -- --sample-size 200`

### Memory Issues

**Problem**: Out of memory during benchmarks

**Solutions**:
1. Run benchmarks sequentially: `cargo bench --bench arithmetic`
2. Reduce input sizes (edit benchmark constants)
3. Monitor with: `watch -n 1 free -h`

### Performance Regression

**Problem**: Performance suddenly degraded

**Investigation**:
1. Compare against baseline: `cargo bench --baseline old-version`
2. Check git history for recent changes
3. Profile with flamegraph to identify hotspots
4. Verify compiler version hasn't changed

## Best Practices

1. **Document Your Environment**
   - Record CPU, RAM, OS version
   - Note any system configuration changes
   - Track Rust version used

2. **Version Control**
   - Tag commits used for comparisons
   - Save benchmark results in version control
   - Document significant performance changes

3. **Reproducibility**
   - Use fixed random seeds
   - Document exact commands used
   - Share raw data and analysis scripts

4. **Regular Benchmarking**
   - Run benchmarks before/after major changes
   - Track performance trends over time
   - Set up alerts for regressions

## Resources

- [Criterion.rs Documentation](https://bheisler.github.io/criterion.rs/book/)
- [Timely Dataflow Documentation](https://timelydataflow.github.io/timely-dataflow/)
- [Differential Dataflow Documentation](https://timelydataflow.github.io/differential-dataflow/)
- [DFIR Documentation](https://hydro.run/docs/)

## Contributing

When adding new benchmarks:

1. Implement in both frameworks when possible
2. Use consistent naming: `{pattern}_{framework}`
3. Document expected performance characteristics
4. Include in this comparison guide
5. Ensure reproducibility

## Support

For issues or questions:
- Main repository issues: [bigweaver-agent-canary-hydro-zeta/issues](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta/issues)
- This repository issues: [bigweaver-agent-canary-zeta-hydro-deps/issues](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps/issues)
