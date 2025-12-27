# Timely and Differential-Dataflow Benchmarks

This directory contains benchmarks that use timely-dataflow and differential-dataflow implementations for performance comparison with Hydro-native implementations.

## Overview

These benchmarks were migrated from the main bigweaver-agent-canary-hydro-zeta repository to isolate dependencies on timely and differential-dataflow, allowing the main repository to build faster without these external dependencies.

## Available Benchmarks

### Timely-Dataflow Benchmarks
- **arithmetic** - Arithmetic operations benchmark using timely
- **fan_in** - Fan-in pattern benchmark using timely
- **fan_out** - Fan-out pattern benchmark using timely
- **fork_join** - Fork-join pattern benchmark using timely (generated via build.rs)
- **identity** - Identity transformation benchmark using timely
- **join** - Join operations benchmark using timely
- **upcase** - String transformation benchmark using timely

### Differential-Dataflow Benchmarks
- **reachability** - Graph reachability benchmark using differential-dataflow

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench reachability
cargo bench -p benches --bench fork_join
```

## Performance Comparison

To compare performance with Hydro-native implementations, run the corresponding benchmarks in the [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository:

```bash
# In the main hydro-zeta repository
cd ../bigweaver-agent-canary-hydro-zeta
cargo bench -p benches
```

## Data Files

- **reachability_edges.txt** - Test data for reachability benchmark
- **reachability_reachable.txt** - Expected results for reachability benchmark

## Build Script

The `build.rs` script generates the fork_join benchmark code at build time, creating a surface syntax file `fork_join_20.hf` with a configurable number of operations.

## Dependencies

This package depends on:
- `timely-master` (version 0.13.0-dev.1) - Timely dataflow engine
- `differential-dataflow-master` (version 0.13.0-dev.1) - Differential dataflow framework
- `criterion` - Benchmarking framework
- Additional supporting libraries (futures, rand, tokio, etc.)

## Migration Notes

These benchmarks were migrated from bigweaver-agent-canary-hydro-zeta to separate concerns and reduce build dependencies. The migration preserves:
- Original benchmark implementations
- Directory structure
- Build scripts and data files
- Performance comparison capability

For more details, see the BENCHMARK_MIGRATION.md file in the main repository.
