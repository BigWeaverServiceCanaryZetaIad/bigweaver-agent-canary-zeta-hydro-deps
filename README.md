# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies that were moved from the main bigweaver-agent-canary-hydro-zeta repository to avoid including timely and differential-dataflow dependencies in the main repository.

## Benchmarks

The `benches` directory contains microbenchmarks comparing Hydro (dfir_rs) with Timely Dataflow and Differential Dataflow.

### Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
```

### Available Benchmarks

- `arithmetic` - Pipeline arithmetic operations
- `fan_in` - Fan-in operations
- `fan_out` - Fan-out operations  
- `fork_join` - Fork-join patterns
- `futures` - Futures handling
- `identity` - Identity operations
- `join` - Join operations
- `micro_ops` - Micro-operation benchmarks
- `reachability` - Graph reachability benchmarks
- `symmetric_hash_join` - Symmetric hash join benchmarks
- `upcase` - String uppercase operations
- `words_diamond` - Word processing benchmarks

## Purpose

This separation allows the main repository to maintain a cleaner dependency structure while preserving performance comparison capability with timely and differential-dataflow.