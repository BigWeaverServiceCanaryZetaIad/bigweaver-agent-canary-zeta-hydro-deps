# Microbenchmarks

Performance benchmarks comparing Hydro with Timely Dataflow and Differential Dataflow.

## Overview

This package contains benchmarks that were moved from the main Hydro repository to maintain a cleaner separation between the core Hydro framework and external dataflow library comparisons.

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench micro_ops
```

## Performance Comparisons

The benchmarks enable performance comparisons between:
- **Hydro (dfir_rs)**: The Hydro dataflow framework
- **Timely Dataflow**: Direct timely dataflow implementations
- **Differential Dataflow**: Differential dataflow implementations

Each benchmark typically includes implementations for multiple frameworks to facilitate direct performance comparisons.

## Available Benchmarks

### Timely Dataflow Benchmarks
- `arithmetic.rs` - Arithmetic operations
- `fan_in.rs` - Fan-in dataflow patterns
- `fan_out.rs` - Fan-out dataflow patterns  
- `fork_join.rs` - Fork-join patterns
- `identity.rs` - Identity transformations
- `join.rs` - Join operations
- `upcase.rs` - String transformations

### Differential Dataflow Benchmarks
- `reachability.rs` - Graph reachability computations using test data files

### Hydro Comparison Benchmarks
- `futures.rs` - Async futures benchmarks
- `micro_ops.rs` - Micro-operation comparisons
- `symmetric_hash_join.rs` - Hash join implementations
- `words_diamond.rs` - Word processing patterns

## Test Data Files

The benchmarks use the following test data files located in `benches/`:
- `words_alpha.txt` - English word list from https://github.com/dwyl/english-words
- `reachability_edges.txt` - Graph edges for reachability testing
- `reachability_reachable.txt` - Expected reachability results

## Benchmark Output

Benchmarks use the Criterion framework and generate:
- Console output with timing statistics
- HTML reports in `target/criterion/` directory
- Performance comparison charts

## Dependencies

The benchmarks depend on:
- `dfir_rs` - Hydro's dataflow implementation (from main repository)
- `sinktools` - Utilities (from main repository)
- `timely-master` - Timely Dataflow framework
- `differential-dataflow-master` - Differential Dataflow framework
- `criterion` - Benchmarking framework

## Notes

- Benchmarks use git dependencies to reference the main Hydro repository
- All benchmarks can be run independently
- Performance results may vary based on system configuration
