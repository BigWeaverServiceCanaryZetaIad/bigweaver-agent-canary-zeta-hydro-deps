# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmark code and dependencies for the Hydro project that depend on external frameworks like timely-dataflow and differential-dataflow.

## Benchmarks

The `benches` directory contains microbenchmarks comparing Hydro with other dataflow frameworks including timely-dataflow and differential-dataflow.

### Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
```

### About

These benchmarks were moved from the main [hydro repository](https://github.com/hydro-project/hydro) to avoid including timely-dataflow and differential-dataflow as dependencies in the core project while retaining the ability to run performance comparisons.