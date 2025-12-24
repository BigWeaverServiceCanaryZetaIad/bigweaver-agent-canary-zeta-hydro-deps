# Benchmark Migration Documentation

## Overview

This document describes the migration of timely-dataflow and differential-dataflow benchmarks from the `bigweaver-agent-canary-hydro-zeta` repository to the `bigweaver-agent-canary-zeta-hydro-deps` repository.

## Migration Date

December 20, 2025

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
- `timely = "0.12"` (actively used in all benchmarks)
- `differential-dataflow = "0.12"` (available for future benchmarks)
- Supporting dependencies:
  - `criterion = { version = "0.3", features = ["async_tokio"] }`
  - `lazy_static = "1.4.0"`
  - `rand = "0.8.4"`
  - `seq-macro = "0.2"`
  - `tokio = { version = "1.0", features = ["rt-multi-thread"] }`

**Note**: While the current benchmark implementations primarily use timely-dataflow directly, differential-dataflow is included as a dependency to:
1. Keep it out of the main repository's dependency tree
2. Support future benchmarks that may use differential-dataflow features
3. Enable incremental computation benchmarks when needed

### Removed from bigweaver-agent-canary-hydro-zeta
- `timely = "*"` (from benches/Cargo.toml)
- Any references to differential-dataflow in benchmark files

Note: The main repository's benchmark directory may have been removed entirely or may contain only non-timely/differential benchmarks after migration.

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

1. **Check source repository has core implementations without benchmarks:**
   ```bash
   cd bigweaver-agent-canary-hydro-zeta
   ls -la
   # Should see: babyflow/, hydroflow/, spinachflow/ directories
   # Should NOT see: benches/ directory
   ```

2. **Check source repository has no timely/differential dependencies:**
   ```bash
   cd bigweaver-agent-canary-hydro-zeta
   grep -r "timely\|differential-dataflow" */Cargo.toml || echo "No timely/differential dependencies found ✓"
   ```

3. **Build the source repository:**
   ```bash
   cd bigweaver-agent-canary-hydro-zeta
   cargo build
   ```

4. **Check destination repository has all benchmarks:**
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps
   ls -la timely-differential-benches/benches/
   # Should see: arithmetic.rs, fan_in.rs, fan_out.rs, fork_join.rs, identity.rs, 
   #             join.rs, reachability.rs, upcase.rs, zip.rs, and data files
   ```

5. **Configure path dependencies and build:**
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps/timely-differential-benches
   # Edit Cargo.toml and uncomment the path dependencies:
   # babyflow = { path = "../../bigweaver-agent-canary-hydro-zeta/babyflow" }
   # hydroflow = { path = "../../bigweaver-agent-canary-hydro-zeta/hydroflow" }
   # spinachflow = { path = "../../bigweaver-agent-canary-hydro-zeta/spinachflow" }
   
   cd ..
   cargo build
   ```

6. **Run the benchmarks:**
   ```bash
   cargo bench
   ```

### Verification Results

**Files Migrated**: ✓ All 9 benchmark files successfully migrated
- arithmetic.rs
- fan_in.rs
- fan_out.rs
- fork_join.rs
- identity.rs
- join.rs
- reachability.rs
- upcase.rs
- zip.rs

**Data Files**: ✓ Both data files present
- reachability_edges.txt (532KB)
- reachability_reachable.txt (38KB)

**Dependencies**: ✓ Properly declared in timely-differential-benches/Cargo.toml
- timely = "0.12" (actively used in all benchmarks)
- differential-dataflow = "0.12" (available for future use)
- Path dependencies to babyflow, hydroflow, spinachflow (cross-repository)

**Workspace Structure**: ✓ Correct
- Root Cargo.toml declares workspace with timely-differential-benches member
- Resolver 2 enabled for proper dependency resolution

**Benchmark Configuration**: ✓ All benchmarks properly configured
- All 9 benchmarks declared with `harness = false`
- Criterion framework configured with async_tokio support

## Post-Migration Changes in Main Repository

After this migration, the main repository (bigweaver-agent-canary-hydro-zeta) has:

1. ✓ **Core implementations retained**: babyflow, hydroflow, and spinachflow directories remain in the repository
2. ✓ **Benchmarks removed**: benches/ directory removed entirely
3. ✓ **No timely/differential dependencies**: All references to timely-dataflow and differential-dataflow removed from Cargo.toml files
4. ✓ **Updated documentation**: README.md explains the migration and how to run cross-repository benchmarks
5. ✓ **Workspace configuration**: Cargo.toml workspace includes only core implementations (babyflow, hydroflow, spinachflow)

## Maintenance

Going forward:

- **New timely/differential benchmarks**: Add to this repository
- **Core functionality benchmarks**: Add to the main repository
- **Dependency updates**: Update timely and differential-dataflow versions in this repository's Cargo.toml

## References

- Main Repository: bigweaver-agent-canary-hydro-zeta
- Source Commit: 513b2091 (Add slightly more complex reachability benchmark)
- Migration Script: scripts/compare_benchmarks.sh
