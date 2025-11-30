# Benchmark Guide

## Overview

This guide explains how to run, interpret, and contribute to the Hydro benchmarks that compare performance with timely and differential-dataflow implementations.

## Prerequisites

### System Requirements

- Rust 1.70 or later (check `rust-toolchain.toml` in main repository)
- Cargo
- Git
- Sufficient RAM (some benchmarks process large datasets)
- Stable internet connection (for fetching dependencies)

### Initial Setup

```bash
# Clone this repository
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps

# Build dependencies (this may take a while on first run)
cargo build -p benches
```

## Running Benchmarks

### Run All Benchmarks

To run all benchmarks in the suite:

```bash
cargo bench -p benches
```

This will execute all benchmark variations and generate HTML reports in `target/criterion/`.

### Run Specific Benchmark

To run a specific benchmark:

```bash
# Run the reachability benchmark
cargo bench -p benches --bench reachability

# Run the identity benchmark
cargo bench -p benches --bench identity

# Run the join benchmark
cargo bench -p benches --bench join
```

### Run Benchmark with Specific Filter

Criterion supports filtering by benchmark name:

```bash
# Run only Hydro variants
cargo bench -p benches --bench reachability -- hydro

# Run only timely variants
cargo bench -p benches --bench identity -- timely

# Run specific size variations
cargo bench -p benches --bench fan_in -- "size/1000"
```

### Baseline Comparisons

To save a baseline for comparison:

```bash
# Save current results as baseline
cargo bench -p benches -- --save-baseline my-baseline

# Compare against baseline
cargo bench -p benches -- --baseline my-baseline
```

## Benchmark Descriptions

### arithmetic.rs

**Purpose**: Tests basic arithmetic operations on streams

**Variants**:
- Hydro implementation
- Timely implementation
- Different operation counts

**Measures**: Throughput of arithmetic operations in dataflow

**Use case**: Validating basic operation performance

### fan_in.rs

**Purpose**: Tests merging multiple streams into one

**Variants**:
- Different numbers of input streams (2, 4, 8, 16)
- Hydro vs Timely implementations

**Measures**: Union/merge operation performance

**Use case**: Understanding overhead of stream merging

### fan_out.rs

**Purpose**: Tests splitting one stream into multiple outputs

**Variants**:
- Different numbers of output streams (2, 4, 8, 16)
- Hydro vs Timely implementations

**Measures**: Tee/split operation performance

**Use case**: Understanding overhead of stream duplication

### fork_join.rs

**Purpose**: Tests fork-join patterns (split, process, merge)

**Variants**:
- Different numbers of fork levels
- Filtered splits

**Measures**: Complex dataflow pattern performance

**Use case**: Real-world pattern validation

### futures.rs

**Purpose**: Tests async/futures-based operations

**Variants**:
- Different async operation types
- Hydro vs native async implementations

**Measures**: Async operation overhead

**Use case**: Validating async integration

### identity.rs

**Purpose**: Tests minimal overhead (identity transformation)

**Variants**:
- Different input sizes (1K, 10K, 100K, 1M elements)
- Hydro vs Timely implementations

**Measures**: Baseline dataflow overhead

**Use case**: Understanding minimum performance cost

### join.rs

**Purpose**: Tests join operations between streams

**Variants**:
- Different join sizes
- Different key distributions
- Hydro vs Timely implementations

**Measures**: Join operation performance

**Use case**: Database-like operation validation

### micro_ops.rs

**Purpose**: Tests individual micro-operations

**Variants**:
- Map, filter, fold operations
- Different input sizes
- Hydro vs Timely implementations

**Measures**: Per-operation overhead

**Use case**: Fine-grained performance analysis

### reachability.rs

**Purpose**: Tests graph reachability algorithms

**Variants**:
- Different graph sizes
- Hydro vs Differential implementations

**Measures**: Iterative computation performance

**Use case**: Complex algorithm validation

**Data**: Uses `reachability_edges.txt` (graph edges)

### symmetric_hash_join.rs

**Purpose**: Tests symmetric hash join implementation

**Variants**:
- Different data sizes
- Different key distributions

**Measures**: Join algorithm performance

**Use case**: Streaming join validation

### upcase.rs

**Purpose**: Tests string transformation operations

**Variants**:
- Different string lengths
- Different batch sizes

**Measures**: String operation performance

**Use case**: Text processing validation

### words_diamond.rs

**Purpose**: Tests diamond-shaped dataflow patterns

**Variants**:
- Different processing paths
- Merge strategies

**Measures**: Complex topology performance

**Use case**: Multi-path dataflow validation

**Data**: Uses `words_alpha.txt` (English word list)

## Interpreting Results

### Criterion Output

Criterion generates detailed statistics:

```
identity/hydro/1000     time:   [10.234 µs 10.567 µs 10.912 µs]
                        change: [-2.3421% +0.1234% +2.4567%] (p = 0.92 > 0.05)
                        No change in performance detected.
```

**Key metrics**:
- **time**: [lower_bound median upper_bound] - execution time range
- **change**: Performance change from previous run
- **p-value**: Statistical significance (< 0.05 means significant change)

### Performance Comparison

When comparing Hydro vs Timely/Differential:

1. **Lower is better**: Shorter execution times indicate better performance
2. **Check variance**: Wide bounds indicate unstable measurements
3. **Statistical significance**: p < 0.05 indicates real performance difference
4. **Relative performance**: Compare ratios, not absolute differences

### HTML Reports

Criterion generates HTML reports in `target/criterion/`:

```bash
# Open reports in browser
open target/criterion/report/index.html
```

Reports include:
- Performance plots
- Statistical analysis
- Comparison graphs
- Regression analysis

## Performance Analysis

### Expected Performance Characteristics

**Hydro vs Timely**:
- Hydro should have comparable performance (within 10-20%)
- Hydro may have slightly higher overhead due to abstractions
- Hydro benefits: better ergonomics and type safety

**When Hydro is Faster**:
- Operations with compiler optimizations
- Type-specialized implementations
- Eliminated runtime checks

**When Timely is Faster**:
- Highly optimized hot paths
- Lower-level control
- Minimal abstraction overhead

### Optimization Guidelines

If benchmarks show unexpected results:

1. **Profile the code**: Use `cargo flamegraph` or `perf`
2. **Check compilation**: Ensure release mode (`--release`)
3. **Verify data sizes**: Some operations scale non-linearly
4. **Review implementation**: Compare with reference implementations

## Troubleshooting

### Long Compilation Times

First build takes time due to dependencies:

```bash
# Build in release mode to ensure optimizations
cargo build --release -p benches
```

### Out of Memory

Some benchmarks use large datasets:

```bash
# Run with smaller data sizes
cargo bench -p benches --bench reachability -- "small"

# Increase system memory or swap
```

### Inconsistent Results

Performance can vary due to system load:

```bash
# Run with longer warm-up
cargo bench -p benches -- --warm-up-time 10

# Increase sample size
cargo bench -p benches -- --sample-size 1000

# Disable CPU scaling
sudo cpupower frequency-set --governor performance
```

### Dependency Issues

If git dependencies fail to fetch:

```bash
# Clear cargo cache
rm -rf ~/.cargo/git
cargo clean

# Retry build
cargo build -p benches
```

## Adding New Benchmarks

### Benchmark Template

```rust
use criterion::{black_box, criterion_group, criterion_main, Criterion};

fn my_benchmark(c: &mut Criterion) {
    c.bench_function("my_test", |b| {
        b.iter(|| {
            // Code to benchmark
            black_box(my_function());
        });
    });
}

criterion_group!(benches, my_benchmark);
criterion_main!(benches);
```

### Best Practices

1. **Use `black_box`**: Prevents compiler optimization of benchmark code
2. **Include setup**: Separate setup from measured code
3. **Multiple variants**: Compare different implementations
4. **Document**: Explain what the benchmark measures
5. **Realistic data**: Use representative inputs

### Adding to Cargo.toml

```toml
[[bench]]
name = "my_benchmark"
harness = false
```

## Continuous Integration

### Running in CI

Example GitHub Actions workflow:

```yaml
name: Benchmarks

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  benchmark:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Run benchmarks
        run: cargo bench -p benches --no-fail-fast
      - name: Archive results
        uses: actions/upload-artifact@v2
        with:
          name: benchmark-results
          path: target/criterion
```

### Performance Regression Detection

Use criterion's baseline feature:

```bash
# In CI, save baseline on main branch
cargo bench -p benches -- --save-baseline main

# On PR, compare against main
cargo bench -p benches -- --baseline main
```

## Advanced Usage

### Custom Criterion Configuration

Modify benchmark code to customize:

```rust
use criterion::Criterion;

let mut c = Criterion::default()
    .sample_size(1000)
    .warm_up_time(Duration::from_secs(5))
    .measurement_time(Duration::from_secs(10));
```

### Profiling Integration

Use profilers with benchmarks:

```bash
# Flamegraph
cargo flamegraph --bench identity -- --bench

# Perf
perf record --call-graph=dwarf cargo bench -p benches --bench identity
perf report
```

### Memory Profiling

```bash
# Valgrind massif
valgrind --tool=massif cargo bench -p benches --bench reachability

# DHAT
cargo bench -p benches --bench reachability --profile=profiling
```

## Contributing

### Submitting Benchmark Improvements

1. Fork the repository
2. Create a feature branch
3. Add/modify benchmarks
4. Run full benchmark suite
5. Document changes
6. Submit pull request with results

### Review Checklist

- [ ] Benchmark measures specific performance characteristic
- [ ] Multiple implementations compared (Hydro vs Timely/Differential)
- [ ] Realistic input data
- [ ] Documented purpose and interpretation
- [ ] Added to Cargo.toml
- [ ] Results included in PR description

## Resources

- [Criterion.rs Documentation](https://bheisler.github.io/criterion.rs/book/)
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)
- [Hydro Project](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)

## Support

For questions or issues:
- Open an issue in this repository
- Discuss in main repository for Hydro-specific questions
- Check existing benchmark documentation
