# Migration Summary: Timely and Differential-Dataflow Benchmarks

## Overview

This document summarizes the migration of timely and differential-dataflow benchmarks from the `bigweaver-agent-canary-hydro-zeta` repository to the dedicated `bigweaver-agent-canary-zeta-hydro-deps` repository.

## Migration Date

November 26, 2024

## Objective

To isolate timely and differential-dataflow dependencies in a separate repository, improving dependency hygiene and maintaining cleaner boundaries in the main hydro codebase.

## What Was Migrated

### Benchmark Files

The following benchmark files were extracted and migrated:

1. **arithmetic.rs** - Arithmetic operation benchmarks using timely dataflow
2. **fan_in.rs** - Stream concatenation (fan-in) pattern benchmarks
3. **fan_out.rs** - Stream distribution (fan-out) pattern benchmarks  
4. **fork_join.rs** - Stream splitting and joining pattern benchmarks
5. **identity.rs** - Identity/no-op operation benchmarks
6. **join.rs** - Hash join operation benchmarks
7. **upcase.rs** - String transformation benchmarks
8. **reachability.rs** - Graph reachability benchmarks (uses both timely and differential-dataflow)

### Data Files

- **reachability_edges.txt** (521KB) - Graph edge data for reachability benchmark
- **reachability_reachable.txt** (38KB) - Expected reachable nodes for validation

### Configuration Files

- **Cargo.toml** - Package configuration with timely/differential dependencies
- **build.rs** - Build script for generating fork_join benchmark code
- **README.md** - Documentation for running and understanding the benchmarks
- **.gitignore** - Build artifact exclusions

## Key Changes

### Simplified Benchmarks

The migrated benchmarks were simplified to include **only** the timely and differential-dataflow implementations. The original files in the source repository contained multiple implementations (hydroflow, timely, raw pipelines, etc.) for comparison purposes. 

In the new repository, each benchmark file contains only:
- The timely dataflow implementation (all benchmarks)
- The differential-dataflow implementation (reachability only)

This simplification:
- Removes dependencies on dfir_rs and sinktools
- Focuses exclusively on timely/differential performance
- Maintains the core benchmark functionality

### Dependency Configuration

The new `Cargo.toml` includes minimal dependencies:

**Dev Dependencies:**
- `timely-master` (v0.13.0-dev.1)
- `differential-dataflow-master` (v0.13.0-dev.1)
- `criterion` (v0.5.0) with async_tokio and html_reports
- Supporting libraries: futures, nameof, rand, rand_distr, seq-macro, static_assertions, tokio

## File Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── README.md                     # Repository overview
├── MIGRATION_SUMMARY.md         # This file
├── .gitignore                   # Build artifact exclusions
└── benches/
    ├── Cargo.toml               # Package configuration
    ├── README.md                # Benchmark documentation
    ├── build.rs                 # Build script
    └── benches/
        ├── arithmetic.rs
        ├── fan_in.rs
        ├── fan_out.rs
        ├── fork_join.rs
        ├── identity.rs
        ├── join.rs
        ├── upcase.rs
        ├── reachability.rs
        ├── reachability_edges.txt
        └── reachability_reachable.txt
```

## Source Repository Changes

The following files should be **removed** from `bigweaver-agent-canary-hydro-zeta` after this migration is complete:

From `benches/benches/`:
- The timely/differential-specific benchmark functions can be removed from:
  - arithmetic.rs
  - fan_in.rs
  - fan_out.rs
  - fork_join.rs
  - identity.rs
  - join.rs
  - upcase.rs
  - reachability.rs

The source files should retain their hydroflow benchmark implementations while removing the timely/differential implementations to avoid dependency requirements.

Alternatively, if the entire benchmark comparison is no longer needed, the whole `benches/` directory could be removed from the source repository.

## Dependencies Isolated

This migration successfully isolates the following external dependencies from the main repository:
- `timely-master` (0.13.0-dev.1)
- `differential-dataflow-master` (0.13.0-dev.1)

## Running the Migrated Benchmarks

From the `bigweaver-agent-canary-zeta-hydro-deps` repository:

```bash
cd benches
cargo bench                          # Run all benchmarks
cargo bench --bench reachability    # Run specific benchmark
```

## Benefits

1. **Dependency Isolation**: timely and differential-dataflow dependencies no longer needed in main repository
2. **Cleaner Main Repository**: Reduced dependency footprint in the core hydro codebase
3. **Focused Benchmarking**: Dedicated repository for timely/differential performance testing
4. **Maintainability**: Easier to update and maintain these specific dependencies separately

## Verification

To verify the migration:

1. Check that all benchmark files are present in the new repository
2. Verify data files (reachability_edges.txt, reachability_reachable.txt) are included
3. Confirm Cargo.toml has correct dependencies
4. Run `cargo check` in the benches directory to verify compilation
5. Run `cargo bench` to verify benchmarks execute correctly

## Notes

- The benchmarks maintain their original functionality and performance characteristics
- Benchmark results can be compared with historical data from the original repository
- The isolation allows for independent versioning of these benchmarks
