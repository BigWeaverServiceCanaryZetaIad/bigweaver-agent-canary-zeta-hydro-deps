# Benchmark Migration Documentation

## Overview

This document describes the migration of timely and differential-dataflow benchmark files from the bigweaver-agent-canary-hydro-zeta repository to the bigweaver-agent-canary-zeta-hydro-deps repository.

## Rationale

The migration was performed to:
1. **Remove direct dependencies**: Eliminate timely and differential-dataflow package dependencies from the main bigweaver-agent-canary-hydro-zeta repository
2. **Maintain performance comparison capability**: Retain the ability to run performance benchmarks comparing Hydro with Timely/Differential Dataflow frameworks
3. **Improve dependency management**: Separate concerns by isolating external dataflow framework dependencies in a dedicated repository
4. **Prevent technical debt**: Avoid unnecessary dependencies in the main codebase while preserving benchmark functionality

## Changes Made

### Files Moved to bigweaver-agent-canary-zeta-hydro-deps

The following benchmark files and data were moved:

**Benchmark Files:**
- `benches/benches/arithmetic.rs` - Arithmetic operation benchmarks
- `benches/benches/fan_in.rs` - Fan-in dataflow pattern benchmarks
- `benches/benches/fan_out.rs` - Fan-out dataflow pattern benchmarks
- `benches/benches/fork_join.rs` - Fork-join pattern benchmarks
- `benches/benches/identity.rs` - Identity transformation benchmarks
- `benches/benches/join.rs` - Join operation benchmarks (usize and String types)
- `benches/benches/reachability.rs` - Graph reachability algorithm benchmarks
- `benches/benches/upcase.rs` - String uppercase transformation benchmarks

**Data Files:**
- `benches/benches/reachability_edges.txt` - Edge data for reachability benchmarks
- `benches/benches/reachability_reachable.txt` - Expected reachable vertices for validation

### Files Retained in bigweaver-agent-canary-hydro-zeta

The following benchmarks remain in the main repository as they do not depend on timely or differential-dataflow:

- `benches/benches/futures.rs` - Futures-based benchmarks
- `benches/benches/micro_ops.rs` - Hydro micro-operation benchmarks
- `benches/benches/symmetric_hash_join.rs` - Symmetric hash join benchmarks
- `benches/benches/words_diamond.rs` - Words diamond pattern benchmarks
- `benches/benches/words_alpha.txt` - Word list data file

### Dependency Changes

**bigweaver-agent-canary-hydro-zeta/benches/Cargo.toml:**
- Removed: `differential-dataflow` dependency
- Removed: `timely` dependency
- Removed: Benchmark entries for moved files

**bigweaver-agent-canary-zeta-hydro-deps/benches/Cargo.toml:**
- Added: `differential-dataflow` dependency
- Added: `timely` dependency
- Added: Benchmark entries for all moved files
- Added: Common dependencies (criterion, futures, rand, etc.)

## Repository Structure

### bigweaver-agent-canary-zeta-hydro-deps

```
bigweaver-agent-canary-zeta-hydro-deps/
├── Cargo.toml (workspace configuration)
├── README.md
└── benches/
    ├── Cargo.toml (package configuration with timely/differential dependencies)
    ├── README.md (benchmark documentation)
    └── benches/
        ├── arithmetic.rs
        ├── fan_in.rs
        ├── fan_out.rs
        ├── fork_join.rs
        ├── identity.rs
        ├── join.rs
        ├── reachability.rs
        ├── upcase.rs
        ├── reachability_edges.txt
        └── reachability_reachable.txt
```

### bigweaver-agent-canary-hydro-zeta

The benches directory now contains only Hydro-specific benchmarks without external dataflow framework dependencies.

## Running Benchmarks

### Main Repository (Hydro-only benchmarks)

```bash
cd bigweaver-agent-canary-hydro-zeta
cargo bench -p benches
```

### Deps Repository (Timely/Differential comparison benchmarks)

```bash
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench -p hydro-deps-benches
```

Or for a specific benchmark:

```bash
cargo bench -p hydro-deps-benches --bench reachability
```

## Verification Steps

To verify the migration was successful:

1. **Build the main repository** without timely/differential dependencies:
   ```bash
   cd bigweaver-agent-canary-hydro-zeta
   cargo build -p benches
   ```

2. **Run remaining benchmarks** in the main repository:
   ```bash
   cargo bench -p benches
   ```

3. **Build the deps repository** with timely/differential dependencies:
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps
   cargo build -p hydro-deps-benches
   ```

4. **Run moved benchmarks** in the deps repository:
   ```bash
   cargo bench -p hydro-deps-benches
   ```

5. **Verify no timely/differential references** remain in main repo:
   ```bash
   cd bigweaver-agent-canary-hydro-zeta
   grep -r "timely\|differential-dataflow" benches/ --include="*.toml"
   # Should return no results
   ```

## Performance Comparison Workflow

To compare Hydro performance with Timely/Differential Dataflow:

1. Run benchmarks in the main repository to get Hydro performance metrics
2. Run corresponding benchmarks in the deps repository to get comparison metrics
3. Compare results using criterion's HTML reports or saved benchmark data

## Future Maintenance

- **Adding new Hydro-only benchmarks**: Add to `bigweaver-agent-canary-hydro-zeta/benches`
- **Adding new comparison benchmarks**: Add to `bigweaver-agent-canary-zeta-hydro-deps/benches`
- **Updating dependencies**: Update timely/differential versions only in the deps repository

## CI/CD Considerations

The existing benchmark workflow in `bigweaver-agent-canary-hydro-zeta/.github/workflows/benchmark.yml` will continue to run the Hydro-specific benchmarks. The workflow has been preserved without modification and will now only execute the remaining benchmarks (micro_ops, futures, symmetric_hash_join, words_diamond).

For performance tracking of comparison benchmarks in the deps repository, a similar workflow could be set up if desired.

## Configuration Files

The following configuration files have been copied to the deps repository to ensure consistent code formatting and linting:
- `clippy.toml` - Clippy linting configuration
- `rustfmt.toml` - Rust formatting configuration
- `rust-toolchain.toml` - Rust toolchain version specification

## Migration Date

This migration was completed on December 26, 2024.

## Related Documentation

- Main repository benchmarks: `bigweaver-agent-canary-hydro-zeta/benches/README.md`
- Deps repository benchmarks: `bigweaver-agent-canary-zeta-hydro-deps/benches/README.md`
