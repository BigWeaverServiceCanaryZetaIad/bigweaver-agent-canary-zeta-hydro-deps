# Performance Comparison Guide

## Overview

This guide explains how to use the benchmarks in this repository to compare performance between different implementations, track performance over time, and identify regressions.

## Table of Contents

1. [Comparing Implementations](#comparing-implementations)
2. [Tracking Performance Over Time](#tracking-performance-over-time)
3. [Cross-Repository Comparisons](#cross-repository-comparisons)
4. [Detecting Regressions](#detecting-regressions)
5. [Performance Analysis Workflow](#performance-analysis-workflow)
6. [Automated Comparison Tools](#automated-comparison-tools)

## Comparing Implementations

### Within a Single Benchmark

Each benchmark typically includes multiple implementations of the same operation. For example, `arithmetic.rs` includes:

- `arithmetic/dfir_rs/compiled` - Hydro compiled
- `arithmetic/timely` - Timely dataflow
- `arithmetic/raw` - Raw Rust baseline
- `arithmetic/iter` - Iterator baseline

#### Running the Comparison

```bash
# Run all implementations in the arithmetic benchmark
cargo bench --bench arithmetic
```

#### Reading Results

```
arithmetic/dfir_rs/compiled    time:   [124.67 µs 125.89 µs 127.11 µs]
arithmetic/timely              time:   [234.56 µs 235.67 µs 236.78 µs]
arithmetic/raw                 time:   [89.12 µs 90.23 µs 91.34 µs]
arithmetic/iter                time:   [78.45 µs 79.56 µs 80.67 µs]
```

**Performance Ratios**:
- Hydro vs Raw: 125.89 / 90.23 = **1.40x** (Hydro is 1.40x slower than raw)
- Hydro vs Timely: 235.67 / 125.89 = **1.87x** (Hydro is 1.87x faster than Timely)
- Hydro vs Iter: 125.89 / 79.56 = **1.58x** (Hydro is 1.58x slower than iterators)

### Across Multiple Benchmarks

To understand how different implementations perform across various patterns:

```bash
# Run multiple related benchmarks
cargo bench --bench arithmetic --bench identity --bench join
```

Create a comparison table:

| Benchmark | Hydro | Timely | Ratio (T/H) |
|-----------|-------|--------|-------------|
| arithmetic | 125.89 µs | 235.67 µs | 1.87x |
| identity | 45.23 µs | 89.12 µs | 1.97x |
| join | 456.78 µs | 789.12 µs | 1.73x |

This shows Hydro is consistently faster than Timely across these benchmarks.

## Tracking Performance Over Time

### Using Criterion's History

Criterion automatically tracks benchmark history:

```bash
# Initial baseline run
cargo bench --bench arithmetic

# After making changes
cargo bench --bench arithmetic
```

Output will show:
```
arithmetic/dfir_rs/compiled
                        time:   [123.45 µs 124.67 µs 125.89 µs]
                        change: [-5.2% -3.1% -1.0%] (p = 0.01 < 0.05)
                        Performance has improved.
```

### Explicit Baseline Management

For more control over comparisons:

```bash
# Save current state as baseline
cargo bench --bench arithmetic -- --save-baseline before_optimization

# Make changes...

# Compare against saved baseline
cargo bench --bench arithmetic -- --baseline before_optimization
```

### Long-term Tracking

For tracking over weeks/months:

```bash
# Create dated baseline
cargo bench --bench arithmetic -- --save-baseline $(date +%Y%m%d)

# Later, compare
cargo bench --bench arithmetic -- --baseline 20241124
```

### Historical Comparison

Criterion stores historical data in `target/criterion/<benchmark>/`. The HTML reports show:

- Line charts of performance over time
- Confidence intervals for each run
- Trend analysis

View reports:
```bash
open target/criterion/arithmetic/report/index.html
```

## Cross-Repository Comparisons

Since this repository depends on the main `bigweaver-agent-canary-hydro-zeta` repository, you can compare performance after changes to the main repo.

### Workflow

1. **Establish Baseline with Current Main Repo**:
   ```bash
   cd /projects/sandbox/bigweaver-agent-canary-zeta-hydro-deps
   cargo bench --bench arithmetic -- --save-baseline main_current
   ```

2. **Make Changes to Main Repository**:
   ```bash
   cd /projects/sandbox/bigweaver-agent-canary-hydro-zeta
   # Make changes to dfir_rs or other components...
   git commit -m "feat: optimize dataflow execution"
   ```

3. **Compare Performance**:
   ```bash
   cd /projects/sandbox/bigweaver-agent-canary-zeta-hydro-deps
   cargo bench --bench arithmetic -- --baseline main_current
   ```

4. **Review Results**:
   - Check percentage changes
   - Verify statistical significance (p < 0.05)
   - Review HTML reports for detailed analysis

### Comparing Specific Commits

To compare performance across specific commits of the main repository:

```bash
# Checkout specific commit in main repo
cd /projects/sandbox/bigweaver-agent-canary-hydro-zeta
git checkout <commit-hash-1>

# Run benchmarks
cd /projects/sandbox/bigweaver-agent-canary-zeta-hydro-deps
cargo bench --bench arithmetic -- --save-baseline commit1

# Checkout different commit
cd /projects/sandbox/bigweaver-agent-canary-hydro-zeta
git checkout <commit-hash-2>

# Compare
cd /projects/sandbox/bigweaver-agent-canary-zeta-hydro-deps
cargo bench --bench arithmetic -- --baseline commit1
```

## Detecting Regressions

### Automated Regression Detection

Criterion automatically detects significant changes:

```
Performance has regressed.  <-- Automatic detection
```

This is based on:
- Statistical significance (p-value < 0.05)
- Consistent change across multiple samples
- Change exceeds noise threshold

### Manual Regression Analysis

When reviewing benchmark results:

1. **Check Statistical Significance**: 
   - p < 0.05 indicates reliable change
   - p > 0.05 means change might be noise

2. **Evaluate Magnitude**:
   - < 5% change: Often acceptable
   - 5-15% change: Worth investigating
   - > 15% change: Significant, needs attention

3. **Consider Context**:
   - Does the change align with code modifications?
   - Is the regression in an expected area?
   - Are there corresponding improvements elsewhere?

### Regression Investigation Workflow

When a regression is detected:

1. **Confirm the Regression**:
   ```bash
   # Run benchmark multiple times
   cargo bench --bench arithmetic
   cargo bench --bench arithmetic
   cargo bench --bench arithmetic
   ```

2. **Isolate the Cause**:
   ```bash
   # Test if it's specific to one implementation
   cargo bench --bench arithmetic dfir_rs
   cargo bench --bench arithmetic timely
   ```

3. **Profile the Code**:
   ```bash
   # Generate flamegraph
   cargo flamegraph --bench arithmetic -- --bench
   
   # Or use perf
   cargo bench --bench arithmetic --no-run --profile profile
   perf record -g ./target/profile/deps/arithmetic-* --bench
   perf report
   ```

4. **Bisect Changes**:
   ```bash
   # In main repository
   cd /projects/sandbox/bigweaver-agent-canary-hydro-zeta
   git bisect start
   git bisect bad HEAD
   git bisect good <last-known-good-commit>
   
   # Test each commit
   cd /projects/sandbox/bigweaver-agent-canary-zeta-hydro-deps
   cargo bench --bench arithmetic
   # Mark as good or bad based on results
   ```

## Performance Analysis Workflow

### Standard Analysis Process

1. **Establish Baseline**:
   ```bash
   cargo bench -- --save-baseline baseline
   ```

2. **Make Changes**:
   - Implement optimizations
   - Refactor code
   - Update dependencies

3. **Run Benchmarks**:
   ```bash
   cargo bench -- --baseline baseline
   ```

4. **Analyze Results**:
   - Check absolute times
   - Review percentage changes
   - Examine HTML reports
   - Verify statistical significance

5. **Validate**:
   - Run multiple times
   - Test on different machines
   - Compare against expectations

6. **Document**:
   - Record significant changes
   - Note unexpected results
   - Update documentation if needed

### Comprehensive Comparison

For thorough analysis across all benchmarks:

```bash
# Save comprehensive baseline
cargo bench -- --save-baseline full_baseline

# Make changes...

# Run all benchmarks with comparison
cargo bench -- --baseline full_baseline > comparison_results.txt

# Review results
less comparison_results.txt
```

### Pattern Analysis

Compare performance across similar patterns:

```bash
# Fan patterns
cargo bench --bench fan_in --bench fan_out

# Join patterns  
cargo bench --bench join --bench symmetric_hash_join

# Transformation patterns
cargo bench --bench arithmetic --bench identity --bench upcase
```

## Automated Comparison Tools

### Script for Automated Comparison

Create a script `compare.sh`:

```bash
#!/bin/bash

# compare.sh - Automated benchmark comparison script

BASELINE=${1:-baseline}
BENCHMARK=${2:-""}

echo "=== Running Benchmarks ==="
echo "Baseline: $BASELINE"
echo "Benchmark: $BENCHMARK"
echo ""

if [ -z "$BENCHMARK" ]; then
    # Run all benchmarks
    cargo bench -- --baseline "$BASELINE"
else
    # Run specific benchmark
    cargo bench --bench "$BENCHMARK" -- --baseline "$BASELINE"
fi

echo ""
echo "=== Opening HTML Reports ==="
if command -v xdg-open &> /dev/null; then
    xdg-open target/criterion/report/index.html
elif command -v open &> /dev/null; then
    open target/criterion/report/index.html
else
    echo "HTML reports available at: target/criterion/report/index.html"
fi
```

Usage:
```bash
chmod +x compare.sh

# Compare all benchmarks against baseline
./compare.sh baseline

# Compare specific benchmark
./compare.sh baseline arithmetic
```

### JSON Output for Analysis

Export results as JSON for custom analysis:

```bash
# This requires modifying Criterion configuration in benchmarks
# See Criterion documentation for details on JSON output
cargo bench --bench arithmetic -- --output-format json > results.json
```

### Continuous Benchmarking

For CI/CD integration:

```yaml
# Example GitHub Actions workflow
name: Benchmarks

on:
  pull_request:
  push:
    branches: [main]

jobs:
  benchmark:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: actions-rs/toolchain@v1
        with:
          toolchain: stable
      
      - name: Run benchmarks
        run: |
          cargo bench --bench arithmetic -- --sample-size 10
      
      - name: Upload results
        uses: actions/upload-artifact@v2
        with:
          name: benchmark-results
          path: target/criterion/
```

## Best Practices

### When Comparing Performance

1. **Consistent Environment**:
   - Use the same machine
   - Close unnecessary applications
   - Disable CPU frequency scaling if possible
   - Ensure adequate cooling

2. **Multiple Runs**:
   - Run benchmarks 3-5 times
   - Look for consistency
   - Investigate if results vary significantly

3. **Statistical Rigor**:
   - Trust p-values < 0.05
   - Be skeptical of small changes without significance
   - Use larger sample sizes for small differences

4. **Holistic View**:
   - Don't optimize one benchmark at the expense of others
   - Consider real-world workloads
   - Balance performance with code clarity

### When Tracking Over Time

1. **Regular Baselines**:
   - Save baselines at major milestones
   - Use dated names for clarity
   - Document what changed between baselines

2. **Trend Analysis**:
   - Look for patterns over multiple runs
   - Investigate gradual degradation
   - Celebrate improvements

3. **Context Documentation**:
   - Note hardware changes
   - Record significant code changes
   - Track dependency updates

## Troubleshooting Comparisons

### Inconsistent Results

If comparisons show high variance:

1. Check system load during benchmarks
2. Ensure consistent CPU frequency
3. Increase sample size: `--sample-size 100`
4. Increase measurement time: `--measurement-time 10`

### Unexpected Changes

If benchmarks show unexpected results:

1. Verify all dependencies are at expected versions
2. Check for recent changes in main repository
3. Ensure build is in release mode
4. Clear target directory and rebuild

### Baseline Not Found

If baseline comparison fails:

```bash
# List available baselines
ls target/criterion/<benchmark>/

# Recreate baseline if needed
cargo bench --bench arithmetic -- --save-baseline baseline
```

## Example Workflows

### Pre-commit Performance Check

```bash
#!/bin/bash
# pre-commit-bench.sh

echo "Running quick performance check..."
cargo bench -- --sample-size 10 --measurement-time 1 > bench_output.txt

# Check for regressions (simplified)
if grep -q "Performance has regressed" bench_output.txt; then
    echo "WARNING: Performance regression detected!"
    echo "Review bench_output.txt for details"
    exit 1
fi

echo "Performance check passed"
```

### Weekly Performance Report

```bash
#!/bin/bash
# weekly-report.sh

DATE=$(date +%Y%m%d)
REPORT="performance_report_$DATE.txt"

echo "Weekly Performance Report - $DATE" > "$REPORT"
echo "=====================================" >> "$REPORT"
echo "" >> "$REPORT"

cargo bench -- --baseline week_ago >> "$REPORT" 2>&1

echo "" >> "$REPORT"
echo "Report saved to: $REPORT"
echo "HTML reports available at: target/criterion/report/index.html"

# Save new baseline for next week
cargo bench -- --save-baseline "baseline_$DATE" > /dev/null 2>&1
```

## References

- [Criterion.rs Book - Comparing Functions](https://bheisler.github.io/criterion.rs/book/user_guide/comparing_functions.html)
- [Statistical Methods in Benchmarking](https://bheisler.github.io/criterion.rs/book/user_guide/comparing_functions.html#statistical-benchmarking)
- Main Repository: `../bigweaver-agent-canary-hydro-zeta/`

---

**Last Updated**: November 24, 2024  
**Maintained By**: BigWeaverServiceCanaryZetaIad Team
