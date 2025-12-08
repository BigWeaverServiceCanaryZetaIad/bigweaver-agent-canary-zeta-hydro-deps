# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies that were separated from the main `bigweaver-agent-canary-hydro-zeta` repository to avoid unwanted dependencies in the main codebase.

## Benchmarks

The `benches` directory contains microbenchmarks for Hydro that depend on `timely` and `differential-dataflow` packages. These benchmarks were moved here to keep the main repository free from these dependencies while retaining the ability to run performance comparisons.

### Running Benchmarks

To run all benchmarks:
```bash
cargo bench -p benches
```

To run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench join
```

### Available Benchmarks

- `arithmetic` - Basic arithmetic operations
- `fan_in` - Fan-in operation patterns
- `fan_out` - Fan-out operation patterns
- `fork_join` - Fork-join patterns
- `futures` - Futures-based operations
- `identity` - Identity operations
- `join` - Join operations
- `micro_ops` - Micro-operation benchmarks
- `reachability` - Graph reachability benchmarks
- `symmetric_hash_join` - Symmetric hash join operations
- `upcase` - String uppercase operations
- `words_diamond` - Word processing diamond pattern

### Performance Comparisons

These benchmarks can be used to compare performance across different versions of Hydro or against other dataflow systems. The benchmarks use Criterion for statistical analysis and HTML report generation.

## Dependencies

This repository depends on:
- `dfir_rs` - From the main bigweaver-agent-canary-hydro-zeta repository
- `sinktools` - From the main bigweaver-agent-canary-hydro-zeta repository
- `timely-master` - Timely dataflow library
- `differential-dataflow-master` - Differential dataflow library

Note: The dependencies on `dfir_rs` and `sinktools` are configured to use git dependencies pointing to the upstream repository.