# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for the BigWeaver Hydro project.

## Overview

The benchmarks in this repository were moved from the main `bigweaver-agent-canary-hydro-zeta` repository to:
- Enable separate evolution of benchmark code from the main codebase
- Improve build times in the main repository
- Maintain cleaner separation of concerns between core functionality and performance testing
- Allow benchmarks to be maintained and updated independently

## Benchmarks

The `benches` directory contains performance benchmarks for various dataflow operations:

### Timely Dataflow Benchmarks
- **join.rs** - Join operations using timely dataflow operators
- **upcase.rs** - String transformation benchmarks
- **arithmetic.rs** - Arithmetic operations
- **fan_in.rs**, **fan_out.rs** - Dataflow fan patterns
- **fork_join.rs** - Parallel execution patterns
- **identity.rs** - Identity transformation operations
- **symmetric_hash_join.rs** - Symmetric hash join operations
- **words_diamond.rs** - Word processing diamond pattern

### Differential Dataflow Benchmarks
- **reachability.rs** - Graph reachability using differential-dataflow operators

### Other Benchmarks
- **futures.rs** - Async futures benchmarking
- **micro_ops.rs** - Micro-operation benchmarks

## Running Benchmarks

To run the benchmarks:

```bash
# Run all benchmarks
cargo bench

# Run specific benchmark
cargo bench -p benches -- <benchmark_name>

# Run with specific output format
cargo bench -p benches -- dfir --output-format bencher
```

## Dependencies

The benchmarks depend on:
- **dfir_rs** - Core dataflow runtime (from main hydro repository)
- **sinktools** - Utility tools (from main hydro repository)
- **timely** - Timely dataflow framework
- **differential-dataflow** - Differential dataflow framework
- **criterion** - Benchmarking framework

## Performance Comparisons

These benchmarks enable performance comparisons between:
- Different dataflow implementations
- Hydro native operations vs. timely/differential implementations
- Various optimization strategies

For historical benchmark results and trends, refer to the main repository's gh-pages branch.