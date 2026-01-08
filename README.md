# bigweaver-agent-canary-zeta-hydro-deps

## Overview

This repository contains benchmarks that depend on timely-dataflow and differential-dataflow packages. These benchmarks were migrated from the [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to isolate heavyweight dependencies and improve build times.

## Purpose

The main repository focuses on Hydro-native implementations, while this repository maintains performance comparison benchmarks using Timely and Differential-Dataflow frameworks. This separation allows:

1. **Faster builds** in the main repository without timely/differential-dataflow dependencies
2. **Preserved comparison capabilities** for evaluating performance characteristics
3. **Clear architectural boundaries** between core implementation and comparative benchmarks
4. **Independent versioning** of benchmark dependencies

## Repository Contents

- `benches/` - Benchmark implementations and test data
- `benches/Cargo.toml` - Package configuration with timely/differential-dataflow dependencies
- `benches/build.rs` - Build script for code generation
- `benches/README.md` - Detailed benchmark documentation

## Benchmarks

The following benchmarks are available:

- **arithmetic** - Arithmetic operations across different execution models
- **fan_in** - Fan-in patterns where multiple streams merge
- **fan_out** - Fan-out patterns where a single stream splits
- **fork_join** - Fork-join patterns with repeated splitting and merging
- **identity** - Identity transformation (no-op) overhead
- **join** - Hash-based join operations
- **reachability** - Graph reachability using iterative dataflow
- **upcase** - String transformation operations

Each benchmark compares Timely/Differential-Dataflow implementations against baseline Rust implementations.

## Running Benchmarks

```bash
# Run all benchmarks
cargo bench -p benches

# Run specific benchmark
cargo bench -p benches --bench arithmetic

# Run specific test within a benchmark
cargo bench -p benches --bench reachability -- differential
```

## Dependencies

- **timely-master** (0.13.0-dev.1) - Timely dataflow framework
- **differential-dataflow-master** (0.13.0-dev.1) - Differential dataflow framework
- **criterion** (0.5.0) - Benchmarking framework with statistical analysis

See `benches/Cargo.toml` for complete dependency list.

## Related Repository

- [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) - Main repository with Hydro-native benchmarks

## Migration

These benchmarks were migrated from the main repository on December 17, 2024. See BENCHMARK_MIGRATION.md in the main repository for migration details.