# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmark code for the Hydro project with dependencies on `timely` and `differential-dataflow` packages. These benchmarks were separated from the main `bigweaver-agent-canary-hydro-zeta` repository to maintain cleaner dependency boundaries.

## Contents

- **benches/**: Microbenchmarks for Hydro and other crates, including performance tests for distributed protocols

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
```

## Performance Comparisons

This repository maintains the ability to run performance comparisons between different implementations. The benchmarks reference the core `dfir_rs` and `sinktools` crates from the main repository via relative path dependencies.

## Dependencies

The benchmarks in this repository depend on:
- `timely` and `differential-dataflow` for dataflow processing
- `dfir_rs` and `sinktools` from the main repository (via relative paths)
- `criterion` for benchmark framework

See `benches/Cargo.toml` for the complete list of dependencies.