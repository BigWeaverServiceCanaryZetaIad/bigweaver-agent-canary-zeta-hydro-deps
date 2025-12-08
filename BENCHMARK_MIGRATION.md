# Benchmark Migration Guide

## Overview

This document describes the migration of timely and differential-dataflow benchmarks from the main Hydro repository to this dedicated benchmarks repository.

## Rationale

The benchmarks that depend on `timely` and `differential-dataflow` packages were moved to this repository to:

1. **Prevent Dependency Pollution**: Keep the main Hydro repository clean from dependencies that are only needed for performance comparison benchmarks
2. **Retain Performance Comparison Capability**: Maintain the ability to run benchmarks comparing Hydro's performance against timely/differential-dataflow
3. **Improve Maintainability**: Separate concerns by isolating external dependency benchmarks

## What Was Moved

### Benchmarks Migrated to bigweaver-agent-canary-zeta-hydro-deps

The following benchmarks that depend on timely/differential-dataflow were moved:

- `arithmetic.rs` - Arithmetic operations benchmarks
- `fan_in.rs` - Fan-in pattern benchmarks
- `fan_out.rs` - Fan-out pattern benchmarks
- `fork_join.rs` - Fork-join pattern benchmarks
- `identity.rs` - Identity operation benchmarks
- `join.rs` - Join operation benchmarks
- `reachability.rs` - Graph reachability benchmarks
- `upcase.rs` - String uppercase transformation benchmarks

#### Supporting Files Moved:
- `reachability_edges.txt` - Graph edges data for reachability benchmark
- `reachability_reachable.txt` - Expected reachability results
- `words_alpha.txt` - Word list for various benchmarks (also kept in main repo for words_diamond)
- `build.rs` - Build script for generating fork_join benchmark code

### Benchmarks Retained in bigweaver-agent-canary-hydro-zeta

The following benchmarks that don't depend on timely/differential-dataflow remain in the main repository:

- `futures.rs` - Async futures benchmarks
- `micro_ops.rs` - Micro-operations benchmarks
- `symmetric_hash_join.rs` - Symmetric hash join benchmarks
- `words_diamond.rs` - Diamond pattern word processing benchmark

## Dependencies Removed from Main Repository

The following dependencies were removed from the main repository's `benches/Cargo.toml`:

- `differential-dataflow` (differential-dataflow-master v0.13.0-dev.1)
- `timely` (timely-master v0.13.0-dev.1)
- `rand` (v0.8.0)
- `rand_distr` (v0.4.3)

## Integration Points

### Running Migrated Benchmarks

To run the timely/differential-dataflow benchmarks:

```bash
cd /path/to/bigweaver-agent-canary-zeta-hydro-deps
cargo bench -p hydro-timely-benchmarks
```

### Running Retained Benchmarks

To run the benchmarks that remain in the main repository:

```bash
cd /path/to/bigweaver-agent-canary-hydro-zeta
cargo bench -p benches
```

## Changes Made

### In bigweaver-agent-canary-hydro-zeta:

1. **Removed benchmarks**: Deleted 8 benchmark files that depend on timely/differential-dataflow
2. **Updated Cargo.toml**: 
   - Removed `timely` and `differential-dataflow` dependencies
   - Removed `rand` and `rand_distr` dependencies
   - Removed benchmark declarations for moved benchmarks
3. **Updated README**: Added note about benchmark migration with link to deps repository
4. **Removed build.rs**: No longer needed as fork_join benchmark was moved

### In bigweaver-agent-canary-zeta-hydro-deps:

1. **Added benches directory**: Complete benchmark structure with Cargo.toml and supporting files
2. **Updated package name**: Changed from `benches` to `hydro-timely-benchmarks` for clarity
3. **Modified dependencies**: 
   - Changed `dfir_rs` from path dependency to git dependency (pointing to upstream Hydro repo)
   - Removed `sinktools` path dependency (not needed for these benchmarks)
   - Removed `futures` and `tokio` (not needed for timely/differential benchmarks)
4. **Created documentation**: Added comprehensive README and this migration guide

## Verification

To verify the migration was successful:

1. **Build main repository benchmarks**:
   ```bash
   cd bigweaver-agent-canary-hydro-zeta
   cargo build -p benches
   ```

2. **Build migrated benchmarks**:
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps
   cargo build -p hydro-timely-benchmarks
   ```

3. **Run benchmarks**:
   ```bash
   # In main repo
   cargo bench -p benches
   
   # In deps repo
   cargo bench -p hydro-timely-benchmarks
   ```

## Future Considerations

- If additional benchmarks requiring external dependencies are added, they should be placed in this repository
- The `dfir_rs` dependency in this repository uses a git reference; consider updating this when new releases are published
- Performance comparison workflows may need to be updated to run benchmarks from both repositories

## References

- Main repository: [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)
- Deps repository: [bigweaver-agent-canary-zeta-hydro-deps](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps)
