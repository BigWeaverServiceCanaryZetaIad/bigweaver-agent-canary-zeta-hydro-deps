# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks for timely and differential-dataflow performance comparisons.

## Benchmarks

The benchmarks are located in the `benches` directory and include:

### Timely Dataflow Benchmarks
- **identity.rs**: Identity benchmark comparing various dataflow frameworks including timely, hydroflow, and raw Rust implementations
  - Tests performance of passing data through 20 identity operations
  - Includes comparisons with pipeline, iterator, and raw copy implementations

### Differential Dataflow Benchmarks
- **reachability.rs**: Graph reachability benchmark comparing timely, differential-dataflow, and hydroflow implementations
  - Tests graph reachability algorithms using various dataflow frameworks
  - Includes edge and reachability data files for testing

## Running Benchmarks

To run all benchmarks:
```bash
cargo bench
```

To run specific benchmarks:
```bash
cargo bench --bench identity
cargo bench --bench reachability
```

## Dependencies

These benchmarks depend on:
- `timely` (timely-master v0.13.0-dev.1)
- `differential-dataflow` (differential-dataflow-master v0.13.0-dev.1)
- `dfir_rs` and `sinktools` from the main hydro repository
- `criterion` for benchmarking framework