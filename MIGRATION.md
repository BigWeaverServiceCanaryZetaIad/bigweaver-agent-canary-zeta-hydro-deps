# Benchmark Migration

## Overview

This document describes the migration of timely and differential-dataflow benchmarks from the main Hydro repository ([bigweaver-agent-canary-hydro-zeta](https://github.com/hydro-project/hydro)) to this separate dependencies repository.

## Migrated Benchmarks

The following benchmarks were moved from the main repository:

### Timely Benchmarks
- `arithmetic.rs` - Arithmetic operations benchmark
- `fan_in.rs` - Fan-in pattern benchmark  
- `fan_out.rs` - Fan-out pattern benchmark
- `fork_join.rs` - Fork-join pattern benchmark
- `identity.rs` - Identity operation benchmark
- `upcase.rs` - String uppercase benchmark
- `join.rs` - Join operation benchmark

### Differential-Dataflow Benchmarks
- `reachability.rs` - Graph reachability benchmark
- `reachability_edges.txt` - Test data for reachability benchmark
- `reachability_reachable.txt` - Expected results for reachability benchmark

## Reason for Migration

The benchmarks were moved to this separate repository to:

1. **Reduce main repository dependencies**: Keep timely and differential-dataflow as dependencies only in this repository, not in the main Hydro codebase
2. **Improve build times**: Reduce compilation time for developers working on the main Hydro repository
3. **Maintain performance testing**: Retain the ability to run performance comparisons against timely/differential-dataflow
4. **Cleaner architecture**: Separate experimental/comparison benchmarks from core Hydro functionality

## What Stayed in Main Repository

The following benchmarks remain in the main Hydro repository as they do not depend on timely or differential-dataflow:
- `micro_ops` - Micro-operations benchmark
- `symmetric_hash_join` - Symmetric hash join benchmark
- `words_diamond` - Words diamond pattern benchmark

## Migration Date

This migration was completed on December 8, 2025.

## Changes Made

### In bigweaver-agent-canary-zeta-hydro-deps (this repository):
- Created `benches/` crate with workspace structure
- Copied benchmark files from main repository (commit b8e7d982)
- Created `Cargo.toml` with timely and differential-dataflow dependencies
- Added documentation (README.md, CONTRIBUTING.md)
- Copied configuration files (rustfmt.toml, clippy.toml, rust-toolchain.toml)

### In bigweaver-agent-canary-hydro-zeta (main repository):
- Created BENCHMARKS.md documenting benchmark locations
- Updated README.md to reference separated benchmarks
- Updated CONTRIBUTING.md to document benchmark organization
- Removed timely and differential-dataflow dependencies from Cargo.toml files
  (Note: Cargo.lock still contains orphaned entries that will be cleaned up on next cargo build)

## Running Migrated Benchmarks

To run the benchmarks that were moved:

```bash
# Clone this repository
git clone https://github.com/hydro-project/hydro-deps.git
cd hydro-deps

# Run all benchmarks
cargo bench -p benches

# Run specific benchmark
cargo bench -p benches --bench reachability
```

## Historical Context

These benchmarks were originally created to compare Hydro's performance with timely and differential-dataflow implementations. While valuable for performance analysis, keeping these dependencies in the main repository added unnecessary complexity for most Hydro developers.
