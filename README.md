# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks for the Hydro project that depend on timely-dataflow and differential-dataflow.

## Structure

- `benches/` - Microbenchmarks comparing Hydro with timely and differential-dataflow implementations

## Running Benchmarks

To run all benchmarks:
```bash
cargo bench -p benches
```

To run a specific benchmark:
```bash
cargo bench -p benches --bench reachability
```

## Available Benchmarks

- `arithmetic` - Arithmetic operations
- `fan_in` - Fan-in patterns
- `fan_out` - Fan-out patterns
- `fork_join` - Fork-join patterns
- `futures` - Futures-based operations
- `identity` - Identity transformations
- `join` - Join operations
- `micro_ops` - Micro-operations
- `reachability` - Graph reachability
- `symmetric_hash_join` - Symmetric hash join
- `upcase` - String uppercase operations
- `words_diamond` - Word processing diamond pattern

## Dependencies

This repository depends on:
- `timely-dataflow` (timely-master package)
- `differential-dataflow` (differential-dataflow-master package)
- `dfir_rs` from the main Hydro repository
- `sinktools` from the main Hydro repository

## Migration Notes

These benchmarks were moved from the main `bigweaver-agent-canary-hydro-zeta` repository to separate the timely/differential-dataflow dependencies from the main codebase.