# Timely and Differential-Dataflow Benchmarks

This repository contains performance benchmarks for timely and differential-dataflow implementations, comparing them with Hydroflow/dfir_rs implementations.

## Overview

These benchmarks were moved from the main bigweaver-agent-canary-hydro-zeta repository to maintain a cleaner dependency structure. By isolating these benchmarks in a dedicated repository, we avoid including timely and differential-dataflow dependencies in the main codebase.

## Available Benchmarks

### 1. `arithmetic.rs`
Benchmarks arithmetic operations across different frameworks:
- **Pipeline**: Multi-threaded channel-based pipeline
- **Raw**: Direct vector operations (baseline)
- **Iterator**: Rust iterator chains
- **Iterator with Collect**: Iterator with intermediate collections
- **Hydroflow Compiled**: Compiled dfir_rs implementation
- **Hydroflow Interpreted**: Interpreted dfir_rs implementation
- **Timely**: Timely dataflow implementation

**Purpose**: Compare overhead of different dataflow frameworks for simple arithmetic operations.

### 2. `fan_in.rs`
Benchmarks fan-in patterns where multiple input streams merge into one:
- **Hydroflow Compiled**: Compiled dfir_rs implementation
- **Hydroflow Interpreted**: Interpreted dfir_rs implementation  
- **Timely**: Timely dataflow implementation

**Purpose**: Evaluate performance of merging multiple data streams.

### 3. `fan_out.rs`
Benchmarks fan-out patterns where one stream splits into multiple outputs:
- **Hydroflow Compiled**: Compiled dfir_rs implementation
- **Hydroflow Interpreted**: Interpreted dfir_rs implementation
- **Timely**: Timely dataflow implementation

**Purpose**: Evaluate performance of distributing data to multiple consumers.

### 4. `fork_join.rs`
Benchmarks fork-join patterns where work is split, processed in parallel, then joined:
- **Hydroflow Compiled**: Compiled dfir_rs implementation
- **Hydroflow Interpreted**: Interpreted dfir_rs implementation
- **Timely**: Timely dataflow implementation

**Purpose**: Assess parallel processing capabilities.

### 5. `identity.rs`
Benchmarks the identity operation (no-op passthrough):
- **Hydroflow Compiled**: Compiled dfir_rs implementation
- **Hydroflow Interpreted**: Interpreted dfir_rs implementation
- **Timely**: Timely dataflow implementation

**Purpose**: Measure baseline framework overhead.

### 6. `join.rs`
Benchmarks join operations between two data streams:
- **Hydroflow Compiled**: Compiled dfir_rs implementation
- **Hydroflow Interpreted**: Interpreted dfir_rs implementation
- **Timely**: Timely dataflow implementation

**Purpose**: Compare join operation performance across frameworks.

### 7. `reachability.rs`
Benchmarks graph reachability algorithms using differential-dataflow:
- **Differential-Dataflow**: Incremental graph reachability computation
- **Hydroflow**: dfir_rs implementation of graph reachability

**Purpose**: Evaluate performance on complex graph algorithms. Uses data files:
- `reachability_edges.txt` (524KB) - Graph edges
- `reachability_reachable.txt` (40KB) - Expected reachable nodes

### 8. `upcase.rs`
Benchmarks string uppercase transformation:
- **Hydroflow Compiled**: Compiled dfir_rs implementation
- **Hydroflow Interpreted**: Interpreted dfir_rs implementation
- **Timely**: Timely dataflow implementation

**Purpose**: Test performance on simple data transformations.

## Running Benchmarks

### Prerequisites

Ensure you have Rust installed with the appropriate toolchain. This repository uses workspace dependencies defined in the root `Cargo.toml`.

### Run All Benchmarks

```bash
cargo bench -p benches
```

### Run a Specific Benchmark

```bash
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench fan_in
cargo bench -p benches --bench fan_out
cargo bench -p benches --bench fork_join
cargo bench -p benches --bench identity
cargo bench -p benches --bench join
cargo bench -p benches --bench reachability
cargo bench -p benches --bench upcase
```

### Run a Specific Test within a Benchmark

```bash
cargo bench -p benches --bench arithmetic -- "arithmetic/dfir_rs/compiled"
cargo bench -p benches --bench arithmetic -- "arithmetic/timely"
```

## Performance Comparison

### Comparing Frameworks

The benchmarks are designed to facilitate direct comparison between:
1. **Hydroflow/dfir_rs (Compiled)**: Ahead-of-time compiled dataflow
2. **Hydroflow/dfir_rs (Interpreted)**: Runtime interpreted dataflow
3. **Timely**: Timely dataflow framework
4. **Differential-Dataflow**: Incremental computation framework

### Interpreting Results

Criterion outputs detailed statistics including:
- **Time**: Mean execution time with confidence intervals
- **Throughput**: Operations per second (where applicable)
- **Comparison**: Relative performance vs. baseline

Results are saved to `target/criterion/` with:
- HTML reports for visualization
- Statistical analysis of performance
- Historical comparison over multiple runs

### Performance Analysis Guide

When comparing results, consider:

1. **Overhead**: Identity benchmarks show pure framework overhead
2. **Scalability**: Fan-in/fan-out show how frameworks handle multiple streams
3. **Computation**: Arithmetic and upcase show computational overhead
4. **Complex Operations**: Join and reachability show performance on realistic workloads

### Baseline Comparisons

The `arithmetic` benchmark includes baseline implementations:
- **raw**: Theoretical minimum with direct vector operations
- **pipeline**: Multi-threaded channels (common pattern)
- **iter**: Standard Rust iterators

Use these to understand the overhead added by dataflow frameworks.

## Generating Comparison Reports

After running benchmarks, HTML reports are generated in `target/criterion/<benchmark_name>/`:

```bash
# Run benchmarks
cargo bench -p benches

# Open reports in browser
# Linux:
xdg-open target/criterion/report/index.html

# macOS:
open target/criterion/report/index.html

# Windows:
start target/criterion/report/index.html
```

## Dependencies

This benchmark suite depends on:

- **timely**: Timely dataflow framework (v0.13.0-dev.1)
- **differential-dataflow**: Differential dataflow framework (v0.13.0-dev.1)
- **dfir_rs**: Hydroflow dataflow language (from hydro-project/hydro)
- **criterion**: Benchmarking harness (v0.5.0)
- **sinktools**: Utilities for dfir_rs (from hydro-project/hydro)

Additional utility dependencies:
- **tokio**: Async runtime (v1.29.0)
- **futures**: Async utilities (v0.3)
- **rand**: Random number generation (v0.8.0)
- **rand_distr**: Random distributions (v0.4.3)

## Architecture

### Benchmark Structure

Each benchmark file follows this pattern:

```rust
use criterion::{Criterion, criterion_group, criterion_main};

fn benchmark_hydroflow_compiled(c: &mut Criterion) {
    c.bench_function("name/dfir_rs/compiled", |b| {
        // Benchmark code
    });
}

fn benchmark_timely(c: &mut Criterion) {
    c.bench_function("name/timely", |b| {
        // Benchmark code
    });
}

criterion_group!(
    name = benches;
    config = Criterion::default();
    targets = benchmark_hydroflow_compiled, benchmark_timely
);
criterion_main!(benches);
```

### Data Flow

1. Input data is prepared (arrays, vectors, or files)
2. Framework-specific setup is performed
3. Benchmark iterations execute the dataflow
4. Results are collected and analyzed by Criterion

## Continuous Performance Monitoring

### Tracking Performance Over Time

Criterion automatically tracks performance changes across runs:

```bash
# Run benchmarks to establish baseline
cargo bench -p benches

# Make changes to framework code
# ...

# Run again to see performance delta
cargo bench -p benches
```

Criterion will display performance changes as percentage differences.

### Performance Regression Detection

To fail on performance regressions in CI:

```bash
# Save baseline
cargo bench -p benches --save-baseline main

# After changes, compare against baseline
cargo bench -p benches --baseline main
```

## Troubleshooting

### Build Errors

If you encounter dependency resolution issues:

```bash
# Update Cargo.lock
cargo update

# Clean build artifacts
cargo clean
```

### Missing Data Files

The `reachability` benchmark requires data files:
- Ensure `benches/benches/reachability_edges.txt` exists
- Ensure `benches/benches/reachability_reachable.txt` exists

### Performance Variability

For more stable results:
- Close other applications
- Disable CPU frequency scaling
- Run multiple times and compare trends
- Use longer sample sizes for small benchmarks

## Contributing

When adding new benchmarks:

1. Follow the existing naming convention
2. Add benchmark entry to `Cargo.toml`
3. Include all framework implementations (hydroflow compiled/interpreted, timely, differential)
4. Update this README with benchmark description
5. Ensure benchmarks are reproducible and use consistent data

## Related Repositories

- **bigweaver-agent-canary-hydro-zeta**: Main Hydroflow repository (contains non-timely benchmarks)
- **hydro-project/hydro**: Hydroflow source code and documentation

## Migration History

These benchmarks were moved from bigweaver-agent-canary-hydro-zeta on 2024-11-23 to reduce dependency complexity in the main repository. For historical context, see `TIMELY_REMOVAL_SUMMARY.md` in the original repository.

---

**Last Updated**: 2024-11-23  
**Maintainer**: BigWeaverServiceCanaryZetaIad Team
