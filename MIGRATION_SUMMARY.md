# Benchmark Migration Summary

## Overview

This document describes the migration of timely and differential-dataflow benchmarks from the main Hydro repository to this dedicated dependencies repository.

## What Was Moved

All benchmarks that depend on `timely` and `differential-dataflow` packages have been moved from the main `bigweaver-agent-canary-hydro-zeta` repository to this repository.

### Moved Files and Directories

- `benches/` - Complete benchmark suite
  - `benches/Cargo.toml` - Benchmark package configuration
  - `benches/README.md` - Benchmark documentation
  - `benches/build.rs` - Build script
  - `benches/benches/` - Individual benchmark implementations
    - `arithmetic.rs` - Arithmetic operations benchmarks
    - `fan_in.rs` - Fan-in pattern benchmarks
    - `fan_out.rs` - Fan-out pattern benchmarks
    - `fork_join.rs` - Fork-join pattern benchmarks
    - `futures.rs` - Futures-based benchmarks
    - `identity.rs` - Identity operation benchmarks
    - `join.rs` - Join operation benchmarks
    - `micro_ops.rs` - Micro-operation benchmarks
    - `reachability.rs` - Graph reachability benchmarks
    - `symmetric_hash_join.rs` - Symmetric hash join benchmarks
    - `upcase.rs` - String upcase benchmarks
    - `words_diamond.rs` - Diamond pattern benchmarks
    - Data files: `reachability_edges.txt`, `reachability_reachable.txt`, `words_alpha.txt`
- `.github/workflows/benchmark.yml` - CI workflow for benchmarks

## Changes Made

### In bigweaver-agent-canary-zeta-hydro-deps (this repository)

1. **Added workspace structure** - Created root `Cargo.toml` with workspace configuration
2. **Migrated benchmarks** - Added complete `benches/` directory from main repository
3. **Updated dependencies** - Modified `benches/Cargo.toml` to use git dependencies:
   - `dfir_rs` now references the main repository via git
   - `sinktools` now references the main repository via git
   - `timely` and `differential-dataflow` dependencies remain as registry dependencies
4. **Added configuration files** - Copied `rust-toolchain.toml`, `clippy.toml`, and `rustfmt.toml`
5. **Updated documentation** - Enhanced `README.md` with benchmark instructions and migration context
6. **Added CI workflow** - Migrated `.github/workflows/benchmark.yml` for automated testing

### In bigweaver-agent-canary-hydro-zeta (main repository)

1. **Removed benchmarks** - Deleted the entire `benches/` directory
2. **Removed dependencies** - The following dependencies were removed from the workspace:
   - `timely-master` (timely)
   - `differential-dataflow-master` (differential-dataflow)
3. **Removed CI workflow** - Deleted `.github/workflows/benchmark.yml`
4. **Updated workspace** - Removed `benches` from workspace members in root `Cargo.toml`

## Benefits

1. **Reduced Compilation Time** - The main repository no longer needs to compile heavyweight timely/differential-dataflow dependencies
2. **Cleaner Dependencies** - Core development work doesn't pull in benchmark-specific dependencies
3. **Maintained Functionality** - All performance comparison capabilities are preserved
4. **Separation of Concerns** - Benchmarks and core functionality are properly separated

## Usage After Migration

### Running Benchmarks

To run benchmarks after the migration:

```bash
# Clone the deps repository
git clone https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps

# Run all benchmarks
cargo bench -p benches

# Run specific benchmark
cargo bench -p benches --bench reachability
```

### For Developers

- **Core development**: Work in the main `bigweaver-agent-canary-hydro-zeta` repository
- **Benchmark development**: Work in this `bigweaver-agent-canary-zeta-hydro-deps` repository
- **Performance testing**: CI workflows in this repository will run benchmarks automatically

## Related Changes

This migration aligns with the team's strategy of:
- Proactive dependency management
- Maintaining clean repository structures
- Preventing dependency bloat
- Preserving specialized functionality in dedicated repositories

## References

- Main repository: [bigweaver-agent-canary-hydro-zeta](https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)
- Benchmarks repository: [bigweaver-agent-canary-zeta-hydro-deps](https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps)
