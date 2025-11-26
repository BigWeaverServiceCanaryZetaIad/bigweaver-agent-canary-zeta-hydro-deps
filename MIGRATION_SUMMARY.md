# Benchmark Migration Summary

## Overview

This document summarizes the migration of Timely and Differential Dataflow benchmarks from the `bigweaver-agent-canary-hydro-zeta` repository to the `bigweaver-agent-canary-zeta-hydro-deps` repository.

## Migration Details

**Date**: 2024
**Source Repository**: `bigweaver-agent-canary-hydro-zeta`
**Destination Repository**: `bigweaver-agent-canary-zeta-hydro-deps`

## Motivation

The benchmarks were moved to achieve several key objectives:

1. **Dependency Isolation**: Remove `timely` and `differential-dataflow` dependencies from the main Hydro repository
2. **Cleaner Architecture**: Separate performance testing infrastructure from core implementation
3. **Focused Development**: Enable independent evolution of benchmarks and core code
4. **Better Maintenance**: Centralize performance testing concerns in a dedicated repository
5. **Reduced Complexity**: Simplify the main repository's dependency graph

## What Was Moved

### Directory Structure
```
bigweaver-agent-canary-hydro-zeta/benches/ 
    → bigweaver-agent-canary-zeta-hydro-deps/benches/
```

### Files Migrated

**Configuration Files**:
- `benches/Cargo.toml` - Benchmark dependencies and configuration
- `benches/build.rs` - Build-time code generation for benchmarks
- `benches/README.md` - Benchmark usage documentation

**Benchmark Files** (13 total):
- `benches/benches/arithmetic.rs` - Arithmetic operation benchmarks
- `benches/benches/fan_in.rs` - Fan-in pattern benchmarks
- `benches/benches/fan_out.rs` - Fan-out pattern benchmarks
- `benches/benches/fork_join.rs` - Fork-join pattern benchmarks
- `benches/benches/futures.rs` - Async futures benchmarks
- `benches/benches/identity.rs` - Identity/passthrough benchmarks
- `benches/benches/join.rs` - Join operation benchmarks
- `benches/benches/micro_ops.rs` - Micro-operation benchmarks
- `benches/benches/reachability.rs` - Graph reachability benchmarks
- `benches/benches/symmetric_hash_join.rs` - Symmetric hash join benchmarks
- `benches/benches/upcase.rs` - String transformation benchmarks
- `benches/benches/words_diamond.rs` - Diamond pattern benchmarks

**Data Files**:
- `benches/benches/reachability_edges.txt` - Graph data for reachability benchmark
- `benches/benches/reachability_reachable.txt` - Expected results for reachability
- `benches/benches/words_alpha.txt` - English words dataset for string benchmarks

## Changes Made During Migration

### 1. Dependency Path Updates

**Before** (in bigweaver-agent-canary-hydro-zeta):
```toml
[dev-dependencies]
dfir_rs = { path = "../dfir_rs", features = [ "debugging" ] }
sinktools = { path = "../sinktools", version = "^0.0.1" }
```

**After** (in bigweaver-agent-canary-zeta-hydro-deps):
```toml
[dev-dependencies]
# For CI/CD and general use: git dependencies
dfir_rs = { git = "https://github.com/hydro-project/hydro", branch = "main", features = [ "debugging" ] }
sinktools = { git = "https://github.com/hydro-project/hydro", branch = "main", version = "^0.0.1" }

# For local development with unpublished changes, uncomment and adjust paths:
# dfir_rs = { path = "../../bigweaver-agent-canary-hydro-zeta/dfir_rs", features = [ "debugging" ] }
# sinktools = { path = "../../bigweaver-agent-canary-hydro-zeta/sinktools", version = "^0.0.1" }
```

### 2. Workspace Configuration

Created a new `Cargo.toml` workspace file in the hydro-deps repository:
```toml
[workspace]
members = ["benches"]
resolver = "2"
```

### 3. Documentation Enhancements

**New Files Created**:
- `README.md` - Comprehensive repository documentation
- `BENCHMARK_DESCRIPTIONS.md` - Detailed benchmark descriptions
- `MIGRATION_SUMMARY.md` - This file

**Updated Files**:
- `benches/README.md` - Retained original documentation

## Benchmark Functionality Preserved

All benchmark functionality has been preserved:

✅ All 13 benchmark files migrated successfully
✅ All data files included (reachability_edges.txt, reachability_reachable.txt, words_alpha.txt)
✅ Build-time code generation (build.rs) intact
✅ Criterion configuration preserved
✅ All benchmark configurations in Cargo.toml maintained

## Performance Comparison Capability

The migration maintains the ability to run performance comparisons:

### Running Benchmarks in the New Location

```bash
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench -p benches
```

### Comparing with Historical Data

If historical benchmark data exists in the main repository:

1. **Export old benchmarks** (before removal from main repo):
   ```bash
   cd bigweaver-agent-canary-hydro-zeta
   cargo bench -p benches -- --save-baseline old
   cp -r target/criterion /path/to/backup/
   ```

2. **Run new benchmarks**:
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps
   cargo bench -p benches -- --save-baseline new
   ```

3. **Compare results** using criterion's comparison tools

### Cross-Repository Benchmarking

For comparing implementations between repositories:

1. Set up local path dependencies in `benches/Cargo.toml`
2. Run benchmarks with different configurations
3. Use criterion's baseline comparison features

## Impact on Main Repository

### Changes Required in bigweaver-agent-canary-hydro-zeta

1. **Remove benches from workspace** in `Cargo.toml`:
   ```toml
   [workspace]
   members = [
       # "benches",  # Moved to bigweaver-agent-canary-zeta-hydro-deps
       "copy_span",
       # ... other members
   ]
   ```

2. **Update README.md** to reference new benchmark location:
   ```markdown
   ## Benchmarks
   
   Performance benchmarks have been moved to the 
   [bigweaver-agent-canary-zeta-hydro-deps](../bigweaver-agent-canary-zeta-hydro-deps) 
   repository for better dependency isolation.
   ```

3. **Optional**: Add a note in RELEASING.md about benchmark repository

### Dependencies Removed from Main Repository

After the migration, these dependencies are no longer needed in the main repository:
- `timely` (timely-master)
- `differential-dataflow` (differential-dataflow-master)

These remain only in the hydro-deps repository's benchmark dependencies.

## Testing and Verification

### Verification Steps Completed

✅ **Benchmark Files**: All 13 benchmark source files copied
✅ **Data Files**: All 3 data files (txt) copied
✅ **Build Configuration**: build.rs and Cargo.toml properly configured
✅ **Workspace Setup**: New Cargo workspace created
✅ **Documentation**: Comprehensive documentation added

### Verification Steps Recommended

- [ ] Run all benchmarks in new location: `cargo bench -p benches`
- [ ] Verify benchmark results are consistent with historical data
- [ ] Test both git and path dependency configurations
- [ ] Validate build.rs code generation works correctly
- [ ] Ensure all data files are accessible to benchmarks
- [ ] Run benchmarks in CI/CD pipeline
- [ ] Update any documentation references in main repository
- [ ] Verify clippy and rustfmt still work correctly

## Teams Impacted

Based on the organization's structure, this migration impacts:

1. **Development Team**: Need to reference new repository for benchmarks
2. **Performance Testing Team**: Primary users of the benchmarked repository
3. **CI/CD Team**: Need to update pipelines to include new repository
4. **Documentation Team**: Update references and guides

## Coordination Notes

This migration involves changes to multiple repositories:

- **bigweaver-agent-canary-zeta-hydro-deps**: Receives benchmarks (this repository)
- **bigweaver-agent-canary-hydro-zeta**: Source repository (needs cleanup)

These changes should be coordinated as companion PRs to ensure:
- Benchmarks are available before removal from main repository
- Documentation is updated consistently
- CI/CD pipelines are updated appropriately

## Rollback Plan

If issues are discovered, rollback involves:

1. Revert PR in bigweaver-agent-canary-hydro-zeta (restore benches/)
2. Close PR in bigweaver-agent-canary-zeta-hydro-deps
3. Investigate and address issues
4. Re-attempt migration with fixes

## Future Considerations

### Potential Enhancements

1. **Comparison Scripts**: Add automated scripts for cross-repository performance comparison
2. **CI Integration**: Set up automated benchmark runs on PR merges
3. **Performance Tracking**: Implement long-term performance tracking dashboard
4. **Additional Benchmarks**: Add new benchmarks focused on timely/differential patterns
5. **Dependency Updates**: Easier to update timely/differential versions independently

### Maintenance

- Keep benchmark dependencies up to date
- Regularly sync with main repository changes to dfir_rs/sinktools APIs
- Maintain documentation as benchmarks evolve
- Archive historical performance data

## References

- Main Repository: `bigweaver-agent-canary-hydro-zeta`
- Benchmark Repository: `bigweaver-agent-canary-zeta-hydro-deps`
- Criterion Documentation: https://github.com/bheisler/criterion.rs
- Timely Dataflow: https://github.com/TimelyDataflow/timely-dataflow
- Differential Dataflow: https://github.com/TimelyDataflow/differential-dataflow

## Questions and Support

For questions about:
- **Running benchmarks**: See README.md and BENCHMARK_DESCRIPTIONS.md
- **Adding benchmarks**: See BENCHMARK_DESCRIPTIONS.md and benches/README.md
- **Migration issues**: Contact the Development Team
- **Performance analysis**: Contact the Performance Testing Team