# Timely/Differential-Dataflow Benchmarks

Benchmarks for comparing Hydro implementations with timely and differential-dataflow implementations.

## Overview

This directory contains benchmarks that depend on timely and differential-dataflow. These benchmarks were moved from the [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to reduce build dependencies and improve build times for the main repository.

## Available Benchmarks

- **arithmetic** - Arithmetic operations benchmark comparing pipeline, raw, iterator, and Hydroflow implementations
- **fan_in** - Fan-in pattern benchmark testing multiple input streams merging
- **fan_out** - Fan-out pattern benchmark testing distribution to multiple outputs
- **fork_join** - Fork-join pattern benchmark with generated code
- **identity** - Identity transformation benchmark comparing different implementations
- **join** - Join operations benchmark comparing Hydroflow and timely implementations
- **reachability** - Graph reachability benchmark using differential-dataflow
- **upcase** - String transformation benchmark

## Prerequisites

These benchmarks require access to the `dfir_rs` and `sinktools` crates from the main repository. Ensure that the [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository is cloned as a sibling directory to this repository:

```
parent-directory/
├── bigweaver-agent-canary-hydro-zeta/
│   ├── dfir_rs/
│   └── sinktools/
└── bigweaver-agent-canary-zeta-hydro-deps/
    └── benches/
```

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench join
cargo bench -p benches --bench reachability
```

## Build Script

The `build.rs` script generates code for the fork_join benchmark at build time. Generated files are ignored by git (see `.gitignore`).

## Data Files

- `reachability_edges.txt` - Test data for reachability benchmark
- `reachability_reachable.txt` - Expected results for reachability benchmark

## Performance Comparison

To compare performance between Hydro-native and timely/differential-dataflow implementations:

1. Run benchmarks in the main repository (Hydro-native):
   ```bash
   cd ../bigweaver-agent-canary-hydro-zeta
   cargo bench -p benches
   ```

2. Run benchmarks in this repository (timely/differential-dataflow):
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps
   cargo bench -p benches
   ```

3. Compare the results from both runs to evaluate performance characteristics

## Dependencies

The benchmarks use the following major dependencies:

- **criterion** - Benchmarking framework
- **timely-master** (v0.13.0-dev.1) - Timely dataflow framework
- **differential-dataflow-master** (v0.13.0-dev.1) - Differential dataflow framework
- **dfir_rs** - Hydroflow's DFIR implementation (from main repository)
- **sinktools** - Utility tools (from main repository)

## Migration Notes

These benchmarks were migrated from the main repository on December 17, 2024. See [BENCHMARK_MIGRATION.md](../BENCHMARK_MIGRATION.md) in the main repository for details about the migration process.
