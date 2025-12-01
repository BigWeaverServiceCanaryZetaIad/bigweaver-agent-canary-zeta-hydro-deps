# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks for Hydro that depend on timely and differential-dataflow packages.

## Benchmarks

The `benches` directory contains microbenchmarks comparing DFIR and other frameworks including timely and differential-dataflow.

### Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
```

### Available Benchmarks

- `arithmetic` - Tests arithmetic operations in pipelines
- `fan_in` - Fan-in patterns
- `fan_out` - Fan-out patterns  
- `fork_join` - Fork-join patterns
- `futures` - Async futures benchmarks
- `identity` - Identity transformations
- `join` - Join operations
- `micro_ops` - Micro-operations
- `reachability` - Graph reachability
- `symmetric_hash_join` - Symmetric hash join operations
- `upcase` - String uppercasing
- `words_diamond` - Diamond pattern with word processing

## Dependencies

These benchmarks depend on:
- `timely` (package: timely-master)
- `differential-dataflow` (package: differential-dataflow-master)
- `dfir_rs` (from the main hydro repository)
- `sinktools` (from the main hydro repository)

The main hydro repository dependencies are pulled via git to avoid circular dependencies.