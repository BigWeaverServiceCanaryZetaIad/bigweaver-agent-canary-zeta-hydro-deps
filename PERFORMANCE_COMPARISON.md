# Performance Comparison Guide

This guide explains how to run performance comparisons between Hydro/DFIR, timely-dataflow, and differential-dataflow using the benchmarks in this repository.

## Table of Contents

- [Quick Start](#quick-start)
- [Benchmark Categories](#benchmark-categories)
- [Running Comparisons](#running-comparisons)
- [Analyzing Results](#analyzing-results)
- [Best Practices](#best-practices)
- [Example Workflows](#example-workflows)
- [Interpreting Data](#interpreting-data)

## Quick Start

### Basic Comparison Run

```bash
# Clone the repository
git clone <repository-url>/bigweaver-agent-canary-zeta-hydro-deps
cd bigweaver-agent-canary-zeta-hydro-deps

# Run all benchmarks
cargo bench -p hydro-timely-benchmarks

# View results
open target/criterion/report/index.html
```

### Focused Comparison

Compare a specific operation across all frameworks:

```bash
cargo bench -p hydro-timely-benchmarks --bench arithmetic
```

## Benchmark Categories

### 1. Computational Benchmarks

**Purpose**: Compare raw computational performance

**Benchmarks**:
- `arithmetic`: Numerical operations (add, multiply, aggregate)
- `identity`: Baseline overhead (minimal computation)
- `upcase`: String transformations

**When to use**: 
- Evaluating framework overhead
- Understanding CPU-bound performance
- Baseline measurements

### 2. Data Flow Pattern Benchmarks

**Purpose**: Compare different data flow patterns

**Benchmarks**:
- `fan_in`: Multiple inputs to single output
- `fan_out`: Single input to multiple outputs  
- `fork_join`: Parallel processing with synchronization

**When to use**:
- Designing dataflow architectures
- Understanding parallelism overhead
- Evaluating routing performance

### 3. Join Operation Benchmarks

**Purpose**: Compare join implementations and memory patterns

**Benchmarks**:
- `join`: Standard equi-join operations
- `symmetric_hash_join`: Symmetric hash-based joins

**When to use**:
- Optimizing join-heavy workloads
- Memory usage analysis
- Scaling studies

### 4. Graph Algorithm Benchmarks

**Purpose**: Compare iterative dataflow algorithms

**Benchmarks**:
- `reachability`: Transitive closure computation

**When to use**:
- Fixed-point computation evaluation
- Iterative algorithm performance
- Convergence analysis

### 5. Complex Workflow Benchmarks

**Purpose**: Compare realistic multi-stage pipelines

**Benchmarks**:
- `words_diamond`: Diamond dataflow pattern
- `futures`: Asynchronous operations
- `micro_ops`: Fine-grained operations

**When to use**:
- End-to-end performance evaluation
- Real-world workflow simulation
- Composite operation analysis

## Running Comparisons

### Standard Comparison

Run all benchmarks with default settings:

```bash
cargo bench -p hydro-timely-benchmarks
```

**Output location**: `target/criterion/`

**Time estimate**: 10-30 minutes (depending on hardware)

### Category-Specific Comparison

Run specific benchmark categories:

```bash
# Computational benchmarks
cargo bench -p hydro-timely-benchmarks --bench arithmetic
cargo bench -p hydro-timely-benchmarks --bench identity
cargo bench -p hydro-timely-benchmarks --bench upcase

# Data flow patterns
cargo bench -p hydro-timely-benchmarks --bench fan_in
cargo bench -p hydro-timely-benchmarks --bench fan_out
cargo bench -p hydro-timely-benchmarks --bench fork_join

# Join operations
cargo bench -p hydro-timely-benchmarks --bench join
cargo bench -p hydro-timely-benchmarks --bench symmetric_hash_join

# Graph algorithms
cargo bench -p hydro-timely-benchmarks --bench reachability

# Complex workflows
cargo bench -p hydro-timely-benchmarks --bench words_diamond
cargo bench -p hydro-timely-benchmarks --bench futures
cargo bench -p hydro-timely-benchmarks --bench micro_ops
```

### Baseline Comparison

Establish a baseline for future comparisons:

```bash
# Save current results as baseline
cargo bench -p hydro-timely-benchmarks -- --save-baseline before-optimization

# Make code changes...

# Compare against baseline
cargo bench -p hydro-timely-benchmarks -- --baseline before-optimization
```

**Use cases**:
- Validating optimizations
- Regression testing
- A/B testing different implementations

### Time-Limited Comparison

For quick checks or CI environments:

```bash
# Reduce sample size and measurement time
cargo bench -p hydro-timely-benchmarks -- --sample-size 10 --measurement-time 5
```

## Analyzing Results

### Criterion Output Structure

```
target/criterion/
├── report/
│   └── index.html          # Main report entry point
├── arithmetic/
│   ├── report/
│   │   └── index.html      # Arithmetic benchmark report
│   └── ...
├── join/
│   ├── report/
│   │   └── index.html      # Join benchmark report
│   └── ...
└── ...
```

### HTML Reports

Open the main report:

```bash
open target/criterion/report/index.html
```

**Report contents**:
- Performance plots (time vs iterations)
- Statistical summaries (mean, std dev, confidence intervals)
- Comparison charts (current vs baseline)
- Detailed timing distributions

### Command-Line Output

During benchmark execution, Criterion prints:

```
arithmetic/dfir         time:   [48.234 µs 48.891 µs 49.621 µs]
arithmetic/timely       time:   [52.123 µs 52.789 µs 53.512 µs]
                        change: [+6.5% +8.1% +9.8%] (p = 0.00 < 0.05)
```

**Interpreting**:
- `time: [lower_bound mean upper_bound]`: 95% confidence interval
- `change`: Performance difference from baseline (if available)
- `p = 0.00 < 0.05`: Statistically significant change

### Extracting Data

Export benchmark data for analysis:

```bash
# JSON format (for programmatic analysis)
cargo bench -p hydro-timely-benchmarks -- --output-format json > results.json

# CSV format (for spreadsheets)
# Note: Requires post-processing of Criterion output
```

## Best Practices

### 1. System Preparation

**Before running benchmarks**:

```bash
# Linux: Set CPU governor to performance
sudo cpupower frequency-set --governor performance

# Close unnecessary applications
# Disable browser, IDEs, etc.

# Check system load
uptime  # Should show low load average
```

**Why**: Minimize external interference for consistent results

### 2. Multiple Runs

Always run benchmarks multiple times:

```bash
# Run 3 times and compare
for i in 1 2 3; do
    cargo bench -p hydro-timely-benchmarks -- --save-baseline run-$i
done
```

**Why**: Account for system variance and increase confidence

### 3. Warm Cache vs Cold Cache

**Warm cache** (default):
```bash
cargo bench -p hydro-timely-benchmarks
```

**Cold cache** (more realistic):
```bash
# Clear caches between runs (Linux)
sync; echo 3 | sudo tee /proc/sys/vm/drop_caches

cargo bench -p hydro-timely-benchmarks
```

**When to use each**:
- Warm cache: Optimistic performance, best-case scenarios
- Cold cache: Realistic performance, first-run behavior

### 4. Input Size Selection

Different input sizes reveal different characteristics:

- **Small inputs** (< 1K elements): Framework overhead dominates
- **Medium inputs** (1K - 100K): Balanced view of performance
- **Large inputs** (> 100K): Memory/cache effects visible

Adjust in benchmark source code as needed.

### 5. Statistical Rigor

Criterion provides confidence intervals:

```
time:   [48.234 µs 48.891 µs 49.621 µs]
         ^^^^^^^^  ^^^^^^^^  ^^^^^^^^
         lower     mean      upper
         95% confidence interval
```

**Guidelines**:
- Non-overlapping intervals → significant difference
- Large intervals → high variance (investigate causes)
- Narrow intervals → stable, reliable measurements

## Example Workflows

### Workflow 1: Evaluate New Optimization

**Scenario**: You've optimized a DFIR operator and want to measure impact

```bash
# 1. Establish baseline (before optimization)
git checkout main
cargo bench -p hydro-timely-benchmarks -- --save-baseline before

# 2. Apply optimization
git checkout feature/optimization

# 3. Run comparison
cargo bench -p hydro-timely-benchmarks -- --baseline before

# 4. Analyze results
open target/criterion/report/index.html
```

**Look for**:
- Percentage improvement in relevant benchmarks
- No regression in other benchmarks
- Statistical significance (non-overlapping confidence intervals)

### Workflow 2: Compare Framework Suitability

**Scenario**: Choosing between DFIR, Timely, or Differential for a new project

```bash
# 1. Identify relevant benchmarks
# For graph algorithms: reachability
# For joins: join, symmetric_hash_join
# For general dataflow: arithmetic, fan_in, fan_out

# 2. Run relevant benchmarks
cargo bench -p hydro-timely-benchmarks --bench reachability
cargo bench -p hydro-timely-benchmarks --bench join

# 3. Extract comparison data
# Review HTML reports for relative performance

# 4. Consider trade-offs
# - Absolute performance
# - Memory usage (visible in benchmark output)
# - Ease of implementation
# - Ecosystem maturity
```

### Workflow 3: Regression Detection

**Scenario**: Ensure new changes don't degrade performance

```bash
# 1. In CI or pre-commit hook
cargo bench -p hydro-timely-benchmarks -- --baseline main

# 2. Check for significant regressions
# Parse Criterion output for performance changes > 10%

# 3. Fail CI if regressions detected
# (Requires scripting around Criterion output)
```

### Workflow 4: Scaling Analysis

**Scenario**: Understand how performance scales with input size

```bash
# 1. Edit benchmark to test multiple sizes
# In benchmark source file (e.g., arithmetic.rs):
for size in [100, 1_000, 10_000, 100_000] {
    group.bench_with_input(BenchmarkId::new("dfir", size), &size, |b, &s| {
        // benchmark with size `s`
    });
}

# 2. Run benchmark
cargo bench -p hydro-timely-benchmarks --bench arithmetic

# 3. Analyze scaling behavior
# Check if performance scales linearly, sub-linearly, or super-linearly
```

## Interpreting Data

### Performance Metrics

#### Absolute Performance

**Metric**: Raw execution time (µs, ms, s)

**Interpretation**:
- Lower is better
- Consider in context of use case requirements
- Compare to baseline/budget

#### Relative Performance

**Metric**: Ratio between frameworks

```
DFIR:     48.891 µs
Timely:   52.789 µs
Ratio:    1.08x (DFIR is 8% faster)
```

**Interpretation**:
- < 1.1x: Roughly equivalent performance
- 1.1x - 2.0x: Noticeable difference
- > 2.0x: Significant performance gap

#### Throughput

**Metric**: Operations/items per second

**Calculation**: `input_size / execution_time`

**Example**:
- Processing 10,000 items in 50ms
- Throughput: 200,000 items/second

**Use case**: Evaluating streaming/batch processing capacity

#### Memory Usage

**Metric**: Peak memory consumption

**Note**: Criterion doesn't measure memory directly. Use additional tools:

```bash
# With Valgrind (Linux)
valgrind --tool=massif cargo bench --no-run
valgrind --tool=massif ./target/release/deps/arithmetic-<hash>

# With heaptrack (Linux)
heaptrack cargo bench -p hydro-timely-benchmarks --bench arithmetic
```

### Common Patterns

#### Pattern 1: Framework Overhead

**Observation**: Small input sizes show large performance differences

**Interpretation**: Framework setup/teardown dominates execution time

**Action**: 
- For small workloads, framework overhead matters
- Consider framework complexity vs performance needs

#### Pattern 2: Scaling Behavior

**Observation**: Performance ratio changes with input size

**Example**:
- Small inputs: DFIR 1.5x faster than Timely
- Large inputs: DFIR 0.8x slower than Timely

**Interpretation**: Different frameworks optimize for different workloads

**Action**: Choose framework based on expected workload characteristics

#### Pattern 3: High Variance

**Observation**: Large confidence intervals or inconsistent results

**Possible causes**:
- Background system activity
- Non-deterministic algorithms
- Memory/cache effects
- Thermal throttling

**Action**:
- Improve system isolation
- Increase sample size
- Investigate benchmark implementation

#### Pattern 4: Optimization Plateaus

**Observation**: Further optimizations show diminishing returns

**Interpretation**: Approaching theoretical limits or bottleneck elsewhere

**Action**: 
- Profile to find new bottlenecks
- Consider algorithmic changes rather than micro-optimizations

### Red Flags

⚠️ **Suspiciously fast results**: May indicate benchmark not measuring correctly

⚠️ **Inconsistent measurements**: High variance suggests system interference

⚠️ **Unrealistic scaling**: Performance should generally degrade with input size

⚠️ **Compiler optimizations**: Ensure benchmarks aren't optimized away

## Advanced Topics

### Custom Metrics

Extend benchmarks with custom measurements:

```rust
use criterion::{criterion_group, criterion_main, Criterion, BenchmarkId};

fn custom_metric_benchmark(c: &mut Criterion) {
    let mut group = c.benchmark_group("custom_metrics");
    
    group.bench_function("example", |b| {
        b.iter_custom(|iters| {
            let start = std::time::Instant::now();
            for _ in 0..iters {
                // Your code
            }
            start.elapsed()
        });
    });
}
```

### Profiling Integration

Combine benchmarks with profilers:

```bash
# CPU profiling with perf (Linux)
perf record -g cargo bench -p hydro-timely-benchmarks --bench arithmetic
perf report

# Flamegraphs
cargo install flamegraph
cargo flamegraph --bench arithmetic -p hydro-timely-benchmarks

# Memory profiling
heaptrack cargo bench -p hydro-timely-benchmarks --bench join
```

### Continuous Benchmarking

Track performance over time:

```yaml
# GitHub Actions example
name: Benchmark
on: [push, pull_request]

jobs:
  benchmark:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      
      - name: Run benchmarks
        run: cargo bench -p hydro-timely-benchmarks
        
      - name: Store results
        uses: benchmark-action/github-action-benchmark@v1
        with:
          tool: 'cargo'
          output-file-path: target/criterion/*/new/estimates.json
          github-token: ${{ secrets.GITHUB_TOKEN }}
          auto-push: true
```

## Troubleshooting

### Issue: Benchmarks fail to compile

**Solution**: Ensure dependencies are correctly specified in `Cargo.toml`

```bash
cargo clean
cargo build --release -p hydro-timely-benchmarks
```

### Issue: Results are inconsistent

**Solution**: Improve system isolation

```bash
# Check for background processes
top

# Kill unnecessary processes
# Close browsers, IDEs, etc.

# Run with higher sample size
cargo bench -p hydro-timely-benchmarks -- --sample-size 200
```

### Issue: Benchmarks take too long

**Solution**: Reduce sample size or measurement time

```bash
cargo bench -p hydro-timely-benchmarks -- --sample-size 10 --measurement-time 5
```

### Issue: Out of memory errors

**Solution**: Reduce input sizes in benchmark source code or increase system memory

## Further Resources

- [Criterion.rs Documentation](https://bheisler.github.io/criterion.rs/book/)
- [Rust Performance Book](https://nnethercote.github.io/perf-book/)
- [Statistical Analysis of Benchmarks](https://en.wikipedia.org/wiki/Benchmarking#Statistical_analysis)
- [Timely Dataflow Performance](https://github.com/TimelyDataflow/timely-dataflow/tree/master/communication/benches)

## Contributing

To improve this guide or add new comparison techniques, please open an issue or pull request.

---

**Last Updated**: December 2025
