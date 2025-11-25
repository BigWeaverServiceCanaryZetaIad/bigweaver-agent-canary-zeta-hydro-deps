# Migration Summary: Timely and Differential-Dataflow Benchmarks

## Overview

This document summarizes the migration of timely and differential-dataflow benchmarks from the `bigweaver-agent-canary-hydro-zeta` repository to this dedicated `bigweaver-agent-canary-zeta-hydro-deps` repository.

## Migration Date

November 25, 2024

## Rationale

The benchmarks were moved to maintain clean separation of dependencies and align with team architecture principles:

1. **Dependency Isolation**: The main repository should not depend on timely and differential-dataflow packages
2. **Build Time Optimization**: Removing these dependencies from the main repository improves build times
3. **Separation of Concerns**: Benchmarks for external dependencies are better maintained in a separate repository
4. **Architectural Consistency**: Follows established team patterns of isolating specific functionality

## What Was Migrated

### Benchmark Files (8 total)

All benchmark source files that depend on timely or differential-dataflow:

1. **arithmetic.rs** - Arithmetic pipeline benchmarks using timely operators
2. **fan_in.rs** - Fan-in pattern benchmarks using timely operators  
3. **fan_out.rs** - Fan-out pattern benchmarks using timely operators
4. **fork_join.rs** - Fork-join pattern benchmarks using timely operators
5. **identity.rs** - Identity/overhead benchmarks using timely operators
6. **join.rs** - Join operation benchmarks using timely operators
7. **reachability.rs** - Graph reachability using differential-dataflow operators
8. **upcase.rs** - String transformation benchmarks using timely operators

### Data Files (2 total)

Supporting data files for benchmarks:

1. **reachability_edges.txt** - Graph edge data (521 KB)
2. **reachability_reachable.txt** - Expected reachable nodes (38 KB)

### Dependencies

The following dependencies were added to this repository's `Cargo.toml`:

```toml
[dev-dependencies]
criterion = { version = "0.5.0", features = [ "async_tokio", "html_reports" ] }
dfir_rs = { path = "../bigweaver-agent-canary-hydro-zeta/dfir_rs", features = [ "debugging" ] }
differential-dataflow = { package = "differential-dataflow-master", version = "0.13.0-dev.1" }
futures = "0.3"
nameof = "1.0.0"
rand = "0.8.0"
rand_distr = "0.4.3"
seq-macro = "0.2.0"
sinktools = { path = "../bigweaver-agent-canary-hydro-zeta/sinktools", version = "^0.0.1" }
static_assertions = "1.0.0"
timely = { package = "timely-master", version = "0.13.0-dev.1" }
tokio = { version = "1.29.0", features = [ "rt-multi-thread" ] }
```

## What Remained in Main Repository

The following benchmarks remain in `bigweaver-agent-canary-hydro-zeta` as they do not depend on timely or differential-dataflow:

- **futures.rs** - Async futures benchmark
- **micro_ops.rs** - Micro-operations benchmark
- **symmetric_hash_join.rs** - Hash join benchmark
- **words_diamond.rs** - Diamond pattern benchmark
- **words_alpha.txt** - Data file for words_diamond (3.7 MB)

## Repository Structure

### Before Migration

```
bigweaver-agent-canary-hydro-zeta/
└── benches/
    ├── Cargo.toml (with timely/differential deps)
    ├── benches/
    │   ├── arithmetic.rs
    │   ├── fan_in.rs
    │   ├── fan_out.rs
    │   ├── fork_join.rs
    │   ├── futures.rs
    │   ├── identity.rs
    │   ├── join.rs
    │   ├── micro_ops.rs
    │   ├── reachability.rs
    │   ├── symmetric_hash_join.rs
    │   ├── upcase.rs
    │   ├── words_diamond.rs
    │   ├── reachability_edges.txt
    │   ├── reachability_reachable.txt
    │   └── words_alpha.txt
    └── build.rs
```

### After Migration

```
bigweaver-agent-canary-hydro-zeta/
└── benches/
    ├── Cargo.toml (no timely/differential deps)
    ├── benches/
    │   ├── futures.rs
    │   ├── micro_ops.rs
    │   ├── symmetric_hash_join.rs
    │   ├── words_diamond.rs
    │   └── words_alpha.txt
    └── build.rs

bigweaver-agent-canary-zeta-hydro-deps/
├── Cargo.toml (with timely/differential deps)
├── README.md
├── BENCHMARK_GUIDE.md
├── MIGRATION_SUMMARY.md
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

## Dependencies Between Repositories

This repository maintains dependencies on the main repository for:

- **dfir_rs**: Core Hydroflow dataflow library (path dependency)
- **sinktools**: Utilities for sink operations (path dependency)

These are referenced as sibling path dependencies:

```toml
dfir_rs = { path = "../bigweaver-agent-canary-hydro-zeta/dfir_rs", features = [ "debugging" ] }
sinktools = { path = "../bigweaver-agent-canary-hydro-zeta/sinktools", version = "^0.0.1" }
```

## Running Benchmarks Post-Migration

### In Main Repository

```bash
cd bigweaver-agent-canary-hydro-zeta
cargo bench -p benches
```

Runs 4 benchmarks: futures, micro_ops, symmetric_hash_join, words_diamond

### In This Repository

```bash
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench
```

Runs 8 benchmarks: arithmetic, fan_in, fan_out, fork_join, identity, join, reachability, upcase

## Performance Comparison Workflow

To compare performance across both repositories:

1. **Run main repository benchmarks:**
   ```bash
   cd bigweaver-agent-canary-hydro-zeta
   cargo bench -p benches -- --save-baseline main-repo
   ```

2. **Run hydro-deps benchmarks:**
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps
   cargo bench -- --save-baseline deps-repo
   ```

3. **Results are saved separately** and can be compared using Criterion's baseline comparison features

## Impact Analysis

### Benefits

✅ **Reduced main repository dependencies**: No longer depends on timely/differential-dataflow  
✅ **Faster builds**: Main repository builds faster without these large dependencies  
✅ **Clear separation**: Benchmarks are organized by their dependency requirements  
✅ **Maintained functionality**: All benchmarks continue to work and can be compared  
✅ **Better modularity**: Each repository has a focused purpose

### Considerations

⚠️ **Cross-repository dependencies**: This repo depends on main repo for dfir_rs and sinktools  
⚠️ **Workspace structure**: Both repositories should be cloned as siblings  
⚠️ **Coordination**: Changes to dfir_rs may affect benchmarks in both repositories

## Verification

### Main Repository

1. Build succeeds without timely/differential-dataflow:
   ```bash
   cargo build --workspace
   ```

2. Remaining benchmarks run correctly:
   ```bash
   cargo bench -p benches
   ```

3. No timely/differential references remain:
   ```bash
   grep -r "timely\|differential-dataflow" --include="Cargo.toml" .
   ```

### This Repository

1. Benchmarks build successfully:
   ```bash
   cargo build --benches
   ```

2. All migrated benchmarks run:
   ```bash
   cargo bench
   ```

3. Dependencies resolve correctly:
   ```bash
   cargo tree | grep -E "(timely|differential|dfir_rs|sinktools)"
   ```

## Documentation Updates

### Main Repository

- ✅ Updated `benches/README.md` to reflect removed benchmarks
- ✅ Created `BENCHMARK_REMOVAL.md` documenting the removal
- ✅ Created `CHANGES_SUMMARY.md` summarizing all changes
- ✅ Updated references to point to this repository

### This Repository

- ✅ Created comprehensive `README.md`
- ✅ Created detailed `BENCHMARK_GUIDE.md`
- ✅ Created this `MIGRATION_SUMMARY.md`
- ✅ Configured `Cargo.toml` with all necessary dependencies

## Team Coordination

This migration follows team practices:

- ✅ **Separation of concerns**: Different repositories for different dependency sets
- ✅ **Documentation**: Comprehensive docs created per team standards
- ✅ **Performance testing maintained**: Benchmarks retain ability to run performance comparisons
- ✅ **Cross-repository coordination**: PRs created in both repositories

## Future Considerations

### Adding New Benchmarks

- Benchmarks **without** timely/differential dependencies → main repository
- Benchmarks **with** timely/differential dependencies → this repository

### Updating Dependencies

When updating timely or differential-dataflow versions:

1. Update versions in this repository's `Cargo.toml`
2. Test all benchmarks run successfully
3. Update documentation if breaking changes occur

### Synchronizing with Main Repository

If dfir_rs or sinktools APIs change:

1. Verify benchmarks in this repository still compile
2. Update benchmark code if necessary
3. Coordinate releases between repositories

## References

- Main repository: `bigweaver-agent-canary-hydro-zeta`
- Main repository removal documentation: `BENCHMARK_REMOVAL.md`
- Main repository changes summary: `CHANGES_SUMMARY.md`
- Team practice: Maintaining dedicated repositories for different components
- Team principle: Clean separation of dependencies

## Questions or Issues

If you encounter issues with the migrated benchmarks:

1. Verify both repositories are cloned as siblings
2. Ensure main repository is up to date
3. Check that path dependencies resolve correctly
4. Refer to `BENCHMARK_GUIDE.md` for troubleshooting
