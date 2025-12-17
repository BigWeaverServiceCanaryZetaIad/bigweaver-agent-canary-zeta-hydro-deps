# Timely/Differential-Dataflow Benchmarks

Benchmarks for comparing Hydro implementations with timely and differential-dataflow.

## Overview

This directory contains benchmarks that depend on timely and differential-dataflow. These benchmarks are kept separate from the main repository to avoid build dependencies for core development while preserving the ability to run performance comparisons.

## Available Benchmarks

### Dataflow Pattern Benchmarks
- **arithmetic** - Arithmetic operations benchmark
- **fan_in** - Fan-in pattern benchmark
- **fan_out** - Fan-out pattern benchmark
- **fork_join** - Fork-join pattern benchmark (with code generation)
- **identity** - Identity transformation benchmark

### Join and Query Benchmarks
- **join** - Join operations benchmark
- **reachability** - Graph reachability benchmark
- **upcase** - String transformation benchmark

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

## Performance Comparison Workflow

1. Run benchmarks in this repository (with timely/differential-dataflow)
2. Run corresponding benchmarks in the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository (Hydro-native)
3. Compare results to evaluate performance characteristics

## Dependencies

This package includes:
- **criterion** - Benchmarking framework
- **differential-dataflow-master** (version 0.13.0-dev.1)
- **timely-master** (version 0.13.0-dev.1)
- Supporting libraries: futures, rand, tokio, etc.

## Build Script

The `build.rs` script generates code for the fork_join benchmark at build time, creating `fork_join_20.hf` with the specified number of operations.

## Data Files

- `reachability_edges.txt` - Test data for reachability benchmark
- `reachability_reachable.txt` - Expected results for reachability benchmark

## Related Repositories

- **[bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)** - Main Hydro repository with DFIR-native benchmarks
