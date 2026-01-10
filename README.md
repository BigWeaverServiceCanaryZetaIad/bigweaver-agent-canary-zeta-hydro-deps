# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies that were separated from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/hydro-project/hydro) repository to avoid including heavy dependencies (timely and differential-dataflow) in the main codebase.

## Benchmarks

The `benches` directory contains microbenchmarks comparing Hydro performance against timely and differential-dataflow implementations.

### Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench join
```

### Available Benchmarks

- **arithmetic**: Pipeline operations with arithmetic computations
- **fan_in**: Fan-in patterns with multiple inputs
- **fan_out**: Fan-out patterns with multiple outputs
- **fork_join**: Fork-join patterns
- **futures**: Async futures-based operations
- **identity**: Identity transformation benchmarks
- **join**: Join operation benchmarks
- **micro_ops**: Micro-operation benchmarks
- **reachability**: Graph reachability using differential-dataflow
- **symmetric_hash_join**: Symmetric hash join benchmarks
- **upcase**: String uppercase transformation
- **words_diamond**: Diamond pattern with word processing

### Dependencies

The benchmarks depend on:
- **timely-master**: For timely dataflow comparisons
- **differential-dataflow-master**: For differential dataflow comparisons
- **dfir_rs**: Referenced from the main hydro repository
- **sinktools**: Referenced from the main hydro repository
- **criterion**: For benchmark harness

## Performance Comparison

These benchmarks are designed to retain the ability to run performance comparisons between Hydro and timely/differential-dataflow implementations. Each benchmark typically includes multiple implementations (raw, timely, dfir_rs/Hydro) to compare performance characteristics.