# Timely and Differential-Dataflow Benchmarks

This repository contains performance comparison benchmarks for DFIR (Hydro) against timely-dataflow and differential-dataflow.

## Purpose

These benchmarks compare the performance of DFIR implementations with equivalent implementations using timely-dataflow and differential-dataflow. By separating these benchmarks from the main Hydro repository, we avoid introducing timely and differential-dataflow as dependencies in the core codebase while still maintaining the ability to run performance comparisons.

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p timely-differential-benchmarks
```

Run specific benchmarks:
```bash
cargo bench -p timely-differential-benchmarks --bench arithmetic
cargo bench -p timely-differential-benchmarks --bench fan_in
cargo bench -p timely-differential-benchmarks --bench fan_out
cargo bench -p timely-differential-benchmarks --bench fork_join
cargo bench -p timely-differential-benchmarks --bench identity
cargo bench -p timely-differential-benchmarks --bench join
cargo bench -p timely-differential-benchmarks --bench reachability
cargo bench -p timely-differential-benchmarks --bench upcase
```

## Benchmark Descriptions

- **arithmetic** - Arithmetic operation benchmarks comparing DFIR, timely-dataflow, and pipeline implementations
- **fan_in** - Fan-in pattern benchmarks testing multiple input streams merging
- **fan_out** - Fan-out pattern benchmarks testing single stream splitting to multiple outputs
- **fork_join** - Fork-join pattern benchmarks with filtering and merging
- **identity** - Identity operation benchmarks testing basic data flow
- **join** - Join operation benchmarks comparing different join implementations
- **reachability** - Graph reachability benchmarks using real-world graph data
- **upcase** - String uppercase transformation benchmarks

## Data Files

- **reachability_edges.txt** - Graph edge data for reachability benchmarks
- **reachability_reachable.txt** - Expected reachable nodes for validation

## Dependencies

These benchmarks depend on:
- `timely-dataflow-master` (0.13.0-dev.1) - For timely-dataflow comparisons
- `differential-dataflow-master` (0.13.0-dev.1) - For differential-dataflow comparisons
- `dfir_rs` - Referenced from the main Hydro repository via git
- `sinktools` - Referenced from the main Hydro repository via git

## Migration Notes

These benchmarks were moved from the main `bigweaver-agent-canary-hydro-zeta` repository to remove timely and differential-dataflow dependencies from the core Hydro codebase. The DFIR-native benchmarks (micro_ops, futures, symmetric_hash_join, words_diamond) remain in the main repository.

For more information about the main Hydro repository, visit: https://github.com/hydro-project/hydro
