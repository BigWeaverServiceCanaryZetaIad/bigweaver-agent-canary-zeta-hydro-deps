# Benchmark Migration from bigweaver-agent-canary-hydro-zeta

## Overview

This document describes the migration of benchmarks that depend on `timely` and `differential-dataflow` from the main Hydro repository to this separate repository.

## What Was Moved

The following files were moved from the `bigweaver-agent-canary-hydro-zeta` repository to this repository:

### Benchmark Crate (`benches/`)
- `benches/Cargo.toml` - Benchmark package configuration with timely/differential-dataflow dependencies
- `benches/README.md` - Benchmark usage documentation
- `benches/build.rs` - Build script
- `benches/benches/` - Directory containing all benchmark files:
  - `arithmetic.rs` - Arithmetic operation benchmarks
  - `fan_in.rs` - Fan-in pattern benchmarks
  - `fan_out.rs` - Fan-out pattern benchmarks
  - `fork_join.rs` - Fork-join pattern benchmarks
  - `futures.rs` - Future-based operation benchmarks
  - `identity.rs` - Identity operation benchmarks
  - `join.rs` - Join operation benchmarks
  - `micro_ops.rs` - Micro-operation benchmarks
  - `reachability.rs` - Graph reachability benchmarks
  - `reachability_edges.txt` - Test data for reachability benchmarks
  - `reachability_reachable.txt` - Expected results for reachability benchmarks
  - `symmetric_hash_join.rs` - Symmetric hash join benchmarks
  - `upcase.rs` - String uppercase benchmarks
  - `words_alpha.txt` - Word list for benchmarks
  - `words_diamond.rs` - Word processing diamond pattern benchmarks

## Dependencies Removed from Main Repository

The following dependencies were removed from the main repository's `Cargo.lock`:

- `timely-master` (v0.13.0-dev.1)
- `differential-dataflow-master` (v0.13.0-dev.1)
- `timely-bytes-master`
- `timely-communication-master`
- `timely-container-master`
- `timely-logging-master`

## Changes Made to Benchmark Crate

The `benches/Cargo.toml` was updated to reference the main repository's crates via git dependencies instead of path dependencies:

```toml
dfir_rs = { git = "https://...", features = [ "debugging" ] }
sinktools = { git = "https://...", version = "^0.0.1" }
```

This allows the benchmarks to continue using the main repository's code while being in a separate repository.

## Rationale for Migration

1. **Dependency Isolation**: Remove direct dependencies on `timely` and `differential-dataflow` from the main repository
2. **Build Performance**: Reduce build times for developers working on the main repository
3. **Cleaner Architecture**: Maintain separation of concerns between core functionality and performance testing
4. **Reduced Dependency Footprint**: Minimize the number of external dependencies in the main repository
5. **Flexibility**: Allow benchmarks to be updated and run independently of main repository releases

## How to Run Performance Comparisons

Despite being in a separate repository, the benchmarks can still perform performance comparisons:

1. Clone this repository
2. Run benchmarks using `cargo bench -p benches`
3. Compare results across different versions by checking out different commits of the main repository (via git dependencies)

The benchmarks automatically fetch the specified version of the main repository's code when building.

## Timeline

This migration was performed to improve the maintainability and build efficiency of the Hydro project while preserving the ability to run comprehensive performance comparisons.
