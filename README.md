# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies that depend on timely-dataflow and differential-dataflow, separated from the main bigweaver-agent-canary-hydro-zeta repository to reduce dependency overhead and improve build performance.

## Benchmarks

The `benches` directory contains microbenchmarks comparing Hydro with timely-dataflow and differential-dataflow implementations.

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

- **arithmetic**: Pipeline arithmetic operations
- **fan_in**: Fan-in patterns
- **fan_out**: Fan-out patterns  
- **fork_join**: Fork-join patterns
- **identity**: Identity transformations
- **upcase**: String uppercasing
- **join**: Join operations
- **reachability**: Graph reachability
- **micro_ops**: Micro-operation benchmarks
- **symmetric_hash_join**: Symmetric hash join
- **words_diamond**: Word processing diamond pattern
- **futures**: Futures-based operations

## Dependencies

This repository references the main hydro repository via git dependencies to access dfir_rs and sinktools crates while maintaining the ability to run performance comparisons with timely and differential-dataflow.