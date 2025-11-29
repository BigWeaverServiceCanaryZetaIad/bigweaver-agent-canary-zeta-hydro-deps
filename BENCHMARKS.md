# Benchmark Documentation

## Overview

This document describes the benchmarks in this repository, how to run them, interpret results, and understand their relationship to the main Hydro repository.

## Purpose

These benchmarks serve multiple purposes:

1. **Performance Comparison**: Compare Hydro (dfir_rs) performance against Timely Dataflow and Differential Dataflow
2. **Regression Detection**: Track performance changes over time
3. **Optimization Validation**: Verify that optimizations actually improve performance
4. **Architecture Decisions**: Provide data for architectural choices

## Benchmark Suite

### 1. arithmetic.rs
**Purpose**: Measures overhead of arithmetic operations in a pipeline

**Implementations**:
- Raw single-threaded pipeline (baseline)
- Multi-threaded channel-based pipeline
- Hydro (dfir_rs) implementation
- Timely Dataflow implementation

**What it measures**: Basic throughput and overhead of adding numbers through a pipeline

### 2. fan_in.rs
**Purpose**: Tests performance of merging multiple input streams

**Scenario**: Multiple streams feeding into a single output stream

**Use cases**: Log aggregation, multi-sensor data fusion, distributed system monitoring

### 3. fan_out.rs
**Purpose**: Tests performance of splitting a stream into multiple outputs

**Scenario**: Single input stream distributed to multiple downstream consumers

**Use cases**: Event broadcasting, data replication, parallel processing

### 4. fork_join.rs
**Purpose**: Tests fork-join patterns with alternating filter operations

**Complexity**: Generates code for 20 operations with alternating filters (even/odd)

**Special note**: Uses build.rs to generate the actual benchmark code at compile time

### 5. futures.rs
**Purpose**: Tests async/await patterns and futures integration

**Focus**: Measures overhead of async operations in dataflow contexts

### 6. identity.rs
**Purpose**: Baseline identity transformation benchmark

**Why it matters**: Measures minimum overhead of the framework itself

**Pattern**: Input → Identity → Output (no actual transformation)

### 7. join.rs
**Purpose**: Tests two-way join operations

**Scenario**: Joining two streams on a common key

**Use cases**: Database-style joins, correlation analysis, matching operations

### 8. micro_ops.rs
**Purpose**: Microbenchmarks for individual operations

**Focus**: Low-level operation performance (map, filter, fold, etc.)

**Why it matters**: Helps identify specific operation bottlenecks

### 9. reachability.rs
**Purpose**: Graph algorithm performance (transitive closure)

**Data**: 
- `reachability_edges.txt`: Graph edge list (~55K edges)
- `reachability_reachable.txt`: Expected reachability results (~7.8K entries)

**Algorithm**: Iteratively computes which nodes are reachable from each node

**Complexity**: Tests iterative algorithms typical in graph processing

### 10. symmetric_hash_join.rs
**Purpose**: Hash join implementation comparison

**Pattern**: Symmetric hash join (useful for streaming joins)

**Why it matters**: Common pattern in stream processing systems

### 11. upcase.rs
**Purpose**: String transformation benchmark

**Operation**: Converting strings to uppercase

**Why it matters**: Tests string handling and transformation overhead

### 12. words_diamond.rs
**Purpose**: Diamond pattern with word processing

**Data**: `words_alpha.txt` - 370K+ English words

**Pattern**: Fork → Process → Join (diamond shape)

**Scenario**: Split words, process independently, then recombine

## Running Benchmarks

### Prerequisites

1. Rust toolchain 1.91.1 (specified in `rust-toolchain.toml`)
2. Access to main Hydro repository (for dfir_rs and sinktools dependencies)

### Basic Usage

```bash
# Run all benchmarks
cargo bench -p benches

# Run specific benchmark
cargo bench -p benches --bench reachability

# Run with specific pattern
cargo bench -p benches -- identity

# Run benchmarks with longer sample time (more accurate)
cargo bench -p benches -- --sample-size 100
```

### Viewing Results

Criterion generates HTML reports in `target/criterion/`:

```bash
# Open the main report
open target/criterion/report/index.html

# Or for Linux
xdg-open target/criterion/report/index.html

# View specific benchmark
open target/criterion/arithmetic/report/index.html
```

## Interpreting Results

### Key Metrics

1. **Time per iteration**: Average time to complete one benchmark run
2. **Throughput**: Operations per second
3. **Standard deviation**: Consistency of results
4. **Comparison**: How this run compares to previous runs

### Understanding the Reports

- **Green**: Performance improved vs. baseline
- **Red**: Performance degraded vs. baseline
- **Blue**: No significant change

### Performance Comparison Patterns

When comparing Hydro vs. Timely vs. Differential:

- **Lower is better**: For time measurements
- **Higher is better**: For throughput measurements
- **Look for**: Consistent patterns across multiple benchmark types
- **Watch for**: Outliers that might indicate specific optimization opportunities

## Benchmark Architecture

### Framework Usage

Each benchmark typically includes 3-4 implementations:

1. **Raw/Baseline**: Pure Rust without any framework (control)
2. **Hydro (dfir_rs)**: Using Hydro's dataflow syntax
3. **Timely**: Using Timely Dataflow operators
4. **Differential**: Using Differential Dataflow (where applicable)

### Criterion Integration

All benchmarks use the Criterion framework which provides:
- Statistical analysis of results
- HTML reports with graphs
- Automatic baseline comparison
- Outlier detection
- Configurable sample sizes

## Relationship to Main Repository

### Dependencies

The benchmarks depend on the main repository for:

```toml
dfir_rs = { git = "https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git", features = [ "debugging" ] }
sinktools = { git = "https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git", version = "^0.0.1" }
```

### Why Separate Repositories?

1. **Dependency Management**: Main repo stays free of timely/differential-dataflow
2. **Build Time**: Benchmarks don't slow down regular development builds
3. **Focus**: Main repo focuses on features, this repo on performance
4. **Modularity**: Can update benchmark versions independently

### Coordinated Changes

When making changes that affect both repositories:

1. Update main repository with new features
2. Update benchmark dependencies to point to new main repo version
3. Add/update benchmarks for new features
4. Run full benchmark suite
5. Document performance characteristics

## Continuous Integration

### Benchmark Workflow

The repository previously had a benchmark workflow (`.github/workflows/benchmark.yml`) that:
- Ran on pull requests and main branch
- Generated performance reports
- Compared against baseline
- Uploaded results as artifacts

This can be re-enabled when needed for CI/CD integration.

## Adding New Benchmarks

### Step-by-Step Guide

1. **Create benchmark file**: `benches/benches/my_benchmark.rs`

2. **Structure**: Follow this pattern:
   ```rust
   use criterion::{Criterion, criterion_group, criterion_main};
   use dfir_rs::dfir_syntax;
   
   fn benchmark_hydro(c: &mut Criterion) {
       c.bench_function("my_benchmark/hydro", |b| {
           b.iter(|| {
               // Your benchmark code
           });
       });
   }
   
   criterion_group!(benches, benchmark_hydro);
   criterion_main!(benches);
   ```

3. **Update Cargo.toml**: Add bench entry:
   ```toml
   [[bench]]
   name = "my_benchmark"
   harness = false
   ```

4. **Document**: Add description to this file

5. **Test**: Run the benchmark to ensure it works:
   ```bash
   cargo bench -p benches --bench my_benchmark
   ```

### Best Practices

1. **Keep it focused**: Each benchmark should test one specific thing
2. **Include baseline**: Add a raw Rust version for comparison
3. **Use realistic data**: Size data appropriately (not too small, not too large)
4. **Warm-up**: Criterion handles this, but be aware of cold-start effects
5. **Document**: Explain what you're measuring and why

## Troubleshooting

### Common Issues

1. **Long benchmark times**: Some benchmarks (especially reachability) take time
   - Solution: Run specific benchmarks during development
   - Use `--sample-size` to reduce iterations during testing

2. **Inconsistent results**: Performance varies between runs
   - Ensure system isn't under heavy load
   - Close other applications
   - Use `--sample-size` to increase samples for more stable results

3. **Dependency errors**: Can't find dfir_rs or sinktools
   - Ensure main repository is accessible
   - Check network connection for git dependencies
   - Verify git credentials if repository is private

4. **Build failures**: Code doesn't compile
   - Check Rust version matches `rust-toolchain.toml`
   - Update dependencies: `cargo update`
   - Check main repository for breaking changes

### Performance Debugging

If benchmarks show unexpected performance:

1. **Compare against baseline**: Check historical results
2. **Profile**: Use `cargo flamegraph` or similar tools
3. **Check generated code**: Use `cargo expand` to see macro output
4. **Isolate**: Create minimal reproduction case
5. **Test variations**: Try different data sizes, patterns

## References

- Criterion documentation: https://bheisler.github.io/criterion.rs/book/
- Timely Dataflow: https://github.com/TimelyDataflow/timely-dataflow
- Differential Dataflow: https://github.com/TimelyDataflow/differential-dataflow
- Main Hydro repository: https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta
