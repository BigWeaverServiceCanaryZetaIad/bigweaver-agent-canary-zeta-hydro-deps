# Benchmark Comparison Guide

This guide explains how to compare benchmarks between this repository (Timely/Differential Dataflow) and the main Hydro repository.

## Overview

This repository provides reference benchmarks using established dataflow frameworks. Comparing these with Hydro benchmarks helps:

1. **Validate Performance**: Ensure Hydro meets or exceeds baseline performance
2. **Identify Optimization Opportunities**: Highlight areas where Hydro can improve
3. **Understand Trade-offs**: Compare high-level vs. low-level programming models
4. **Track Progress**: Monitor performance improvements over time

## Framework Comparison

### Programming Model Differences

| Aspect | Timely/Differential | Hydro |
|--------|---------------------|-------|
| **Abstraction Level** | Low-level imperative | High-level declarative |
| **Staging** | Runtime | Compile-time (via staging) |
| **Distribution** | Runtime placement | Choreographed (compile-time) |
| **Type System** | Generic Rust | Staged with location types |
| **Optimization** | Runtime operator fusion | Compile-time optimization |

### When to Compare

- **Throughput**: Operations per second for batch processing
- **Latency**: Time to process individual items
- **Memory Usage**: Peak and average memory consumption
- **Scalability**: Performance with increasing data sizes
- **Overhead**: Framework-specific costs

## Running Comparable Benchmarks

### 1. In This Repository (Timely/Differential)

```bash
# Run all benchmarks
cd /path/to/bigweaver-agent-canary-zeta-hydro-deps
cargo bench

# Run specific benchmark suites
cargo bench -p timely-benchmarks
cargo bench -p differential-benchmarks

# Run specific benchmark
cargo bench -p timely-benchmarks --bench arithmetic
cargo bench -p differential-benchmarks --bench reachability
```

### 2. In Main Repository (Hydro)

```bash
# Navigate to main repository
cd /path/to/bigweaver-agent-canary-hydro-zeta

# Run equivalent benchmarks (if available)
# Note: Exact benchmark names may differ
cargo bench --package dfir_rs

# Run specific examples
cargo run --release --example kvs_bench
```

## Benchmark Equivalence

### Arithmetic Operations

**This Repo:**
```bash
cargo bench -p timely-benchmarks --bench arithmetic
cargo bench -p differential-benchmarks --bench arithmetic
```

**Main Repo:** Look for similar computational benchmarks in `dfir_rs` or `hydro_lang` benchmark suites.

**What to Compare:**
- Throughput (operations/sec) for different input sizes
- Memory allocation patterns
- CPU utilization

### Identity Operations

**This Repo:**
```bash
cargo bench -p timely-benchmarks --bench identity
cargo bench -p differential-benchmarks --bench identity
```

**Main Repo:** Look for minimal overhead benchmarks that pass data through the system.

**What to Compare:**
- Baseline framework overhead
- Data copy costs
- Scheduling overhead

### Graph Algorithms (Reachability)

**This Repo:**
```bash
cargo bench -p differential-benchmarks --bench reachability
```

**Main Repo:** Look for graph algorithm examples or benchmarks involving iteration.

**What to Compare:**
- Iteration efficiency
- Convergence speed
- Memory usage during iteration
- Incremental update performance (differential only)

### Stream Operations (Fan-in/Fan-out)

**This Repo:**
```bash
cargo bench -p timely-benchmarks --bench fan_in
cargo bench -p timely-benchmarks --bench fan_out
cargo bench -p differential-benchmarks --bench fan_in
cargo bench -p differential-benchmarks --bench fan_out
```

**Main Repo:** Look for benchmarks involving stream merging and splitting.

**What to Compare:**
- Multi-stream coordination overhead
- Backpressure handling
- Memory buffering

## Interpreting Results

### Criterion Output Format

Criterion provides several metrics:

```
arithmetic/100          time:   [45.234 µs 45.891 µs 46.612 µs]
                        change: [-2.3421% +0.1234% +2.7891%] (p = 0.89 > 0.05)
                        No change in performance detected.
```

**Key Metrics:**
- **time**: [lower_bound estimate upper_bound] - 95% confidence interval
- **change**: Percentage change from previous baseline
- **p-value**: Statistical significance (p < 0.05 indicates significant change)

### Cross-Framework Comparison

When comparing across frameworks, consider:

1. **Absolute Performance**: Raw throughput and latency numbers
2. **Scaling Characteristics**: How performance changes with input size
3. **Memory Efficiency**: Peak memory usage and allocation patterns
4. **Code Complexity**: Lines of code and abstraction overhead

### Example Comparison Table

| Benchmark | Timely | Differential | Hydro | Notes |
|-----------|--------|--------------|-------|-------|
| Arithmetic (10K) | 250 µs | 320 µs | 180 µs | Hydro benefits from compile-time optimization |
| Identity (10K) | 120 µs | 180 µs | 95 µs | Lower overhead in Hydro |
| Reachability (1K) | N/A | 850 µs | 720 µs | Differential optimized for incremental |
| Fan-in (8 branches) | 380 µs | 420 µs | 340 µs | Hydro's compile-time fusion helps |

## Advanced Analysis

### Using Flamegraphs

Profile Timely/Differential benchmarks:

```bash
cargo install flamegraph
cargo flamegraph --bench arithmetic -p timely-benchmarks
```

Profile Hydro benchmarks:

```bash
cd /path/to/bigweaver-agent-canary-hydro-zeta
cargo flamegraph --bench <benchmark-name>
```

### Memory Profiling

Use `valgrind` or `heaptrack` for detailed memory analysis:

```bash
# For Timely/Differential
valgrind --tool=massif cargo bench -p timely-benchmarks --bench arithmetic

# For Hydro
cd /path/to/bigweaver-agent-canary-hydro-zeta
valgrind --tool=massif cargo bench --bench <benchmark-name>
```

### Perf Analysis

Linux `perf` for detailed performance counters:

```bash
# Record performance data
perf record --call-graph dwarf cargo bench -p timely-benchmarks --bench arithmetic

# Analyze results
perf report
```

## Exporting Results

### Criterion JSON Output

Criterion saves JSON data in `target/criterion/<benchmark>/base/estimates.json`

Parse and compare programmatically:

```bash
# Extract timing data
cat target/criterion/timely_arithmetic/100/base/estimates.json | jq '.mean'
```

### Creating Comparison Reports

Use the provided data to create comparison reports:

1. Run all benchmarks in both repositories
2. Extract timing data from Criterion JSON files
3. Create comparison tables or charts
4. Document any significant differences

## Best Practices

### 1. Consistent Environment

- Run benchmarks on the same hardware
- Use the same Rust version and optimization settings
- Minimize background processes
- Consider using dedicated benchmarking machines

### 2. Multiple Runs

- Run benchmarks multiple times to account for variance
- Use Criterion's baseline feature to track changes over time
- Consider statistical significance (p-values)

### 3. Warm-up

- Criterion handles warm-up automatically
- But be aware of JIT effects in complex scenarios
- Consider steady-state performance for long-running workloads

### 4. Realistic Workloads

- Use data sizes representative of real applications
- Consider different data distributions (uniform, skewed, etc.)
- Test edge cases (empty inputs, very large inputs)

## Common Pitfalls

### ❌ Comparing Debug vs Release

Always compare release builds:
```bash
cargo bench  # Already uses --release
```

### ❌ Different Optimization Levels

Ensure both repositories use the same optimization settings in `Cargo.toml`:
```toml
[profile.release]
opt-level = 3
lto = "fat"
codegen-units = 1
```

### ❌ Ignoring Variance

Account for measurement noise and system variance. Criterion provides confidence intervals - use them!

### ❌ Unfair Comparisons

Different programming models may favor different patterns. A high-level framework might have higher overhead for simple operations but better overall system performance.

## Reporting Performance Issues

When reporting performance issues, include:

1. **Environment**: Hardware specs, OS, Rust version
2. **Benchmark code**: Exact code being measured
3. **Raw data**: Criterion output or JSON files
4. **Comparisons**: Side-by-side results
5. **Analysis**: What you expected vs. what you observed
6. **Profiling data**: Flamegraphs or perf data if available

## Related Documentation

- [Criterion.rs User Guide](https://bheisler.github.io/criterion.rs/book/)
- [Rust Performance Book](https://nnethercote.github.io/perf-book/)
- [Timely Dataflow Documentation](https://timelydataflow.github.io/timely-dataflow/)
- [Differential Dataflow Documentation](https://timelydataflow.github.io/differential-dataflow/)
- [Hydro Documentation](https://hydro.run/)

## Questions and Support

For questions about these benchmarks or comparisons:

1. Check the main repository documentation
2. Review existing performance discussions
3. Open an issue with detailed information about your comparison scenario
