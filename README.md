# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks for timely and differential-dataflow that have been separated from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to avoid dependency bloat.

## Purpose

These benchmarks allow for performance comparisons of dataflow patterns and operations without requiring the main repository to maintain dependencies on timely and differential-dataflow packages.

## Structure

- `benches/` - Microbenchmarks for Hydro and related dataflow operations

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench micro_ops
```

## Available Benchmarks

- **arithmetic** - Arithmetic operation benchmarks
- **fan_in** - Fan-in pattern benchmarks
- **fan_out** - Fan-out pattern benchmarks
- **fork_join** - Fork-join pattern benchmarks
- **futures** - Future-based operation benchmarks
- **identity** - Identity operation benchmarks
- **join** - Join operation benchmarks
- **micro_ops** - Micro-operation benchmarks
- **reachability** - Graph reachability benchmarks
- **symmetric_hash_join** - Symmetric hash join benchmarks
- **upcase** - String uppercase transformation benchmarks
- **words_diamond** - Word processing diamond pattern benchmarks

## Dependencies

This repository depends on:
- `timely` (timely-master package)
- `differential-dataflow` (differential-dataflow-master package)
- `dfir_rs` and `sinktools` from the main hydro repository (via git dependencies)

## Migration

These benchmarks were moved from the main repository to maintain a clean separation of concerns and reduce build times for the core hydro project. The original benchmark code and history can be found in the main repository's git history.