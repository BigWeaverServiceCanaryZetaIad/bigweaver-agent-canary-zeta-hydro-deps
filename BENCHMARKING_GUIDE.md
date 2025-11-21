# Benchmarking Guide

This guide provides comprehensive instructions for running, interpreting, and contributing to the performance benchmarks in this repository.

## Overview

This repository contains performance benchmarks comparing three dataflow frameworks:
- **Hydroflow (dfir_rs)** - The main Hydro dataflow framework
- **Timely Dataflow** - A low-latency data-parallel dataflow system
- **Differential Dataflow** - An incremental computation framework built on Timely

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Running Benchmarks](#running-benchmarks)
3. [Understanding Results](#understanding-results)
4. [Benchmark Categories](#benchmark-categories)
5. [Performance Comparison Methodology](#performance-comparison-methodology)
6. [Troubleshooting](#troubleshooting)
7. [Contributing New Benchmarks](#contributing-new-benchmarks)

## Prerequisites

### Required Software

- Rust toolchain (specified in `rust-toolchain.toml`)
- Cargo (comes with Rust)
- Git (for cloning dependencies)

### Repository Setup

The benchmarks depend on the main Hydro repository. Ensure you have access to:
- This repository: `bigweaver-agent-canary-zeta-hydro-deps`
- Main Hydro repository: `bigweaver-agent-canary-hydro-zeta` (referenced via git dependencies)

The Cargo.toml automatically pulls `dfir_rs` and `sinktools` from the main repository via git dependencies.

## Running Benchmarks

### Run All Benchmarks

To execute all benchmarks:

```bash
cd /projects/sandbox/bigweaver-agent-canary-zeta-hydro-deps
cargo bench -p benches
```

This will:
1. Compile all benchmark code
2. Run each benchmark multiple times for statistical accuracy
3. Generate detailed HTML reports in `target/criterion/`

### Run Specific Benchmarks

To run individual benchmark suites:

```bash
# Arithmetic operations pipeline
cargo bench -p benches --bench arithmetic

# Graph reachability (includes differential dataflow)
cargo bench -p benches --bench reachability

# Join operations
cargo bench -p benches --bench join

# Fan-in pattern
cargo bench -p benches --bench fan_in

# Fan-out pattern
cargo bench -p benches --bench fan_out

# Fork-join pattern
cargo bench -p benches --bench fork_join

# Identity/pass-through operations
cargo bench -p benches --bench identity

# String operations (uppercase)
cargo bench -p benches --bench upcase
```

### Run Specific Test Cases

To run a specific test case within a benchmark:

```bash
cargo bench -p benches --bench arithmetic -- "arithmetic/timely"
cargo bench -p benches --bench arithmetic -- "arithmetic/dfir_rs"
```

### Baseline Comparison

To save a baseline for future comparison:

```bash
cargo bench -p benches --bench arithmetic -- --save-baseline my-baseline
```

To compare against a saved baseline:

```bash
cargo bench -p benches --bench arithmetic -- --baseline my-baseline
```

## Understanding Results

### Criterion Output

Criterion provides several key metrics:

```
arithmetic/timely       time:   [45.123 ms 45.456 ms 45.789 ms]
                        change: [-2.5% +0.1% +2.8%] (p = 0.95)
```

- **time**: The measurement range (lower bound, estimate, upper bound)
- **change**: Performance change compared to previous run
- **p-value**: Statistical confidence (0.95 = 95% confidence)

### HTML Reports

Detailed reports are generated at:
```
target/criterion/[benchmark-name]/[test-case]/report/index.html
```

These reports include:
- Violin plots showing distribution
- Iteration time comparisons
- Regression analysis
- Historical trends

### Interpreting Performance

When comparing frameworks:

1. **Throughput Benchmarks** (e.g., arithmetic, identity)
   - Lower time = Better performance
   - Compare total execution time for processing same data volume

2. **Latency Benchmarks** (e.g., fan_in, fan_out)
   - Measures time for data to flow through the pipeline
   - Important for real-time applications

3. **Complex Operations** (e.g., reachability, join)
   - Tests framework efficiency for sophisticated algorithms
   - May show different performance characteristics

## Benchmark Categories

### 1. Data Transformation Benchmarks

**Files**: `arithmetic.rs`, `identity.rs`, `upcase.rs`

Test basic data transformation operations:
- Map operations
- Data copying and movement
- String transformations

**What they measure**: Raw throughput and operator overhead

### 2. Flow Pattern Benchmarks

**Files**: `fan_in.rs`, `fan_out.rs`, `fork_join.rs`

Test common dataflow patterns:
- **Fan-in**: Multiple streams merging into one
- **Fan-out**: One stream splitting to multiple consumers
- **Fork-join**: Parallel processing with synchronization

**What they measure**: Framework efficiency in handling branching dataflows

### 3. Data Operations Benchmarks

**Files**: `join.rs`

Test relational operations:
- Hash joins
- Stream joins
- Data correlation

**What they measure**: Complex operation performance and memory efficiency

### 4. Graph Algorithm Benchmarks

**Files**: `reachability.rs`

Test incremental computation:
- Graph traversal
- Transitive closure
- Differential dataflow capabilities

**What they measure**: Incremental computation efficiency and convergence speed

## Performance Comparison Methodology

### Fair Comparison Principles

All benchmarks follow these principles for fair comparison:

1. **Same Input Data**: All frameworks process identical inputs
2. **Same Operations**: Equivalent operations across frameworks
3. **Same Output**: Results are validated for correctness
4. **Warm-up**: Criterion handles warm-up automatically
5. **Statistical Rigor**: Multiple iterations with outlier detection

### Baseline Implementations

Each benchmark includes baseline implementations:
- **raw**: Minimal overhead reference implementation
- **iter**: Iterator-based Rust implementation
- **pipeline**: Thread-based pipeline (where applicable)

These provide context for framework overhead.

### Framework Variants

For Hydroflow, we test multiple API styles:
- **compiled**: Pre-compiled sink-based API
- **surface**: Higher-level dfir_syntax! macro
- **compiled_no_cheating**: Prevents compiler optimizations with black_box

## Troubleshooting

### Common Issues

#### 1. Git Dependency Errors

**Error**: `failed to load manifest for dependency 'dfir_rs'`

**Solution**: Ensure the main Hydro repository is accessible. Check network connectivity and git credentials.

#### 2. Build Failures

**Error**: Compilation errors in benchmark code

**Solution**: 
```bash
# Clean build artifacts
cargo clean

# Update dependencies
cargo update

# Try building without running
cargo build -p benches
```

#### 3. Slow Benchmark Execution

**Issue**: Benchmarks taking too long

**Solution**: Reduce sample size or duration:
```bash
cargo bench -p benches -- --sample-size 10 --warm-up-time 1
```

#### 4. Inconsistent Results

**Issue**: High variance in benchmark results

**Possible causes**:
- System load (other processes running)
- CPU throttling
- Background services

**Solution**: 
- Close unnecessary applications
- Disable CPU frequency scaling
- Run benchmarks multiple times

### Performance Tuning

For more stable results:

```bash
# Disable CPU frequency scaling (Linux)
echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor

# Set CPU affinity (Linux)
taskset -c 0 cargo bench -p benches

# Increase process priority
nice -n -20 cargo bench -p benches
```

## Contributing New Benchmarks

### Benchmark Template

When adding new benchmarks, follow this structure:

```rust
use criterion::{Criterion, black_box, criterion_group, criterion_main};
use dfir_rs::dfir_syntax;
use timely::dataflow::operators::{Inspect, Map, ToStream};

// Configuration constants
const BENCHMARK_SIZE: usize = 1_000_000;

// Baseline implementation
fn benchmark_raw(c: &mut Criterion) {
    c.bench_function("my_benchmark/raw", |b| {
        b.iter(|| {
            // Minimal overhead implementation
            black_box(/* computation */);
        });
    });
}

// Hydroflow implementation
fn benchmark_hydroflow(c: &mut Criterion) {
    c.bench_function("my_benchmark/dfir_rs", |b| {
        b.iter_batched(
            || {
                dfir_syntax! {
                    // Hydroflow graph definition
                }
            },
            |mut df| {
                df.run_available_sync();
            },
            criterion::BatchSize::SmallInput,
        )
    });
}

// Timely Dataflow implementation
fn benchmark_timely(c: &mut Criterion) {
    c.bench_function("my_benchmark/timely", |b| {
        b.iter(|| {
            timely::example(|scope| {
                // Timely graph definition
            });
        })
    });
}

// For incremental computation, add Differential Dataflow
fn benchmark_differential(c: &mut Criterion) {
    c.bench_function("my_benchmark/differential", |b| {
        b.iter(|| {
            // Differential dataflow implementation
        })
    });
}

criterion_group!(
    my_benchmark_group,
    benchmark_raw,
    benchmark_hydroflow,
    benchmark_timely,
    benchmark_differential,
);
criterion_main!(my_benchmark_group);
```

### Adding to Cargo.toml

Register the new benchmark in `benches/Cargo.toml`:

```toml
[[bench]]
name = "my_benchmark"
harness = false
```

### Documentation Requirements

When adding benchmarks:

1. Add description to `benches/README.md`
2. Document what the benchmark measures
3. Include any special data files needed
4. Update this guide if introducing new patterns

### Validation

Ensure your benchmark:

1. **Produces Correct Results**: Validate output across all implementations
2. **Measures Relevant Metrics**: Focus on meaningful performance aspects
3. **Runs in Reasonable Time**: Each test case should complete in seconds, not minutes
4. **Has Clear Purpose**: Document what performance aspect is being tested

### Review Checklist

Before submitting:

- [ ] Benchmark compiles without warnings
- [ ] All implementations produce identical results
- [ ] Benchmark runs successfully with `cargo bench`
- [ ] Documentation updated
- [ ] Code follows existing style conventions
- [ ] Appropriate use of `black_box` to prevent optimization
- [ ] Configuration constants clearly defined

## Advanced Topics

### Custom Criterion Configuration

Modify benchmark behavior in code:

```rust
use criterion::{Criterion, BenchmarkId, Throughput};

fn custom_benchmark(c: &mut Criterion) {
    let mut group = c.benchmark_group("my_group");
    
    // Configure sample size
    group.sample_size(100);
    
    // Configure throughput measurement
    group.throughput(Throughput::Elements(BENCHMARK_SIZE as u64));
    
    // Add parametric benchmarks
    for size in [1000, 10000, 100000] {
        group.bench_with_input(
            BenchmarkId::from_parameter(size),
            &size,
            |b, &size| {
                b.iter(|| { /* benchmark with size */ });
            }
        );
    }
    
    group.finish();
}
```

### Profiling

To profile benchmarks:

```bash
# With perf (Linux)
cargo bench -p benches --bench arithmetic -- --profile-time=5

# With flamegraph
cargo flamegraph --bench arithmetic -p benches
```

### Memory Profiling

Check memory usage:

```bash
# With valgrind massif
valgrind --tool=massif cargo bench -p benches --bench arithmetic -- --test
```

## Best Practices

1. **Always use `black_box`** to prevent compiler optimizations from eliminating work
2. **Validate correctness** before measuring performance
3. **Use consistent input sizes** across frameworks for fair comparison
4. **Document assumptions** about data distributions or patterns
5. **Run on consistent hardware** for reproducible results
6. **Include baseline implementations** for context
7. **Measure end-to-end** including setup and teardown when relevant

## References

- [Criterion.rs Documentation](https://bheisler.github.io/criterion.rs/book/)
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)
- [Hydroflow Documentation](https://hydro.run/)

## Getting Help

If you encounter issues:

1. Check this guide's [Troubleshooting](#troubleshooting) section
2. Review existing benchmark implementations
3. Check Criterion.rs documentation
4. Consult the main Hydro repository documentation
