# Benchmark Migration Summary

## Overview

This document summarizes the migration of timely and differential-dataflow benchmarks from the `bigweaver-agent-canary-hydro-zeta` repository to the `bigweaver-agent-canary-zeta-hydro-deps` repository.

## What Was Moved

### Files Migrated

The following files were moved from `bigweaver-agent-canary-hydro-zeta` to `bigweaver-agent-canary-zeta-hydro-deps`:

```
benches/
├── Cargo.toml                          # Benchmark package configuration
├── README.md                           # Benchmark documentation
├── build.rs                            # Build script for generated benchmarks
└── benches/                            # Benchmark implementations
    ├── .gitignore                      # Git ignore patterns
    ├── arithmetic.rs                   # Arithmetic operations benchmark
    ├── fan_in.rs                       # Fan-in pattern benchmark
    ├── fan_out.rs                      # Fan-out pattern benchmark
    ├── fork_join.rs                    # Fork-join pattern benchmark
    ├── futures.rs                      # Futures-based operations benchmark
    ├── identity.rs                     # Identity operation benchmark
    ├── join.rs                         # Join operation benchmark
    ├── micro_ops.rs                    # Micro-operations benchmark
    ├── reachability.rs                 # Graph reachability benchmark
    ├── reachability_edges.txt          # Test data for reachability
    ├── reachability_reachable.txt      # Expected results for reachability
    ├── symmetric_hash_join.rs          # Symmetric hash join benchmark
    ├── upcase.rs                       # String uppercase benchmark
    ├── words_alpha.txt                 # Word list (3.7MB)
    └── words_diamond.rs                # Word processing diamond pattern
```

### Dependencies Removed from Source Repository

The following dependencies were removed from `bigweaver-agent-canary-hydro-zeta` and are now only present in `bigweaver-agent-canary-zeta-hydro-deps`:

- `timely` (package: `timely-master`, version: `0.13.0-dev.1`)
- `differential-dataflow` (package: `differential-dataflow-master`, version: `0.13.0-dev.1`)

These dependencies are used exclusively for performance comparison benchmarks and are no longer needed in the main repository.

### Removed Configuration Files

From `bigweaver-agent-canary-hydro-zeta`:
- `.github/workflows/benchmark.yml` - GitHub Actions workflow for running benchmarks
- `.github/gh-pages/index.md` - References to benchmark history and latest benchmarks pages

## Changes Made

### In `bigweaver-agent-canary-zeta-hydro-deps` (Destination)

1. **Created workspace structure:**
   - Added root `Cargo.toml` with workspace configuration
   - Set up workspace-level lints and package metadata
   - Configured `benches` as a workspace member

2. **Updated benchmark dependencies:**
   - Changed `dfir_rs` path from `../dfir_rs` to `../../bigweaver-agent-canary-hydro-zeta/dfir_rs`
   - Changed `sinktools` path from `../sinktools` to `../../bigweaver-agent-canary-hydro-zeta/sinktools`
   - Kept `timely` and `differential-dataflow` dependencies for performance comparisons

3. **Added documentation:**
   - `README.md` - High-level repository overview
   - `BENCHMARK_GUIDE.md` - Comprehensive guide to benchmarks
   - `MIGRATION_SUMMARY.md` - This file

### In `bigweaver-agent-canary-hydro-zeta` (Source)

The source repository had already removed:
1. The entire `benches/` directory and all its contents
2. References to benchmarks in `.github/gh-pages/index.md`
3. The `.github/workflows/benchmark.yml` workflow file
4. All `timely` and `differential-dataflow` dependencies from Cargo.toml files

These changes were completed in commit `b161bc10ad3946dbdf16659d1bb9a7031ba1c909`.

## Benefits of This Migration

1. **Cleaner Dependency Graph**: The main Hydro repository no longer depends on timely and differential-dataflow packages, reducing dependency complexity.

2. **Faster Build Times**: Developers working on the core Hydro codebase don't need to build benchmark dependencies.

3. **Separation of Concerns**: Benchmarks are isolated in their own repository, making it easier to maintain and update them independently.

4. **Preserved Functionality**: All benchmark functionality is retained and can still be run from the deps repository.

5. **Improved Organization**: Benchmark-related code and data files are now in a dedicated location.

## Running Benchmarks After Migration

### Prerequisites

Ensure both repositories are cloned side-by-side:
```
/projects/sandbox/
├── bigweaver-agent-canary-hydro-zeta/
└── bigweaver-agent-canary-zeta-hydro-deps/
```

### Run Benchmarks

```bash
cd /projects/sandbox/bigweaver-agent-canary-zeta-hydro-deps
cargo bench -p benches
```

### Run Specific Benchmark

```bash
cd /projects/sandbox/bigweaver-agent-canary-zeta-hydro-deps
cargo bench -p benches --bench reachability
```

## Performance Comparison Functionality

The benchmarks continue to provide performance comparisons between:
- **Hydro (dfir_rs)**: The native Hydro dataflow implementation
- **Timely Dataflow**: A low-latency dataflow system
- **Differential Dataflow**: An incremental computation framework

Each benchmark file typically contains implementations for all three systems, allowing for direct performance comparisons using the Criterion benchmarking framework.

## Verification

### Check Source Repository

The source repository should have:
- ✅ No `benches/` directory
- ✅ No `timely` or `differential-dataflow` dependencies in any Cargo.toml
- ✅ No benchmark workflow files
- ✅ No benchmark references in gh-pages

### Check Destination Repository

The destination repository should have:
- ✅ Complete `benches/` directory with all benchmark files
- ✅ Workspace Cargo.toml configuration
- ✅ Properly configured dependency paths to source repository
- ✅ All benchmark data files (edges.txt, words_alpha.txt, etc.)
- ✅ Documentation files (README.md, BENCHMARK_GUIDE.md, MIGRATION_SUMMARY.md)

## Future Maintenance

### When Updating Main Repository

When making changes to `dfir_rs` or `sinktools` in the main repository:
1. Check if benchmark code needs updates for API compatibility
2. Run benchmarks to ensure they still work correctly
3. Update benchmark implementations if needed

### When Adding New Benchmarks

New benchmarks should be added to `bigweaver-agent-canary-zeta-hydro-deps`:
1. Create new `.rs` file in `benches/benches/`
2. Add `[[bench]]` entry to `benches/Cargo.toml`
3. Follow existing benchmark patterns (Hydro, Timely, Differential comparisons)
4. Update documentation if needed

### When Updating Benchmark Dependencies

Update `timely` or `differential-dataflow` versions in `bigweaver-agent-canary-zeta-hydro-deps/benches/Cargo.toml` as needed for compatibility or performance improvements.

## Migration Completed

Date: 2025-11-29
Migrated By: Automated migration process
Source Commit (before removal): 484e6fdd
Removal Commit: b161bc10ad3946dbdf16659d1bb9a7031ba1c909
