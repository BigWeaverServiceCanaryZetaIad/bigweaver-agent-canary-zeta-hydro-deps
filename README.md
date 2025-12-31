# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarking dependencies for the Hydro project, separated from the main repository to avoid unnecessary dependencies in the core codebase.

## Contents

- `benches/` - Microbenchmarks for Hydro and other crates, including comparisons with Timely Dataflow and Differential Dataflow

## Running Benchmarks

From this repository root, run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench fan_in
cargo bench -p benches --bench join
```

## Dependencies

The benchmarks require access to the main `bigweaver-agent-canary-hydro-zeta` repository, which should be located at `../bigweaver-agent-canary-hydro-zeta` relative to this repository.

Key dependencies:
- `criterion` - Statistics-driven benchmarking library
- `timely` (timely-master) - Timely Dataflow framework for comparison
- `differential-dataflow` (differential-dataflow-master) - Differential Dataflow framework for comparison
- `dfir_rs` - Main Hydro/DFIR runtime (from main repository)
- `sinktools` - Utilities for data sinks (from main repository)

## Benchmark Categories

- **Graph algorithms**: reachability
- **Join operations**: join, symmetric_hash_join
- **Micro-operations**: micro_ops (map, flat_map, union, tee, fold, sort, etc.)
- **Flow patterns**: fan_in, fan_out, fork_join, identity, upcase, words_diamond
- **Async operations**: futures
- **Arithmetic**: arithmetic

See `benches/README.md` for more details about individual benchmarks.
