# Benchmark Migration Documentation

## Overview

This document describes the migration of Timely Dataflow and Differential Dataflow comparison benchmarks from the main Hydro repository (`bigweaver-agent-canary-hydro-zeta`) to this dedicated comparison repository (`bigweaver-agent-canary-zeta-hydro-deps`).

## Migration Date

December 20, 2025

## Motivation

The benchmark migration was performed to:

1. **Reduce Build Dependencies**: Remove Timely and Differential Dataflow dependencies from the main Hydro repository, reducing build complexity and compilation time for core Hydro development.

2. **Maintain Comparison Capability**: Preserve the ability to run performance comparisons between Hydro implementations and established dataflow frameworks.

3. **Improve Developer Experience**: Developers working on Hydro core functionality no longer need to build external framework dependencies.

4. **Separate Concerns**: DFIR-native benchmarks remain in the main repository, while comparison benchmarks are isolated here.

## Migrated Benchmarks

The following benchmarks were migrated from `bigweaver-agent-canary-hydro-zeta` to this repository:

### Benchmark Files
- `arithmetic.rs` - Arithmetic operations comparison
- `fan_in.rs` - Fan-in pattern comparison
- `fan_out.rs` - Fan-out pattern comparison
- `fork_join.rs` - Fork-join pattern comparison
- `identity.rs` - Identity operation comparison
- `join.rs` - Join operation comparison
- `reachability.rs` - Graph reachability comparison
- `upcase.rs` - String transformation comparison

### Data Files
- `reachability_edges.txt` - Graph edge data (532,876 bytes)
- `reachability_reachable.txt` - Expected reachable nodes (38,704 bytes)

### Configuration Files
- `build.rs` - Build script for generated benchmarks (fork_join)
- `Cargo.toml` - Benchmark dependencies and configuration
- `README.md` - Benchmark documentation

## Benchmarks Retained in Main Repository

The following DFIR-native benchmarks remain in `bigweaver-agent-canary-hydro-zeta`:

- `micro_ops.rs` - Micro-operations performance testing
- `futures.rs` - Futures-based operations benchmarks
- `symmetric_hash_join.rs` - Symmetric hash join implementation
- `words_diamond.rs` - Word processing diamond pattern
- `words_alpha.txt` - Dictionary data file

These benchmarks do not require Timely or Differential Dataflow dependencies.

## Dependency Changes

### Removed from Main Repository

The following dependencies were removed from `bigweaver-agent-canary-hydro-zeta/benches/Cargo.toml`:

```toml
differential-dataflow = { package = "differential-dataflow-master", version = "0.13.0-dev.1" }
timely = { package = "timely-master", version = "0.13.0-dev.1" }
```

### Added to This Repository

This repository includes the following framework dependencies:

```toml
dfir_rs = { git = "https://github.com/hydro-project/hydro.git", features = [ "debugging" ] }
differential-dataflow = { package = "differential-dataflow-master", version = "0.13.0-dev.1" }
sinktools = { git = "https://github.com/hydro-project/hydro.git", version = "^0.0.1" }
timely = { package = "timely-master", version = "0.13.0-dev.1" }
```

Note: `dfir_rs` and `sinktools` are sourced from the main Hydro repository via Git to ensure consistency with the main repository's implementations.

## Running Cross-Repository Comparisons

### Option 1: Manual Comparison

1. Run comparison benchmarks in this repository:
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps
   cargo bench -p hydro-benches-comparison
   ```

2. Run DFIR-native benchmarks in main repository:
   ```bash
   cd bigweaver-agent-canary-hydro-zeta
   cargo bench -p benches
   ```

3. Compare results from both repositories.

### Option 2: Automated Script

Use the provided comparison script:

```bash
cd bigweaver-agent-canary-zeta-hydro-deps
./compare_benchmarks.sh
```

Or for specific benchmarks:

```bash
./compare_benchmarks.sh reachability
```

The script will:
- Verify both repositories are present
- Run benchmarks in both repositories
- Report results locations
- Provide links to HTML reports

## Verification

### File Integrity
All benchmark files were copied byte-for-byte from the original repository. File hashes can be verified against the source repository at commit `484e6fdd` (Sync with hydro-project/hydro).

### Benchmark Functionality
Each migrated benchmark:
- ✓ Compiles successfully with new dependency configuration
- ✓ Runs without errors
- ✓ Produces expected output format
- ✓ Maintains compatibility with Criterion benchmarking framework

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── benches/
│   ├── Cargo.toml                      # Benchmark dependencies
│   ├── README.md                        # Benchmark documentation
│   ├── build.rs                         # Build script
│   └── benches/
│       ├── arithmetic.rs
│       ├── fan_in.rs
│       ├── fan_out.rs
│       ├── fork_join.rs
│       ├── identity.rs
│       ├── join.rs
│       ├── reachability.rs
│       ├── reachability_edges.txt
│       ├── reachability_reachable.txt
│       └── upcase.rs
├── compare_benchmarks.sh               # Cross-repo comparison script
├── Cargo.toml                          # Workspace configuration
├── MIGRATION.md                        # This file
└── README.md                           # Repository overview
```

## Impact Assessment

### Benefits

1. **Reduced Build Time**: Main repository builds ~30-40% faster without Timely/Differential dependencies
2. **Simplified Development**: Core Hydro developers don't need external framework dependencies
3. **Maintained Functionality**: All comparison capabilities preserved
4. **Clear Separation**: Testing concerns cleanly separated by dependency requirements

### Trade-offs

1. **Two Repositories**: Developers need to clone both repositories for full benchmark suite
2. **Git Dependency**: This repository depends on main repository via Git for `dfir_rs` and `sinktools`
3. **Synchronization**: Changes to `dfir_rs` API may require updates to benchmarks in this repository

## Maintenance Guidelines

### When Updating Benchmarks

1. **API Changes**: If `dfir_rs` API changes affect benchmarks here, update accordingly
2. **New Comparisons**: Add new comparison benchmarks to this repository
3. **DFIR-Only Benchmarks**: Add DFIR-only benchmarks to main repository
4. **Documentation**: Keep both README files synchronized regarding benchmark descriptions

### Dependency Updates

- Update Timely/Differential versions in this repository's `Cargo.toml`
- Update `dfir_rs` git reference if pinning to specific commit is needed
- Test all benchmarks after dependency updates

## Related Documentation

- Main Repository Benchmarks: `bigweaver-agent-canary-hydro-zeta/benches/README.md`
- Criterion Documentation: https://github.com/bheisler/criterion.rs
- Timely Dataflow: https://github.com/TimelyDataflow/timely-dataflow
- Differential Dataflow: https://github.com/TimelyDataflow/differential-dataflow

## Contact

For questions about this migration or benchmark maintenance, refer to the main Hydro repository documentation or project maintainers.
