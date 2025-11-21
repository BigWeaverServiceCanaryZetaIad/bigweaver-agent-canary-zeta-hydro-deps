# Comprehensive Benchmarking Guide

This guide provides detailed information about running, interpreting, and extending the Hydroflow external framework benchmarks.

## Table of Contents

1. [Overview](#overview)
2. [Running Benchmarks](#running-benchmarks)
3. [Understanding Results](#understanding-results)
4. [Framework Comparison Methodology](#framework-comparison-methodology)
5. [Benchmark Details](#benchmark-details)
6. [Performance Analysis](#performance-analysis)
7. [Troubleshooting](#troubleshooting)

## Overview

This benchmark suite compares Hydroflow performance against established dataflow frameworks:

- **Timely Dataflow**: Low-level dataflow coordination framework
- **Differential Dataflow**: Incremental computation on top of Timely
- **Hydroflow**: Modern dataflow framework with multiple programming models

The benchmarks implement equivalent dataflow patterns to enable fair comparisons across different implementation approaches.

## Running Benchmarks

### Prerequisites

Ensure you have:
- Rust 1.70+ (uses edition 2021)
- 4GB+ RAM for larger benchmarks
- Release mode for accurate measurements

### Basic Commands

```bash
# Run all benchmarks
cargo bench

# Run specific benchmark suite
cargo bench --bench identity_comparison
cargo bench --bench join_comparison
cargo bench --bench reachability_comparison

# Run with specific number of samples
cargo bench -- --sample-size 10

# Save baseline for comparison
cargo bench -- --save-baseline my_baseline

# Compare against baseline
cargo bench -- --baseline my_baseline
```

### Advanced Options

```bash
# Run only Timely implementations
cargo bench --bench identity_comparison -- timely

# Run with verbose output
cargo bench -- --verbose

# Run quick mode (fewer samples)
cargo bench -- --quick

# Run specific test within a benchmark
cargo bench --bench identity_comparison -- "identity/timely"
```

## Understanding Results

### Criterion Output

Criterion provides:
- **Mean time**: Average execution time
- **Std deviation**: Measure of variance
- **Median**: Middle value (robust to outliers)
- **MAD**: Median Absolute Deviation

Example output:
```
identity/timely        time:   [45.234 ms 45.891 ms 46.612 ms]
                       change: [-2.3456% +0.1234% +2.7890%] (p = 0.89)
                       No change in performance detected.
```

### Throughput Metrics

Calculate elements per second:
```
throughput = elements_processed / execution_time_seconds
```

For identity benchmark with 1M elements:
- Time: 45.891 ms
- Throughput: 1,000,000 / 0.045891 = ~21.8M elements/sec

### HTML Reports

Open detailed reports:
```bash
open target/criterion/report/index.html
```

Reports include:
- Violin plots showing distribution
- Iteration time trends
- Comparison charts
- Statistical analysis

## Framework Comparison Methodology

### Fair Comparison Principles

1. **Equivalent Operations**: Each implementation performs the same logical computation
2. **Same Input Data**: All frameworks process identical inputs
3. **Warm Caches**: Multiple iterations ensure caches are warm
4. **Release Mode**: Always benchmark in release mode
5. **Isolated Execution**: No other heavy processes running

### What We Measure

- **Throughput**: Elements processed per second
- **Latency**: End-to-end execution time
- **Overhead**: Framework overhead vs baseline
- **Scalability**: Performance with varying input sizes

### What We Don't Measure

- **Memory Usage**: Not directly measured (future work)
- **Distributed Performance**: Single-node only
- **Startup Time**: Benchmarks measure steady-state
- **Compilation Time**: Not included in measurements

## Benchmark Details

### Identity Benchmark

**Purpose**: Measure pure framework overhead with minimal computation.

**Pattern**:
```
source -> map(f1) -> map(f2) -> ... -> map(f20) -> sink
```

**Key Insights**:
- Framework scheduling overhead
- Function call overhead
- Data movement costs

**Expected Performance Order**:
1. Raw iteration (baseline)
2. Hydroflow compiled
3. Timely Dataflow
4. Hydroflow scheduled

### Join Benchmark

**Purpose**: Measure hash join performance.

**Pattern**:
```
left_stream  ─┐
              ├─> join -> output
right_stream ─┘
```

**Key Insights**:
- Hash table performance
- State management overhead
- Memory allocation patterns

**Expected Performance Order**:
1. Baseline sequential
2. Hydroflow
3. Timely (with coordination overhead)

### Reachability Benchmark

**Purpose**: Iterative graph algorithm with fixed-point computation.

**Pattern**:
```
roots -> iterate { v -> neighbors(v) -> distinct } -> output
```

**Key Insights**:
- Iteration overhead
- State management
- Fixed-point detection

**Expected Performance Order**:
1. Baseline BFS (optimized for this specific case)
2. Differential Dataflow (incremental)
3. Hydroflow
4. Timely with feedback

**Notes**:
- Differential shines with multiple queries
- Single-query benchmarks favor specialized algorithms
- Real benefits appear with incremental updates

### Fan-In/Fan-Out Benchmarks

**Purpose**: Measure stream merging and splitting overhead.

**Pattern (Fan-In)**:
```
stream1 ─┐
stream2 ─┤
stream3 ─┼─> union -> output
  ...   ─┤
streamN ─┘
```

**Pattern (Fan-Out)**:
```
         ┌─> consumer1
         ├─> consumer2
source ──┼─> consumer3
         ├─> ...
         └─> consumerN
```

**Key Insights**:
- Data cloning overhead
- Scheduling complexity
- Memory bandwidth

### Fork-Join Benchmark

**Purpose**: Split-process-merge pattern.

**Pattern**:
```
         ┌─> filter(even) ─┐
source ──┤                 ├─> union -> output
         └─> filter(odd) ──┘
```

**Key Insights**:
- Branch prediction
- Filter selectivity
- Merge overhead

### Arithmetic Benchmark

**Purpose**: Computational workload with actual computation.

**Pattern**:
```
source -> compute -> compute -> ... -> compute -> sink
```

**Key Insights**:
- Computation vs framework overhead
- Pipeline optimization
- SIMD opportunities

## Performance Analysis

### Interpreting Speedup

Speedup = Baseline_Time / Framework_Time

- **Speedup > 1.0**: Faster than baseline
- **Speedup = 1.0**: Same as baseline
- **Speedup < 1.0**: Slower than baseline

Example:
```
Baseline: 100ms
Framework: 80ms
Speedup: 100/80 = 1.25x (25% faster)
```

### When to Trust Results

✅ **Trust when**:
- Standard deviation < 5% of mean
- Multiple runs show consistency
- Results match expectations
- P-value indicates significance

❌ **Be cautious when**:
- High variance (check for background processes)
- Unexpected results (validate implementation)
- Very small execution times (< 1ms)
- Non-deterministic behavior

### Common Performance Patterns

**Linear Scaling**: Doubling input doubles time
- Indicates good algorithmic complexity
- Expected for simple pipelines

**Sublinear Scaling**: Doubling input less than doubles time
- Cache effects
- Amortized initialization costs

**Superlinear Scaling**: Doubling input more than doubles time
- Cache misses
- Memory allocation
- GC pressure

## Comparing with Main Repository

To compare with Hydroflow-only benchmarks from the main repository:

```bash
# Run main repository benchmarks
cd ../bigweaver-agent-canary-hydro-zeta
cargo bench -p benches -- --save-baseline hydroflow_main

# Run comparison benchmarks
cd ../bigweaver-agent-canary-zeta-hydro-deps
cargo bench -- --save-baseline hydroflow_with_external

# Manually compare results from target/criterion/
```

## Extending Benchmarks

### Adding a New Benchmark

1. **Create benchmark file**: `benches/my_new_benchmark.rs`

2. **Implement pattern for each framework**:

```rust
// Timely implementation
fn benchmark_timely(c: &mut Criterion) {
    c.bench_function("my_benchmark/timely", |b| {
        b.iter(|| {
            // Timely implementation
        });
    });
}

// Hydroflow implementation
fn benchmark_hydroflow(c: &mut Criterion) {
    c.bench_function("my_benchmark/hydroflow", |b| {
        b.iter(|| {
            // Hydroflow implementation
        });
    });
}

// Baseline implementation
fn benchmark_baseline(c: &mut Criterion) {
    c.bench_function("my_benchmark/baseline", |b| {
        b.iter(|| {
            // Baseline implementation
        });
    });
}

criterion_group!(my_benchmark, benchmark_timely, benchmark_hydroflow, benchmark_baseline);
criterion_main!(my_benchmark);
```

3. **Add to Cargo.toml**:
```toml
[[bench]]
name = "my_new_benchmark"
harness = false
```

4. **Run and validate**:
```bash
cargo bench --bench my_new_benchmark
```

### Benchmark Best Practices

1. **Use black_box**: Prevent compiler optimization
```rust
use criterion::black_box;
black_box(value); // Prevents value from being optimized away
```

2. **Setup/Teardown**: Use `iter_batched` for setup
```rust
b.iter_batched(
    || setup_data(),      // Setup (not measured)
    |data| process(data), // Measured section
    BatchSize::LargeInput,
);
```

3. **Realistic Data**: Use representative inputs
```rust
// Good: Realistic distribution
let data = generate_realistic_data();

// Bad: Trivial data
let data = vec![1, 2, 3];
```

4. **Warm Caches**: Ensure caches are warm
```rust
// Criterion does this automatically with multiple iterations
```

5. **Document Differences**: Explain implementation variations
```rust
/// Note: This uses HashMap for simplicity,
/// production code would use a more efficient structure
```

## Troubleshooting

### Benchmark Fails to Compile

**Problem**: Missing dependencies
```
error: unresolved import `differential_dataflow`
```

**Solution**: Ensure all dependencies are in `Cargo.toml`
```bash
cargo update
cargo build --release
```

### Inconsistent Results

**Problem**: High variance between runs

**Solution**:
1. Close other applications
2. Disable CPU frequency scaling
3. Run more samples: `cargo bench -- --sample-size 100`
4. Check for thermal throttling

### Out of Memory

**Problem**: Benchmark crashes with OOM

**Solution**:
1. Reduce input size temporarily
2. Check for memory leaks
3. Use `iter_batched` to cleanup between iterations

### Unexpected Performance

**Problem**: Results don't match expectations

**Solution**:
1. Verify implementations are equivalent
2. Check for debug assertions: `cargo bench --release`
3. Profile with `perf` or `flamegraph`
4. Review generated code: `cargo asm`

### Compilation Extremely Slow

**Problem**: Timely/Differential take very long to compile

**Solution**:
1. This is expected (heavy use of generics)
2. Use `sccache` for caching
3. Use `cargo check` for quick validation
4. Only run benchmarks when needed

## Performance Tips

### For Fastest Benchmarks

```bash
# Use full optimizations
export RUSTFLAGS="-C target-cpu=native -C opt-level=3"
cargo bench

# Disable debug assertions
cargo bench --release

# Use LTO
# (already configured in Cargo.toml)
```

### For Faster Compilation

```bash
# Use parallel compilation
export CARGO_BUILD_JOBS=8

# Use sccache
cargo install sccache
export RUSTC_WRAPPER=sccache

# Skip dependencies that don't change
cargo bench --keep-going
```

## Statistical Significance

Criterion performs statistical analysis:

- **P-value < 0.05**: Likely a real difference
- **P-value > 0.05**: Difference might be noise
- **Confidence intervals**: Range of likely true values

Example interpretation:
```
change: [-2.3456% +0.1234% +2.7890%] (p = 0.89)
```
- Performance changed between -2.3% and +2.7%
- P-value 0.89 indicates high uncertainty
- Conclusion: No significant change

## References

- [Criterion User Guide](https://bheisler.github.io/criterion.rs/book/)
- [Timely Dataflow Documentation](https://docs.rs/timely/)
- [Differential Dataflow Documentation](https://docs.rs/differential-dataflow/)
- [Hydroflow Documentation](https://hydro.run/)
- [Rust Performance Book](https://nnethercote.github.io/perf-book/)

## Contributing

To contribute new benchmarks:

1. Follow existing patterns
2. Document the benchmark purpose
3. Implement for all frameworks (or document why not)
4. Add tests to verify correctness
5. Update this guide with insights

## Support

For questions or issues:
1. Check existing documentation
2. Review Criterion documentation
3. Compare with main repository benchmarks
4. Open an issue with details
