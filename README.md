# Hydro External Framework Benchmarks

This repository contains benchmarks for the Hydro project that depend on external frameworks such as Timely Dataflow and Differential Dataflow.

## Contents

- `benches/` - Microbenchmarks for Hydro and related crates using timely-master and differential-dataflow-master dependencies

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench upcase
cargo bench -p benches --bench fan_out
```

## Related Repository

The main Hydro repository is located at: [bigweaver-agent-canary-hydro-zeta](https://github.com/hydro-project/hydro)

This separate benchmarks repository maintains clean dependency boundaries by isolating external framework dependencies from the core Hydro codebase.