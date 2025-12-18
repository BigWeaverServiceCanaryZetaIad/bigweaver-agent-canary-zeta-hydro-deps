# bigweaver-agent-canary-zeta-hydro-deps

## Overview

This repository contains benchmarks and code that depend on Timely Dataflow and Differential Dataflow for performance comparison with Hydro implementations. It was created to isolate these heavy dependencies from the main development repository and improve build times.

## Purpose

The primary purpose of this repository is to:

1. **Performance Comparison** - Provide equivalent implementations of dataflow patterns using Timely and Differential Dataflow for benchmarking against Hydro
2. **Dependency Isolation** - Keep the heavy Timely/Differential-Dataflow dependencies separate from core Hydro development
3. **Build Time Optimization** - Reduce build times in the main repository by removing these large external dependencies
4. **Maintained Reference** - Serve as a maintained reference for comparative performance analysis

## Contents

### Benchmarks (`benches/`)

Contains comprehensive benchmarks comparing dataflow patterns:
- **arithmetic** - Arithmetic operations through pipelines
- **fan_in** - Multiple streams converging to one
- **fan_out** - Single stream distributed to multiple outputs
- **fork_join** - Fork-join parallelism patterns
- **identity** - Baseline dataflow overhead measurement
- **join** - Stream join operations
- **reachability** - Graph reachability computation
- **upcase** - String transformation operations

See [benches/README.md](benches/README.md) for detailed benchmark documentation.

## Running Benchmarks

```bash
# Run all benchmarks
cargo bench -p benches

# Run specific benchmark
cargo bench -p benches --bench arithmetic
```

## Dependencies

This repository includes:
- **timely-master** (0.13.0-dev.1) - Timely Dataflow framework
- **differential-dataflow-master** (0.13.0-dev.1) - Differential Dataflow framework
- **criterion** - Benchmarking framework

## Related Repositories

- **[bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)** - Main Hydro project repository with DFIR-native implementations and Hydro-native benchmarks

## Migration Information

These benchmarks were migrated from the main repository to reduce dependencies and improve build performance. See the BENCHMARK_MIGRATION.md file in the main repository for detailed migration documentation.

## Performance Comparison Workflow

1. Run Hydro-native benchmarks in the main repository
2. Run Timely/Differential-Dataflow benchmarks in this repository
3. Compare results to evaluate performance characteristics

## Build Notes

- Initial builds can take significant time due to the size of Timely/Differential-Dataflow dependencies
- The fork_join benchmark uses code generation at build time via `build.rs`
- Generated files are excluded from version control