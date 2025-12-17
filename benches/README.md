# Timely and Differential-Dataflow Benchmarks

Benchmarks for comparing Hydro with timely and differential-dataflow implementations.

## Overview

This directory contains benchmarks that depend on timely and differential-dataflow. These benchmarks are maintained separately from the main repository to avoid introducing those dependencies into the core Hydro project.

## Available Benchmarks

- **arithmetic** - Arithmetic operations benchmark
- **fan_in** - Fan-in pattern benchmark
- **fan_out** - Fan-out pattern benchmark
- **fork_join** - Fork-join pattern benchmark
- **identity** - Identity transformation benchmark
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
cargo bench -p benches --bench fork_join
cargo bench -p benches --bench reachability
```

## Performance Comparison

To compare performance with Hydro-native implementations, use the benchmarks in the [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository.

## Data Files

- `reachability_edges.txt` - Test data for reachability benchmark
- `reachability_reachable.txt` - Expected results for reachability benchmark

## Build Script

The `build.rs` script generates code for the `fork_join` benchmark at build time. Generated files (matching `fork_join_*.hf`) are ignored by git.

## Dependencies

Most benchmarks in this repository compare timely/differential-dataflow implementations with Hydro-native (dfir_rs) implementations. To run these benchmarks, you need:

1. The bigweaver-agent-canary-hydro-zeta repository checked out as a sibling directory
2. The dfir_rs and sinktools crates must be available in the main repository

The Cargo.toml references these dependencies using relative paths:
- `dfir_rs = { path = "../../bigweaver-agent-canary-hydro-zeta/dfir_rs" }`
- `sinktools = { path = "../../bigweaver-agent-canary-hydro-zeta/sinktools" }`

Some benchmarks (join.rs, upcase.rs) only use timely/differential-dataflow and don't require these dependencies.
