# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmark dependencies for the Hydro project, specifically benchmarks that were migrated from the main bigweaver-agent-canary-hydro-zeta repository to maintain separation of concerns and reduce build complexity in the main codebase.

## Contents

- **benches/** - Microbenchmarks for Hydro and related crates including:
  - Benchmarks comparing Hydro with Timely performance
  - Join operation benchmarks
  - Benchmarks using differential dataflow operators
  - Various micro-operation benchmarks

## Running Benchmarks

To run all benchmarks:
```bash
cargo bench -p benches
```

To run specific benchmarks:
```bash
cargo bench -p benches --bench identity
cargo bench -p benches --bench join
cargo bench -p benches --bench reachability
```

For more details, see [benches/README.md](benches/README.md).

## Dependencies

The benchmarks depend on:
- `timely-master` (version 0.13.0-dev.1)
- `differential-dataflow-master` (version 0.13.0-dev.1)
- `dfir_rs` from the main Hydro repository
- Other supporting crates

## Purpose

This repository supports performance testing and comparison capabilities while keeping the main Hydro codebase focused on production code.