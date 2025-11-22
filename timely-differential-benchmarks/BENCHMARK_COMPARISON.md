# Benchmark Comparison Guide

This document provides guidance for comparing these Timely/Differential benchmarks with Hydro implementations.

## Overview

These benchmarks serve as reference implementations for performance comparison with the Hydro dataflow system. They provide baseline performance metrics for Timely Dataflow and Differential Dataflow.

## Comparison Methodology

### Running Comparative Benchmarks

#### 1. Run Timely/Differential Benchmarks (This Repository)
```bash
cd bigweaver-agent-canary-zeta-hydro-deps/timely-differential-benchmarks
cargo bench --bench arithmetic -- --save-baseline timely-baseline
cargo bench --bench fan_in -- --save-baseline timely-baseline
cargo bench --bench fan_out -- --save-baseline timely-baseline
cargo bench --bench fork_join -- --save-baseline timely-baseline
cargo bench --bench identity -- --save-baseline timely-baseline
cargo bench --bench join -- --save-baseline timely-baseline
cargo bench --bench reachability -- --save-baseline timely-baseline
cargo bench --bench upcase -- --save-baseline timely-baseline
```

#### 2. Run Hydro Benchmarks (Main Repository)
```bash
cd bigweaver-agent-canary-hydro-zeta
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench fan_in
cargo bench -p benches --bench fan_out
cargo bench -p benches --bench fork_join
cargo bench -p benches --bench identity
cargo bench -p benches --bench join
cargo bench -p benches --bench reachability
cargo bench -p benches --bench upcase
```

### Ensuring Fair Comparison

#### Data Size Consistency
All benchmarks use identical data sizes:

| Benchmark | Data Size | Operations |
|-----------|-----------|------------|
| arithmetic | 1,000,000 integers | 20 map operations |
| fan_in | 20 × 1,000,000 integers | 20 stream concat |
| fan_out | 1,000,000 integers | 20 stream splits |
| fork_join | 100,000 integers | 20 fork-join iterations |
| identity | 1,000,000 integers | 20 identity operations |
| join | 100,000 tuples × 2 | 1 hash join |
| reachability | 55,008 edges | Until convergence |
| upcase | 100,000 strings | 20 transformations |

#### System Configuration
For accurate comparisons:

1. **Run on the same hardware**
   - CPU, RAM, storage should be identical
   - Avoid cloud instances with variable performance

2. **Identical system state**
   - Close unnecessary applications
   - Disable background tasks
   - Use consistent CPU governor (performance mode)

3. **Same compiler settings**
   ```bash
   # Use release mode for both
   cargo bench  # Automatically uses --release
   ```

4. **Warm-up considerations**
   - Criterion handles warm-up automatically
   - Run multiple iterations for statistical significance

## Performance Metrics

### Key Metrics to Compare

#### 1. Throughput
- **Metric**: Elements processed per second
- **Calculate**: `data_size / execution_time`
- **Example**: 1,000,000 integers / 12.5ms = 80M elements/second

#### 2. Latency
- **Metric**: Time to process single batch
- **Reported by**: Criterion mean time
- **Lower is better**

#### 3. Memory Usage
```bash
# Monitor memory during benchmark
/usr/bin/time -v cargo bench --bench reachability

# Look for:
# - Maximum resident set size
# - Average resident set size
```

#### 4. CPU Utilization
```bash
# Use system monitoring tools
htop  # Watch CPU usage during benchmarks
```

### Expected Performance Patterns

#### Timely/Differential Characteristics
- **Strengths**:
  - Mature, highly optimized implementation
  - Excellent for iterative algorithms (reachability)
  - Low operator overhead
  - Efficient feedback loops

- **Overhead**:
  - Progress tracking system
  - Message buffering
  - Timestamp management

#### Hydro Characteristics
- **Strengths**:
  - Flexible syntax options (surface, compiled)
  - Integration with Rust async ecosystem
  - Modern API design
  - Compile-time optimizations

- **Trade-offs**:
  - Different optimization strategies
  - Various compilation modes with different performance profiles

## Benchmark-Specific Comparisons

### Arithmetic
**What it tests**: Pipeline throughput for simple operations

**Timely/Differential**: 
- Pure dataflow pipeline
- Minimal overhead per operation

**Hydro equivalents**:
- `benchmark_hydroflow_compiled`: Compiled execution
- `benchmark_hydroflow_surface`: Surface syntax
- `benchmark_pipeline`: Raw pipeline comparison

**Comparison focus**: Operator overhead, pipeline efficiency

### Fan-In
**What it tests**: Stream merging efficiency

**Timely/Differential**:
- Uses `Concatenate` operator
- Efficient multi-stream merge

**Hydro equivalents**:
- `benchmark_hydroflow_surface`: Union operator
- `benchmark_iters`: Iterator-based merge

**Comparison focus**: Stream management overhead

### Fan-Out
**What it tests**: Stream broadcasting efficiency

**Timely/Differential**:
- Stream cloning mechanism
- Multiple consumers of single stream

**Hydro equivalents**:
- `benchmark_hydroflow_surface`: Tee operator
- `benchmark_sol`: Speed of light baseline

**Comparison focus**: Broadcasting overhead, memory efficiency

### Fork-Join
**What it tests**: Complex dataflow patterns with splits and merges

**Timely/Differential**:
- Filter-based splitting
- Concatenate-based joining
- Iterative pattern

**Hydro equivalents**:
- `benchmark_hydroflow`: Compiled graph execution
- `benchmark_hydroflow_surface`: Surface syntax
- `benchmark_raw`: Raw implementation

**Comparison focus**: Pattern complexity handling

### Identity
**What it tests**: Baseline operator overhead

**Timely/Differential**:
- Minimal computation
- Pure operator overhead measurement

**Hydro equivalents**:
- Multiple Hydro variants
- Pipeline and iterator baselines

**Comparison focus**: Fundamental operator cost

### Join
**What it tests**: Hash join performance for different data types

**Timely/Differential**:
- Custom binary operator
- Hash table management
- Two variants: usize and String

**Hydro equivalents**:
- `benchmark_sol`: Optimal join implementation

**Comparison focus**: Join algorithm efficiency, type handling

### Reachability (Critical Comparison)
**What it tests**: Iterative graph algorithms

**Timely/Differential**:
- **Timely**: Feedback loops with filter
- **Differential**: Incremental computation with iterate

**Hydro equivalents**:
- `benchmark_hydroflow_scheduled`: Scheduled graph execution
- `benchmark_hydroflow_surface`: Surface syntax with recursion
- Multiple variants with different optimization levels

**Comparison focus**: 
- Iterative computation efficiency
- Convergence speed
- Memory usage during iteration
- Incremental vs. full recomputation

**Special note**: This is the ONLY benchmark with Differential Dataflow implementation, showcasing incremental computation benefits.

### Upcase
**What it tests**: String manipulation through dataflow

**Timely/Differential**:
- Three variants testing different string operations
- Memory allocation patterns

**Hydro equivalents**:
- Raw and iterator baselines
- Multiple operation types

**Comparison focus**: String handling efficiency, memory allocation overhead

## Results Analysis

### Reading Criterion Output

#### Performance Comparison
```
arithmetic/timely       time:   [12.345 ms 12.456 ms 12.567 ms]
```

**Interpretation**:
- First value: Lower bound of confidence interval
- Middle value: Point estimate (mean)
- Last value: Upper bound of confidence interval

#### Change Detection
```
change: [-2.1234% -1.2345% -0.3456%] (p = 0.02 < 0.05)
Performance has improved.
```

**Interpretation**:
- Shows change compared to baseline
- p-value indicates statistical significance
- p < 0.05 means change is statistically significant

### Comparison Table Template

| Benchmark | Timely (ms) | Hydro Compiled (ms) | Hydro Surface (ms) | Winner | Notes |
|-----------|-------------|---------------------|-------------------|--------|-------|
| arithmetic | 12.5 | 13.2 | 14.1 | Timely | Similar performance |
| fan_in | 25.3 | 26.1 | 27.8 | Timely | Close match |
| fan_out | 18.9 | 19.2 | 20.5 | Timely | Broadcasting efficiency |
| fork_join | 45.6 | 44.2 | 48.9 | Hydro Compiled | Complex patterns |
| identity | 8.2 | 8.5 | 9.1 | Timely | Low overhead |
| join (usize) | 35.7 | 36.2 | - | Similar | Join efficiency |
| join (String) | 89.3 | 91.5 | - | Similar | String handling |
| reachability (Timely) | 46.8 | 45.1 | 48.2 | Hydro Compiled | Graph iteration |
| reachability (Diff) | 52.3 | - | - | - | Incremental only |
| upcase (in-place) | 22.1 | 22.8 | 24.3 | Timely | String ops |

### Statistical Significance

When comparing results:

1. **Within 5% difference**: Generally considered equivalent
2. **5-15% difference**: Noticeable but may be system variation
3. **>15% difference**: Significant performance difference
4. **Always check**: p-values and confidence intervals

## Comparison Best Practices

### 1. Multiple Runs
```bash
# Run each benchmark multiple times
for i in {1..5}; do
    cargo bench --bench arithmetic
done
```

### 2. Baseline Establishment
```bash
# Save baselines for future comparison
cargo bench -- --save-baseline version-1.0
cargo bench -- --save-baseline version-2.0

# Compare versions
cargo bench -- --baseline version-1.0
```

### 3. System Isolation
```bash
# Set CPU governor to performance
echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor

# Disable frequency scaling
sudo cpupower frequency-set --governor performance
```

### 4. Result Documentation
- Save HTML reports from `target/criterion/report/`
- Export comparison tables
- Document system configuration
- Note any anomalies or special conditions

## Advanced Analysis

### Profiling for Detailed Comparison

#### Using `perf` (Linux)
```bash
# Profile Timely benchmark
cargo bench --bench arithmetic --profile-time 30

perf record -g cargo bench --bench arithmetic
perf report
```

#### Using flamegraphs
```bash
cargo install flamegraph
cargo flamegraph --bench arithmetic
```

### Memory Profiling
```bash
# Using valgrind
valgrind --tool=massif cargo bench --bench reachability

# Using heaptrack (if available)
heaptrack cargo bench --bench reachability
```

## Interpreting Results

### When Timely/Differential is Faster
Possible reasons:
- Highly optimized implementation
- Better operator fusion
- More efficient progress tracking
- Mature compilation pipeline

**Action**: Identify specific optimizations that can be ported

### When Hydro is Faster
Possible reasons:
- Compile-time optimizations
- Better specialization
- Reduced overhead for specific patterns
- Async runtime benefits

**Action**: Document advantages and consider applying to other scenarios

### When Results are Similar
Indicates:
- Both systems are well-optimized for the workload
- Fundamental algorithmic constraints dominate
- System overhead is minimal compared to computation

**Action**: Focus optimization efforts elsewhere

## Reporting Comparisons

### Benchmark Report Template

```markdown
# Benchmark Comparison Report

## System Configuration
- CPU: [CPU Model]
- RAM: [Amount]
- OS: [Operating System]
- Rust Version: [Version]

## Results Summary

[Include comparison table]

## Key Findings

1. **Overall Performance**: [Summary]
2. **Strengths**: [What each system does best]
3. **Areas for Improvement**: [Identified optimization opportunities]

## Detailed Analysis

### [Benchmark Name]
- **Results**: [Timely vs Hydro]
- **Analysis**: [Why one might be faster]
- **Recommendations**: [Optimization suggestions]

## Conclusion

[Overall assessment and recommendations]
```

## References

- Timely Dataflow paper: [Naiad: A Timely Dataflow System](https://dl.acm.org/doi/10.1145/2517349.2522738)
- Differential Dataflow: [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)
- Hydro documentation: [Hydro Project](https://hydro.run/)
- Criterion benchmarking: [Criterion.rs](https://bheisler.github.io/criterion.rs/)
