# Performance Comparison Guide

This guide provides detailed instructions for running performance comparisons between Hydroflow/dfir_rs, Timely, and Differential-Dataflow frameworks.

## Table of Contents

1. [Quick Start](#quick-start)
2. [Running Benchmarks](#running-benchmarks)
3. [Interpreting Results](#interpreting-results)
4. [Comparative Analysis](#comparative-analysis)
5. [Performance Tracking](#performance-tracking)
6. [Best Practices](#best-practices)
7. [Troubleshooting](#troubleshooting)

## Quick Start

### Basic Comparison

```bash
# Run all benchmarks to compare all frameworks
cargo bench -p benches

# View HTML report
open target/criterion/report/index.html  # macOS
xdg-open target/criterion/report/index.html  # Linux
```

### Framework-Specific Testing

```bash
# Test only Hydroflow implementations
cargo bench -p benches -- "dfir_rs"

# Test only Timely implementations
cargo bench -p benches -- "timely"

# Test only Differential-Dataflow
cargo bench -p benches -- "differential"
```

## Running Benchmarks

### Complete Benchmark Suite

Run all benchmarks to get comprehensive comparison data:

```bash
cargo bench -p benches
```

This runs:
- 8 benchmark files
- Multiple implementations per benchmark (Hydroflow compiled/interpreted, Timely, etc.)
- Statistical analysis with warm-up, measurement, and iteration counts

### Individual Benchmarks

Run specific benchmarks for focused comparison:

```bash
# Arithmetic operations
cargo bench -p benches --bench arithmetic

# Graph reachability (Differential-Dataflow showcase)
cargo bench -p benches --bench reachability

# Framework overhead measurement
cargo bench -p benches --bench identity
```

### Specific Test Cases

Run individual test cases within benchmarks:

```bash
# Compare specific implementations
cargo bench -p benches --bench arithmetic -- "arithmetic/dfir_rs/compiled"
cargo bench -p benches --bench arithmetic -- "arithmetic/timely"

# Multiple specific tests
cargo bench -p benches --bench arithmetic -- "arithmetic/dfir_rs" "arithmetic/timely"
```

### Quick Comparison Mode

For rapid iteration during development:

```bash
# Shorter sample period
cargo bench -p benches -- --sample-size 10 --quick

# Specific measurement time
cargo bench -p benches -- --measurement-time 5
```

## Interpreting Results

### Reading Criterion Output

Criterion provides detailed statistics for each benchmark:

```
arithmetic/dfir_rs/compiled
                        time:   [485.23 µs 489.67 µs 494.52 µs]
                        thrpt:  [2.0222 Melem/s 2.0424 Melem/s 2.0611 Melem/s]
```

Key metrics:
- **time**: Execution time with confidence intervals [lower bound, mean, upper bound]
- **thrpt**: Throughput in operations per second
- **change**: Performance change vs. previous run (if available)

### Comparison with Baseline

When comparing to a previous run:

```
arithmetic/timely       time:   [1.2456 ms 1.2523 ms 1.2598 ms]
                        change: [-5.2341% -4.1234% -2.9876%] (p = 0.00 < 0.05)
                        Performance has improved.
```

Interpretation:
- **Negative change**: Performance improved (faster)
- **Positive change**: Performance degraded (slower)
- **p-value < 0.05**: Change is statistically significant

### Framework Comparison Matrix

After running all benchmarks, compare frameworks across patterns:

| Benchmark | Hydroflow (Compiled) | Hydroflow (Interpreted) | Timely | Winner |
|-----------|----------------------|-------------------------|--------|--------|
| Identity | ~X µs | ~Y µs | ~Z µs | ? |
| Arithmetic | ~X µs | ~Y µs | ~Z µs | ? |
| Fan-In | ~X µs | ~Y µs | ~Z µs | ? |
| Fan-Out | ~X µs | ~Y µs | ~Z µs | ? |
| Fork-Join | ~X µs | ~Y µs | ~Z µs | ? |
| Join | ~X µs | ~Y µs | ~Z µs | ? |
| Upcase | ~X µs | ~Y µs | ~Z µs | ? |

## Comparative Analysis

### Understanding Performance Characteristics

#### 1. Framework Overhead (Identity Benchmark)

The identity benchmark measures pure framework overhead:

```bash
cargo bench -p benches --bench identity
```

**What to look for**:
- Hydroflow compiled should show lowest overhead
- Hydroflow interpreted will show higher overhead due to runtime interpretation
- Timely may show moderate overhead due to worker coordination

**Why it matters**: Indicates baseline cost of using each framework.

#### 2. Computational Overhead (Arithmetic, Upcase)

These benchmarks include actual work:

```bash
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench upcase
```

**What to look for**:
- Relative performance shifts compared to identity
- How frameworks handle simple transformations
- Scaling behavior with amount of computation

**Why it matters**: Shows how frameworks handle typical dataflow operations.

#### 3. Stream Multiplexing (Fan-In, Fan-Out)

Multiple stream handling:

```bash
cargo bench -p benches --bench fan_in
cargo bench -p benches --bench fan_out
```

**What to look for**:
- How efficiently frameworks merge/split streams
- Memory allocation patterns
- Coordination overhead

**Why it matters**: Reflects performance on complex topologies.

#### 4. Parallelism (Fork-Join)

Parallel execution patterns:

```bash
cargo bench -p benches --bench fork_join
```

**What to look for**:
- Speedup from parallelism
- Synchronization overhead
- Thread utilization

**Why it matters**: Important for multi-core scaling.

#### 5. Complex Operations (Join, Reachability)

Realistic workloads:

```bash
cargo bench -p benches --bench join
cargo bench -p benches --bench reachability
```

**What to look for**:
- State management efficiency
- Algorithm-specific optimizations
- Memory usage patterns

**Why it matters**: Most representative of real-world performance.

### Baseline Comparisons (Arithmetic Only)

The arithmetic benchmark includes non-framework baselines:

```bash
cargo bench -p benches --bench arithmetic
```

Baselines:
- **raw**: Direct vector operations (theoretical minimum)
- **pipeline**: Multi-threaded channels (common alternative)
- **iter**: Standard Rust iterators
- **iter-collect**: Iterators with collections

Use these to understand:
- Absolute framework overhead
- How close frameworks get to theoretical optimum
- Trade-offs between ease of use and performance

### Statistical Significance

Criterion performs rigorous statistical analysis:

- **Warm-up phase**: Ensures stable CPU state
- **Measurement phase**: Multiple iterations for statistical validity
- **Outlier detection**: Identifies and handles anomalous measurements
- **Regression analysis**: Detects performance regressions

Trust results when:
- ✅ Confidence intervals are narrow
- ✅ p-value < 0.05 for comparisons
- ✅ Multiple runs show consistent results

Be cautious when:
- ⚠️ Wide confidence intervals
- ⚠️ p-value > 0.05 (changes not significant)
- ⚠️ High variability between runs

## Performance Tracking

### Establishing Baselines

Create a baseline for future comparisons:

```bash
# Run all benchmarks and save as baseline
cargo bench -p benches --save-baseline main

# Or for specific framework version
cargo bench -p benches --save-baseline v0.1.0
```

### Comparing Against Baseline

After making changes:

```bash
# Compare current performance to baseline
cargo bench -p benches --baseline main

# See percentage changes and statistical significance
```

Output shows:
- Performance changes as percentages
- Statistical significance of changes
- Regression or improvement indicators

### Tracking Over Time

For longitudinal performance tracking:

```bash
# Regular benchmarking
cargo bench -p benches --save-baseline $(date +%Y-%m-%d)

# Compare against specific date
cargo bench -p benches --baseline 2024-11-23
```

### Automated Performance Monitoring

In CI/CD pipelines:

```yaml
# Example GitHub Actions
- name: Run benchmarks
  run: cargo bench -p benches --save-baseline ${{ github.sha }}

- name: Compare with main
  run: cargo bench -p benches --baseline main
  
- name: Check for regressions
  run: |
    # Parse criterion output for regressions
    # Fail if performance degrades > 10%
```

## Best Practices

### Environment Preparation

For reliable benchmarks:

1. **Close unnecessary applications**
   ```bash
   # Linux: check CPU load
   htop
   
   # Close browsers, IDEs, etc.
   ```

2. **Disable CPU frequency scaling** (if possible)
   ```bash
   # Linux: set governor to performance
   echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
   ```

3. **Ensure adequate cooling**
   - Let system cool down between runs
   - Monitor CPU temperature
   - Watch for thermal throttling

4. **Use consistent power settings**
   - Plugged into AC power (laptops)
   - Disable power saving modes
   - Turn off background tasks

### Running Methodology

For accurate comparisons:

1. **Run multiple times**
   ```bash
   # Run 3 times, use median
   cargo bench -p benches
   cargo bench -p benches
   cargo bench -p benches
   ```

2. **Use sufficient sample sizes**
   ```bash
   # Default is good, but can increase for stability
   cargo bench -p benches -- --sample-size 100
   ```

3. **Longer measurement times for small operations**
   ```bash
   # Increase measurement time for microsecond-scale benchmarks
   cargo bench -p benches -- --measurement-time 10
   ```

4. **Isolate changes**
   - Benchmark before and after specific changes
   - Don't mix multiple optimization attempts
   - Document what changed between runs

### Analysis Workflow

Systematic approach to performance analysis:

1. **Establish baseline**
   ```bash
   git checkout main
   cargo bench -p benches --save-baseline main
   ```

2. **Make changes**
   ```bash
   git checkout feature-branch
   # Make modifications
   ```

3. **Compare performance**
   ```bash
   cargo bench -p benches --baseline main
   ```

4. **Document results**
   - Note significant changes
   - Explain performance differences
   - Consider trade-offs

5. **Investigate regressions**
   - Profile code if needed
   - Check for algorithm changes
   - Verify compiler optimizations

### Reporting Performance

When sharing benchmark results:

1. **Include full context**
   - Hardware specifications (CPU, RAM, OS)
   - Software versions (Rust, dependencies)
   - Benchmark parameters used
   - Environmental conditions

2. **Show statistical data**
   - Mean and confidence intervals
   - Statistical significance (p-values)
   - Multiple run consistency

3. **Provide comparisons**
   - Baseline vs. current
   - Framework vs. framework
   - Relative performance ratios

4. **Share HTML reports**
   ```bash
   # Generate and share
   cargo bench -p benches
   tar czf benchmark-results.tar.gz target/criterion/
   ```

## Troubleshooting

### High Variability

**Problem**: Wide confidence intervals, inconsistent results

**Solutions**:
```bash
# Increase sample size
cargo bench -p benches -- --sample-size 200

# Increase measurement time
cargo bench -p benches -- --measurement-time 20

# Check system load
htop  # Close other processes

# Disable turbo boost (Linux)
echo 0 | sudo tee /sys/devices/system/cpu/intel_pstate/no_turbo
```

### Unexpected Performance

**Problem**: Results don't match expectations

**Solutions**:
1. Check compiler optimization level
   ```bash
   # Benchmarks should run with --release
   cargo bench  # Automatically uses release mode
   ```

2. Verify dependencies are up-to-date
   ```bash
   cargo update
   cargo clean
   cargo bench -p benches
   ```

3. Profile to understand bottlenecks
   ```bash
   # Use cargo-flamegraph
   cargo install flamegraph
   cargo flamegraph --bench arithmetic -- --bench
   ```

### Comparison Failures

**Problem**: Can't compare against baseline

**Solutions**:
```bash
# List available baselines
ls target/criterion/*/base/

# Remove corrupted baseline
rm -rf target/criterion/*/baseline-name/

# Re-establish baseline
cargo bench -p benches --save-baseline baseline-name
```

### Build Issues

**Problem**: Benchmarks won't compile

**Solutions**:
```bash
# Clean build
cargo clean
cargo build --release

# Check dependency versions
cargo tree

# Update Cargo.lock
cargo update
```

### Missing Benchmarks

**Problem**: Some benchmarks don't run

**Solutions**:
1. Check Cargo.toml has [[bench]] entries
2. Verify benchmark files exist in benches/benches/
3. Check for compilation errors
   ```bash
   cargo build --benches
   ```

## Advanced Topics

### Custom Comparison Scripts

Automate framework comparison:

```bash
#!/bin/bash
# compare-frameworks.sh

echo "Running Hydroflow benchmarks..."
cargo bench -p benches -- "dfir_rs" > hydroflow-results.txt

echo "Running Timely benchmarks..."
cargo bench -p benches -- "timely" > timely-results.txt

echo "Comparing results..."
# Parse and compare results
python3 compare-results.py hydroflow-results.txt timely-results.txt
```

### Integration with Performance Tracking Systems

Export results to tracking systems:

```bash
# Export Criterion results to JSON
cargo bench -p benches -- --output-format json > results.json

# Parse and send to monitoring system
python3 export-to-monitoring.py results.json
```

### Continuous Benchmarking

Set up automated performance tracking:

```yaml
# .github/workflows/benchmark.yml
name: Continuous Benchmarking

on:
  push:
    branches: [main]
  pull_request:

jobs:
  benchmark:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      
      - name: Setup Rust
        uses: actions-rs/toolchain@v1
        
      - name: Run benchmarks
        run: cargo bench -p benches
        
      - name: Store results
        uses: actions/upload-artifact@v2
        with:
          name: benchmark-results
          path: target/criterion/
```

## Conclusion

Effective performance comparison requires:
- ✅ Systematic methodology
- ✅ Controlled environment
- ✅ Statistical rigor
- ✅ Proper interpretation
- ✅ Comprehensive documentation

This guide provides the foundation for reliable, reproducible performance comparisons between Hydroflow/dfir_rs, Timely, and Differential-Dataflow frameworks.

---

**Last Updated**: 2024-11-23  
**Maintained by**: BigWeaverServiceCanaryZetaIad Team