# bigweaver-agent-canary-zeta-hydro-deps

This repository contains dependencies and benchmarks for the timely and differential-dataflow crates that have been separated from the main bigweaver-agent-canary-hydro-zeta repository.

## Structure

- `benches/` - Microbenchmarks for Hydro using timely and differential-dataflow

## Benchmarks

The benchmarks directory contains performance tests that depend on the timely and differential-dataflow packages. These were moved here to keep the main repository free of these dependencies.

### Running Benchmarks

To run all benchmarks:
```bash
cargo bench -p benches
```

To run a specific benchmark:
```bash
cargo bench -p benches --bench reachability
```

### Available Benchmarks

- `arithmetic` - Arithmetic operations benchmarks
- `fan_in` - Fan-in pattern benchmarks
- `fan_out` - Fan-out pattern benchmarks
- `fork_join` - Fork-join pattern benchmarks
- `futures` - Async futures benchmarks
- `identity` - Identity operation benchmarks
- `join` - Join operation benchmarks
- `micro_ops` - Micro-operations benchmarks
- `reachability` - Graph reachability benchmarks
- `symmetric_hash_join` - Symmetric hash join benchmarks
- `upcase` - String uppercase benchmarks
- `words_diamond` - Word processing diamond pattern benchmarks

## Purpose

This repository maintains the ability to run performance comparisons for timely and differential-dataflow functionality while keeping the main Hydro repository clean of these dependencies.