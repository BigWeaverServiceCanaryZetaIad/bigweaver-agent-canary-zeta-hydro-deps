# Timely and Differential-Dataflow Benchmarks

This directory contains benchmarks that compare Hydro's DFIR implementation with Timely Dataflow and Differential Dataflow implementations.

## Overview

These benchmarks were moved from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to maintain a clean separation between core Hydro-native code and benchmarks that require external dataflow dependencies.

## Available Benchmarks

- **arithmetic** - Arithmetic operations benchmark comparing different implementations
- **fan_in** - Fan-in pattern benchmark
- **fan_out** - Fan-out pattern benchmark
- **fork_join** - Fork-join pattern benchmark (uses generated code via build.rs)
- **identity** - Identity transformation benchmark
- **join** - Join operations benchmark
- **reachability** - Graph reachability benchmark (uses test data files)
- **upcase** - String transformation benchmark

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench reachability
cargo bench -p benches --bench join
```

## Performance Comparison

These benchmarks allow comparison between:
- Hydro DFIR-native implementations
- Timely Dataflow implementations
- Differential Dataflow implementations

To compare with Hydro-native benchmarks without timely/differential dependencies, see the [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository.

## Dependencies

This package depends on:
- **timely-master** - Timely Dataflow library
- **differential-dataflow-master** - Differential Dataflow library
- **dfir_rs** - Hydro's DFIR implementation (from main repository)
- **sinktools** - Hydro's sink utilities (from main repository)
- **criterion** - Benchmarking framework

## Test Data

- `reachability_edges.txt` - Input edges for the reachability benchmark
- `reachability_reachable.txt` - Expected reachable nodes for verification

## Generated Files

The fork_join benchmark uses a build script (`build.rs`) to generate benchmark code at compile time. Generated files follow the pattern `fork_join_*.hf` and are excluded from version control.

## Build Requirements

To build and run these benchmarks, you need:
- Rust toolchain (stable or nightly)
- Cargo package manager
- Git (for fetching dfir_rs and sinktools dependencies)

The build script will automatically generate required files during the build process.

## Verification

All benchmarks have been verified to:
- ✅ Properly import timely or differential-dataflow libraries
- ✅ Include all necessary dependencies in Cargo.toml
- ✅ Have access to required test data files
- ✅ Be properly declared with `harness = false`

For detailed verification results, see [BENCHMARK_VERIFICATION_REPORT.md](../BENCHMARK_VERIFICATION_REPORT.md) in the repository root.
