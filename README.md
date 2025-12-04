# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for the Hydro project that depend on external dataflow libraries.

## Benchmarks

The `benches/` directory contains microbenchmarks for comparing Hydro performance with Timely Dataflow and Differential Dataflow implementations.

### Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench timely_upcase
```

### Available Benchmarks

- **arithmetic.rs** - Timely Dataflow arithmetic operations
- **fan_in.rs** - Timely Dataflow fan-in patterns
- **fan_out.rs** - Timely Dataflow fan-out patterns
- **fork_join.rs** - Timely Dataflow fork-join patterns
- **futures.rs** - Async futures benchmarks
- **identity.rs** - Timely Dataflow identity operations
- **join.rs** - Timely Dataflow join operations
- **micro_ops.rs** - Micro-operation benchmarks
- **reachability.rs** - Differential Dataflow reachability computations
- **symmetric_hash_join.rs** - Symmetric hash join benchmarks
- **upcase.rs** - Timely Dataflow string transformations
- **words_diamond.rs** - Word processing diamond pattern

## Dependencies

This repository uses git dependencies to reference the main Hydro repository for `dfir_rs` and `sinktools` packages.