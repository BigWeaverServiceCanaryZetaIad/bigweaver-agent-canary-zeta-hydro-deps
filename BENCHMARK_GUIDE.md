# Benchmark Guide

This guide provides comprehensive information for running, analyzing, and comparing the performance benchmarks in this repository.

## Table of Contents

- [Quick Reference](#quick-reference)
- [Benchmark Overview](#benchmark-overview)
- [Running Benchmarks](#running-benchmarks)
- [Analyzing Results](#analyzing-results)
- [Performance Comparison](#performance-comparison)
- [Benchmark Descriptions](#benchmark-descriptions)
- [Best Practices](#best-practices)
- [Troubleshooting](#troubleshooting)

## Quick Reference

```bash
# Run all benchmarks
cargo bench

# Run specific benchmark
cargo bench --bench reachability

# Run with custom sample size
cargo bench -- --sample-size 100

# Run with specific measurement time
cargo bench -- --measurement-time 10

# View HTML reports
open target/criterion/report/index.html
```

## Benchmark Overview

This repository contains 12 benchmarks organized into three categories:

### 1. Dataflow Pattern Benchmarks
Test fundamental dataflow patterns and operations:
- `arithmetic` - Pipeline arithmetic operations
- `fan_in` - Stream merging patterns
- `fan_out` - Stream splitting patterns
- `fork_join` - Parallel execution patterns
- `identity` - Identity transformations (baseline)
- `join` - Stream join operations
- `symmetric_hash_join` - Hash-based joins

### 2. Application Benchmarks
Test real-world application scenarios:
- `reachability` - Graph reachability algorithms using differential dataflow
- `words_diamond` - Word processing in diamond dataflow patterns
- `upcase` - String transformation operations

### 3. System Benchmarks
Test system-level operations:
- `futures` - Asynchronous futures-based operations
- `micro_ops` - Micro-level operation performance

Each benchmark typically includes multiple implementation variants for comparison:
- **dfir_rs/compiled** - Hydro's compiled dataflow
- **dfir_rs/interpreted** - Hydro's interpreted dataflow
- **timely** - Timely Dataflow implementation
- **differential** - Differential Dataflow implementation (where applicable)
- **baseline** - Raw/iterator implementations for reference

## Running Benchmarks

### Basic Usage

```bash
# Run all benchmarks (recommended first run)
cargo bench

# Run specific benchmark
cargo bench --bench arithmetic

# Run multiple specific benchmarks
cargo bench --bench arithmetic --bench join

# Run benchmarks matching a pattern
cargo bench arithmetic
```

### Advanced Options

```bash
# Control sample size (number of times each benchmark runs)
cargo bench -- --sample-size 50

# Control measurement time (seconds per benchmark)
cargo bench -- --measurement-time 10

# Control warm-up time (seconds)
cargo bench -- --warm-up-time 3

# Disable HTML report generation (faster)
cargo bench -- --noplot

# Save baseline for comparison
cargo bench -- --save-baseline initial

# Compare against saved baseline
cargo bench -- --baseline initial

# Run specific benchmark variant
cargo bench --bench arithmetic -- compiled

# List all available benchmarks
cargo bench -- --list
```

### Environment Configuration

For reproducible results:

```bash
# Set consistent CPU frequency (Linux)
sudo cpupower frequency-set -g performance

# Run benchmarks
cargo bench

# Restore power saving
sudo cpupower frequency-set -g powersave
```

## Analyzing Results

### HTML Reports

Criterion generates detailed HTML reports:

```bash
# After running benchmarks
open target/criterion/report/index.html  # macOS
xdg-open target/criterion/report/index.html  # Linux
start target/criterion/report/index.html  # Windows
```

Reports include:
- **Summary statistics** (mean, median, std dev)
- **Performance plots** over time
- **PDF and histogram** of measurements
- **Comparison charts** (if baseline exists)

### Command-Line Output

Benchmark results are also printed to stdout:

```
arithmetic/dfir_rs/compiled
                        time:   [1.2345 ms 1.2456 ms 1.2567 ms]
                        change: [-2.3% -1.5% -0.7%] (p = 0.00 < 0.05)
                        Performance has improved.
```

Understanding the output:
- **time:** `[lower_bound estimate upper_bound]` - 95% confidence interval
- **change:** Performance change vs. previous run (if available)
- **p-value:** Statistical significance (< 0.05 means significant change)

### Data Files

Criterion stores raw data in `target/criterion/<benchmark>/<variant>/`:
- `estimates.json` - Statistical estimates
- `sample.json` - Raw measurement data
- `tukey.json` - Outlier analysis
- `base/` - Baseline data (if saved)

## Performance Comparison

### Comparing Implementations

To compare different implementations within a benchmark:

1. **Run the benchmark:**
   ```bash
   cargo bench --bench arithmetic
   ```

2. **View the HTML report:**
   - Navigate to `target/criterion/report/index.html`
   - Click on the benchmark name
   - Compare the violin plots and statistics for each variant

3. **Key metrics to compare:**
   - **Mean time** - Average performance
   - **Standard deviation** - Consistency
   - **Throughput** - Operations per second (if reported)

### Comparing Across Hydro Versions

To compare performance with the main Hydro repository:

#### Method 1: Git Dependency Version

1. **Update Cargo.toml to specific Hydro commit:**
   ```toml
   [dev-dependencies]
   dfir_rs = { git = "https://github.com/hydro-project/hydro", rev = "<commit-sha>", features = [ "debugging" ] }
   ```

2. **Run benchmarks and save baseline:**
   ```bash
   cargo bench -- --save-baseline hydro-v1
   ```

3. **Update to new commit:**
   ```toml
   dfir_rs = { git = "https://github.com/hydro-project/hydro", rev = "<new-commit-sha>", features = [ "debugging" ] }
   ```

4. **Run benchmarks and compare:**
   ```bash
   cargo update -p dfir_rs
   cargo bench -- --baseline hydro-v1
   ```

5. **View comparison report:**
   ```bash
   open target/criterion/report/index.html
   ```

#### Method 2: Manual Comparison

1. **Run benchmarks in hydro-deps:**
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps
   cargo bench 2>&1 | tee results-deps.txt
   cp -r target/criterion /tmp/criterion-deps
   ```

2. **If benchmarks exist in main Hydro repo, run them:**
   ```bash
   cd /path/to/hydro
   cargo bench 2>&1 | tee results-hydro.txt
   cp -r target/criterion /tmp/criterion-hydro
   ```

3. **Compare the results:**
   - Review the mean times in both result files
   - Compare HTML reports side-by-side
   - Calculate percentage differences

4. **Document findings:**
   ```markdown
   ## Performance Comparison
   
   **Date:** 2025-11-30
   **Hardware:** Intel i7-9700K, 16GB RAM, Ubuntu 22.04
   **Hydro Commit:** abc123
   
   | Benchmark | Hydro-deps | Main Hydro | Difference |
   |-----------|------------|------------|------------|
   | arithmetic/compiled | 1.23 ms | 1.25 ms | -1.6% |
   | reachability | 45.6 ms | 44.2 ms | +3.2% |
   ```

### Comparing Across Time

Track performance over time:

```bash
# Initial baseline
cargo bench -- --save-baseline initial

# After changes
cargo bench -- --baseline initial

# Save new baseline
cargo bench -- --save-baseline after-optimization

# Compare two baselines (requires custom scripting)
# Or view historical data in target/criterion/<benchmark>/history/
```

## Benchmark Descriptions

### arithmetic

Tests arithmetic operations in dataflow pipelines with multiple sequential operations.

**Implementations:**
- `pipeline` - Thread-based pipeline
- `raw` - Raw vector operations
- `iter` - Iterator chains
- `iter-collect` - Iterator with intermediate collections
- `dfir_rs/compiled` - Hydro compiled
- `dfir_rs/interpreted` - Hydro interpreted
- `timely` - Timely Dataflow

**Key metrics:** Throughput (ops/sec), latency per operation

### fan_in

Tests patterns where multiple input streams merge into one.

**Implementations:**
- `dfir_rs/compiled`
- `dfir_rs/interpreted`
- `timely`

**Key metrics:** Merge overhead, throughput

### fan_out

Tests patterns where one stream splits into multiple outputs.

**Implementations:**
- `dfir_rs/compiled`
- `dfir_rs/interpreted`
- `timely`

**Key metrics:** Split overhead, throughput

### fork_join

Tests parallel fork-join execution patterns.

**Implementations:**
- `dfir_rs/compiled`
- `dfir_rs/interpreted`
- `timely`

**Key metrics:** Parallel efficiency, synchronization overhead

### futures

Tests asynchronous futures-based operations.

**Implementations:**
- `dfir_rs/compiled`
- `tokio/channels`

**Key metrics:** Async overhead, throughput

### identity

Tests identity transformations (minimal work, baseline for overhead).

**Implementations:**
- `dfir_rs/compiled`
- `dfir_rs/interpreted`
- `timely`

**Key metrics:** Framework overhead

### join

Tests join operations between two dataflows.

**Implementations:**
- `dfir_rs/compiled`
- `dfir_rs/interpreted`
- `timely`
- `differential`

**Key metrics:** Join throughput, memory usage patterns

### micro_ops

Tests micro-level operations for detailed performance analysis.

**Implementations:**
- Various micro-operations

**Key metrics:** Individual operation costs

### reachability

Tests graph reachability algorithms using differential dataflow.

**Data:** 55,008 edges, 7,855 reachable nodes

**Implementations:**
- `differential`
- `dfir_rs` (if implemented)

**Key metrics:** Convergence time, memory usage

### symmetric_hash_join

Tests symmetric hash join algorithms.

**Implementations:**
- `dfir_rs/compiled`
- `differential`

**Key metrics:** Join throughput, hash efficiency

### upcase

Tests string transformation operations (uppercase conversion).

**Implementations:**
- `dfir_rs/compiled`
- `dfir_rs/interpreted`
- `timely`

**Key metrics:** String processing throughput

### words_diamond

Tests word processing in diamond dataflow patterns.

**Data:** 370,104 words from English dictionary

**Implementations:**
- `dfir_rs/compiled`
- `dfir_rs/interpreted`

**Key metrics:** Word processing throughput, pattern efficiency

## Best Practices

### 1. Minimize System Noise

```bash
# Close unnecessary applications
# Stop background services
# Disable automatic updates

# Linux: Use performance CPU governor
sudo cpupower frequency-set -g performance

# Check system load
uptime
top
```

### 2. Ensure Consistent Environment

- Use the same machine for comparisons
- Run at similar times of day (avoid thermal variations)
- Ensure adequate cooling (avoid thermal throttling)
- Use consistent power settings (plugged in vs. battery)

### 3. Run Multiple Times

```bash
# Run benchmarks multiple times to verify consistency
for i in {1..3}; do
    echo "Run $i"
    cargo bench 2>&1 | tee benchmark-run-$i.txt
done
```

### 4. Save Baselines

```bash
# Before major changes
cargo bench -- --save-baseline before-feature-x

# After changes
cargo bench -- --baseline before-feature-x
```

### 5. Document Everything

Create a benchmark log:
```markdown
## Benchmark Log

### 2025-11-30: Initial baseline
- Commit: abc123
- Hardware: Intel i7-9700K, 16GB RAM
- OS: Ubuntu 22.04
- Results: See results-2025-11-30.txt

### 2025-12-01: After optimization X
- Commit: def456
- Changes: Optimized join operator
- Results: 15% improvement in join benchmark
- See: results-2025-12-01.txt
```

### 6. Understand Statistical Significance

- **p < 0.05** - Statistically significant change
- **p ≥ 0.05** - Changes likely due to noise
- Look at confidence intervals, not just point estimates
- Larger sample sizes provide more reliable results

## Troubleshooting

### Benchmarks Take Too Long

```bash
# Reduce sample size
cargo bench -- --sample-size 10

# Reduce measurement time
cargo bench -- --measurement-time 5

# Run specific benchmarks only
cargo bench --bench arithmetic --bench identity
```

### High Variance in Results

**Possible causes:**
- System load (close other apps)
- Thermal throttling (improve cooling)
- CPU frequency scaling (use performance governor)
- Background processes (check with `top` or Activity Monitor)

**Solutions:**
```bash
# Check system load
uptime

# Monitor during benchmark
watch -n 1 "cat /proc/cpuinfo | grep MHz"

# Increase sample size for more reliable results
cargo bench -- --sample-size 100
```

### Compilation Errors

```bash
# Update dependencies
cargo update

# Clean and rebuild
cargo clean
cargo build --release

# Check Rust version
rustc --version
# Should be 1.91.1 per rust-toolchain.toml
```

### Missing Dependencies

```bash
# Ensure all git dependencies are accessible
cargo fetch

# Check network connectivity
ping github.com

# If behind proxy, set environment variables
export HTTP_PROXY=http://proxy.example.com:8080
export HTTPS_PROXY=http://proxy.example.com:8080
```

### Criterion Errors

```bash
# Remove old criterion data
rm -rf target/criterion

# Re-run benchmarks
cargo bench
```

## Advanced Topics

### Custom Benchmark Configurations

Edit `benches/benches/<benchmark>.rs`:

```rust
fn custom_config() -> Criterion {
    Criterion::default()
        .sample_size(100)
        .measurement_time(Duration::from_secs(10))
        .warm_up_time(Duration::from_secs(3))
}

criterion_group! {
    name = benches;
    config = custom_config();
    targets = my_benchmark
}
```

### Profiling Benchmarks

```bash
# Use perf (Linux)
cargo bench --bench arithmetic --profile-time 10 -- --profile-time 10

# Use Instruments (macOS)
instruments -t "Time Profiler" target/release/deps/arithmetic-<hash>

# Use cargo-flamegraph
cargo install flamegraph
cargo flamegraph --bench arithmetic
```

### CI/CD Integration

```yaml
# .github/workflows/benchmark.yml
name: Benchmarks
on: [push]
jobs:
  benchmark:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Run benchmarks
        run: cargo bench
      - name: Upload results
        uses: actions/upload-artifact@v3
        with:
          name: benchmark-results
          path: target/criterion/
```

## References

- [Criterion.rs Documentation](https://bheisler.github.io/criterion.rs/book/)
- [Hydro Documentation](https://hydro.run/)
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)

## Support

For questions or issues:
1. Check this guide and [benches/README.md](benches/README.md)
2. Review existing benchmark implementations
3. Consult the main Hydro repository documentation
4. Open an issue in this repository

---

*Last Updated: 2025-11-30*
