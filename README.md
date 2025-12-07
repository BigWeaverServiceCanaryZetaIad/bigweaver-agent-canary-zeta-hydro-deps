# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and code that depend on [timely-dataflow](https://github.com/TimelyDataflow/timely-dataflow) and [differential-dataflow](https://github.com/TimelyDataflow/differential-dataflow).

## Purpose

This repository was created to separate benchmarks with external dependencies (`timely` and `differential-dataflow`) from the main `bigweaver-agent-canary-hydro-zeta` repository. This separation:

- Keeps the main repository free from unnecessary dependencies
- Maintains the ability to run performance comparisons between Hydro and timely/differential-dataflow
- Provides a dedicated space for dependency-heavy benchmarking code

## Contents

### Benchmarks

The `benches/` directory contains microbenchmarks for comparing Hydro with timely and differential-dataflow implementations. These benchmarks include:

- **arithmetic**: Arithmetic operations benchmarks
- **fan_in**: Fan-in pattern benchmarks
- **fan_out**: Fan-out pattern benchmarks
- **fork_join**: Fork-join pattern benchmarks
- **futures**: Async futures benchmarks
- **identity**: Identity operation benchmarks
- **join**: Join operation benchmarks
- **micro_ops**: Micro-operations benchmarks
- **reachability**: Graph reachability benchmarks
- **symmetric_hash_join**: Symmetric hash join benchmarks
- **upcase**: String uppercase transformation benchmarks
- **words_diamond**: Word processing diamond pattern benchmarks

## Running Benchmarks

To run all benchmarks:
```bash
cargo bench -p benches
```

To run a specific benchmark:
```bash
cargo bench -p benches --bench reachability
```

## Dependencies

This repository references the `bigweaver-agent-canary-hydro-zeta` repository using relative paths for shared components like `dfir_rs` and `sinktools`. Ensure both repositories are cloned side by side in the same parent directory:

```
/path/to/parent/
├── bigweaver-agent-canary-hydro-zeta/
└── bigweaver-agent-canary-zeta-hydro-deps/
```

## Migration

These benchmarks were migrated from the main `bigweaver-agent-canary-hydro-zeta` repository. For details about the migration, see [BENCHMARKS_MIGRATION.md](BENCHMARKS_MIGRATION.md).