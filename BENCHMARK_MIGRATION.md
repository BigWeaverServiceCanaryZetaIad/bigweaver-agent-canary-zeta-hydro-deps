# Benchmark Migration Documentation

## Overview

This document describes the migration of timely and differential-dataflow benchmarks from the bigweaver-agent-canary-hydro-zeta repository to the bigweaver-agent-canary-zeta-hydro-deps repository.

## Migration Date

December 17, 2024

## Objective

To reduce build dependencies and improve build times for the main repository while maintaining the ability to run performance comparisons with Timely/Differential implementations.

## Changes Made

### In bigweaver-agent-canary-hydro-zeta (Main Repository)

#### Removed Benchmarks
The following benchmarks were moved to the deps repository:
- `arithmetic.rs` - Arithmetic operations benchmark
- `fan_in.rs` - Fan-in pattern benchmark
- `fan_out.rs` - Fan-out pattern benchmark
- `fork_join.rs` - Fork-join pattern benchmark
- `identity.rs` - Identity transformation benchmark
- `join.rs` - Join operations benchmark
- `reachability.rs` - Graph reachability benchmark
- `upcase.rs` - String transformation benchmark

#### Removed Data Files
- `reachability_edges.txt` - Test data for reachability benchmark
- `reachability_reachable.txt` - Expected results for reachability benchmark

#### Removed Build Script
- `benches/build.rs` - Build script for fork_join benchmark code generation

#### Removed Dependencies
From `benches/Cargo.toml`:
- `differential-dataflow` (package: "differential-dataflow-master", version: "0.13.0-dev.1")
- `timely` (package: "timely-master", version: "0.13.0-dev.1")

#### Retained Benchmarks
The following Hydro-native benchmarks remain in the main repository:
- `futures.rs` - Futures-based operations benchmark
- `micro_ops.rs` - Micro-operations benchmark
- `symmetric_hash_join.rs` - Symmetric hash join benchmark
- `words_diamond.rs` - Word processing diamond pattern benchmark

#### Updated Documentation
- `benches/README.md` - Updated to reflect Hydro-native focus and reference deps repository
- `README.md` - Updated to reference the separated benchmarks repository

### In bigweaver-agent-canary-zeta-hydro-deps (Dependencies Repository)

#### Added Benchmarks
All timely/differential-dataflow benchmarks were added:
- `arithmetic.rs`
- `fan_in.rs`
- `fan_out.rs`
- `fork_join.rs`
- `identity.rs`
- `join.rs`
- `reachability.rs`
- `upcase.rs`

#### Added Data Files
- `reachability_edges.txt`
- `reachability_reachable.txt`

#### Added Build Script
- `benches/build.rs`

#### Added Configuration
- `benches/Cargo.toml` - Package configuration with timely/differential-dataflow dependencies
- `benches/.gitignore` - Git ignore patterns for generated files

#### Added Documentation
- `benches/README.md` - Comprehensive documentation for benchmark usage
- `README.md` - Updated repository description and purpose

## Dependencies

### Main Repository (After Migration)
The `benches/Cargo.toml` now includes only:
- criterion (for benchmarking framework)
- dfir_rs (Hydro's DFIR implementation)
- futures
- nameof
- rand
- rand_distr
- seq-macro
- sinktools
- static_assertions
- tokio

### Dependencies Repository
The `benches/Cargo.toml` includes:
- criterion (for benchmarking framework)
- differential-dataflow-master (version 0.13.0-dev.1)
- timely-master (version 0.13.0-dev.1)
- futures
- nameof
- rand
- rand_distr
- seq-macro
- static_assertions
- tokio

## Performance Comparison Workflow

### Running Hydro-Native Benchmarks
From the main repository:
```bash
cd bigweaver-agent-canary-hydro-zeta
cargo bench -p benches
```

### Running Timely/Differential-Dataflow Benchmarks
From the deps repository:
```bash
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench -p benches
```

### Comparing Results
Results from both repositories can be compared to evaluate performance characteristics between:
- Hydro-native implementations (main repository)
- Timely/Differential-Dataflow implementations (deps repository)

## Benefits

1. **Reduced Build Dependencies**: The main repository no longer depends on timely and differential-dataflow
2. **Faster Build Times**: Core development builds are faster without external dataflow dependencies
3. **Maintained Functionality**: Performance comparison capabilities are preserved in the deps repository
4. **Clear Separation**: Clean architectural boundary between core implementation and comparative benchmarks
5. **Improved Maintainability**: Each repository has a focused purpose and dependency set

## Repository Links

- Main Repository: https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta
- Dependencies Repository: https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps

## Verification

To verify the migration:

1. Main repository builds successfully without timely/differential-dataflow:
   ```bash
   cd bigweaver-agent-canary-hydro-zeta/benches
   cargo build
   cargo bench
   ```

2. Dependencies repository builds successfully with benchmarks:
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps/benches
   cargo build
   cargo bench
   ```

3. All Hydro-native benchmarks run in main repository
4. All timely/differential-dataflow benchmarks run in deps repository

## Notes

- The wordlist file `words_alpha.txt` remains in the main repository as it's used by the `words_diamond` benchmark
- The `.gitignore` pattern for generated `fork_join_*.hf` files was copied to the deps repository
- Build script `build.rs` generates code for the fork_join benchmark at build time
