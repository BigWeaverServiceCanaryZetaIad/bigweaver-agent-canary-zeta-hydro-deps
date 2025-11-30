# Benchmark Migration Summary

## Overview

This document summarizes the migration of timely and differential-dataflow benchmarks from the main `bigweaver-agent-canary-hydro-zeta` repository to this separate `bigweaver-agent-canary-zeta-hydro-deps` repository.

## Migration Date

November 30, 2025

## Rationale

The benchmarks were moved to a separate repository for the following reasons:

1. **Dependency Separation**: Avoids adding `timely` and `differential-dataflow` dependencies to the main Hydro repository
2. **Cleaner Main Repository**: Keeps the main repository focused on core Hydro functionality
3. **Maintained Performance Comparison**: Retains the ability to run performance comparisons between Hydro and other dataflow systems
4. **Independent Development**: Allows benchmark development without affecting the main repository

## What Was Moved

### Source Repository
**From**: `BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta`

The following were removed from the source repository:
- `benches/` directory (entire benchmark workspace)
- Timely and differential-dataflow dependencies from `Cargo.lock`

### Target Repository  
**To**: `BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps`

The following were added to this repository:
- `benches/` directory with all benchmark code
- Workspace configuration in `Cargo.toml`
- Documentation (`README.md`, `BENCHMARK_GUIDE.md`)
- Build infrastructure (`.gitignore`)

## Files Moved

### Benchmark Source Files

All files from `benches/benches/`:
- `arithmetic.rs` - Arithmetic operations benchmarks
- `fan_in.rs` - Fan-in pattern benchmarks
- `fan_out.rs` - Fan-out pattern benchmarks
- `fork_join.rs` - Fork-join pattern benchmarks
- `futures.rs` - Futures-based benchmarks
- `identity.rs` - Identity/passthrough benchmarks
- `join.rs` - Join operation benchmarks
- `micro_ops.rs` - Micro-operation benchmarks
- `reachability.rs` - Graph reachability benchmarks
- `symmetric_hash_join.rs` - Symmetric hash join benchmarks
- `upcase.rs` - String uppercase benchmarks
- `words_diamond.rs` - Word processing diamond pattern benchmarks

### Test Data Files
- `reachability_edges.txt` - Graph edges for reachability benchmark
- `reachability_reachable.txt` - Expected reachability results
- `words_alpha.txt` - English word list for word benchmarks

### Configuration Files
- `benches/Cargo.toml` - Benchmark package configuration
- `benches/build.rs` - Build script for generated benchmarks
- `benches/README.md` - Benchmark documentation
- `benches/benches/.gitignore` - Git ignore rules

## Changes Made During Migration

### Dependency Updates

The `benches/Cargo.toml` was updated to reference dependencies from the main repository via git:

**Before** (path dependencies):
```toml
dfir_rs = { path = "../dfir_rs", features = [ "debugging" ] }
sinktools = { path = "../sinktools", version = "^0.0.1" }
```

**After** (git dependencies):
```toml
dfir_rs = { git = "https://github.com/hydro-project/hydro.git", branch = "main", features = [ "debugging" ] }
sinktools = { git = "https://github.com/hydro-project/hydro.git", branch = "main" }
```

### New Files Added

- `Cargo.toml` - Workspace configuration at repository root
- `.gitignore` - Standard Rust gitignore patterns
- `README.md` - Repository documentation
- `BENCHMARK_GUIDE.md` - Comprehensive benchmarking guide
- `MIGRATION_SUMMARY.md` - This document

## Benchmark Dependencies

The benchmarks depend on:

### From Main Repository (via git)
- `dfir_rs` - Core Hydro dataflow runtime
- `sinktools` - Utility tools for sinks

### External Crates
- `timely-master` (v0.13.0-dev.1) - Timely dataflow library
- `differential-dataflow-master` (v0.13.0-dev.1) - Differential dataflow library
- `criterion` (v0.5.0) - Benchmarking framework
- `futures` (v0.3) - Async futures support
- `tokio` (v1.29.0) - Async runtime
- `rand` (v0.8.0) - Random number generation
- `rand_distr` (v0.4.3) - Random distributions
- Other utilities: `nameof`, `seq-macro`, `static_assertions`

## How to Run Benchmarks

### From This Repository

```bash
# Clone this repository
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps

# Run all benchmarks
cargo bench -p benches

# Run specific benchmark
cargo bench -p benches --bench identity
```

### Performance Comparisons

Each benchmark typically includes multiple implementations:
1. **DFIR (Hydro)** - Main Hydro implementation
2. **Timely** - Timely-dataflow implementation
3. **Differential** - Differential-dataflow implementation (where applicable)
4. **Baseline** - Minimal overhead baseline (some benchmarks)

Results can be compared to track performance improvements and regressions.

## Impact on Main Repository

### Removed Dependencies
The main repository no longer has direct dependencies on:
- `timely-master`
- `differential-dataflow-master`

These dependencies were only used by benchmarks and are not required for core Hydro functionality.

### Cargo.lock Updates
The `Cargo.lock` in the main repository will be updated to remove entries for:
- `timely-master`
- `timely-bytes-master`
- `timely-communication-master`
- `timely-container-master`
- `timely-logging-master`
- `differential-dataflow-master`

This will happen automatically when running `cargo update` or `cargo build` in the main repository.

### No Functional Changes
The migration does not affect:
- Core Hydro functionality
- DFIR runtime behavior
- Public APIs
- Documentation (except benchmark references)
- CI/CD pipelines (except benchmark-specific workflows)

## Maintaining Performance Comparisons

### Before Migration
Benchmarks were run with:
```bash
cd bigweaver-agent-canary-hydro-zeta
cargo bench -p benches
```

### After Migration
Benchmarks are now run with:
```bash
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench -p benches
```

The actual benchmark code and methodology remain unchanged, ensuring continuity in performance tracking.

## CI/CD Considerations

### Main Repository
- Remove or update benchmark-specific CI jobs
- No longer needs to install timely/differential dependencies for benchmarks

### This Repository
- Can add dedicated benchmark CI workflows
- Can run benchmarks on performance-critical changes
- Can archive benchmark results for historical comparison

## Future Enhancements

Potential improvements for this repository:

1. **Automated Performance Tracking**: Set up CI to track performance over time
2. **Benchmark Results Dashboard**: Visualize performance trends
3. **Expanded Benchmarks**: Add more comparison benchmarks as needed
4. **Version Pinning**: Pin specific versions of Hydro for stable comparisons
5. **Cross-Repository Coordination**: Coordinate benchmark updates with Hydro releases

## References

- Main Repository: https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta
- Timely Dataflow: https://github.com/TimelyDataflow/timely-dataflow
- Differential Dataflow: https://github.com/TimelyDataflow/differential-dataflow
- Criterion.rs: https://github.com/bheisler/criterion.rs

## Questions or Issues

For questions about:
- **Benchmark methodology**: See `BENCHMARK_GUIDE.md`
- **Running benchmarks**: See `benches/README.md`
- **Migration process**: Open an issue in this repository
- **Hydro functionality**: Refer to the main repository
