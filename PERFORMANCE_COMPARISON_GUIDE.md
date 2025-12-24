# Performance Comparison Guide

## Overview

This guide explains how to run and interpret performance comparisons between the timely/differential-dataflow benchmarks in this repository and hydro-native benchmarks in the main `bigweaver-agent-canary-hydro-zeta` repository.

## Table of Contents

1. [Quick Start](#quick-start)
2. [Understanding the Benchmarks](#understanding-the-benchmarks)
3. [Running Comparisons](#running-comparisons)
4. [Interpreting Results](#interpreting-results)
5. [Best Practices](#best-practices)
6. [Troubleshooting](#troubleshooting)

## Quick Start

### Automated Comparison (Recommended)

Run benchmarks in both repositories automatically:

```bash
cd /projects/sandbox/bigweaver-agent-canary-zeta-hydro-deps
./scripts/compare_benchmarks.sh
```

### View Results

Open the generated HTML reports in your browser:

```bash
# Timely/Differential results
open target/criterion/report/index.html

# Hydro-native results (if available)
open ../bigweaver-agent-canary-hydro-zeta/target/criterion/report/index.html
```

## Understanding the Benchmarks

### Benchmark Suite

This repository contains 9 benchmarks that test different dataflow patterns:

| Benchmark | Pattern | What It Tests |
|-----------|---------|---------------|
| **arithmetic** | Chained operations | Framework overhead, operation chaining efficiency |
| **fan_in** | Multiple inputs → single output | Data aggregation, synchronization overhead |
| **fan_out** | Single input → multiple outputs | Data distribution, parallel processing |
| **fork_join** | Split → process → merge | Complex dataflow patterns, coordination |
| **identity** | Pass-through | Minimal overhead baseline, data movement cost |
| **join** | Combine two streams | Join operation efficiency, memory usage |
| **reachability** | Graph traversal | Iterative computation, state management |
| **upcase** | String transformation | Data transformation overhead |
| **zip** | Combine elements | Stream synchronization |

### Framework Comparison

Each benchmark typically includes multiple implementations:

- **timely**: Timely-dataflow (data-parallel streaming)
- **differential**: Differential-dataflow (incremental computation)
- **babyflow**: Simplified baseline for comparison
- **spinach**: Alternative dataflow model
- **hydroflow**: Hydroflow's compiled push-pull model
- **raw/iter**: Minimal overhead baselines

## Running Comparisons

### Method 1: Automated Script (Recommended)

The comparison script handles everything automatically:

```bash
cd /projects/sandbox/bigweaver-agent-canary-zeta-hydro-deps
./scripts/compare_benchmarks.sh
```

**What it does:**
1. Validates repository paths
2. Runs all timely/differential benchmarks
3. Checks for main repository benchmarks
4. Runs main repository benchmarks (if available)
5. Generates comparison reports

**Customize repository path:**
```bash
MAIN_REPO_DIR=/custom/path/to/main/repo ./scripts/compare_benchmarks.sh
```

### Method 2: Manual Execution

For fine-grained control, run benchmarks manually:

#### Step 1: Run Timely/Differential Benchmarks

```bash
cd /projects/sandbox/bigweaver-agent-canary-zeta-hydro-deps

# Run all benchmarks
cargo bench -p timely-differential-benches

# Run specific benchmark
cargo bench -p timely-differential-benches --bench arithmetic

# Run with shorter sample time (faster)
cargo bench -p timely-differential-benches -- --sample-size 10
```

#### Step 2: Run Hydro-Native Benchmarks

```bash
cd /projects/sandbox/bigweaver-agent-canary-hydro-zeta

# Run all benchmarks (if package exists)
cargo bench -p benches

# Run specific benchmark
cargo bench -p benches --bench arithmetic
```

#### Step 3: Compare Results

1. Open HTML reports in each repository:
   - `target/criterion/report/index.html`

2. Compare key metrics:
   - **Throughput**: Higher is better
   - **Latency**: Lower is better
   - **Consistency**: Smaller variance is better

### Method 3: Continuous Monitoring

Set up Criterion to track performance over time:

```bash
# Baseline measurement
cargo bench -p timely-differential-benches -- --save-baseline master

# After changes, compare to baseline
cargo bench -p timely-differential-benches -- --baseline master
```

## Interpreting Results

### Understanding Criterion Output

Criterion provides several metrics for each benchmark:

```
arithmetic/timely       time:   [15.234 ms 15.367 ms 15.512 ms]
                        thrpt:  [64.481 Melem/s 65.086 Melem/s 65.653 Melem/s]
```

**Key metrics:**
- **time**: [lower_bound **estimate** upper_bound]
  - Estimate is the most likely value
  - Bounds show 95% confidence interval
- **thrpt** (throughput): Elements processed per second
- **change**: Percentage change from previous run (if available)

### Comparing Frameworks

When comparing timely/differential with hydro-native:

#### Performance Expectations

**Timely/Differential Strengths:**
- Excellent for large-scale data processing
- Efficient streaming computation
- Strong scalability with data volume
- Optimized for distributed scenarios

**Potential Trade-offs:**
- Initial setup overhead
- Memory allocation patterns
- Framework abstraction costs

**Hydro-Native Strengths:**
- May have different optimization strategies
- Potentially lower overhead for specific patterns
- Framework-specific optimizations

#### What to Look For

1. **Relative Performance**
   - Which framework is faster for each pattern?
   - By how much? (10%? 2x? 10x?)

2. **Scaling Characteristics**
   - How does performance change with data size?
   - Run benchmarks with different input sizes

3. **Consistency**
   - Which framework has lower variance?
   - More predictable performance is valuable

4. **Pattern-Specific Insights**
   - Some frameworks excel at certain patterns
   - Identify strengths and weaknesses

### Example Analysis

```
Benchmark: arithmetic
---------------------
timely:        15.2 ms  (65.8 Melem/s)
hydroflow:     12.8 ms  (78.1 Melem/s)
raw (baseline): 8.4 ms (119.0 Melem/s)

Analysis:
- Hydroflow is 18% faster than timely for this pattern
- Both have reasonable overhead vs raw baseline (timely: 1.8x, hydroflow: 1.5x)
- Indicates hydroflow's compiled push-pull model benefits simple chains
```

## Best Practices

### 1. Consistent Environment

Ensure fair comparisons:

```bash
# Close unnecessary applications
# Disable CPU frequency scaling (if possible)
# Use consistent compiler versions
rustc --version
```

### 2. Multiple Runs

Run benchmarks multiple times to account for variance:

```bash
for i in {1..3}; do
    echo "Run $i"
    cargo bench -p timely-differential-benches
done
```

### 3. Isolate Changes

When testing optimizations:

```bash
# Before optimization
cargo bench -p timely-differential-benches -- --save-baseline before

# Make changes...

# After optimization
cargo bench -p timely-differential-benches -- --baseline before
```

### 4. Profile Memory Usage

Criterion measures time, but memory matters too:

```bash
# Use cargo-instruments (macOS) or perf (Linux)
cargo instruments -t alloc --bench arithmetic -p timely-differential-benches

# Or valgrind
valgrind --tool=massif cargo bench --bench arithmetic -p timely-differential-benches
```

### 5. Test Different Input Sizes

Modify benchmark constants to test scaling:

```rust
// In arithmetic.rs
const NUM_INTS: usize = 1_000_000;  // Try 10k, 100k, 1M, 10M
const NUM_OPS: usize = 20;           // Try 5, 10, 20, 50
```

## Troubleshooting

### "Main repository not found"

```bash
# Solution 1: Set environment variable
export MAIN_REPO_DIR=/path/to/bigweaver-agent-canary-hydro-zeta
./scripts/compare_benchmarks.sh

# Solution 2: Use inline variable
MAIN_REPO_DIR=/path/to/repo ./scripts/compare_benchmarks.sh
```

### Benchmarks Take Too Long

```bash
# Reduce sample size
cargo bench -p timely-differential-benches -- --sample-size 10

# Run specific benchmark only
cargo bench -p timely-differential-benches --bench arithmetic

# Reduce warm-up time
cargo bench -p timely-differential-benches -- --warm-up-time 1
```

### High Variance in Results

**Causes:**
- Background processes
- CPU frequency scaling
- Thermal throttling
- Insufficient warm-up

**Solutions:**
```bash
# Increase sample size
cargo bench -- --sample-size 100

# Increase warm-up time
cargo bench -- --warm-up-time 5

# Check for background processes
top
htop
```

### Cannot Find Benchmark Package in Main Repository

This is expected if hydro-native benchmarks haven't been created yet. The script will skip gracefully:

```
ℹ No benchmark package found in main repository
  This is expected if hydro-native benchmarks haven't been added yet
```

To add hydro-native benchmarks to the main repository:

1. Create equivalent benchmark implementations
2. Add to benches/Cargo.toml
3. Run comparison script again

### Different Results Between Runs

**Normal variance:** ±5% is typical
**Investigate if:** Variance exceeds 10%

```bash
# Check system load
uptime

# Check CPU frequency
cat /proc/cpuinfo | grep MHz

# Check thermal state
sensors  # If available
```

## Advanced Topics

### Custom Benchmark Comparisons

Create custom comparison reports:

```bash
# Export Criterion data
cargo bench -p timely-differential-benches -- --output-format json > timely_results.json

cd ../bigweaver-agent-canary-hydro-zeta
cargo bench -p benches -- --output-format json > hydro_results.json

# Parse and compare (custom script needed)
python compare_results.py timely_results.json hydro_results.json
```

### Continuous Integration

Integrate benchmarks into CI:

```yaml
# .github/workflows/benchmark.yml
name: Benchmark
on: [push]
jobs:
  benchmark:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - run: cargo bench -p timely-differential-benches -- --output-format json
      - uses: benchmark-action/github-action-benchmark@v1
```

### Profiling Specific Benchmarks

Deep-dive into performance:

```bash
# CPU profiling (Linux)
cargo bench --bench arithmetic --profile release -- --profile-time=10
perf record -g target/release/deps/arithmetic-*
perf report

# Flame graph
cargo flamegraph --bench arithmetic -p timely-differential-benches
```

## Resources

### Documentation
- [Criterion.rs Documentation](https://bheisler.github.io/criterion.rs/book/)
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)

### Files in This Repository
- `timely-differential-benches/README.md` - Benchmark overview
- `MIGRATION.md` - Migration history and context
- `scripts/compare_benchmarks.sh` - Automated comparison script
- Individual benchmark files in `timely-differential-benches/benches/`

### Related Repositories
- Main repository: `bigweaver-agent-canary-hydro-zeta`
- This repository: `bigweaver-agent-canary-zeta-hydro-deps`

## Contributing

### Adding New Benchmarks

1. Create benchmark file: `timely-differential-benches/benches/new_benchmark.rs`
2. Register in `Cargo.toml`:
   ```toml
   [[bench]]
   name = "new_benchmark"
   harness = false
   ```
3. Implement using Criterion
4. Update documentation
5. Add equivalent benchmark to main repository (optional)

### Improving Comparisons

- Enhance comparison script with statistical analysis
- Add visualization tools for results
- Automate report generation
- Create performance regression tests

## Questions or Issues?

- Check existing documentation in this repository
- Review Criterion.rs documentation
- Examine benchmark implementations for examples
- Consult team members familiar with benchmarking practices
