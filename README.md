# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies that depend on external packages like `timely` and `differential-dataflow`. These have been separated from the main `bigweaver-agent-canary-hydro-zeta` repository to avoid unnecessary dependencies in the main codebase.

## Contents

- **benches**: Microbenchmarks for Hydro and related crates, including comparisons with `timely` and `differential-dataflow` implementations.

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

The benchmarks in this repository allow for performance comparisons between Hydro implementations and other dataflow systems. Results can be compared with benchmarks in the main repository to evaluate performance characteristics.