# Benchmarking Guide

Comprehensive guide for running and analyzing performance benchmarks comparing Hydro/DFIR, Timely, and Differential-dataflow implementations.

## Table of Contents

- [Quick Start](#quick-start)
- [Understanding Benchmark Results](#understanding-benchmark-results)
- [Performance Comparison Methodology](#performance-comparison-methodology)
- [Benchmark Categories](#benchmark-categories)
- [Advanced Usage](#advanced-usage)
- [Interpreting Results](#interpreting-results)
- [Best Practices](#best-practices)
- [Troubleshooting](#troubleshooting)

## Quick Start

### Run All Benchmarks

```bash
cargo bench -p benches
```

This will:
1. Compile all benchmarks with optimizations
2. Run each benchmark multiple times for statistical confidence
3. Generate HTML reports in `target/criterion/`
4. Display summary results in the terminal

### Run Specific Benchmark

```bash
cargo bench -p benches --bench reachability
```

### View Results

Open the generated HTML report:
```bash
# Linux/macOS
open target/criterion/report/index.html

# Or just navigate to it in your browser
```

## Understanding Benchmark Results

### Terminal Output

When you run benchmarks, you'll see output like:

```
reachability/hydro      time:   [45.234 ms 46.123 ms 47.012 ms]
                        change: [-2.3456% -1.2345% +0.1234%] (p = 0.34 > 0.05)
                        No change in performance detected.

reachability/differential
                        time:   [52.456 ms 53.234 ms 54.012 ms]
                        change: [-0.5432% +0.3210% +1.2345%] (p = 0.23 > 0.05)
                        No change in performance detected.
```

#### Components Explained

- **time: [lower estimate upper]** 
  - Lower bound (2.5th percentile)
  - Point estimate (50th percentile/median)
  - Upper bound (97.5th percentile)
  
- **change: [lower estimate upper]**
  - Performance change compared to previous run
  - Negative = faster (improvement)
  - Positive = slower (regression)

- **p-value**
  - Statistical significance test
  - p < 0.05 = statistically significant change
  - p > 0.05 = no significant change detected

- **Performance verdict**
  - "Performance has improved" (faster with p < 0.05)
  - "Performance has regressed" (slower with p < 0.05)
  - "No change in performance detected" (p > 0.05)

### HTML Reports

The HTML reports provide:

1. **Violin Plots** - Distribution of execution times
2. **Line Charts** - Historical performance tracking
3. **Comparison Tables** - Side-by-side comparison of variants
4. **Statistical Details** - Detailed statistical analysis

## Performance Comparison Methodology

### Framework Variants

Most benchmarks include multiple implementations:

1. **Hydro/DFIR** (`*/hydro` or `*/dfir`)
   - The primary Hydro dataflow implementation
   - Uses the dfir_rs library
   - Focus on ergonomics and developer experience

2. **Timely** (`*/timely`)
   - Direct timely-dataflow implementation
   - Lower-level dataflow framework
   - Focus on raw performance

3. **Differential** (`*/differential`)
   - Differential-dataflow implementation
   - Incremental computation framework
   - Focus on dynamic data scenarios

4. **Reference Implementations** (`*/pipeline`, `*/raw`)
   - Baseline implementations using standard Rust
   - Help understand framework overhead

### Comparing Results

To compare implementations:

1. **Run full suite**:
   ```bash
   cargo bench -p benches 2>&1 | tee benchmark-results.txt
   ```

2. **Analyze in HTML report**: Open `target/criterion/report/index.html`

3. **Look for patterns**:
   - Which implementation is fastest for which workload?
   - How do frameworks compare on different patterns?
   - What is the overhead of each framework?

Example comparison table:

| Benchmark | Hydro | Timely | Differential | Winner |
|-----------|-------|--------|--------------|--------|
| arithmetic | 125ms | 110ms | 135ms | Timely |
| reachability | 46ms | 49ms | 53ms | Hydro |
| join | 78ms | 72ms | 68ms | Differential |

## Benchmark Categories

### 1. Dataflow Patterns

#### fan_in
Tests performance when multiple independent streams merge into one.

```bash
cargo bench -p benches --bench fan_in
```

**What it measures**: Stream merging overhead, coordination costs

**Implementations**: Hydro, Timely

#### fan_out
Tests performance when one stream splits into multiple independent streams.

```bash
cargo bench -p benches --bench fan_out
```

**What it measures**: Stream splitting overhead, data replication costs

**Implementations**: Hydro, Timely

#### fork_join
Tests combined fork-join patterns (split then merge).

```bash
cargo bench -p benches --bench fork_join
```

**What it measures**: Complex dataflow topology performance

**Implementations**: Hydro, Timely

### 2. Core Operations

#### arithmetic
Pipeline of arithmetic operations (repeated additions).

```bash
cargo bench -p benches --bench arithmetic
```

**What it measures**: Basic operation throughput, pipeline efficiency

**Implementations**: Hydro, Timely, Pipeline (reference)

#### identity
No-op transformations (data passing through unchanged).

```bash
cargo bench -p benches --bench identity
```

**What it measures**: Minimal framework overhead, baseline performance

**Implementations**: Hydro, Timely, Raw (reference)

#### join
Standard two-stream join operations.

```bash
cargo bench -p benches --bench join
```

**What it measures**: Join algorithm performance, state management

**Implementations**: Hydro, Timely, Differential

#### symmetric_hash_join
Symmetric hash join implementation comparison.

```bash
cargo bench -p benches --bench symmetric_hash_join
```

**What it measures**: Advanced join strategy performance

**Implementations**: Hydro, Differential

#### micro_ops
Fine-grained micro-operations for detailed analysis.

```bash
cargo bench -p benches --bench micro_ops
```

**What it measures**: Individual operation costs, framework granularity

**Implementations**: Hydro

### 3. Applications

#### reachability
Graph reachability computation on real graph data.

```bash
cargo bench -p benches --bench reachability
```

**What it measures**: Iterative computation, graph algorithms

**Implementations**: Hydro, Timely, Differential

**Data files**: 
- `reachability_edges.txt` - Graph structure
- `reachability_reachable.txt` - Expected results

#### upcase
String uppercase transformation workload.

```bash
cargo bench -p benches --bench upcase
```

**What it measures**: String processing, transformation pipeline

**Implementations**: Hydro, Timely

#### words_diamond
Word processing with diamond-shaped dataflow pattern.

```bash
cargo bench -p benches --bench words_diamond
```

**What it measures**: Complex data processing pipeline

**Implementations**: Hydro, Timely

**Data file**: `words_alpha.txt` (~466k English words)

#### futures
Async stream processing with futures.

```bash
cargo bench -p benches --bench futures
```

**What it measures**: Async/await performance, future composition

**Implementations**: Hydro

## Advanced Usage

### Baseline Management

#### Save Current Performance as Baseline

```bash
cargo bench -p benches --save-baseline main
```

This saves current measurements as the "main" baseline for future comparisons.

#### Compare Against Saved Baseline

```bash
cargo bench -p benches --baseline main
```

This runs benchmarks and compares against the "main" baseline.

#### Use Case: Testing Optimizations

```bash
# Before optimization
cargo bench -p benches --save-baseline before-opt

# Make your changes...

# After optimization
cargo bench -p benches --baseline before-opt
```

### Filtering Benchmarks

#### Run All Variants of One Benchmark

```bash
cargo bench -p benches --bench join
```

#### Run Specific Implementation

Use grep to filter output:
```bash
cargo bench -p benches | grep "hydro"
```

### Custom Sample Sizes

For quicker iterations (less accurate):
```bash
cargo bench -p benches -- --sample-size 10
```

For more accurate results (slower):
```bash
cargo bench -p benches -- --sample-size 500
```

### Warm-up Iterations

Adjust warm-up time:
```bash
cargo bench -p benches -- --warm-up-time 5
```

## Interpreting Results

### When to Trust Results

✅ **Trust results when**:
- p-value < 0.05 for claimed improvements/regressions
- Multiple runs show consistent results
- Change magnitude > 5% (meaningful difference)
- Running on dedicated hardware with minimal background processes

❌ **Be skeptical when**:
- p-value > 0.05 (not statistically significant)
- Results vary wildly between runs
- Change magnitude < 1-2% (likely noise)
- Running on busy system with other processes

### Performance Regression Detection

If you see:
```
Performance has regressed: [+8.2345% +10.1234% +12.3456%] (p = 0.00 < 0.05)
```

**Action items**:
1. Verify it's reproducible (run again)
2. Check what changed in the codebase
3. Profile to identify bottleneck
4. Consider if the regression is acceptable (feature vs. performance trade-off)

### Variance Analysis

High variance (wide confidence interval) suggests:
- Non-deterministic behavior
- External interference (system load)
- Cold cache effects
- Need for more samples

Example of high variance:
```
time: [45.234 ms 80.123 ms 115.012 ms]  <- Very wide range
```

## Best Practices

### 1. Consistent Environment

- **Same machine**: Run benchmarks on the same hardware
- **Minimal load**: Close unnecessary applications
- **Power settings**: Disable power management, CPU frequency scaling
- **Isolation**: Use dedicated benchmarking machine if possible

### 2. Multiple Runs

Don't rely on a single benchmark run:
```bash
# Run multiple times and look for consistency
cargo bench -p benches
cargo bench -p benches
cargo bench -p benches
```

### 3. Baseline Tracking

Maintain baselines for important releases:
```bash
cargo bench -p benches --save-baseline v1.0
cargo bench -p benches --save-baseline v1.1
cargo bench -p benches --save-baseline v1.2
```

### 4. Document Findings

Keep a log of benchmark results and analysis:
```markdown
## 2024-01-15: Optimization of join operator

Before: join/hydro - 78.5ms
After:  join/hydro - 65.2ms
Change: -17% improvement

Details: Switched to hash join algorithm...
```

### 5. Focus on Meaningful Differences

- < 1% difference: Likely noise, ignore
- 1-5% difference: Interesting if consistent
- 5-10% difference: Significant if p < 0.05
- \> 10% difference: Very significant, investigate

## Troubleshooting

### Compilation Errors

**Problem**: Dependencies fail to build

**Solution**:
```bash
# Clean and rebuild
cargo clean
cargo build -p benches

# Update dependencies
cargo update
```

### Benchmark Hangs

**Problem**: Benchmark never completes

**Solution**:
- Check if benchmark has infinite loop
- Reduce sample size for testing: `cargo bench -- --sample-size 10`
- Check system resources (memory, CPU)

### Inconsistent Results

**Problem**: Results vary significantly between runs

**Solution**:
1. Close background applications
2. Disable CPU frequency scaling
3. Increase sample size
4. Run on dedicated hardware

### Missing Data Files

**Problem**: Benchmark fails with file not found error

**Solution**:
```bash
# Verify data files exist
ls benches/benches/*.txt

# Data files should include:
# - reachability_edges.txt
# - reachability_reachable.txt
# - words_alpha.txt
```

### Out of Memory

**Problem**: System runs out of memory during benchmarks

**Solution**:
- Run benchmarks individually
- Reduce input sizes in benchmark configuration
- Add more RAM or use machine with more memory

## Additional Resources

- [Criterion.rs Documentation](https://bheisler.github.io/criterion.rs/book/)
- [Main Hydro Repository](https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)
- [Benchmark Migration Guide](https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta/-/blob/main/docs/docs/benchmarks/migration.md)

## Questions or Issues?

If you encounter problems or have questions about benchmarking:

1. Check this guide's troubleshooting section
2. Review the Criterion.rs documentation
3. Check the main repository's documentation
4. Open an issue in the repository
