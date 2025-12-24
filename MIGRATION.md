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
- `timely = "0.12"`
- `differential-dataflow = "0.12"`
- Supporting dependencies:
  - `criterion = { version = "0.3", features = ["async_tokio"] }`
  - `lazy_static = "1.4.0"`
  - `rand = "0.8.4"`
  - `seq-macro = "0.2"`
  - `tokio = { version = "1.0", features = ["rt-multi-thread"] }`

### Path Dependencies (for performance comparison)
- `babyflow = { path = "../../bigweaver-agent-canary-hydro-zeta/babyflow" }`
- `hydroflow = { path = "../../bigweaver-agent-canary-hydro-zeta/hydroflow" }`
- `spinachflow = { path = "../../bigweaver-agent-canary-hydro-zeta/spinachflow" }`

These path dependencies reference the core implementations in the main repository, which do NOT have timely/differential-dataflow dependencies.

### Removed from bigweaver-agent-canary-hydro-zeta
- `timely = "*"` (from benches/Cargo.toml) - completely removed
- Any references to differential-dataflow in benchmark files - moved to this repository
- The entire benches/ directory structure - moved to this repository

Note: The main repository retains babyflow, hydroflow, and spinachflow implementations as these do NOT depend on timely/differential-dataflow and are needed by the benchmarks in this repository.

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

1. **Check main repository structure**:
   ```bash
   cd bigweaver-agent-canary-hydro-zeta
   # Should only have Cargo.toml, README.md, and core implementations
   ls -la
   # Should list: babyflow/, hydroflow/, spinachflow/
   
   # Verify no timely/differential dependencies
   grep -r "timely\|differential" babyflow/Cargo.toml hydroflow/Cargo.toml spinachflow/Cargo.toml
   # Should return nothing
   ```

2. **Build the main repository** (should be fast without timely/differential):
   ```bash
   cd bigweaver-agent-canary-hydro-zeta
   cargo build
   ```

3. **Build the deps repository** (requires main repo side-by-side):
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps
   cargo build
   ```

4. **Run the benchmarks**:
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps
   cargo bench
   ```

5. **Verify path dependencies work**:
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps
   # Check that benchmarks can find the core implementations
   cargo check
   ```

## Post-Migration Changes in Main Repository

After this migration, the main repository has:

1. ✅ Removed all benchmark files that depend on timely/differential-dataflow
2. ✅ Removed all timely and differential-dataflow dependencies from Cargo.toml files
3. ✅ Updated documentation to reference this repository for performance comparisons
4. ✅ Retained core implementations (babyflow, hydroflow, spinachflow) that do NOT depend on timely/differential-dataflow
5. ✅ These core implementations are used by benchmarks in this repository via path dependencies

### Current Repository Structure

**bigweaver-agent-canary-hydro-zeta** (main repository):
```
.
├── Cargo.toml              # Workspace with babyflow, hydroflow, spinachflow
├── README.md               # Updated with migration documentation
├── babyflow/               # Core implementation (no timely/differential deps)
├── hydroflow/              # Core implementation (no timely/differential deps)
└── spinachflow/            # Core implementation (no timely/differential deps)
```

**bigweaver-agent-canary-zeta-hydro-deps** (this repository):
```
.
├── Cargo.toml              # Workspace configuration
├── README.md               # Repository documentation
├── MIGRATION.md            # This file
├── scripts/
│   └── compare_benchmarks.sh
└── timely-differential-benches/
    ├── Cargo.toml          # With path deps to main repo + timely/differential deps
    ├── README.md
    └── benches/            # All benchmark files
```

## Maintenance

Going forward:

- **New timely/differential benchmarks**: Add to this repository
- **Core functionality benchmarks**: Add to the main repository
- **Dependency updates**: Update timely and differential-dataflow versions in this repository's Cargo.toml

## References

- Main Repository: bigweaver-agent-canary-hydro-zeta
- Source Commit: 513b2091 (Add slightly more complex reachability benchmark)
- Migration Script: scripts/compare_benchmarks.sh
