# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for the Hydro project that rely on timely-dataflow and differential-dataflow.

## Benchmarks

The `benches/` directory contains microbenchmarks comparing Hydro performance with timely and differential-dataflow implementations.

### Running Benchmarks

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

### Available Benchmarks

- `arithmetic` - Arithmetic operations benchmarks
- `fan_in` - Fan-in pattern benchmarks
- `fan_out` - Fan-out pattern benchmarks
- `fork_join` - Fork-join pattern benchmarks
- `futures` - Futures-based operations benchmarks
- `identity` - Identity operations benchmarks
- `join` - Join operations benchmarks
- `micro_ops` - Micro-operations benchmarks
- `reachability` - Graph reachability benchmarks
- `symmetric_hash_join` - Symmetric hash join benchmarks
- `upcase` - String transformation benchmarks
- `words_diamond` - Word processing diamond pattern benchmarks

### Dependencies

These benchmarks depend on:
- `dfir_rs` - From the main Hydro repository
- `sinktools` - From the main Hydro repository
- `timely-master` - Timely-dataflow framework
- `differential-dataflow-master` - Differential-dataflow framework

The Hydro dependencies are pulled from the main repository via git dependencies.