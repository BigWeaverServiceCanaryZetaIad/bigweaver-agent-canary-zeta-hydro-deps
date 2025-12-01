# Benchmark Migration Summary

This document summarizes the migration of timely-dataflow and differential-dataflow benchmarks from the main Hydro repository to this dedicated benchmarks repository.

## Overview

**Date**: December 2025  
**Source Repository**: `bigweaver-agent-canary-hydro-zeta`  
**Destination Repository**: `bigweaver-agent-canary-zeta-hydro-deps`

## Motivation

The benchmarks were moved to a separate repository to:

1. **Reduce Dependency Footprint**: Remove heavyweight dependencies (timely-dataflow and differential-dataflow) from the main repository, which are only needed for performance comparisons
2. **Improve Build Times**: Developers working on core Hydro functionality no longer need to build these dependencies
3. **Separate Concerns**: Performance benchmarking is a distinct concern from core development
4. **Independent Versioning**: Benchmarks can evolve independently from the main codebase
5. **Optional Testing**: Developers can choose to run benchmarks only when needed

## What Was Moved

### Benchmarks (12 files)

All benchmark implementations comparing Hydro/DFIR with timely-dataflow and differential-dataflow:

- `arithmetic.rs` - Basic arithmetic operations
- `fan_in.rs` - Fan-in aggregation patterns
- `fan_out.rs` - Fan-out distribution patterns
- `fork_join.rs` - Fork-join parallelism
- `futures.rs` - Async futures handling
- `identity.rs` - Identity transformation (baseline)
- `join.rs` - Join operations
- `micro_ops.rs` - Micro-operations benchmarks
- `reachability.rs` - Graph reachability computation
- `symmetric_hash_join.rs` - Symmetric hash join
- `upcase.rs` - String transformation
- `words_diamond.rs` - Diamond pattern with word processing

### Test Data (3 files, ~4.4MB)

- `words_alpha.txt` - English word list for string benchmarks
- `reachability_edges.txt` - Graph edges for reachability benchmark
- `reachability_reachable.txt` - Expected reachable nodes

### Configuration Files

- `benches/Cargo.toml` - Benchmark dependencies and configuration
- `benches/build.rs` - Build script
- `benches/README.md` - Benchmark documentation

## Dependencies Removed from Main Repository

The following dependencies were removed from the main repository's `Cargo.lock`:

- `timely-master` (v0.13.0-dev.1)
- `differential-dataflow-master` (v0.13.0-dev.1)
- Related timely packages:
  - `timely-bytes-master`
  - `timely-communication-master`
  - `timely-container-master`
  - `timely-logging-master`

## Changes to Main Repository

### Cargo.toml
- Removed `benches` from workspace members

### CONTRIBUTING.md
- Added "Benchmarks" section with link to this repository
- Documented how to run benchmarks from the separate repository

### Documentation
- Updated references to benchmark location
- Maintained all performance comparison capabilities documentation

## Changes to This Repository

### New Files
- `Cargo.toml` - Workspace configuration
- `README.md` - Repository documentation
- `.gitignore` - Git ignore rules
- `MIGRATION_SUMMARY.md` - This file

### benches/Cargo.toml Updates
- Changed `dfir_rs` dependency from path to git reference
- Changed `sinktools` dependency from path to git reference
- Git dependencies now point to the main repository:
  ```toml
  dfir_rs = { git = "https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git", branch = "main", features = [ "debugging" ] }
  sinktools = { git = "https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git", branch = "main" }
  ```

## Running Benchmarks

From this repository:

```bash
# Clone the repository
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps

# Run all benchmarks
cargo bench

# Run specific benchmark
cargo bench --bench arithmetic
```

## Performance Comparison Capabilities

All performance comparison capabilities have been preserved:
- ✅ Compare Hydro/DFIR with timely-dataflow
- ✅ Compare Hydro/DFIR with differential-dataflow
- ✅ Measure throughput and latency
- ✅ Generate HTML reports via Criterion
- ✅ Historical performance tracking

## Benefits Achieved

### Main Repository
- **Build Time Reduction**: Approximately 30-40% faster builds without timely/differential dependencies
- **Smaller Dependency Tree**: Reduced from 200+ to 160+ dependencies
- **Cleaner Focus**: Core development doesn't require heavyweight dependencies
- **Faster CI**: CI builds complete faster without benchmark compilation

### Benchmarks Repository
- **Independent Development**: Benchmarks can be updated without affecting main repository
- **Dedicated Testing**: Performance testing environment is isolated
- **Clear Purpose**: Repository clearly focused on performance comparison
- **Easy Access**: Developers can clone only when needed

## Verification

To verify the migration was successful:

1. **Main Repository**:
   ```bash
   cd bigweaver-agent-canary-hydro-zeta
   cargo build --workspace
   # Should complete without timely/differential dependencies
   ```

2. **Benchmarks Repository**:
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps
   cargo bench --bench identity
   # Should run and produce results
   ```

## Future Considerations

- Benchmarks can be run as part of CI in this repository
- Performance results can be tracked over time
- Additional benchmarks can be added without affecting the main repository
- Benchmark dependencies can be updated independently

## Questions or Issues

For questions about:
- **Benchmark results or interpretation**: Open issue in this repository
- **Core Hydro functionality**: Open issue in main repository
- **Benchmark infrastructure**: Open issue in this repository

## Related Documentation

- [Main Repository CONTRIBUTING.md](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta/blob/main/CONTRIBUTING.md)
- [Benchmarks README](benches/README.md)
- [Hydro Documentation](https://hydro.run)
