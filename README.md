# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for timely and differential-dataflow that have been moved from the main bigweaver-agent-canary-hydro-zeta repository.

## Purpose

This repository was created to separate benchmarks and dependencies on the timely and differential-dataflow packages from the main bigweaver-agent-canary-hydro-zeta repository. This separation helps:

- Avoid unnecessary dependencies in the main repository
- Retain the ability to run performance comparisons
- Maintain benchmark code in a dedicated location

## Benchmarks

The `benches` directory contains microbenchmarks for Hydro and related crates, including comparisons with timely and differential-dataflow.

### Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench identity
cargo bench -p benches --bench arithmetic
```

### Available Benchmarks

- `arithmetic` - Arithmetic operations benchmarks
- `fan_in` - Fan-in pattern benchmarks  
- `fan_out` - Fan-out pattern benchmarks
- `fork_join` - Fork-join pattern benchmarks
- `futures` - Futures-based operations benchmarks
- `identity` - Identity operation benchmarks
- `join` - Join operation benchmarks
- `micro_ops` - Micro-operations benchmarks
- `reachability` - Graph reachability benchmarks
- `symmetric_hash_join` - Symmetric hash join benchmarks
- `upcase` - String uppercase transformation benchmarks
- `words_diamond` - Word processing with diamond pattern benchmarks

## Migration from Main Repository

These benchmarks were previously located in the `benches` directory of the bigweaver-agent-canary-hydro-zeta repository. They have been moved here to keep the main repository focused on core functionality while preserving the ability to run performance comparisons.

The benchmarks reference `dfir_rs` and `sinktools` from the main repository via git dependencies.