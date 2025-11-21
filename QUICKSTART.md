# Quick Start Guide

## Prerequisites

- Rust toolchain (2021 edition or later)
- Git
- 8GB+ RAM recommended for running all benchmarks

## Installation

### 1. Clone the Repository

```bash
git clone <repository-url> bigweaver-agent-canary-zeta-hydro-deps
cd bigweaver-agent-canary-zeta-hydro-deps
```

### 2. Verify Setup

```bash
# Check that Rust is installed
rustc --version

# Verify the workspace structure
cargo tree -p benches --depth 0
```

### 3. Build the Benchmarks

```bash
# Build in release mode (required for accurate benchmarks)
cargo build --release -p benches
```

## Running Your First Benchmark

### Simple Identity Benchmark

The identity benchmark is the simplest and fastest to run:

```bash
cargo bench -p benches --bench identity
```

Expected output:
```
Running benches/identity.rs
identity/hydro         time:   [XXX µs XXX µs XXX µs]
identity/timely        time:   [XXX µs XXX µs XXX µs]
```

### String Processing Benchmark

```bash
cargo bench -p benches --bench upcase
```

This benchmark compares string uppercase operations between Hydro and Timely.

### Graph Algorithm Benchmark

```bash
cargo bench -p benches --bench reachability
```

This is the most complex benchmark, using differential-dataflow for graph reachability computation.

## Understanding Benchmark Results

### Output Format

Criterion provides detailed statistics:

```
benchmark_name/variant  time:   [lower_bound estimate upper_bound]
                        change: [lower%      estimate% upper%]
```

- **time**: Execution time with confidence interval
- **change**: Performance change vs. previous run (if available)

### HTML Reports

View detailed results in your browser:

```bash
# After running benchmarks, open the HTML report
open target/criterion/report/index.html
```

Or navigate to: `target/criterion/<benchmark_name>/report/index.html`

## Common Benchmark Commands

### Run All Benchmarks

```bash
# Full benchmark suite (takes several minutes)
cargo bench -p benches
```

### Run Specific Benchmark Categories

```bash
# Dataflow pattern benchmarks
cargo bench -p benches --bench fan_in
cargo bench -p benches --bench fan_out
cargo bench -p benches --bench fork_join

# Join operation benchmarks
cargo bench -p benches --bench join
cargo bench -p benches --bench symmetric_hash_join

# Async/modern pattern benchmarks
cargo bench -p benches --bench futures
```

### Quick Testing Mode

```bash
# Run benchmarks with reduced iterations (faster, less accurate)
cargo bench -p benches --bench identity -- --quick
```

### Warm-up Only Mode

```bash
# Just verify benchmarks work without full measurement
cargo bench -p benches --bench identity -- --warm-up-time 1 --measurement-time 1
```

## Benchmark Workflow

### 1. Baseline Creation

Create a performance baseline before making changes:

```bash
cargo bench -p benches -- --save-baseline my-baseline
```

### 2. Make Changes

Modify code, update dependencies, or change configurations.

### 3. Compare Performance

```bash
cargo bench -p benches -- --baseline my-baseline
```

This shows performance changes relative to your baseline.

### 4. Review Results

Check the HTML reports for detailed analysis:
- Performance trends
- Statistical significance
- Outlier detection

## Troubleshooting

### Build Failures

**Issue**: Compilation errors with dependencies

```bash
# Clean and rebuild
cargo clean
cargo update
cargo build --release -p benches
```

**Issue**: Missing sinktools dependency

```bash
# Verify git access to hydro repository
cargo fetch
```

### Benchmark Failures

**Issue**: Benchmark takes too long

```bash
# Use warm-up mode or quick mode
cargo bench -p benches --bench <name> -- --quick
```

**Issue**: Out of memory

```bash
# Run benchmarks individually instead of all at once
cargo bench -p benches --bench identity
cargo bench -p benches --bench arithmetic
# ... etc
```

### Permission Issues

**Issue**: Cannot write HTML reports

```bash
# Ensure target directory has write permissions
chmod -R u+w target/
```

## Performance Tips

### 1. Optimize System for Benchmarking

```bash
# Disable CPU frequency scaling (Linux)
echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor

# Close unnecessary applications
# Disable background tasks
```

### 2. Use Release Mode Always

Benchmarks in debug mode are not meaningful:

```bash
# Always use cargo bench (not cargo test)
cargo bench -p benches
```

### 3. Run Multiple Times

For reliable results:

```bash
# Run benchmarks 3 times and compare
cargo bench -p benches -- --save-baseline run1
cargo bench -p benches -- --save-baseline run2
cargo bench -p benches -- --save-baseline run3
```

## Next Steps

### Deep Dive into Specific Benchmarks

1. Read benchmark source code in `benches/benches/`
2. Understand the dataflow patterns being tested
3. Modify parameters to test different scenarios

### Extend Benchmarks

1. Add new benchmark files following existing patterns
2. Update `benches/Cargo.toml` with new `[[bench]]` entries
3. Document new benchmarks in README.md

### Integrate with CI/CD

1. Set up automated benchmark runs
2. Track performance over time
3. Alert on regressions

## Useful Resources

- [Criterion.rs User Guide](https://bheisler.github.io/criterion.rs/book/)
- [Hydro Documentation](https://github.com/hydro-project/hydro)
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)

## Example Session

Complete example of benchmarking workflow:

```bash
# 1. Setup
cd bigweaver-agent-canary-zeta-hydro-deps
cargo build --release -p benches

# 2. Create baseline
cargo bench -p benches --bench identity -- --save-baseline before

# 3. Make hypothetical change to code
# ... edit files ...

# 4. Compare performance
cargo bench -p benches --bench identity -- --baseline before

# 5. Review results
open target/criterion/identity/report/index.html

# 6. Run full suite if satisfied
cargo bench -p benches
```

## Getting Help

If you encounter issues:

1. Check this guide for common solutions
2. Review `MIGRATION.md` for dependency details
3. Consult benchmark source code comments
4. Check Hydro/Timely/Differential documentation
5. Review Criterion.rs documentation for benchmarking questions
