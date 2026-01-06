# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for the Hydro project that depend on external dataflow libraries (timely and differential-dataflow).

## Benches

The `benches` directory contains microbenchmarks for Hydro and related dataflow operations.

### Running Benchmarks

Run all benchmarks:
```
cargo bench -p benches
```

Run specific benchmarks:
```
cargo bench -p benches --bench reachability
cargo bench -p benches --bench upcase
cargo bench -p benches --bench join
cargo bench -p benches --bench fan_in
```

### Available Benchmarks

- **upcase** - String manipulation benchmarks using timely
- **join** - Join operation benchmarks using timely
- **reachability** - Graph reachability benchmarks using differential_dataflow
- **fan_in** - Fan-in dataflow benchmarks
- **fan_out** - Fan-out dataflow benchmarks
- **fork_join** - Fork-join pattern benchmarks
- **identity** - Identity operation benchmarks
- **arithmetic** - Arithmetic operation benchmarks
- **micro_ops** - Micro-operation benchmarks
- **symmetric_hash_join** - Symmetric hash join benchmarks
- **words_diamond** - Word processing diamond pattern benchmarks
- **futures** - Futures-based operation benchmarks

### Dependencies

The benchmarks depend on:
- `timely-master` (version 0.13.0-dev.1)
- `differential-dataflow-master` (version 0.13.0-dev.1)
- `dfir_rs` (from main Hydro repository)
- `sinktools` (from main Hydro repository)
