# Migration Guide

This document explains the migration of timely and differential-dataflow benchmarks from the main Hydro repository to this separate repository.

## Background

The benchmarks in this repository were originally located in the `benches/` directory of the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository. They were moved to avoid including timely and differential-dataflow as dependencies in the main codebase while retaining the ability to run performance comparisons.

## What Was Moved

All files from the original `benches/` directory were moved:

### Benchmark Files
- `benches/arithmetic.rs` - Arithmetic operation benchmarks
- `benches/fan_in.rs` - Fan-in pattern benchmarks
- `benches/fan_out.rs` - Fan-out pattern benchmarks
- `benches/fork_join.rs` - Fork-join pattern benchmarks
- `benches/futures.rs` - Async futures benchmarks
- `benches/identity.rs` - Identity transformation benchmarks
- `benches/join.rs` - Join operation benchmarks
- `benches/micro_ops.rs` - Micro-operations benchmarks
- `benches/reachability.rs` - Graph reachability benchmarks
- `benches/symmetric_hash_join.rs` - Symmetric hash join benchmarks
- `benches/upcase.rs` - String transformation benchmarks
- `benches/words_diamond.rs` - Diamond pattern word processing benchmarks

### Data Files
- `benches/reachability_edges.txt` - Edge data for reachability tests (55,008 edges)
- `benches/reachability_reachable.txt` - Expected reachable nodes
- `benches/words_alpha.txt` - English word list from dwyl/english-words (370,104 words)

### Configuration Files
- `Cargo.toml` - Package configuration with benchmark definitions
- `build.rs` - Build script that generates fork_join benchmark code
- `benches/.gitignore` - Ignore generated benchmark files
- `benches/README.md` - Basic usage instructions

## What Was Removed from Main Repository

From the main repository, the following were removed:

1. **Directory**: `benches/` (entire directory)
2. **Workspace Member**: Removed `"benches"` from `Cargo.toml` workspace members
3. **Dependencies**: Removed all direct dependencies on:
   - `timely` (timely-master)
   - `differential-dataflow` (differential-dataflow-master)
4. **Workflow**: `.github/workflows/benchmark.yml` (CI workflow for benchmarks)
5. **Documentation Reference**: Updated `CONTRIBUTING.md` to reference new location

## Changes Made for Standalone Operation

To make this repository work independently:

### 1. Updated Cargo.toml

**Before** (workspace-based):
```toml
[package]
name = "benches"
edition = { workspace = true }
repository = { workspace = true }
license = { workspace = true }

[lints]
workspace = true

dfir_rs = { path = "../dfir_rs", features = [ "debugging" ] }
sinktools = { path = "../sinktools", version = "^0.0.1" }
```

**After** (standalone with git dependencies):
```toml
[package]
name = "hydro-timely-benches"
edition = "2021"
repository = "https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps"
license = "Apache-2.0"

# No workspace lints

dfir_rs = { git = "https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta", features = [ "debugging" ] }
sinktools = { git = "https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta" }
```

### 2. Added Documentation

New documentation files were added:
- `README.md` - Comprehensive overview and usage instructions
- `SETUP.md` - Detailed setup and troubleshooting guide
- `MIGRATION.md` - This file explaining the migration

### 3. Added .gitignore

Created `.gitignore` to exclude build artifacts and generated files.

## How to Run Benchmarks After Migration

### Previously (in main repository)
```bash
cd bigweaver-agent-canary-hydro-zeta
cargo bench -p benches
cargo bench -p benches --bench reachability
```

### Now (in hydro-deps repository)
```bash
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench
cargo bench --bench reachability
```

## Maintaining Performance Comparison Capability

The migration preserves the ability to compare performance between Hydro and timely/differential-dataflow:

1. **Git Dependencies**: The benchmarks pull the latest `dfir_rs` and `sinktools` from the main repository
2. **Same Code**: All benchmark implementations remain identical
3. **Same Data**: All test data files are preserved
4. **Criterion Framework**: Still uses Criterion for reliable measurements and HTML reports

## Testing Against Different Versions

To test against a specific version or branch of the main repository:

```toml
# In Cargo.toml, modify the git dependencies:
dfir_rs = { 
    git = "https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta",
    branch = "feature/my-optimization",
    features = [ "debugging" ] 
}
```

Or use a specific commit:
```toml
dfir_rs = { 
    git = "https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta",
    rev = "abc123def456",
    features = [ "debugging" ] 
}
```

## Benefits of the Migration

1. **Cleaner Main Repository**: The main Hydro repository no longer has timely/differential-dataflow as dependencies
2. **Preserved Functionality**: All benchmarks still work and can be run independently
3. **Performance Tracking**: Historical performance comparisons can still be maintained
4. **Separation of Concerns**: Benchmark infrastructure is isolated from main development
5. **Flexible Testing**: Easy to test against different versions of the main repository

## References

- Main Repository: https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta
- Migration Commits:
  - Removal from main: See commit history in main repository
  - Addition to deps: Initial commit in this repository

## Questions or Issues

If you encounter issues with the migrated benchmarks:

1. Check that you have network access to clone git dependencies
2. Ensure you're using a compatible Rust toolchain (see main repo's `rust-toolchain.toml`)
3. Review the SETUP.md file for troubleshooting steps
4. Open an issue in this repository if problems persist
