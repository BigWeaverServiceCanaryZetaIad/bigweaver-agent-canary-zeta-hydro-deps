# Benchmark Performance Comparison Guide

This guide provides detailed instructions for running benchmarks and comparing performance between this repository and the main `bigweaver-agent-canary-hydro-zeta` repository.

## Table of Contents

1. [Quick Start](#quick-start)
2. [Understanding Benchmark Results](#understanding-benchmark-results)
3. [Comparing with Main Repository](#comparing-with-main-repository)
4. [Performance Analysis Workflow](#performance-analysis-workflow)
5. [Interpreting Results](#interpreting-results)
6. [Advanced Usage](#advanced-usage)
7. [Troubleshooting](#troubleshooting)

## Quick Start

### Run All Benchmarks

```bash
cd /projects/sandbox/bigweaver-agent-canary-zeta-hydro-deps
cargo bench
```

### Run Specific Benchmark

```bash
cargo bench --bench arithmetic
```

### Quick Smoke Test (Fast)

```bash
cargo bench -- --test
```

## Understanding Benchmark Results

### Criterion Output Format

Each benchmark produces output like:

```
arithmetic/timely     time:   [123.45 ms 124.56 ms 125.67 ms]
                     change: [-2.34% -1.23% +0.12%] (p = 0.08 > 0.05)
                     No change in performance detected.
```

Breaking this down:
- **time**: Current measurement [lower bound, estimate, upper bound]
- **change**: Percentage change from previous run [lower, estimate, upper]
- **p-value**: Statistical significance (< 0.05 indicates significant change)
- **Status**: Summary of whether performance changed significantly

### Benchmark Categories

Each benchmark typically includes multiple implementations:

1. **Raw/Baseline**: Pure Rust implementation
   - Example: `arithmetic/raw`, `arithmetic/iter`
   - Purpose: Establish theoretical best-case performance

2. **Timely**: Timely Dataflow implementation
   - Example: `arithmetic/timely`
   - Purpose: Compare against mature dataflow framework

3. **Hydro (dfir_rs)**: Hydro implementation
   - Example: `arithmetic/dfir_rs/compiled`, `arithmetic/dfir_rs/surface`
   - Purpose: Measure actual framework performance

## Comparing with Main Repository

### Step 1: Establish Baseline in This Repository

Save current performance as baseline:

```bash
cd /projects/sandbox/bigweaver-agent-canary-zeta-hydro-deps
cargo bench -- --save-baseline hydro-deps-baseline
```

This creates a baseline snapshot in `target/criterion/*/base/`.

### Step 2: Compare Against Baseline

After making changes, compare against the baseline:

```bash
cargo bench -- --baseline hydro-deps-baseline
```

Criterion will show percentage differences from the baseline.

### Step 3: Cross-Repository Comparison

To compare with the main repository (if benchmarks still exist there):

1. **Export results from main repository**:
   ```bash
   cd /path/to/bigweaver-agent-canary-hydro-zeta
   cargo bench -p benches 2>&1 | tee main-repo-results.txt
   ```

2. **Export results from this repository**:
   ```bash
   cd /projects/sandbox/bigweaver-agent-canary-zeta-hydro-deps
   cargo bench 2>&1 | tee hydro-deps-results.txt
   ```

3. **Manual comparison**: Compare the timing values from both files
   - Look at the middle estimate value
   - Calculate percentage differences
   - Consider confidence intervals

### Step 4: HTML Report Comparison

Compare HTML reports side-by-side:

1. **Generate reports in both repositories**:
   ```bash
   # Main repository
   cd /path/to/bigweaver-agent-canary-hydro-zeta
   cargo bench -p benches
   
   # This repository
   cd /projects/sandbox/bigweaver-agent-canary-zeta-hydro-deps
   cargo bench
   ```

2. **Open reports**:
   - Main: `bigweaver-agent-canary-hydro-zeta/target/criterion/report/index.html`
   - Deps: `bigweaver-agent-canary-zeta-hydro-deps/target/criterion/report/index.html`

3. **Compare graphs**: Look at violin plots, time series, and statistical distributions

## Performance Analysis Workflow

### 1. Initial Baseline Run

```bash
# Clean build to ensure consistent environment
cargo clean
cargo build --release

# Run benchmarks and save baseline
cargo bench -- --save-baseline initial
```

### 2. Regular Performance Tracking

Create a script for periodic benchmarking:

```bash
#!/bin/bash
# benchmark-track.sh

DATE=$(date +%Y%m%d-%H%M%S)
BASELINE_NAME="baseline-$DATE"

cd /projects/sandbox/bigweaver-agent-canary-zeta-hydro-deps

# Run benchmarks
cargo bench -- --save-baseline "$BASELINE_NAME"

# Save results
cp -r target/criterion "criterion-results-$DATE"

echo "Benchmark completed: $BASELINE_NAME"
echo "Results saved to: criterion-results-$DATE"
```

### 3. Performance Regression Detection

```bash
# Run current code against known-good baseline
cargo bench -- --baseline initial

# Look for lines with:
# - "Performance has regressed" (bad)
# - "Performance has improved" (good)
# - "No change in performance detected" (neutral)
```

### 4. Focused Performance Investigation

When investigating specific performance issues:

```bash
# Run only the problematic benchmark
cargo bench --bench reachability

# With verbose output
cargo bench --bench reachability -- --verbose

# With warm-up time adjustment (for long-running benchmarks)
cargo bench --bench reachability -- --warm-up-time 10
```

## Interpreting Results

### Performance Metrics to Consider

1. **Absolute Time**
   - Lower is better
   - Compare middle estimate: `time: [lower middle upper]`

2. **Relative Performance**
   - Hydro vs Timely: Should be competitive (within 2-3x)
   - Framework vs Raw: Expect some overhead (dataflow frameworks add ~10-50%)

3. **Statistical Significance**
   - p < 0.05: Change is significant
   - p ≥ 0.05: Change might be noise

4. **Variance/Noise**
   - Narrow confidence intervals: Stable performance
   - Wide intervals: High variance (investigate system conditions)

### Expected Performance Patterns

#### arithmetic.rs
```
Raw         : 10-20 ms  (baseline)
Iterator    : 10-20 ms  (similar to raw)
Timely      : 30-60 ms  (framework overhead)
Hydro       : 30-80 ms  (competitive with timely)
```

#### reachability.rs
```
Timely         : 100-300 ms (iterative computation)
Differential   : 50-150 ms  (incremental computation wins)
Hydro          : 100-400 ms (depends on implementation)
```

### Red Flags

⚠️ **Watch for**:
- Hydro > 5x slower than Timely (investigate)
- Large variance in repeated runs (system noise)
- Regressions > 20% (significant performance loss)
- p-values near 0.05 (borderline significance, rerun)

### Success Indicators

✅ **Good signs**:
- Hydro within 2x of Timely
- Consistent measurements (narrow confidence intervals)
- Improvements over time
- Low p-values for improvements

## Advanced Usage

### Custom Benchmark Configuration

Modify benchmark parameters in individual benchmark files:

```rust
// In benches/benches/arithmetic.rs
const NUM_OPS: usize = 20;      // Change for different workloads
const NUM_INTS: usize = 1_000_000;
```

### Criterion Configuration

Create `.cargo/config.toml` for custom criterion settings:

```toml
[build]
rustflags = ["-C", "target-cpu=native"]  # Optimize for your CPU
```

### Profiling Integration

Use benchmarks with profiling tools:

```bash
# With perf (Linux)
cargo bench --bench arithmetic --profile release -- --profile-time 10

# With flamegraph
cargo install flamegraph
cargo flamegraph --bench arithmetic
```

### Comparing Specific Implementations

Filter by benchmark function name:

```bash
# Only timely implementations
cargo bench -- timely

# Only hydro implementations
cargo bench -- dfir_rs

# Only compiled variants
cargo bench -- compiled
```

### Statistical Analysis

Adjust statistical parameters:

```bash
# More samples for higher confidence
cargo bench -- --sample-size 1000

# Longer measurement time
cargo bench -- --measurement-time 30

# More warm-up iterations
cargo bench -- --warm-up-time 10
```

## Troubleshooting

### Issue: Inconsistent Results

**Symptoms**: Wide confidence intervals, high variance

**Solutions**:
```bash
# 1. Ensure system is idle
# Close other applications

# 2. Disable CPU frequency scaling (Linux)
sudo cpupower frequency-set --governor performance

# 3. Run with higher priority (Linux)
sudo nice -n -20 cargo bench

# 4. Increase sample size
cargo bench -- --sample-size 200
```

### Issue: Very Slow Benchmarks

**Symptoms**: Benchmarks taking > 10 minutes

**Solutions**:
```bash
# Quick test mode
cargo bench -- --test

# Reduce measurement time
cargo bench -- --measurement-time 5

# Run specific benchmarks only
cargo bench --bench arithmetic
```

### Issue: Build Failures

**Symptoms**: Cannot compile benchmarks

**Solutions**:
```bash
# Update dependencies
cargo update

# Clean and rebuild
cargo clean
cargo build

# Check Rust version
rustup show  # Should be 1.91.1

# Update toolchain
rustup update
```

### Issue: Missing Data Files

**Symptoms**: `reachability` benchmark fails

**Solutions**:
```bash
# Verify data files exist
ls -la benches/benches/reachability*.txt

# If missing, restore from backup
# (or regenerate if you have the generation script)
```

### Issue: Out of Memory

**Symptoms**: Benchmark killed or system freezes

**Solutions**:
```bash
# Reduce workload size in benchmark source code
# Edit benches/benches/<benchmark>.rs
# Reduce NUM_INTS or similar constants

# Or run benchmarks sequentially
cargo bench --bench arithmetic
cargo bench --bench fan_in
# ... one at a time
```

## Performance Optimization Tips

### For Benchmark Authors

1. **Warm-up**: Ensure adequate warm-up time
2. **Black-box**: Use `criterion::black_box()` to prevent compiler optimization
3. **Realistic workloads**: Use representative data sizes
4. **Minimize setup**: Put setup in `iter_batched` closure
5. **Consistent environment**: Document system requirements

### For Framework Developers

1. **Profile first**: Use profiling to find bottlenecks
2. **Iterate**: Run benchmarks frequently during development
3. **Regression testing**: Check benchmarks before merging changes
4. **Document expectations**: Set performance goals/SLOs
5. **Track trends**: Monitor long-term performance trends

## Appendix: Benchmark Characteristics

| Benchmark      | Complexity | Runtime | Memory  | Best For               |
|----------------|------------|---------|---------|------------------------|
| arithmetic     | Low        | ~100ms  | Low     | Pipeline overhead      |
| identity       | Low        | ~50ms   | Low     | Framework overhead     |
| fan_in         | Low        | ~100ms  | Low     | Stream merging         |
| fan_out        | Low        | ~100ms  | Low     | Stream splitting       |
| fork_join      | Medium     | ~200ms  | Medium  | Complex patterns       |
| join           | Medium     | ~300ms  | Medium  | Join operations        |
| upcase         | Low        | ~100ms  | Medium  | String operations      |
| reachability   | High       | ~500ms  | High    | Iterative algorithms   |

## Continuous Integration

### CI Pipeline Example

```yaml
# .github/workflows/benchmarks.yml
name: Benchmarks

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  benchmark:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: actions-rs/toolchain@v1
        with:
          toolchain: 1.91.1
      - name: Run benchmarks
        run: cargo bench --no-fail-fast
      - name: Archive results
        uses: actions/upload-artifact@v2
        with:
          name: benchmark-results
          path: target/criterion/
```

## Further Reading

- [Criterion.rs User Guide](https://bheisler.github.io/criterion.rs/book/)
- [Benchmarking Best Practices](https://www.bazhenov.me/posts/rust-benchmarking/)
- [Statistical Analysis of Benchmarks](https://docs.rs/criterion/latest/criterion/index.html#analysis)
- [Performance Profiling in Rust](https://nnethercote.github.io/perf-book/)
