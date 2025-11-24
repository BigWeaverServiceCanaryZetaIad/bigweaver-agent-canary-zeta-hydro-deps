# Benchmark Guide

## Overview

This guide provides comprehensive information about running, understanding, and maintaining the benchmarks in the bigweaver-agent-canary-zeta-hydro-deps repository.

## Table of Contents

1. [Understanding the Benchmarks](#understanding-the-benchmarks)
2. [Running Benchmarks](#running-benchmarks)
3. [Interpreting Results](#interpreting-results)
4. [Benchmark Descriptions](#benchmark-descriptions)
5. [Best Practices](#best-practices)
6. [Advanced Usage](#advanced-usage)

## Understanding the Benchmarks

These benchmarks measure the performance of dataflow operations across different implementations. Each benchmark compares multiple approaches:

- **Hydro (dfir_rs)** - Our dataflow system with multiple execution modes:
  - `compiled` - Optimized compiled execution
  - `compiled_no_cheating` - Compiled with black_box to prevent over-optimization
  - `surface` - Surface syntax API
- **Timely** - Timely dataflow system
- **Differential** - Differential dataflow system (for incremental benchmarks)
- **Baselines** - Raw Rust implementations, iterators, pipelines

## Running Benchmarks

### Basic Commands

```bash
# Run all benchmarks
cargo bench

# Run a specific benchmark file
cargo bench --bench arithmetic

# Run benchmarks matching a pattern
cargo bench identity

# Run with verbose output
cargo bench -- --verbose

# Save baseline for future comparison
cargo bench --bench arithmetic -- --save-baseline my_baseline

# Compare against a saved baseline
cargo bench --bench arithmetic -- --baseline my_baseline
```

### Quick Development Iteration

For faster feedback during development:

```bash
# Reduce sample size (faster but less accurate)
cargo bench -- --sample-size 10

# Reduce measurement time
cargo bench -- --measurement-time 1

# Combine both for very quick checks
cargo bench -- --sample-size 10 --measurement-time 1
```

### Running Specific Benchmark Functions

```bash
# Run only timely benchmarks in arithmetic
cargo bench --bench arithmetic timely

# Run only compiled hydro benchmarks
cargo bench compiled

# Exclude certain benchmarks
cargo bench -- --skip raw
```

## Interpreting Results

### Understanding Output

```
arithmetic/dfir_rs/compiled
                        time:   [123.45 µs 124.67 µs 125.89 µs]
                        change: [-2.5% -1.2% +0.3%] (p = 0.23 > 0.05)
                        No change in performance detected.
```

- **Time Values**: [lower bound, estimate, upper bound] at 95% confidence
- **Change**: Percentage change from previous run
- **P-value**: Statistical significance (p < 0.05 indicates significant change)
- **Performance Detection**: Criterion's assessment of whether performance changed

### HTML Reports

Detailed reports are generated at `target/criterion/`:

```bash
# Open the main index
open target/criterion/report/index.html

# Open specific benchmark report
open target/criterion/arithmetic/report/index.html
```

HTML reports include:
- **Violin plots** showing distribution of measurements
- **Line charts** showing performance over time
- **Comparison charts** between different benchmarks
- **Statistical analysis** with outlier detection

### Comparing Results

#### Between Implementations

To compare different implementations (e.g., Hydro vs Timely):

1. Look at the absolute times for each implementation
2. Calculate the ratio: `timely_time / hydro_time` (e.g., 2.0x means Hydro is 2x faster)
3. Check the confidence intervals to ensure differences are significant

#### Over Time

Criterion automatically tracks performance history:

```bash
# Run benchmark to establish baseline
cargo bench --bench arithmetic

# Make changes...

# Run again to see comparison
cargo bench --bench arithmetic
```

The output will show percentage changes from the previous run.

## Benchmark Descriptions

### arithmetic.rs

**Purpose**: Measures performance of arithmetic operations in a pipeline

**Pattern**: Linear chain of map operations (20 operations by default)

**Implementations**:
- `pipeline` - Multi-threaded channels
- `raw` - Raw vector operations
- `iter` - Rust iterator chains
- `iter-collect` - Iterators with intermediate collections
- `dfir_rs/compiled` - Hydro compiled (optimized)
- `dfir_rs/compiled_no_cheating` - Hydro compiled (with black_box)
- `dfir_rs/surface` - Hydro surface syntax
- `timely` - Timely dataflow

**Input**: 1,000,000 integers

**What It Measures**: 
- Overhead of dataflow systems vs raw operations
- Effect of compilation optimizations
- Pipeline parallelism efficiency

### fan_in.rs

**Purpose**: Tests fan-in dataflow patterns (multiple inputs to single output)

**Pattern**: Multiple source streams merging into one

**What It Measures**:
- Union/merge operation performance
- Multi-input coordination overhead

### fan_out.rs

**Purpose**: Tests fan-out dataflow patterns (single input to multiple outputs)

**Pattern**: Single source splitting to multiple destinations

**What It Measures**:
- Tee/split operation performance
- Multi-output coordination overhead

### fork_join.rs

**Purpose**: Tests fork-join patterns with conditional branching

**Pattern**: Repeated splitting on condition and rejoining

**What It Measures**:
- Conditional routing performance
- Union after split efficiency
- Complex dataflow graph overhead

**Note**: Uses generated code (see `build.rs`)

### identity.rs

**Purpose**: Minimal benchmark measuring pure overhead

**Pattern**: Pass data through with minimal transformation

**What It Measures**:
- Baseline dataflow system overhead
- Scheduler and runtime costs
- Best-case performance

### join.rs

**Purpose**: Tests join operations between streams

**Pattern**: Joining two streams on keys

**What It Measures**:
- Join algorithm performance
- Hash table efficiency
- Multi-stream coordination

### reachability.rs

**Purpose**: Graph reachability computation (transitive closure)

**Pattern**: Iterative graph algorithm

**Input**: 
- Graph with 3,072 nodes
- 521 KB edge list (`reachability_edges.txt`)
- 38 KB expected results (`reachability_reachable.txt`)

**What It Measures**:
- Iterative algorithm performance
- State management in dataflow
- Differential dataflow incremental computation

**Implementations**:
- `dfir_rs` - Hydro implementation
- `timely` - Timely dataflow
- `differential` - Differential dataflow (incremental)

### upcase.rs

**Purpose**: String processing benchmark

**Pattern**: String transformation (uppercase conversion)

**Input**: Word list from `words_alpha.txt` (3.7 MB, ~370,000 words)

**What It Measures**:
- String processing performance
- Memory allocation overhead
- Dataflow with non-primitive types

### micro_ops.rs

**Purpose**: Micro-benchmarks of individual operations

**What It Measures**:
- Individual operator performance
- Operation composition costs
- Minimal transformation overhead

### symmetric_hash_join.rs

**Purpose**: Symmetric hash join implementation benchmark

**Pattern**: Join using symmetric hash join algorithm

**What It Measures**:
- Hash join algorithm variants
- Join optimization strategies

### words_diamond.rs

**Purpose**: Diamond pattern with string processing

**Pattern**: Split, process separately, rejoin

**Input**: Word list from `words_alpha.txt`

**What It Measures**:
- Diamond pattern efficiency
- String processing in complex graphs

### futures.rs

**Purpose**: Async/await and futures performance

**Pattern**: Asynchronous dataflow operations

**What It Measures**:
- Async runtime overhead
- Future composition costs
- Tokio integration performance

## Best Practices

### Running Benchmarks

1. **Stable Environment**: Close unnecessary applications, disable CPU frequency scaling if possible
2. **Multiple Runs**: Run benchmarks multiple times to ensure consistency
3. **Baseline Comparison**: Save baselines before making changes
4. **Isolate Changes**: Make one change at a time for clear attribution

### Interpreting Results

1. **Check Confidence Intervals**: Wide intervals indicate high variance
2. **Statistical Significance**: Don't trust small changes without statistical significance
3. **Multiple Metrics**: Consider both absolute time and relative performance
4. **Real-World Context**: Benchmark conditions may differ from production

### Adding New Benchmarks

1. **Clear Purpose**: Define what the benchmark measures
2. **Realistic Workload**: Use representative data sizes and patterns
3. **Multiple Implementations**: Include baselines for comparison
4. **Documentation**: Explain the benchmark in comments
5. **Reproducibility**: Use fixed seeds for random data

## Advanced Usage

### Custom Criterion Configuration

Edit benchmark files to customize Criterion:

```rust
use criterion::{Criterion, BenchmarkId};

fn my_benchmark(c: &mut Criterion) {
    let mut group = c.benchmark_group("my_group");
    group.sample_size(100);  // Custom sample size
    group.measurement_time(std::time::Duration::from_secs(10));  // Longer measurement
    
    group.bench_function("test", |b| {
        b.iter(|| {
            // benchmark code
        });
    });
    
    group.finish();
}
```

### Parameterized Benchmarks

Test with different input sizes:

```rust
fn bench_with_sizes(c: &mut Criterion) {
    let mut group = c.benchmark_group("sized");
    
    for size in [100, 1000, 10000].iter() {
        group.bench_with_input(BenchmarkId::from_parameter(size), size, |b, &size| {
            b.iter(|| {
                // benchmark with size
            });
        });
    }
    
    group.finish();
}
```

### Profiling Integration

To profile a specific benchmark:

```bash
# Build with profiling symbols
cargo bench --bench arithmetic --no-run --profile profile

# Find the benchmark binary
find target/profile -name "arithmetic-*" -type f

# Run with profiler (e.g., perf on Linux)
perf record -g ./target/profile/deps/arithmetic-<hash> --bench

# View results
perf report
```

### Flamegraph Generation

```bash
# Install cargo-flamegraph
cargo install flamegraph

# Generate flamegraph for a benchmark
cargo flamegraph --bench arithmetic -- --bench
```

### Comparing Against Main Repository

If the main repository has alternative implementations:

```bash
# In this repository
cargo bench --bench arithmetic -- --save-baseline deps_repo

# Make changes in main repo...

# Run again and compare
cargo bench --bench arithmetic -- --baseline deps_repo
```

## Troubleshooting

### High Variance

If benchmarks show high variance:

1. Close background applications
2. Disable CPU frequency scaling
3. Increase sample size: `cargo bench -- --sample-size 100`
4. Increase measurement time: `cargo bench -- --measurement-time 10`

### Outliers

Criterion detects and reports outliers. Many outliers may indicate:

- System interference (background processes)
- Memory pressure
- Thermal throttling
- Non-deterministic behavior in code

### Inconsistent Results

If results vary significantly between runs:

1. Check system load: `top` or `htop`
2. Ensure consistent CPU frequency
3. Verify no thermal throttling is occurring
4. Run multiple times and look for patterns

### Compilation Errors

If benchmarks fail to compile:

1. Verify path dependencies are correct
2. Ensure main repository is up to date
3. Check Rust toolchain version matches main repo
4. Clear target directory: `cargo clean`

## References

- [Criterion.rs Documentation](https://bheisler.github.io/criterion.rs/book/)
- [Hydro Project Documentation](../bigweaver-agent-canary-hydro-zeta/docs/)
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)

---

**Last Updated**: November 24, 2024  
**Maintained By**: BigWeaverServiceCanaryZetaIad Team
