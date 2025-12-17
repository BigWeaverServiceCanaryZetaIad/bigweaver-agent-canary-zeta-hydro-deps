# Timely/Differential-Dataflow Benchmarks

This directory contains benchmarks comparing Hydro with Timely and Differential-Dataflow implementations.

## Overview

These benchmarks were migrated from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to reduce build dependencies and improve build times while maintaining the ability to run performance comparisons.

## Available Benchmarks

### Data Processing Benchmarks
- **arithmetic** - Arithmetic operations benchmark comparing pipeline-based computations
- **identity** - Identity transformation benchmark testing data flow overhead
- **upcase** - String transformation benchmark (uppercase conversion)

### Dataflow Pattern Benchmarks
- **fan_in** - Fan-in pattern benchmark testing multiple inputs converging to one output
- **fan_out** - Fan-out pattern benchmark testing one input distributing to multiple outputs
- **fork_join** - Fork-join pattern benchmark with dynamic code generation

### Join Operations
- **join** - Join operations benchmark comparing different join strategies
- **reachability** - Graph reachability benchmark using differential dataflow

## Dependencies

This benchmark suite requires:
- **timely** (package: timely-master, version: 0.13.0-dev.1)
- **differential-dataflow** (package: differential-dataflow-master, version: 0.13.0-dev.1)
- **criterion** - Benchmarking framework with HTML reports
- **tokio** - Async runtime
- Various supporting libraries (futures, rand, etc.)

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench join
cargo bench -p benches --bench reachability
```

Run with verbose output:
```bash
cargo bench -p benches -- --verbose
```

## Build Process

The `build.rs` script generates code for the `fork_join` benchmark at build time. This creates a `fork_join_20.hf` file in the `benches` directory with dynamically generated filter chains.

## Data Files

- **reachability_edges.txt** - Graph edges for the reachability benchmark
- **reachability_reachable.txt** - Expected reachable nodes for verification

## Performance Comparison Workflow

### Compare with Hydro-Native Benchmarks

1. Run these benchmarks (Timely/Differential-Dataflow):
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps
   cargo bench -p benches
   ```

2. Run Hydro-native benchmarks from the main repository:
   ```bash
   cd bigweaver-agent-canary-hydro-zeta
   cargo bench -p benches
   ```

3. Compare results to evaluate performance characteristics between implementations

## Benchmark Results

Criterion generates detailed HTML reports in `target/criterion/` with:
- Performance measurements and statistics
- Comparison with previous runs
- Visualization of results
- Outlier analysis

## Notes

- These benchmarks use criterion's async_tokio feature for async benchmark support
- The fork_join benchmark requires code generation during build
- Generated files matching `fork_join_*.hf` are ignored by git
- Some benchmarks compare multiple implementation strategies (pipeline vs. timely dataflow)

## Migration Information

These benchmarks were migrated from the main repository on December 17, 2024. For details, see `BENCHMARK_MIGRATION.md` in the main repository.
