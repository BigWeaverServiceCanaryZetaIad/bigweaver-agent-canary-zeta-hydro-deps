# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks comparing Hydro dataflow systems with Timely Dataflow and Differential Dataflow.

## Benchmarks

The `benches/` directory contains performance benchmarks for:
- **fork_join.rs**: Benchmark comparing Hydroflow, Timely, and raw Rust implementations
- **identity.rs**: Identity operation benchmarks across multiple dataflow systems
- **reachability.rs**: Graph reachability algorithm benchmarks using Timely, Differential, and Hydroflow

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench fork_join
cargo bench -p benches --bench identity
```

## Dependencies

This repository contains benchmarks that depend on:
- `timely-master` (v0.13.0-dev.1)
- `differential-dataflow-master` (v0.13.0-dev.1)
- `dfir_rs` (from main hydro repository)
- `criterion` for benchmarking infrastructure

These dependencies were separated from the main Hydro repository to avoid including timely and differential-dataflow dependencies in the core project.