# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for the Hydro project that depend on external libraries like `timely` and `differential-dataflow`.

## Benchmarks

The `benches` directory contains microbenchmarks for Hydro and related crates, including:

- Performance benchmarks for timely dataflow
- Performance benchmarks for differential dataflow
- Various data processing benchmarks

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

- `arithmetic` - Arithmetic operations benchmarks
- `fan_in` - Fan-in pattern benchmarks
- `fan_out` - Fan-out pattern benchmarks
- `fork_join` - Fork-join pattern benchmarks
- `futures` - Async futures benchmarks
- `identity` - Identity operation benchmarks
- `join` - Join operation benchmarks
- `micro_ops` - Micro-operation benchmarks
- `reachability` - Graph reachability benchmarks
- `symmetric_hash_join` - Symmetric hash join benchmarks
- `upcase` - String uppercase transformation benchmarks
- `words_diamond` - Word processing diamond pattern benchmarks

## Repository Purpose

This repository was created to separate benchmarks that depend on `timely` and `differential-dataflow` from the main Hydro repository. This separation:

1. Reduces unnecessary dependencies in the main repository
2. Maintains the ability to run performance comparisons
3. Keeps benchmark history and data files separate
4. Allows independent versioning of benchmark code

## Migration

These benchmarks were migrated from the `bigweaver-agent-canary-hydro-zeta` repository to reduce its dependency footprint while retaining performance testing capabilities.