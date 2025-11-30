# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and tests that depend on external packages like timely and differential-dataflow. These dependencies were moved from the main `bigweaver-agent-canary-hydro-zeta` repository to avoid including these heavy dependencies in the core codebase.

## Benchmarks

The `benches` directory contains microbenchmarks comparing Hydro performance with other dataflow systems.

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

- `arithmetic` - Arithmetic operations pipeline benchmarks
- `fan_in` - Fan-in pattern benchmarks
- `fan_out` - Fan-out pattern benchmarks
- `fork_join` - Fork-join pattern benchmarks
- `futures` - Async futures benchmarks
- `identity` - Identity operation benchmarks
- `join` - Join operation benchmarks
- `micro_ops` - Micro-operations benchmarks
- `reachability` - Graph reachability benchmarks
- `symmetric_hash_join` - Symmetric hash join benchmarks
- `upcase` - String uppercase transformation benchmarks
- `words_diamond` - Diamond pattern with word processing

### Dependencies

The benchmarks depend on:
- `timely` (timely-master 0.13.0-dev.1)
- `differential-dataflow` (differential-dataflow-master 0.13.0-dev.1)
- `dfir_rs` (from bigweaver-agent-canary-hydro-zeta)
- `sinktools` (from bigweaver-agent-canary-hydro-zeta)

Note: The benchmarks reference the sibling `bigweaver-agent-canary-hydro-zeta` repository for dfir_rs and sinktools dependencies.