# Performance Comparison Guide

This guide provides detailed instructions for conducting thorough performance comparisons between Hydro and other dataflow frameworks (Timely, Differential Dataflow).

## Table of Contents

1. [Quick Start](#quick-start)
2. [Establishing Baselines](#establishing-baselines)
3. [Running Comparisons](#running-comparisons)
4. [Interpreting Results](#interpreting-results)
5. [Framework-Specific Analysis](#framework-specific-analysis)
6. [Performance Regression Testing](#performance-regression-testing)
7. [Optimization Workflow](#optimization-workflow)

## Quick Start

### First-Time Setup

1. **Verify Dependencies**:
   ```bash
   # Ensure main Hydro repository is at correct path
   ls ../bigweaver-agent-canary-hydro-zeta/dfir_rs
   
   # Check Rust toolchain
   rustc --version  # Should match rust-toolchain.toml
   ```

2. **Initial Benchmark Run**:
   ```bash
   # Run all benchmarks to verify setup
   cargo bench -p benches
   
   # View results
   open target/criterion/report/index.html  # macOS
   xdg-open target/criterion/report/index.html  # Linux
   ```

3. **Save as Baseline**:
   ```bash
   cargo bench -p benches -- --save-baseline initial
   ```

## Establishing Baselines

Before making any comparisons, establish reliable baselines:

### 1. System Preparation

```bash
# Minimize background processes
# Close web browsers, IDEs, etc.

# Disable CPU frequency scaling (Linux, requires root)
echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor

# Disable turbo boost for consistency (optional, Linux)
echo 1 | sudo tee /sys/devices/system/cpu/intel_pmu/allow_tsx_force_abort
```

### 2. Run Baseline Benchmarks

```bash
# Run comprehensive baseline
cargo bench -p benches -- --save-baseline main

# For specific benchmarks
cargo bench -p benches --bench reachability -- --save-baseline main-reach
cargo bench -p benches --bench micro_ops -- --save-baseline main-micro
```

### 3. Verify Baseline Quality

Check for high variance (>10%) which indicates unreliable measurements:
- High variance suggests system interference
- Re-run with better system isolation
- Results with variance >10% should not be used for comparison

## Running Comparisons

### Compare Across Frameworks

#### 1. Hydro vs Timely

```bash
# Run only Hydro benchmarks
cargo bench -p benches -- dfir_rs

# Run only Timely benchmarks
cargo bench -p benches -- timely

# Run both for direct comparison
cargo bench -p benches --bench reachability
```

**Analysis Points**:
- Compare throughput (elements/second)
- Check latency percentiles (p50, p95, p99)
- Examine memory usage patterns
- Look for scheduling efficiency differences

#### 2. Hydro vs Differential Dataflow

```bash
# Benchmarks with differential implementations
cargo bench -p benches --bench reachability -- differential
cargo bench -p benches --bench upcase -- differential
```

**Analysis Points**:
- Differential excels at incremental computation
- Compare update latency vs batch throughput
- Check memory overhead for maintaining state
- Evaluate fixed-point convergence speed

#### 3. Hydro vs Raw Rust

```bash
# Compare against baseline implementations
cargo bench -p benches -- /raw/
cargo bench -p benches -- /dfir_rs/
```

**Analysis Points**:
- Raw implementation shows theoretical minimum overhead
- Framework overhead = (Hydro time - Raw time) / Raw time
- Target: <20% overhead for simple operations
- Complex operations may show framework benefits

### Compare Across Hydro Implementations

```bash
# Compare compiled vs surface syntax
cargo bench -p benches -- dfir_rs/compiled
cargo bench -p benches -- dfir_rs/surface
```

**Analysis Points**:
- Surface syntax overhead should be minimal (<5%)
- If overhead is high, macro expansion may need optimization
- Compiled version shows lower bound for Hydro performance

### Compare Across Workload Sizes

Modify benchmark source files to test different scales:

```rust
// In arithmetic.rs, change:
const NUM_INTS: usize = 1_000_000;  // Original
const NUM_INTS: usize = 10_000_000; // 10x scale

// In join.rs, change:
const NUM_INTS: usize = 100_000;    // Original
const NUM_INTS: usize = 1_000_000;  // 10x scale
```

Then run:
```bash
cargo bench -p benches --bench arithmetic
```

**Analysis Points**:
- O(n) operations should scale linearly
- O(n²) operations (like cross_join) scale quadratically
- Memory pressure affects larger workloads differently

## Interpreting Results

### Understanding Criterion Output

```
reachability/dfir_rs/surface
                        time:   [45.123 ms 45.456 ms 45.789 ms]
                        change: [-5.2% -3.1% -1.0%] (p = 0.01 < 0.05)
                        Performance has improved.
Found 3 outliers among 100 measurements (3.00%)
  2 (2.00%) high mild
  1 (1.00%) high severe
```

**Interpretation**:
- **Time**: [lower_bound, estimate, upper_bound] with 95% confidence interval
- **Estimate**: Best estimate of actual performance (median)
- **Change**: Percentage difference from baseline
- **P-value**: Statistical significance (p < 0.05 means significant change)
- **Outliers**: Measurements outside normal distribution (should be <5%)

### Performance Metrics

#### 1. Throughput (Primary Metric)

```
Elements/second = NUM_ELEMENTS / time_seconds
```

Higher is better. Compare:
- Hydro throughput / Raw throughput = overhead ratio
- Target: >0.8 (i.e., <20% overhead)

#### 2. Latency (P95/P99)

Check HTML reports for latency percentiles:
- P50 (median): Typical performance
- P95: 95% of operations complete within this time
- P99: 99% of operations complete within this time

Low P95/P99 indicates consistent performance.

#### 3. Variance/Std Dev

```
Coefficient of Variation = std_dev / mean
```

Lower is better:
- <5%: Excellent consistency
- 5-10%: Good consistency
- >10%: Poor consistency (investigate system issues)

### Comparison Tables

Create comparison tables from results:

| Implementation | Time (ms) | vs Raw | vs Timely | Throughput (elem/s) |
|---------------|-----------|--------|-----------|---------------------|
| Raw           | 10.5      | 1.00x  | -         | 95,238              |
| Iterator      | 11.2      | 1.07x  | -         | 89,286              |
| Timely        | 15.8      | 1.50x  | 1.00x     | 63,291              |
| Hydro Compiled| 13.2      | 1.26x  | 0.84x     | 75,758              |
| Hydro Surface | 13.5      | 1.29x  | 0.85x     | 74,074              |

**Interpretation**:
- Hydro is 26-29% slower than raw Rust (acceptable framework overhead)
- Hydro is 15-16% faster than Timely (good relative performance)
- Surface syntax adds only 2.3% overhead vs compiled (excellent)

## Framework-Specific Analysis

### Timely Dataflow Characteristics

**Strengths**:
- Mature, battle-tested codebase
- Excellent for complex timestamp/ordering requirements
- Strong consistency guarantees

**Weaknesses**:
- Higher overhead for simple operations
- More complex API for basic use cases

**When Hydro Should Win**:
- Simple streaming pipelines
- Stateless transformations
- Low-latency requirements

**When Timely May Win**:
- Complex time-based computations
- Multi-worker distributed scenarios
- Heavy state management

### Differential Dataflow Characteristics

**Strengths**:
- Incremental computation (only processes changes)
- Excellent for iterative algorithms
- Efficient for streaming updates

**Weaknesses**:
- Higher memory usage (maintains state)
- Initial batch slower than streaming-only

**When Hydro Should Win**:
- Batch processing (one-shot computation)
- Stateless pipelines
- Memory-constrained environments

**When Differential May Win**:
- Streaming with updates/deletes
- Iterative fixed-point algorithms
- Long-running stateful computations

### Raw Rust Comparison

**Purpose**: Establish theoretical minimum overhead

**Analysis**:
```
Framework Overhead = (Framework Time - Raw Time) / Raw Time * 100%
```

**Acceptable Overheads**:
- Simple operations (map, filter): 10-30%
- Complex operations (join, group): 30-50%
- Iterative algorithms (reachability): 20-40%

**Red Flags**:
- >100% overhead on simple operations
- >200% overhead on any operation
- Overhead increases with workload size

## Performance Regression Testing

### Continuous Integration Workflow

```bash
# 1. On main branch, establish baseline
git checkout main
cargo bench -p benches -- --save-baseline main

# 2. Create feature branch
git checkout -b feature/optimization

# 3. Make changes...

# 4. Run benchmarks and compare
cargo bench -p benches -- --baseline main
```

### Regression Thresholds

Configure Criterion to detect regressions:

```rust
// In benchmark files, configure thresholds:
use criterion::Criterion;

let mut criterion = Criterion::default()
    .significance_level(0.05)      // 5% significance
    .noise_threshold(0.02)         // 2% noise tolerance
    .sample_size(100);             // Number of samples
```

**Interpretation**:
- **Green (Improved)**: Performance increase >5%
- **Yellow (No Change)**: Performance change <5%
- **Red (Regressed)**: Performance decrease >5%

### Automated Regression Detection

```bash
#!/bin/bash
# regression_check.sh

cargo bench -p benches -- --baseline main > results.txt

if grep -q "Performance has regressed" results.txt; then
    echo "❌ Performance regression detected!"
    exit 1
else
    echo "✅ No performance regressions"
    exit 0
fi
```

## Optimization Workflow

### 1. Identify Bottleneck

```bash
# Run all benchmarks to find slowest
cargo bench -p benches

# Focus on specific bottleneck
cargo bench -p benches --bench micro_ops -- --sample-size 50
```

### 2. Profile Hot Paths

```bash
# Install profiling tools
cargo install flamegraph
cargo install cargo-profiling

# Generate flamegraph
cargo bench -p benches --bench reachability -- --profile-time=10

# View flamegraph
open target/criterion/reachability/profile/flamegraph.svg
```

### 3. Hypothesize Optimization

Document expected improvement:
```
Optimization: Cache hash computations in join operator
Expected Impact: 10-15% improvement on join benchmarks
Baseline: join/usize/usize/dfir_rs: 12.5ms
```

### 4. Implement and Measure

```bash
# Save baseline before changes
cargo bench -p benches --bench join -- --save-baseline before-join-opt

# Make changes...

# Compare results
cargo bench -p benches --bench join -- --baseline before-join-opt
```

### 5. Verify Improvement

```bash
# Run multiple times to ensure consistency
for i in {1..5}; do
    cargo bench -p benches --bench join -- --baseline before-join-opt
done

# Check that improvement is consistent (low variance)
```

### 6. Document Results

```markdown
## Join Optimization Results

**Optimization**: Cached hash computations in join operator

**Before**: 12.5ms ± 0.3ms
**After**: 10.8ms ± 0.2ms
**Improvement**: 13.6% faster, 25% lower variance

**Impact by Implementation**:
- join/usize/usize: 13.6% faster
- join/String/String: 8.2% faster (less impact due to string allocation overhead)
```

## Best Practices

### 1. System Setup
- Close all background applications
- Disable CPU frequency scaling
- Use a consistent power profile
- Run on a cool system (avoid thermal throttling)

### 2. Measurement
- Use adequate sample sizes (default 100 is usually good)
- Include warm-up period (default 3s)
- Run multiple iterations for consistency
- Save baselines for reproducibility

### 3. Analysis
- Compare like-to-like (same workload, same environment)
- Consider statistical significance (p-value)
- Look at trends over multiple runs
- Investigate outliers

### 4. Reporting
- Document system configuration
- Include confidence intervals
- Show comparative tables
- Provide context for changes

## Troubleshooting

### High Variance

**Problem**: Results show >10% variance
```
time: [45.1 ms 50.2 ms 55.3 ms]  # Wide confidence interval
```

**Solutions**:
1. Check for background processes: `top` or `htop`
2. Increase sample size: `--sample-size 200`
3. Increase warm-up time: `--warm-up-time 10`
4. Use dedicated benchmark machine

### Inconsistent Comparisons

**Problem**: Results differ between runs

**Solutions**:
1. Save and reuse baselines
2. Run on same hardware configuration
3. Use same compiler version
4. Check for thermal throttling

### Unexpectedly Slow Performance

**Problem**: All benchmarks slower than expected

**Solutions**:
1. Verify release mode: `cargo bench` (not `cargo test`)
2. Check CPU governor: `cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor`
3. Disable debug assertions in dependencies
4. Check for debug builds of dependencies

## Further Reading

- [Criterion.rs Book](https://bheisler.github.io/criterion.rs/book/)
- [Timely Dataflow Book](https://timelydataflow.github.io/timely-dataflow/)
- [Differential Dataflow Documentation](https://github.com/TimelyDataflow/differential-dataflow)
- [Rust Performance Book](https://nnethercote.github.io/perf-book/)
