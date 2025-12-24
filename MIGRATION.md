# Benchmark Migration Documentation

## Overview

This document describes the migration of timely-dataflow and differential-dataflow benchmarks from the `bigweaver-agent-canary-hydro-zeta` repository to the `bigweaver-agent-canary-zeta-hydro-deps` repository.

## Migration Date

December 24, 2025

## Reason for Migration

The benchmarks and their associated dependencies (timely-dataflow and differential-dataflow) were moved to a separate repository to:

1. **Reduce dependency bloat**: Remove unnecessary dependencies from the main repository
2. **Improve build times**: Avoid compiling timely and differential-dataflow in the main codebase
3. **Maintain comparison capability**: Retain the ability to run performance comparisons between different dataflow implementations
4. **Simplify maintenance**: Keep benchmarking infrastructure separate from core functionality

## Files Migrated

### From bigweaver-agent-canary-hydro-zeta

The following files were extracted from commit `513b2091` and migrated to this repository:

#### Benchmark Files
- `benches/benches/arithmetic.rs` → `timely-differential-benches/benches/arithmetic.rs`
- `benches/benches/fan_in.rs` → `timely-differential-benches/benches/fan_in.rs`
- `benches/benches/fan_out.rs` → `timely-differential-benches/benches/fan_out.rs`
- `benches/benches/fork_join.rs` → `timely-differential-benches/benches/fork_join.rs`
- `benches/benches/identity.rs` → `timely-differential-benches/benches/identity.rs`
- `benches/benches/join.rs` → `timely-differential-benches/benches/join.rs`
- `benches/benches/reachability.rs` → `timely-differential-benches/benches/reachability.rs`
- `benches/benches/upcase.rs` → `timely-differential-benches/benches/upcase.rs`
- `benches/benches/zip.rs` → `timely-differential-benches/benches/zip.rs`

#### Data Files
- `benches/benches/reachability_edges.txt` → `timely-differential-benches/benches/reachability_edges.txt`
- `benches/benches/reachability_reachable.txt` → `timely-differential-benches/benches/reachability_reachable.txt`

## Dependencies Migrated

The following dependencies were moved from the main repository to this repository:

### Added to bigweaver-agent-canary-zeta-hydro-deps
- `timely = "0.12"`
- `differential-dataflow = "0.12"`
- Path dependencies to core implementations in main repository:
  - `babyflow = { path = "../../bigweaver-agent-canary-hydro-zeta/babyflow" }`
  - `hydroflow = { path = "../../bigweaver-agent-canary-hydro-zeta/hydroflow" }`
  - `spinachflow = { path = "../../bigweaver-agent-canary-hydro-zeta/spinachflow" }`
- Supporting dependencies:
  - `criterion = { version = "0.3", features = ["async_tokio"] }`
  - `lazy_static = "1.4.0"`
  - `rand = "0.8.4"`
  - `seq-macro = "0.2"`
  - `tokio = { version = "1.0", features = ["rt-multi-thread"] }`

### Retained in bigweaver-agent-canary-hydro-zeta
- Core dataflow implementations (no timely/differential dependencies):
  - `babyflow/` - Basic dataflow implementation
  - `hydroflow/` - Alternative dataflow implementation  
  - `spinachflow/` - Another dataflow implementation variant
- These are needed by the benchmarks in the deps repository via path dependencies

### Removed from bigweaver-agent-canary-hydro-zeta
- All benchmark files that used timely/differential-dataflow
- `timely` and `differential-dataflow` dependencies from any Cargo.toml files

## New Structure in bigweaver-agent-canary-zeta-hydro-deps

```
bigweaver-agent-canary-zeta-hydro-deps/
├── Cargo.toml                           # Workspace configuration
├── README.md                            # Repository documentation
├── MIGRATION.md                         # This file
├── scripts/
│   └── compare_benchmarks.sh           # Cross-repository comparison script
└── timely-differential-benches/
    ├── Cargo.toml                       # Package configuration
    ├── README.md                        # Benchmark documentation
    └── benches/                         # Benchmark implementations and data
        ├── arithmetic.rs
        ├── fan_in.rs
        ├── fan_out.rs
        ├── fork_join.rs
        ├── identity.rs
        ├── join.rs
        ├── reachability.rs
        ├── reachability_edges.txt
        ├── reachability_reachable.txt
        ├── upcase.rs
        └── zip.rs
```

## Performance Comparison

After migration, performance comparisons can still be conducted using:

1. **Direct benchmarking**: Run benchmarks in each repository separately
   ```bash
   # In bigweaver-agent-canary-zeta-hydro-deps
   cargo bench -p timely-differential-benches
   
   # In bigweaver-agent-canary-hydro-zeta
   cargo bench -p benches  # If remaining benchmarks exist
   ```

2. **Automated comparison**: Use the provided comparison script
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps
   ./scripts/compare_benchmarks.sh
   ```

## Verification

To verify the migration was successful:

1. Build the main repository (should not include timely/differential):
   ```bash
   cd bigweaver-agent-canary-hydro-zeta
   cargo build
   ```

2. Build the deps repository with benchmarks:
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps
   cargo build
   ```

3. Run the benchmarks:
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps
   cargo bench
   ```

4. Verify path dependencies are working correctly - benchmarks should be able to use babyflow, hydroflow, and spinachflow from the main repository.

## Post-Migration Changes in Main Repository

After this migration, the main repository:

1. Retains core dataflow implementations (babyflow, hydroflow, spinachflow) needed by benchmarks
2. These implementations do NOT depend on timely-dataflow or differential-dataflow
3. Removed all benchmark files that depend on timely/differential-dataflow
4. Removed timely and differential-dataflow dependencies from all Cargo.toml files
5. Updated documentation to reference this repository for performance comparisons
6. The deps repository uses path dependencies to access the main repository's implementations

## Maintenance

Going forward:

- **New timely/differential benchmarks**: Add to this repository
- **Core functionality benchmarks**: Add to the main repository
- **Dependency updates**: Update timely and differential-dataflow versions in this repository's Cargo.toml

## References

- Main Repository: bigweaver-agent-canary-hydro-zeta
- Source Commit: 513b2091 (Add slightly more complex reachability benchmark)
- Migration Script: scripts/compare_benchmarks.sh
