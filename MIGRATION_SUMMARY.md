# Benchmark Migration Summary

## Overview

This document summarizes the migration of timely and differential-dataflow benchmarks from the main `bigweaver-agent-canary-hydro-zeta` repository to this dedicated `bigweaver-agent-canary-zeta-hydro-deps` repository.

## Rationale

The benchmarks were moved to this separate repository to:

1. **Reduce dependency footprint**: The main repository no longer needs to depend on `timely` and `differential-dataflow` packages
2. **Improve build times**: Contributors working on core features don't need to build benchmark dependencies
3. **Maintain clean separation**: Dependencies for comparative benchmarking are isolated from production code
4. **Preserve functionality**: Performance comparison capabilities are retained in a dedicated location

## What Was Moved

### Directory Structure

```
benches/
├── Cargo.toml          # Package configuration with timely/differential-dataflow dependencies
├── README.md           # Quick reference for running benchmarks
├── build.rs            # Build script for generating benchmark code
└── benches/            # Benchmark implementations
    ├── .gitignore
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

### Dependencies Moved

The following dependencies were moved from the main repository to this repository:
- `timely` (timely-master 0.13.0-dev.1)
- `differential-dataflow` (differential-dataflow-master 0.13.0-dev.1)

### Dependencies Updated

Dependencies on internal packages from the main repository were updated:
- `dfir_rs`: Changed from path dependency to git dependency
- `sinktools`: Changed from path dependency to git dependency

## Changes to Main Repository

### Removed
- `benches/` directory and all contents
- Workspace member reference to `benches` (if it existed)
- Dependencies on `timely` and `differential-dataflow` from Cargo.lock
- Benchmark-related CI/CD workflows (if any)

### Maintained
- Core functionality remains unchanged
- No impact on production code or tests
- Documentation updated to reference new benchmark location

## Performance Comparison Workflow

The ability to run performance comparisons has been maintained. Users can:

1. **Run Hydro-native benchmarks** in the main repository (if/when they exist)
2. **Run comparative benchmarks** in this repository
3. **Compare results** using Criterion's baseline comparison features

See `BENCHMARK_GUIDE.md` for detailed instructions.

## Impact Analysis

### For Contributors

**Main Repository Contributors**:
- ✅ Faster build times (no timely/differential-dataflow compilation)
- ✅ Smaller dependency tree
- ✅ Focus on core functionality without benchmark overhead

**Performance Engineering Team**:
- ✅ Dedicated repository for benchmark management
- ✅ Independent versioning of benchmark code
- ✅ Easier to maintain benchmark-specific dependencies
- ⚠️ Need to clone two repositories for full performance testing

### For CI/CD

**Main Repository CI**:
- ✅ Faster CI runs
- ✅ Reduced dependency download time
- ✅ Cleaner build artifacts

**Benchmark Repository CI**:
- ⚠️ New CI setup needed (if continuous benchmarking is desired)
- ✅ Can run independently without triggering main repository builds

## Migration Date

This migration was completed on [Date] as part of the effort to improve code organization and reduce technical debt.

## Related Changes

- Main repository: Removal of benchmark code and dependencies
- This repository: Initial setup with migrated benchmarks
- Documentation: Updated to reference new benchmark location

## Future Considerations

1. **CI Integration**: Consider setting up automated benchmarking in this repository
2. **Cross-repository Testing**: Coordinate benchmark runs with main repository releases
3. **Dependency Updates**: Keep timely/differential-dataflow dependencies up to date
4. **Documentation**: Maintain synchronization with main repository documentation

## Questions or Issues

If you have questions about this migration or encounter issues:
1. Check the `BENCHMARK_GUIDE.md` for usage instructions
2. Verify git dependencies are correctly configured
3. Consult the team's coordination channels
4. Review the main repository's documentation for Hydro-native benchmarking approaches
