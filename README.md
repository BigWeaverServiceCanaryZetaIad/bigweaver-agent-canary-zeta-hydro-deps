# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for the Hydro project that depend on `timely` and `differential-dataflow` packages. These have been separated from the main repository to keep the main codebase clean of these dependencies.

## Benchmarks

The `benches` directory contains microbenchmarks comparing Hydro performance with timely and differential-dataflow implementations.

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

- `arithmetic` - Arithmetic operations benchmark
- `fan_in` - Fan-in pattern benchmark
- `fan_out` - Fan-out pattern benchmark
- `fork_join` - Fork-join pattern benchmark
- `futures` - Futures-based async benchmark
- `identity` - Identity operation benchmark
- `join` - Join operation benchmark
- `micro_ops` - Micro-operations benchmark
- `reachability` - Graph reachability benchmark
- `symmetric_hash_join` - Symmetric hash join benchmark
- `upcase` - String uppercasing benchmark
- `words_diamond` - Word processing diamond pattern benchmark

## Dependencies

This repository depends on the main `bigweaver-agent-canary-hydro-zeta` repository for core functionality like `dfir_rs` and `sinktools`.