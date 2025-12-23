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

### Path Dependencies for Performance Comparison

The benchmarks require path dependencies to the main repository for performance comparison:
- `babyflow` - from bigweaver-agent-canary-hydro-zeta/babyflow
- `hydroflow` - from bigweaver-agent-canary-hydro-zeta/hydroflow  
- `spinachflow` - from bigweaver-agent-canary-hydro-zeta/spinachflow

These are configured as commented path dependencies in the Cargo.toml and need to be uncommented when running benchmarks.

### Removed from bigweaver-agent-canary-hydro-zeta
- `timely = "*"` (from benches/Cargo.toml)
- References to timely and differential-dataflow in benchmark-specific code

Note: The main repository retains babyflow, hydroflow, and spinachflow as these are the core implementations being benchmarked.

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

1. **Clone both repositories** side-by-side:
   ```bash
   git clone <url>/bigweaver-agent-canary-hydro-zeta.git
   git clone <url>/bigweaver-agent-canary-zeta-hydro-deps.git
   ```

2. **Configure path dependencies** in `bigweaver-agent-canary-zeta-hydro-deps/timely-differential-benches/Cargo.toml`:
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps/timely-differential-benches
   # Edit Cargo.toml to uncomment the path dependencies:
   # babyflow = { path = "../../bigweaver-agent-canary-hydro-zeta/babyflow" }
   # hydroflow = { path = "../../bigweaver-agent-canary-hydro-zeta/hydroflow" }
   # spinachflow = { path = "../../bigweaver-agent-canary-hydro-zeta/spinachflow" }
   ```

3. **Build the deps repository**:
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps
   cargo build
   ```

4. **Run the benchmarks**:
   ```bash
   cargo bench
   ```

5. **Check that the main repository no longer has timely/differential dependencies**:
   ```bash
   cd bigweaver-agent-canary-hydro-zeta
   # Check Cargo.toml files for absence of timely/differential dependencies
   grep -r "timely\|differential-dataflow" . --include="Cargo.toml"
   ```

## Post-Migration Changes in Main Repository

After this migration, the main repository should have:

1. Removed benchmark files that depend on timely/differential-dataflow
2. Removed timely and differential-dataflow dependencies from Cargo.toml files
3. Updated documentation to reference this repository for performance comparisons
4. Optionally retained DFIR-native benchmarks that don't require timely/differential

## Maintenance

Going forward:

- **New timely/differential benchmarks**: Add to this repository
- **Core functionality benchmarks**: Add to the main repository
- **Dependency updates**: Update timely and differential-dataflow versions in this repository's Cargo.toml

## References

- Main Repository: bigweaver-agent-canary-hydro-zeta
- Source Commit: 513b2091 (Add slightly more complex reachability benchmark)
- Migration Script: scripts/compare_benchmarks.sh
