# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for timely and differential-dataflow that were migrated from the main bigweaver-agent-canary-hydro-zeta repository.

## Contents

- **benches/**: Microbenchmarks for Hydro and related crates, including performance comparisons with timely and differential-dataflow

## Running Benchmarks

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

## Dependencies

The benchmarks depend on:
- `timely` (timely-master package)
- `differential-dataflow` (differential-dataflow-master package)
- `dfir_rs` and `sinktools` from the main hydro repository (referenced via git)

These dependencies are maintained separately to avoid polluting the main repository with unnecessary dependencies while retaining the ability to run performance comparisons.