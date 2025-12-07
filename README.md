# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies that depend on `timely` and `differential-dataflow` packages, which have been separated from the main `bigweaver-agent-canary-hydro-zeta` repository to reduce dependency bloat.

## Contents

- **benches/**: Performance benchmarks that use timely and differential-dataflow
  - arithmetic.rs
  - fan_in.rs
  - fan_out.rs
  - fork_join.rs
  - identity.rs
  - join.rs
  - reachability.rs
  - upcase.rs

## Running Benchmarks

To run all benchmarks:
```bash
cargo bench
```

To run a specific benchmark:
```bash
cargo bench --bench <benchmark_name>
```

For example:
```bash
cargo bench --bench arithmetic
```

## Dependencies

This repository depends on:
- `timely` (timely-master): For dataflow computation benchmarks
- `differential-dataflow` (differential-dataflow-master): For incremental computation benchmarks
- `dfir_rs`: The core DFIR framework (referenced as git dependency from main repo)
- `sinktools`: Utility tools (referenced as git dependency from main repo)

## Migration

These benchmarks were moved from the main repository to keep the main repository lean and avoid unnecessary dependencies for users who don't need to run performance benchmarks. See `BENCHMARKS_MIGRATION.md` in the main repository for details.