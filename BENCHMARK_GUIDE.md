# Benchmark Guide

## Table of Contents

1. [Overview](#overview)
2. [Getting Started](#getting-started)
3. [Understanding Benchmarks](#understanding-benchmarks)
4. [Running Benchmarks](#running-benchmarks)
5. [Interpreting Results](#interpreting-results)
6. [Advanced Usage](#advanced-usage)
7. [Performance Analysis](#performance-analysis)
8. [Troubleshooting](#troubleshooting)

## Overview

This guide provides comprehensive information about running and understanding the Hydro performance benchmarks. These benchmarks compare Hydro's dataflow implementation against Timely Dataflow and Differential Dataflow.

### What These Benchmarks Measure

The benchmarks evaluate:
- **Throughput**: How much data can be processed per unit time
- **Latency**: How long it takes to process individual items
- **Scalability**: How performance changes with data volume
- **Comparative Performance**: Hydro vs. established frameworks

## Getting Started

### Prerequisites

Ensure you have:
1. Both repositories cloned side-by-side:
   ```
   workspace/
   ├── bigweaver-agent-canary-hydro-zeta/
   └── bigweaver-agent-canary-zeta-hydro-deps/
   ```
2. Rust toolchain installed (stable or nightly)
3. At least 4GB RAM available
4. Sufficient disk space (~2GB for build artifacts)

### Initial Setup

```bash
# Navigate to the benchmarks repository
cd bigweaver-agent-canary-zeta-hydro-deps

# Build all benchmarks (this may take several minutes)
cargo build -p hydro-deps-benches --release

# Verify everything works
./verify_benchmarks.sh
```

## Understanding Benchmarks

### Benchmark Categories

#### 1. Arithmetic (`arithmetic.rs`)

**Purpose**: Measures performance of basic arithmetic operations in a pipeline.

**What it tests**:
- Pipeline efficiency
- Operator chaining overhead
- Data transformation throughput

**Variants**:
- `arithmetic/pipeline` - Multi-threaded channel-based pipeline
- `arithmetic/raw` - Baseline single-threaded vector operations
- `arithmetic/dfir` - Hydro DFIR implementation
- `arithmetic/timely` - Timely dataflow implementation

**Key parameters**:
- `NUM_OPS`: Number of operations in pipeline (default: 20)
- `NUM_INTS`: Number of integers to process (default: 1,000,000)

#### 2. Fan-In (`fan_in.rs`)

**Purpose**: Tests merging multiple input streams into one.

**What it tests**:
- Stream merging efficiency
- Multi-source coordination
- Synchronization overhead

**Variants**:
- `fan_in/dfir` - Hydro implementation
- `fan_in/timely` - Timely implementation

#### 3. Fan-Out (`fan_out.rs`)

**Purpose**: Tests splitting one stream into multiple outputs.

**What it tests**:
- Stream splitting efficiency
- Broadcast performance
- Multi-consumer patterns

**Variants**:
- `fan_out/dfir` - Hydro implementation
- `fan_out/timely` - Timely implementation

#### 4. Fork-Join (`fork_join.rs`)

**Purpose**: Measures fork-join dataflow pattern performance.

**What it tests**:
- Parallel computation
- Stream synchronization
- Join efficiency

**Variants**:
- `fork_join/dfir` - Hydro implementation
- `fork_join/timely` - Timely implementation

#### 5. Identity (`identity.rs`)

**Purpose**: Measures overhead of the framework itself with no-op transformations.

**What it tests**:
- Framework overhead
- Minimum latency
- Memory efficiency

**Variants**:
- `identity/dfir` - Hydro implementation
- `identity/timely` - Timely implementation

#### 6. Join (`join.rs`)

**Purpose**: Tests stream join operations.

**What it tests**:
- Join algorithm efficiency
- State management
- Memory usage patterns

**Variants**:
- `join/dfir` - Hydro implementation
- `join/timely` - Timely implementation

#### 7. Reachability (`reachability.rs`)

**Purpose**: Graph reachability computation (most complex benchmark).

**What it tests**:
- Iterative computation
- Fixed-point algorithms
- Incremental computation (Differential)

**Variants**:
- `reachability/dfir` - Hydro implementation
- `reachability/timely` - Timely implementation
- `reachability/differential` - Differential Dataflow implementation

**Data files**:
- `reachability_edges.txt` - Graph edge list (~520KB)
- `reachability_reachable.txt` - Expected reachable nodes (~40KB)

#### 8. Upcase (`upcase.rs`)

**Purpose**: String transformation benchmark.

**What it tests**:
- String processing
- Memory allocation patterns
- Transformation overhead

**Variants**:
- `upcase/dfir` - Hydro implementation
- `upcase/timely` - Timely implementation

## Running Benchmarks

### Basic Commands

```bash
# Run all benchmarks (takes ~30-60 minutes)
cargo bench -p hydro-deps-benches

# Run specific benchmark
cargo bench -p hydro-deps-benches --bench arithmetic

# Run specific variant within a benchmark
cargo bench -p hydro-deps-benches --bench arithmetic -- dfir

# Run without generating HTML reports (faster)
cargo bench -p hydro-deps-benches -- --noplot
```

### Customizing Benchmark Runs

#### Adjust Measurement Time

```bash
# Shorter measurement time (less accurate, faster)
cargo bench -p hydro-deps-benches -- --measurement-time 5

# Longer measurement time (more accurate, slower)
cargo bench -p hydro-deps-benches -- --measurement-time 30
```

#### Adjust Sample Size

```bash
# Fewer samples (faster, less confidence)
cargo bench -p hydro-deps-benches -- --sample-size 20

# More samples (slower, higher confidence)
cargo bench -p hydro-deps-benches -- --sample-size 200
```

#### Warm-up Configuration

```bash
# Custom warm-up time
cargo bench -p hydro-deps-benches -- --warm-up-time 3
```

### Running Subsets

```bash
# Run only Hydro variants
cargo bench -p hydro-deps-benches -- dfir

# Run only Timely variants
cargo bench -p hydro-deps-benches -- timely

# Run only specific pattern
cargo bench -p hydro-deps-benches -- fan_
```

## Interpreting Results

### Reading Criterion Output

Typical output looks like:
```
arithmetic/dfir         time:   [45.123 ms 45.456 ms 45.789 ms]
                        change: [-2.3% -1.5% -0.7%] (p = 0.00 < 0.05)
                        Performance has improved.
```

**Components**:
- **time**: `[lower_bound estimate upper_bound]`
  - `lower_bound`: 95% confidence interval lower bound
  - `estimate`: Best estimate of the mean
  - `upper_bound`: 95% confidence interval upper bound

- **change**: Comparison with previous run
  - Shows percentage change in performance
  - Negative values indicate improvement (faster)
  - Positive values indicate regression (slower)

- **p-value**: Statistical significance
  - `p < 0.05`: Statistically significant change
  - `p >= 0.05`: Change could be due to noise

### HTML Reports

Open the detailed HTML report:
```bash
# macOS
open target/criterion/arithmetic/report/index.html

# Linux
xdg-open target/criterion/arithmetic/report/index.html

# Windows
start target/criterion/arithmetic/report/index.html
```

**HTML Report Features**:
- Interactive performance charts
- Distribution plots
- Regression analysis
- Historical comparisons
- Statistical details

### Comparing Implementations

To compare Hydro vs. Timely:

1. Run benchmarks: `cargo bench -p hydro-deps-benches`
2. Look at the time estimates for each variant
3. Calculate the ratio: `timely_time / dfir_time`
   - Ratio > 1: Hydro is faster
   - Ratio < 1: Timely is faster
   - Ratio ≈ 1: Similar performance

**Example**:
```
arithmetic/dfir    time: [45.456 ms ...]
arithmetic/timely  time: [52.123 ms ...]

Ratio: 52.123 / 45.456 ≈ 1.147
Result: Hydro is ~14.7% faster for this workload
```

## Advanced Usage

### Profiling with Performance Tools

#### Using `perf` (Linux)

```bash
# Record performance data
cargo bench -p hydro-deps-benches --bench arithmetic --profile-time 10

# Analyze with perf
perf record -g cargo bench -p hydro-deps-benches --bench arithmetic -- --profile-time 10
perf report
```

#### Using Flamegraph

```bash
# Install flamegraph
cargo install flamegraph

# Generate flamegraph for a benchmark
cargo flamegraph --bench arithmetic -p hydro-deps-benches
```

### Memory Profiling

Using `heaptrack` (Linux):
```bash
heaptrack cargo bench -p hydro-deps-benches --bench arithmetic
heaptrack_gui heaptrack.cargo.*.gz
```

Using `valgrind`:
```bash
valgrind --tool=massif cargo bench -p hydro-deps-benches --bench arithmetic --profile-time 1
ms_print massif.out.*
```

### Custom Benchmark Parameters

To modify benchmark parameters, edit the benchmark file directly:

```rust
// In benches/benches/arithmetic.rs
const NUM_OPS: usize = 20;      // Increase for longer pipelines
const NUM_INTS: usize = 1_000_000;  // Increase for more data
```

Then rebuild and run:
```bash
cargo bench -p hydro-deps-benches --bench arithmetic
```

## Performance Analysis

### Expected Performance Characteristics

#### Arithmetic
- **Hydro**: Should be competitive with Timely, ~10-20% variance
- **Overhead**: ~2-5% compared to raw implementation

#### Fan-In/Fan-Out
- **Hydro**: Should match or exceed Timely for simple patterns
- **Scalability**: Linear with number of streams (up to ~8-16)

#### Fork-Join
- **Hydro**: May have slight overhead vs. Timely (~5-15%)
- **Synchronization**: Key performance factor

#### Join
- **Performance**: Highly dependent on data distribution
- **State size**: Memory usage grows with join cardinality

#### Reachability
- **Differential**: Should be fastest (incremental computation)
- **Iterative**: Hydro and Timely should be similar
- **Convergence**: Depends on graph structure

### Performance Optimization Tips

1. **Use release builds**: Always benchmark with `--release`
2. **Warm-up**: Ensure sufficient warm-up time for JIT/caching
3. **Isolation**: Run on idle system for consistent results
4. **Multiple runs**: Run multiple times to account for variance
5. **Statistical significance**: Check p-values before concluding

### Common Performance Patterns

**Good Performance Indicators**:
- Narrow confidence intervals (< 5% variance)
- Consistent measurements across runs
- Low p-values for changes
- Expected throughput scaling

**Performance Red Flags**:
- Wide confidence intervals (> 10% variance)
- Sudden performance drops
- Unexpected memory growth
- Non-linear scaling

## Troubleshooting

### Benchmark Fails to Compile

```bash
# Clean and rebuild
cargo clean
cargo build -p hydro-deps-benches --release

# Check dependency paths
ls -la ../bigweaver-agent-canary-hydro-zeta/dfir_rs
```

### Inconsistent Results

**Causes**:
- System load (other processes)
- Thermal throttling
- Power management
- Non-deterministic timing

**Solutions**:
```bash
# Increase sample size
cargo bench -p hydro-deps-benches -- --sample-size 200

# Increase measurement time
cargo bench -p hydro-deps-benches -- --measurement-time 20

# Ensure idle system
# Close other applications
# Disable power-saving features
```

### Benchmarks Take Too Long

```bash
# Reduce measurement time
cargo bench -p hydro-deps-benches -- --measurement-time 5 --sample-size 20

# Run subset of benchmarks
cargo bench -p hydro-deps-benches --bench arithmetic --bench identity

# Skip HTML report generation
cargo bench -p hydro-deps-benches -- --noplot
```

### Out of Memory

**For reachability benchmark**:
- Reduce graph size in the data files
- Increase system swap space
- Run on machine with more RAM

**General**:
```bash
# Check memory usage
cargo bench -p hydro-deps-benches --bench <name> -- --profile-time 1
# Monitor with htop or Activity Monitor
```

### "Cannot find module" Errors

Ensure the main Hydro repository is correctly located:
```bash
# From bigweaver-agent-canary-zeta-hydro-deps
ls -la ../bigweaver-agent-canary-hydro-zeta/dfir_rs/Cargo.toml
```

If not, adjust the path in `benches/Cargo.toml`.

## Best Practices

1. **Consistent Environment**: Always run benchmarks on the same machine with similar conditions
2. **Version Control**: Track benchmark results over time with git
3. **Documentation**: Document any configuration changes or anomalies
4. **Statistical Rigor**: Use appropriate sample sizes and measurement times
5. **Comparison Context**: Always compare against baseline when evaluating changes

## References

- [Criterion.rs Documentation](https://bheisler.github.io/criterion.rs/book/)
- [Timely Dataflow Documentation](https://timelydataflow.github.io/timely-dataflow/)
- [Differential Dataflow Documentation](https://timelydataflow.github.io/differential-dataflow/)
- [Rust Performance Book](https://nnethercote.github.io/perf-book/)

## Contributing

To add new benchmarks or improve existing ones, see [CONTRIBUTING.md](CONTRIBUTING.md).
