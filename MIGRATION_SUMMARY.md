# Benchmark Migration Summary

This document describes the migration of timely-dataflow and differential-dataflow benchmarks from the main bigweaver-agent-canary-hydro-zeta repository to this dedicated benchmarks repository.

## Overview

**Date**: December 2025
**Migration Type**: Code organization / Dependency isolation
**Repositories Affected**:
- Source: `bigweaver-agent-canary-hydro-zeta` (main Hydro repository)
- Destination: `bigweaver-agent-canary-zeta-hydro-deps` (this repository)

## Motivation

The benchmarks were separated to achieve several goals:

### 1. Reduced Dependency Footprint
- Removed heavyweight `timely-master` and `differential-dataflow-master` dependencies from main repository
- Eliminated transitive dependencies (~4.4MB of test data files)
- Main repository now focused on core Hydro functionality

### 2. Improved Build Times
- CI/CD pipelines no longer need to build benchmark dependencies for main repository
- Faster iteration for core development work
- Optional performance testing - developers only clone when needed

### 3. Better Code Organization
- Clear separation of concerns: core functionality vs. performance benchmarking
- Independent versioning for benchmarks
- Easier to maintain and update benchmark suite independently

### 4. Preserved Performance Comparison Capabilities
- All benchmark functionality maintained
- Ability to compare Hydro/DFIR vs timely-dataflow vs differential-dataflow
- Criterion integration with HTML reports

## What Was Moved

### Benchmark Files (12 implementations)
- `arithmetic.rs` - Basic arithmetic operations
- `fan_in.rs` - Fan-in patterns  
- `fan_out.rs` - Fan-out patterns
- `fork_join.rs` - Fork-join parallelism
- `futures.rs` - Async futures handling
- `identity.rs` - Baseline overhead measurement
- `join.rs` - Join operations
- `micro_ops.rs` - Micro-operation benchmarks
- `reachability.rs` - Graph reachability computation
- `symmetric_hash_join.rs` - Symmetric hash join implementation
- `upcase.rs` - String transformation
- `words_diamond.rs` - Diamond pattern with word processing

### Test Data Files
- `reachability_edges.txt` (521KB)
- `reachability_reachable.txt` (38KB)
- `words_alpha.txt` (3.7MB)

### Configuration Files
- `benches/Cargo.toml` - Benchmark dependencies and configurations
- `benches/build.rs` - Build script
- `benches/README.md` - Benchmark documentation
- `.gitignore` - Git ignore patterns

## Changes Made

### In bigweaver-agent-canary-zeta-hydro-deps (This Repository)

1. **Added benchmark suite**:
   - Created `benches/` directory with all benchmark implementations
   - Added workspace `Cargo.toml`
   - Added comprehensive README.md

2. **Updated dependencies**:
   - Changed `dfir_rs` dependency from path to git reference
   - Changed `sinktools` dependency from path to git reference
   - Kept timely and differential-dataflow dependencies

3. **Added documentation**:
   - This MIGRATION_SUMMARY.md
   - Updated README.md with benchmark descriptions and usage

### In bigweaver-agent-canary-hydro-zeta (Main Repository)

1. **Removed benchmark code**:
   - Deleted `benches/` directory and all contents
   - Removed "benches" from workspace members in root Cargo.toml

2. **Updated documentation**:
   - Added "Benchmarks" section to CONTRIBUTING.md
   - Added "Performance Benchmarks" section to README.md
   - Both documents reference this repository

3. **Cleaned up dependencies**:
   - Removed timely and differential-dataflow from dependency graph
   - Updated Cargo.lock to reflect removed dependencies

## Integration Points

### Dependencies from Main Repository
The benchmarks still depend on these crates from the main repository:
- `dfir_rs` - Core DFIR runtime and syntax (via git)
- `sinktools` - Utility crate (via git)

These are referenced as git dependencies pointing to the main repository.

### Running Benchmarks

To run benchmarks after migration:

```bash
# Clone the benchmarks repository
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps

# Run all benchmarks
cargo bench

# Run specific benchmark
cargo bench --bench reachability

# Generate HTML reports
cargo bench -- --save-baseline my-baseline
```

## Benefits Achieved

✅ **Reduced main repository size**: ~4.4MB less in test data
✅ **Faster CI/CD builds**: No benchmark dependencies to compile
✅ **Cleaner main repository**: Focused on core Hydro functionality
✅ **Independent benchmark development**: Can update benchmarks without affecting main repo
✅ **Optional performance testing**: Clone only when needed
✅ **Preserved comparison capabilities**: All performance testing functionality maintained

## Migration Process

The migration followed team best practices:

1. **Coordinated multi-repository change**: Changes made to both repositories simultaneously
2. **Documentation updates**: Both repositories updated with references to new structure
3. **Dependency management**: Git dependencies used to maintain integration
4. **Performance preservation**: All benchmark functionality maintained

## Future Considerations

### Benchmark Development
- Benchmarks can now be updated independently of main repository
- New benchmarks can be added without affecting main repository build times
- Benchmark CI/CD can be configured separately

### Integration Testing
- Benchmarks automatically pull latest `dfir_rs` from main repository
- May want to pin to specific versions/tags for reproducible results
- Consider separate CI for benchmark performance tracking

### Documentation
- Keep main repository docs in sync with benchmark capabilities
- Document any breaking changes that affect benchmarks
- Maintain examples in both repositories as appropriate

## Contact

For questions about this migration or the benchmark suite, please file an issue in either:
- [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta/issues)
- [bigweaver-agent-canary-zeta-hydro-deps](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps/issues)
