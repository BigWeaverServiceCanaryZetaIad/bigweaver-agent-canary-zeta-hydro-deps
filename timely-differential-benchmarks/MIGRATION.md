# Migration Documentation

## Overview

This document describes the migration of Timely and Differential Dataflow benchmarks from `bigweaver-agent-canary-hydro-zeta` to `bigweaver-agent-canary-zeta-hydro-deps`.

## Migration Date

Completed: [Current Date]

## Source Repository

**Repository**: bigweaver-agent-canary-hydro-zeta  
**Original Location**: `/benches/`  
**Source Commit**: 484e6fddffa97d507384773d51bf728770a6ac38

## Destination Repository

**Repository**: bigweaver-agent-canary-zeta-hydro-deps  
**New Location**: `/timely-differential-benchmarks/`

## What Was Migrated

### Benchmark Files

The following benchmark implementations were extracted and migrated:

1. **arithmetic.rs**
   - Extracted: `benchmark_timely()` function
   - Purpose: Tests chain of arithmetic operations

2. **fan_in.rs**
   - Extracted: `benchmark_timely()` function
   - Purpose: Tests multiple stream concatenation

3. **fan_out.rs**
   - Extracted: `benchmark_timely()` function
   - Purpose: Tests single stream splitting

4. **fork_join.rs**
   - Extracted: `benchmark_timely()` function
   - Purpose: Tests iterative fork-join patterns

5. **identity.rs**
   - Extracted: `benchmark_timely()` function
   - Purpose: Tests pass-through operations

6. **join.rs**
   - Extracted: `benchmark_timely<L, R>()` function
   - Purpose: Tests hash join operations for usize and String types

7. **reachability.rs**
   - Extracted: `benchmark_timely()` and `benchmark_differential()` functions
   - Purpose: Tests graph reachability with both Timely and Differential implementations
   - **Note**: This is the only benchmark with Differential Dataflow code

8. **upcase.rs**
   - Extracted: `benchmark_timely<O>()` functions for 3 variants
   - Purpose: Tests string transformation operations

### Data Files

The following data files were copied:

1. **reachability_edges.txt** (524KB)
   - Graph edge data for reachability benchmarks
   - 55,008 edges

2. **reachability_reachable.txt** (40KB)
   - Expected reachable nodes for validation
   - 7,855 nodes

3. **words_alpha.txt** (3.7MB)
   - Dictionary data for string processing benchmarks
   - Used by upcase and related benchmarks

### Configuration Files

1. **Cargo.toml**
   - Created new standalone package configuration
   - Dependencies: timely-master (0.13.0-dev.1), differential-dataflow-master (0.13.0-dev.1)
   - Configured all 8 benchmark targets

2. **src/lib.rs**
   - Created minimal library with shared constants

## What Was NOT Migrated

The following were intentionally excluded from migration:

### Hydro-Specific Benchmarks
- All `benchmark_hydroflow_*` functions
- All `benchmark_dfir_rs_*` functions
- All `benchmark_compiled` and `benchmark_surface` functions
- SOL (Speed of Light) reference implementations
- Raw iteration and pipeline benchmarks

### Files Not Needed
- `build.rs` (Hydro-specific build script)
- `.gitignore` (will use repository-level settings)
- Other benchmark files without Timely/Differential code:
  - `futures.rs`
  - `micro_ops.rs`
  - `symmetric_hash_join.rs`
  - `words_diamond.rs`

## Changes Made During Migration

### 1. Code Extraction
- Removed all non-Timely/Differential code from benchmark files
- Kept only the `benchmark_timely()` and `benchmark_differential()` functions
- Preserved all test data and validation logic

### 2. Simplified Criterion Groups
Each benchmark file now has a simple criterion group with only Timely/Differential functions:

```rust
criterion_group!(benchmark_name, benchmark_timely);
criterion_main!(benchmark_name);
```

### 3. Dependency Cleanup
New Cargo.toml includes only necessary dependencies:
- criterion (for benchmarking)
- timely-master (Timely Dataflow)
- differential-dataflow-master (Differential Dataflow)
- rand, rand_distr (for data generation where needed)

### 4. Removed Dependencies
These were not needed for Timely/Differential benchmarks:
- dfir_rs
- sinktools
- futures
- tokio
- nameof
- seq-macro
- static_assertions

## Functional Preservation

All benchmark functionality has been preserved:

### ✅ Retained Features
- Complete Timely Dataflow benchmark implementations
- Complete Differential Dataflow benchmark implementation (reachability)
- All test data files
- All validation logic and assertions
- Performance measurement capabilities
- Statistical analysis via Criterion

### ✅ Benchmark Comparability
- Input data sizes unchanged
- Operation counts unchanged
- Algorithm implementations unchanged
- Results are directly comparable to original benchmarks

## Running Migrated Benchmarks

### In Source Repository (Original)
```bash
cd bigweaver-agent-canary-hydro-zeta
cargo bench -p benches --bench arithmetic -- "arithmetic/timely"
```

### In Destination Repository (New)
```bash
cd bigweaver-agent-canary-zeta-hydro-deps/timely-differential-benchmarks
cargo bench --bench arithmetic
```

## Verification Steps

To verify the migration was successful:

1. **Compilation Check**
   ```bash
   cd timely-differential-benchmarks
   cargo check
   cargo build --release
   ```

2. **Run All Benchmarks**
   ```bash
   cargo bench
   ```

3. **Run Individual Benchmarks**
   ```bash
   cargo bench --bench arithmetic
   cargo bench --bench reachability
   cargo bench --bench join
   ```

4. **Verify Results**
   - Check that benchmarks complete successfully
   - Verify assertions pass (especially in reachability)
   - Compare performance numbers with historical data from source repo

## Source Repository Updates

In the source repository (bigweaver-agent-canary-hydro-zeta), the Timely/Differential code was previously removed in favor of external references. The `benches/` directory now contains:
- Documentation pointing to external benchmarks (EXTERNAL_BENCHMARKS.md)
- Only Hydro-specific benchmark implementations
- Historical information about removed dependencies (CHANGES.md)

## Benefits of Migration

1. **Reduced Source Repository Overhead**
   - Smaller dependency tree in Hydro project
   - Faster compilation times
   - Cleaner separation of concerns

2. **Dedicated Benchmark Suite**
   - Focused Timely/Differential performance testing
   - Independent version management
   - Easier maintenance and updates

3. **Preserved Functionality**
   - All benchmark capabilities retained
   - Performance comparison still possible
   - Historical data preservation

4. **Better Organization**
   - Clear purpose for each repository
   - Easier to find relevant benchmarks
   - Reduced confusion about dependencies

## Future Maintenance

### Adding New Benchmarks
When adding new Timely/Differential benchmarks:
1. Create benchmark file in `benches/`
2. Add benchmark target to `Cargo.toml`
3. Update `README.md` with description
4. Include any required data files

### Updating Dependencies
To update Timely/Differential versions:
1. Update version in `Cargo.toml`
2. Run benchmarks to verify compatibility
3. Update README if API changes affect benchmarks
4. Document any breaking changes

### Performance Tracking
Consider setting up:
- Automated benchmark runs on commits
- Performance regression detection
- Historical performance tracking
- Comparison with Hydro implementations

## References

### Source Repository
- GitHub: hydro-project/hydro
- Original benches: `/benches/`
- Commit with Timely/Differential code: 484e6fddffa97d507384773d51bf728770a6ac38

### Destination Repository  
- Repository: bigweaver-agent-canary-zeta-hydro-deps
- Benchmarks location: `/timely-differential-benchmarks/`

### Related Documentation
- Source repo EXTERNAL_BENCHMARKS.md: Guidance for external comparisons
- Source repo CHANGES.md: Documentation of dependency removal
- This repo README.md: Complete benchmark documentation

## Contact

For questions about this migration or the benchmarks:
- Refer to source repository documentation
- Check Timely/Differential Dataflow project documentation
- Review git history for implementation details
