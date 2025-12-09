# Benchmark Migration History

## Overview

This document tracks the migration of timely and differential-dataflow benchmarks from the main 
Hydro repository to this dedicated dependencies repository.

## Migration Details

**Date:** December 9, 2025

**Source Repository:** BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta

**Source Commit:** 484e6fdd (Sync with hydro-project/hydro)

**Reason for Migration:**
- Separate benchmark dependencies from the main codebase
- Avoid including timely and differential-dataflow as dependencies in the core Hydro repository
- Maintain ability to run performance comparisons independently
- Reduce the dependency footprint of the main repository

## Migrated Components

### Benchmarks
All benchmark files from `benches/benches/` directory:
- `arithmetic.rs` - Basic arithmetic operations
- `fan_in.rs` - Multiple inputs merging to one output
- `fan_out.rs` - One input fanning out to multiple outputs
- `fork_join.rs` - Fork-join pattern benchmarks
- `futures.rs` - Asynchronous operations
- `identity.rs` - Identity/pass-through operations
- `join.rs` - Join operations
- `micro_ops.rs` - Micro-operation benchmarks
- `reachability.rs` - Graph reachability algorithms
- `symmetric_hash_join.rs` - Symmetric hash join operations
- `upcase.rs` - String manipulation operations
- `words_diamond.rs` - Diamond topology benchmarks

### Supporting Files
- `benches/Cargo.toml` - Package manifest with benchmark definitions
- `benches/README.md` - Benchmark documentation
- `benches/build.rs` - Build script
- `benches/benches/.gitignore` - Git ignore rules
- Test data files:
  - `reachability_edges.txt`
  - `reachability_reachable.txt`
  - `words_alpha.txt`

### Configuration Files
- `rustfmt.toml` - Code formatting configuration
- `clippy.toml` - Linting configuration
- `rust-toolchain.toml` - Rust toolchain specification

### GitHub Actions Workflow
- `.github/workflows/benchmark.yml` - Automated benchmark runner
- `.github/gh-pages/` - GitHub Pages configuration for benchmark results
  - `index.md` - Landing page for benchmark results
  - `.gitignore` - Git ignore rules for gh-pages branch

## Changes Made

### Dependency Updates
The original benchmarks used path-based dependencies:
```toml
dfir_rs = { path = "../dfir_rs", features = [ "debugging" ] }
sinktools = { path = "../sinktools", version = "^0.0.1" }
```

These were updated to use Git-based dependencies:
```toml
dfir_rs = { git = "https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git", rev = "484e6fdd", features = [ "debugging" ] }
sinktools = { git = "https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git", rev = "484e6fdd" }
```

### Workspace Setup
Created a new workspace `Cargo.toml` with:
- Workspace configuration matching the main repository
- Same linting rules for consistency
- Edition 2024 configuration

## Impact on Main Repository

### Removed
- `benches/` directory and all contents
- `benches` from workspace members in root `Cargo.toml`
- `.github/workflows/benchmark.yml` workflow
- Direct dependencies on timely and differential-dataflow

### Updated
- `CONTRIBUTING.md` - Added section explaining benchmark location and usage
- Documentation now points to this repository for running benchmarks

## Additions in This Repository

### GitHub Actions Integration
Added a complete CI/CD pipeline for running benchmarks:
- Automated benchmark execution on schedule and manual trigger
- Support for `[ci-bench]` tag in commits and pull requests
- Benchmark result publishing to GitHub Pages
- Historical benchmark tracking and visualization

## Running Benchmarks

To run benchmarks after migration:

```bash
# Clone this repository
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps

# Run all benchmarks
cargo bench -p benches

# Run a specific benchmark
cargo bench -p benches --bench <benchmark_name>
```

## Maintenance

When updating benchmarks to use a newer version of Hydro:
1. Update the `rev` field in `benches/Cargo.toml` to point to the desired commit
2. Test that benchmarks compile and run correctly
3. Update this document with the new commit reference

## Related Pull Requests

- Main repository PR: Removes benches directory and updates documentation
- This repository PR: Adds migrated benchmarks with git dependencies
