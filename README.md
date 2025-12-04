# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for timely-dataflow and differential-dataflow packages used in the Hydro project.

## Contents

This repository includes:

- **benches/**: Microbenchmarks for Hydro and related crates that depend on timely-dataflow and differential-dataflow
- **dfir_rs/**: DFIR runtime for Rust, used by Hydro
- **dfir_lang/**: DFIR language implementation
- **dfir_macro/**: Macro support for DFIR
- **lattices/**: Lattice types and operations
- **lattices_macro/**: Macro support for lattices
- **sinktools/**: Sink utilities
- **variadics/**: Variadic utilities
- **variadics_macro/**: Macro support for variadics
- **hydro_build_utils/**: Build utilities for Hydro

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench identity
```

Available benchmarks:
- `arithmetic` - Arithmetic pipeline benchmarks
- `fan_in` - Fan-in pattern benchmarks
- `fan_out` - Fan-out pattern benchmarks
- `fork_join` - Fork-join pattern benchmarks
- `futures` - Async futures benchmarks
- `identity` - Identity operation benchmarks
- `join` - Join operation benchmarks
- `micro_ops` - Micro-operation benchmarks
- `reachability` - Graph reachability benchmarks
- `symmetric_hash_join` - Symmetric hash join benchmarks
- `upcase` - String uppercase benchmarks
- `words_diamond` - Word processing diamond pattern benchmarks

## Purpose

This repository was created to isolate timely-dataflow and differential-dataflow dependencies from the main Hydro repository (bigweaver-agent-canary-hydro-zeta). This separation:

- Reduces dependency bloat in the main repository
- Allows performance engineers to work on benchmarks without affecting the main codebase
- Maintains the ability to run performance comparisons
- Provides a dedicated space for benchmarking infrastructure

## CI/CD

The repository includes a GitHub Actions workflow (`.github/workflows/benchmark.yml`) that runs benchmarks automatically on:
- Push to main or feature branches (when commit message includes `[ci-bench]`)
- Pull requests (when PR title or body includes `[ci-bench]`)
- Scheduled runs (daily)
- Manual workflow dispatch

## Dependencies

The benchmarks depend on:
- `timely-master` (timely-dataflow)
- `differential-dataflow-master`
- `criterion` for benchmarking infrastructure
- Various Hydro workspace crates for testing

## License

Apache-2.0
