# Benchmark Migration Documentation

## Overview

This document describes the migration of timely-dataflow and differential-dataflow benchmarks from the `bigweaver-agent-canary-hydro-zeta` repository to the `bigweaver-agent-canary-zeta-hydro-deps` repository.

## Migration Date

December 22, 2024

## Reason for Migration

The benchmarks and their associated dependencies (timely-dataflow and differential-dataflow) were moved to a separate repository to:

1. **Reduce dependency bloat**: Remove unnecessary dependencies from the main repository
2. **Improve build times**: Avoid compiling timely and differential-dataflow in the main codebase
3. **Maintain comparison capability**: Retain the ability to run performance comparisons between different dataflow implementations
4. **Simplify maintenance**: Keep benchmarking infrastructure separate from core functionality
5. **Isolate benchmark code**: Extract only the timely-specific benchmark functions, leaving other implementations in the main repository

## Migration Strategy

Unlike a simple file copy, this migration involved **extracting and isolating** only the timely-dataflow benchmark functions from each benchmark file:

- **Before**: Each benchmark file contained multiple implementations (babyflow, hydroflow, spinachflow, timely, etc.)
- **After**: 
  - Main repository: Contains benchmarks for babyflow, hydroflow, spinachflow, and baseline implementations
  - Deps repository: Contains only isolated timely-dataflow benchmarks

This approach ensures:
- Clean separation of concerns
- No circular dependencies
- Independent execution of each repository's benchmarks
- Easier maintenance and updates

## Files Migrated

### From bigweaver-agent-canary-hydro-zeta

The following benchmark functions were extracted and migrated to this repository:

#### Benchmark Files (Timely Functions Only)
- `benches/benches/arithmetic.rs` → `timely-differential-benches/benches/arithmetic.rs` (timely function only)
- `benches/benches/fan_in.rs` → `timely-differential-benches/benches/fan_in.rs` (timely function only)
- `benches/benches/fan_out.rs` → `timely-differential-benches/benches/fan_out.rs` (timely function only)
- `benches/benches/fork_join.rs` → `timely-differential-benches/benches/fork_join.rs` (timely function only)
- `benches/benches/identity.rs` → `timely-differential-benches/benches/identity.rs` (timely function only)
- `benches/benches/join.rs` → `timely-differential-benches/benches/join.rs` (timely function only)
- `benches/benches/reachability.rs` → `timely-differential-benches/benches/reachability.rs` (timely function only)
- `benches/benches/upcase.rs` → `timely-differential-benches/benches/upcase.rs` (timely function only)

Note: `zip.rs` was not migrated as it did not contain a timely implementation.

#### Data Files
- `benches/benches/reachability_edges.txt` → `timely-differential-benches/benches/reachability_edges.txt`
- `benches/benches/reachability_reachable.txt` → `timely-differential-benches/benches/reachability_reachable.txt`

## Dependencies Migrated

### Added to bigweaver-agent-canary-zeta-hydro-deps
- `timely = "0.12"`
- `differential-dataflow = "0.12"`
- Supporting dependencies:
  - `criterion = { version = "0.3", features = ["async_tokio"] }`
  - `lazy_static = "1.4.0"`
  - `rand = "0.8.4"`
  - `seq-macro = "0.2"`
  - `tokio = { version = "1.0", features = ["rt-multi-thread"] }`

### Removed from bigweaver-agent-canary-hydro-zeta
- `timely = "*"` (from benches/Cargo.toml)
- All `use timely::*` imports from benchmark files
- All `benchmark_timely` functions from benchmark files
- References to `benchmark_timely` in `criterion_group!` macros

The main repository retains all other benchmark implementations and their dependencies.

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
    └── benches/                         # Isolated timely benchmarks
        ├── arithmetic.rs                # Only timely implementation
        ├── fan_in.rs                    # Only timely implementation
        ├── fan_out.rs                   # Only timely implementation
        ├── fork_join.rs                 # Only timely implementation
        ├── identity.rs                  # Only timely implementation
        ├── join.rs                      # Only timely implementation
        ├── reachability.rs              # Only timely implementation
        ├── reachability_edges.txt       # Test data
        ├── reachability_reachable.txt   # Test data
        └── upcase.rs                    # Only timely implementation
```

## Performance Comparison

After migration, performance comparisons can be conducted using:

1. **Direct benchmarking**: Run benchmarks in each repository separately
   ```bash
   # In bigweaver-agent-canary-zeta-hydro-deps
   cargo bench -p timely-differential-benches
   
   # In bigweaver-agent-canary-hydro-zeta
   cargo bench -p benches  # Tests babyflow, hydroflow, spinachflow
   ```

2. **Automated comparison**: Use the provided comparison script
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps
   ./scripts/compare_benchmarks.sh
   ```

3. **Manual comparison**: Compare criterion results from `target/criterion/` in each repository

## Verification

To verify the migration was successful:

1. Build the deps repository:
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps
   cargo build
   ```

2. Run the benchmarks:
   ```bash
   cargo bench
   ```

3. Check that the main repository no longer has timely/differential dependencies:
   ```bash
   cd bigweaver-agent-canary-hydro-zeta
   grep -r "timely" benches/Cargo.toml  # Should return nothing
   cargo build  # Should not compile timely
   ```

## Post-Migration Changes in Main Repository

After this migration, the main repository:

1. ✅ Removed timely and differential-dataflow dependencies from `benches/Cargo.toml`
2. ✅ Removed all `use timely::*` imports from benchmark files
3. ✅ Removed all `benchmark_timely` functions from benchmark files
4. ✅ Updated `criterion_group!` macros to exclude timely benchmarks
5. ✅ Updated documentation to reference this repository for timely comparisons
6. ✅ Retained all non-timely benchmarks (babyflow, hydroflow, spinachflow, raw)

## Maintenance

Going forward:

- **New timely/differential benchmarks**: Add to this repository
- **Core functionality benchmarks**: Add to the main repository
- **Dependency updates**: Update timely and differential-dataflow versions in this repository's Cargo.toml
- **Cross-repo comparisons**: Use the comparison script or manually compare criterion results

## Key Differences from Previous Attempts

This migration differs from previous attempts in that:

1. **Isolated benchmarks**: Only timely code was extracted, not entire files
2. **No shared dependencies**: Each repository is fully independent
3. **Clean separation**: No references to babyflow/hydroflow/spinachflow in this repository
4. **Simpler structure**: Each benchmark file contains only one implementation
5. **Easier maintenance**: Changes to one implementation don't affect others

## References

- Main Repository: bigweaver-agent-canary-hydro-zeta
- Source Commit: 513b2091 (Add slightly more complex reachability benchmark)
- Migration Script: scripts/compare_benchmarks.sh
