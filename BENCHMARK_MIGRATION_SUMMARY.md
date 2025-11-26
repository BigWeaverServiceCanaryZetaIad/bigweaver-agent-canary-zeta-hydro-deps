# Benchmark Migration Summary

## Overview

This document summarizes the migration of timely and differential-dataflow benchmarks from the `bigweaver-agent-canary-hydro-zeta` repository to the `bigweaver-agent-canary-zeta-hydro-deps` repository.

## Migration Date

November 26, 2024

## Motivation

The migration was undertaken to:

1. **Improve Dependency Management** - Isolate timely and differential-dataflow dependencies from the main codebase
2. **Reduce Main Repository Footprint** - Remove benchmark-specific code and dependencies from the primary development repository
3. **Maintain Clean Architecture** - Follow the team's preference for separation of concerns and modular repository organization
4. **Preserve Performance Testing** - Ensure all benchmark functionality remains available and maintainable
5. **Enable Focused Development** - Allow independent evolution of benchmarking infrastructure

## What Was Moved

### Directory Structure
```
bigweaver-agent-canary-hydro-zeta/benches/
├── Cargo.toml
├── README.md
├── build.rs
└── benches/
    ├── arithmetic.rs
    ├── fan_in.rs
    ├── fan_out.rs
    ├── fork_join.rs
    ├── futures.rs
    ├── identity.rs
    ├── join.rs
    ├── micro_ops.rs
    ├── reachability.rs
    ├── reachability_edges.txt
    ├── reachability_reachable.txt
    ├── symmetric_hash_join.rs
    ├── upcase.rs
    ├── words_alpha.txt
    └── words_diamond.rs
```

All files and directories above were moved to:
```
bigweaver-agent-canary-zeta-hydro-deps/benches/
```

### Benchmark Files (13 total)

1. **arithmetic.rs** - Pipeline arithmetic operations comparing Hydro, Timely, and baseline implementations
2. **fan_in.rs** - Fan-in dataflow pattern benchmarks
3. **fan_out.rs** - Fan-out dataflow pattern benchmarks
4. **fork_join.rs** - Fork-join pattern benchmarks with generated code
5. **futures.rs** - Async futures processing benchmarks
6. **identity.rs** - Identity operation benchmarks
7. **join.rs** - Hash join operations with Timely dataflow
8. **micro_ops.rs** - Micro-operation performance benchmarks
9. **reachability.rs** - Graph reachability algorithm benchmarks
10. **symmetric_hash_join.rs** - Symmetric hash join pattern benchmarks
11. **upcase.rs** - String transformation benchmarks
12. **words_diamond.rs** - Diamond pattern word processing benchmarks

### Data Files

1. **words_alpha.txt** (3.7 MB) - English word list from https://github.com/dwyl/english-words
2. **reachability_edges.txt** (524 KB) - Graph edges for reachability testing
3. **reachability_reachable.txt** (40 KB) - Expected reachability results

### Configuration Files

1. **Cargo.toml** - Benchmark package configuration (updated with new dependency paths)
2. **README.md** - Benchmark documentation (updated)
3. **build.rs** - Build script for generating fork_join benchmark code

## Dependencies Affected

### Timely and Differential-Dataflow Dependencies

The following dependencies are now isolated in the hydro-deps repository:

```toml
timely = { package = "timely-master", version = "0.13.0-dev.1" }
differential-dataflow = { package = "differential-dataflow-master", version = "0.13.0-dev.1" }
```

These dependencies are used by 8 benchmark files:
- arithmetic.rs
- fan_in.rs
- fan_out.rs
- fork_join.rs
- identity.rs
- join.rs
- reachability.rs
- upcase.rs

### Cross-Repository Dependencies

The benchmarks maintain dependencies on the main repository:

```toml
dfir_rs = { path = "../../bigweaver-agent-canary-hydro-zeta/dfir_rs", features = [ "debugging" ] }
sinktools = { path = "../../bigweaver-agent-canary-hydro-zeta/sinktools", version = "^0.0.1" }
```

## Changes Made

### In bigweaver-agent-canary-zeta-hydro-deps Repository

1. **Created workspace** - Added root Cargo.toml with workspace configuration
2. **Added benches directory** - Copied entire benchmark structure
3. **Updated Cargo.toml** - Modified dependency paths to reference main repository
4. **Enhanced README.md** - Added comprehensive documentation
5. **Created this migration summary** - Documented the migration process

### In bigweaver-agent-canary-hydro-zeta Repository

1. **Removed benches directory** - Eliminated benchmark code from main repository
2. **Updated Cargo.toml** - Removed "benches" from workspace members
3. **Updated documentation** - Added reference to new benchmark location

## Benchmark Functionality Preserved

All benchmark functionality has been preserved:

✅ Performance comparison capabilities maintained
✅ Criterion benchmarking framework integration
✅ HTML report generation
✅ Statistical analysis features
✅ All test data files included
✅ Build script functionality (fork_join code generation)
✅ Async benchmark support

## How to Run Benchmarks

### From the hydro-deps repository:

```bash
# Navigate to the repository
cd /projects/sandbox/bigweaver-agent-canary-zeta-hydro-deps

# Run all benchmarks
cargo bench -p benches

# Run specific benchmark
cargo bench -p benches --bench arithmetic
```

### Requirements:

- Both repositories must be at the same directory level
- The main repository must be available at: `../bigweaver-agent-canary-hydro-zeta`
- All dependencies must be properly installed

## Performance Impact

- **Main Repository**: Reduced by approximately 4.4 MB (benchmark code and data)
- **Benchmark Performance**: No performance impact - benchmarks function identically
- **Build Time**: Main repository builds faster without benchmark dependencies
- **Dependency Tree**: Main repository no longer requires timely/differential-dataflow for non-benchmark builds

## Testing

The migration has been tested to ensure:

✅ Benchmarks compile successfully in new location
✅ Dependency paths resolve correctly
✅ All benchmark tests can be executed
✅ Performance comparison results are consistent
✅ Data files are accessible
✅ Build scripts function properly

## Migration Benefits

1. **Cleaner Main Repository** - Reduced code size and dependency footprint
2. **Better Separation of Concerns** - Performance testing isolated from core functionality
3. **Improved Build Times** - Main repository builds without benchmark dependencies
4. **Focused Development** - Each repository has clear, distinct purpose
5. **Easier Maintenance** - Benchmark updates don't clutter main repository history
6. **Dependency Hygiene** - External framework dependencies properly isolated

## Affected Teams

### Development Team
- **Action**: Update local repository clones to include hydro-deps repository
- **Impact**: Main repository is lighter, benchmarks moved to separate repo

### Performance Testing Team
- **Action**: Update benchmark execution scripts to use new repository location
- **Impact**: All benchmark functionality preserved in new location

### CI/CD Team
- **Action**: Update CI pipelines to checkout both repositories for benchmark runs
- **Impact**: Build configurations need to reference new benchmark location

### Documentation Team
- **Action**: Update documentation to reference new benchmark repository
- **Impact**: User guides and developer documentation need updates

## Repository Structure After Migration

```
/projects/sandbox/
├── bigweaver-agent-canary-hydro-zeta/
│   ├── dfir_rs/              (referenced by benchmarks)
│   ├── sinktools/            (referenced by benchmarks)
│   └── [other components]
│
└── bigweaver-agent-canary-zeta-hydro-deps/
    ├── Cargo.toml            (workspace configuration)
    ├── README.md             (comprehensive documentation)
    ├── BENCHMARK_MIGRATION_SUMMARY.md  (this file)
    └── benches/              (all benchmarks)
        ├── Cargo.toml
        ├── README.md
        ├── build.rs
        └── benches/          (13 benchmark files + data)
```

## Rollback Procedure

If rollback is needed:

1. Copy benchmarks back to main repository
2. Update main repository Cargo.toml to include "benches" in workspace members
3. Restore original dependency paths in benches/Cargo.toml
4. Remove hydro-deps repository (optional)

## Related Changes

This migration is part of a broader effort to:
- Improve repository organization
- Manage technical debt proactively
- Maintain clean dependency structures
- Follow architectural best practices

## Conclusion

The benchmark migration successfully achieves the goals of:
- ✅ Preserving all benchmark functionality
- ✅ Maintaining performance comparison capabilities
- ✅ Reducing main repository footprint
- ✅ Improving code organization
- ✅ Enabling focused development

All benchmarks remain fully functional and accessible in their new location.
