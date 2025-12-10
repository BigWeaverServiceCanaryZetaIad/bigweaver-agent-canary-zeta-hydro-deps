# Benchmarks Migration Guide

This document describes the migration of timely and differential-dataflow benchmarks from the main bigweaver-agent-canary-hydro-zeta repository to this dedicated bigweaver-agent-canary-zeta-hydro-deps repository.

## Overview

The benchmarks comparing Hydro with timely-dataflow and differential-dataflow have been moved to this separate repository to:

- Reduce the dependency footprint of the main repository
- Separate comparison benchmarks from core functionality
- Maintain a cleaner project structure in the main codebase
- Avoid transitive dependencies from timely/differential-dataflow in the main repository

## What Was Moved

### Benchmark Files
All benchmark source files from `benches/benches/`:
- `arithmetic.rs` - Basic arithmetic operations
- `fan_in.rs` - Multiple streams merging
- `fan_out.rs` - Stream splitting
- `fork_join.rs` - Fork and join patterns
- `futures.rs` - Async futures operations
- `identity.rs` - Identity transformations
- `join.rs` - Join operations
- `micro_ops.rs` - Micro-operation benchmarks
- `reachability.rs` - Graph reachability algorithms
- `symmetric_hash_join.rs` - Symmetric hash join operations
- `upcase.rs` - String case transformations
- `words_diamond.rs` - Diamond-shaped dataflow patterns

### Supporting Files
- `benches/Cargo.toml` - Benchmark package configuration (updated to use git dependencies)
- `benches/README.md` - Benchmark documentation
- `benches/build.rs` - Build script for code generation
- Data files: `reachability_edges.txt`, `reachability_reachable.txt`, `words_alpha.txt`

### Configuration Files
- `rustfmt.toml` - Code formatting configuration (copied from main repo)
- `clippy.toml` - Linting configuration (copied from main repo)

## Changes Made

### In bigweaver-agent-canary-zeta-hydro-deps Repository

1. **Created workspace structure** with `Cargo.toml` defining the workspace
2. **Added benches package** as a workspace member
3. **Updated benches/Cargo.toml** to:
   - Use explicit edition, license, and repository fields (removed workspace inheritance)
   - Reference `dfir_rs` and `sinktools` as git dependencies pointing to the main repository
   - Maintain timely and differential-dataflow dependencies for comparison benchmarks
4. **Updated README.md** with comprehensive documentation of available benchmarks
5. **Created this migration guide** (BENCHMARKS_MIGRATION.md)
6. **Copied configuration files** (rustfmt.toml, clippy.toml) for consistency

### In bigweaver-agent-canary-hydro-zeta Repository

1. **Removed benches directory** and all benchmark files
2. **Removed timely and differential-dataflow dependencies** from Cargo.lock
3. **Updated CONTRIBUTING.md** with instructions for running benchmarks in the new location
4. **Updated README.md** with a benchmarks section pointing to this repository

## How to Use the Benchmarks

### Prerequisites
- Rust toolchain (see main repository's rust-toolchain.toml for version)
- Git

### Running Benchmarks

1. Clone this repository:
   ```shell
   git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
   cd bigweaver-agent-canary-zeta-hydro-deps
   ```

2. Run all benchmarks:
   ```shell
   cargo bench -p benches
   ```

3. Run specific benchmarks:
   ```shell
   cargo bench -p benches --bench reachability
   cargo bench -p benches --bench identity
   ```

### Development

The benchmarks reference the main bigweaver-agent-canary-hydro-zeta repository via git dependencies. This means:
- Benchmarks always test against the latest code from the main repository
- No manual synchronization is needed
- Performance comparisons remain accurate and up-to-date

If you need to test benchmarks against local changes in the main repository:
1. Modify the git dependencies in `benches/Cargo.toml` to use local paths
2. Run your benchmarks
3. Revert the dependency changes before committing

## Performance Comparison Functionality

All performance comparison functionality has been preserved. The benchmarks include:
- Direct comparisons between Hydro (dfir_rs), timely-dataflow, and differential-dataflow
- Comprehensive metrics using the criterion benchmark harness
- Consistent test data and workloads across all implementations

## Verification

To verify the benchmarks work in the new location:

1. Build the benchmarks:
   ```shell
   cargo build --package benches --benches
   ```

2. Run a quick sanity check with one benchmark:
   ```shell
   cargo bench -p benches --bench identity -- --quick
   ```

3. Verify formatting and linting:
   ```shell
   cargo fmt --check
   cargo clippy --package benches
   ```

## Maintenance

### Updating Benchmarks
1. Make changes to benchmark files in this repository
2. Test with `cargo bench -p benches`
3. Commit and push changes

### Keeping Configuration in Sync
Periodically check if rustfmt.toml or clippy.toml have been updated in the main repository:
```shell
# From bigweaver-agent-canary-hydro-zeta directory
cp rustfmt.toml ../bigweaver-agent-canary-zeta-hydro-deps/
cp clippy.toml ../bigweaver-agent-canary-zeta-hydro-deps/
```

## Related Changes

- Main repository PR: Removal of benchmarks and dependencies
- This repository PR: Addition of benchmarks with git dependencies

## Additional Notes

This separation follows a modular architecture pattern used by the team, where benchmarking code is separated from main application code. This allows different components to evolve independently while preserving their functional relationships.

The migration maintains all historical benchmark data and ensures continuous performance comparison capabilities.