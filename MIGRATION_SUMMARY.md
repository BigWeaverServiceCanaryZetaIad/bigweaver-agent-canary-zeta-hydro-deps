# Benchmark Migration Summary

## Overview

This document describes the migration of timely-dataflow and differential-dataflow benchmarks from the `bigweaver-agent-canary-hydro-zeta` repository to the `bigweaver-agent-canary-zeta-hydro-deps` repository.

## Date

2025-11-30

## Motivation

- **Dependency Separation**: Separate benchmark dependencies (timely and differential-dataflow) from the main Hydro repository
- **Cleaner Dependency Management**: Avoid unnecessary dependencies in the core Hydro codebase
- **Performance Comparison Focus**: Provide a dedicated repository for performance benchmarks and comparisons
- **Reduced Build Times**: Remove heavy dependencies from the main repository, improving build times for developers who don't need benchmarks

## Changes Made

### In `bigweaver-agent-canary-zeta-hydro-deps` (Destination)

#### Added Files
- `benches/` - Directory containing all benchmark implementations
  - `arithmetic.rs` - Basic arithmetic operations benchmark
  - `fan_in.rs` - Fan-in pattern benchmark
  - `fan_out.rs` - Fan-out pattern benchmark
  - `fork_join.rs` - Fork-join pattern benchmark
  - `futures.rs` - Futures-based operations benchmark
  - `identity.rs` - Identity operation benchmark
  - `join.rs` - Join operation benchmark
  - `micro_ops.rs` - Micro-operation benchmarks
  - `reachability.rs` - Graph reachability benchmark (includes differential-dataflow comparison)
  - `symmetric_hash_join.rs` - Symmetric hash join benchmark
  - `upcase.rs` - String uppercase operation benchmark
  - `words_diamond.rs` - Diamond pattern word processing benchmark
  - `reachability_edges.txt` - Test data for reachability benchmark
  - `reachability_reachable.txt` - Expected results for reachability benchmark
  - `words_alpha.txt` - Word list for word processing benchmarks
  - `.gitignore` - Ignore generated files

- `Cargo.toml` - Package configuration with benchmark dependencies
- `build.rs` - Build script for generating benchmark code
- `README.md` - Documentation for running benchmarks
- `.gitignore` - Repository ignore patterns
- `MIGRATION_SUMMARY.md` - This document

#### Dependencies Added
- `timely` (timely-master 0.13.0-dev.1) - For performance comparisons
- `differential-dataflow` (differential-dataflow-master 0.13.0-dev.1) - For performance comparisons
- `criterion` (0.5.0) - Benchmarking framework
- `dfir_rs` (from main repository) - Core Hydro dataflow runtime
- `sinktools` (from main repository) - Utility tools

### In `bigweaver-agent-canary-hydro-zeta` (Source)

#### Removed
- Benchmarks were already removed in previous commits
- References to `timely` and `differential-dataflow` packages from `Cargo.lock`
- No changes to `Cargo.toml` workspace members (benches was already not included)

## File Mapping

| Source (bigweaver-agent-canary-hydro-zeta) | Destination (bigweaver-agent-canary-zeta-hydro-deps) |
|-------------------------------------------|-----------------------------------------------------|
| benches/benches/arithmetic.rs | benches/arithmetic.rs |
| benches/benches/fan_in.rs | benches/fan_in.rs |
| benches/benches/fan_out.rs | benches/fan_out.rs |
| benches/benches/fork_join.rs | benches/fork_join.rs |
| benches/benches/futures.rs | benches/futures.rs |
| benches/benches/identity.rs | benches/identity.rs |
| benches/benches/join.rs | benches/join.rs |
| benches/benches/micro_ops.rs | benches/micro_ops.rs |
| benches/benches/reachability.rs | benches/reachability.rs |
| benches/benches/symmetric_hash_join.rs | benches/symmetric_hash_join.rs |
| benches/benches/upcase.rs | benches/upcase.rs |
| benches/benches/words_diamond.rs | benches/words_diamond.rs |
| benches/benches/reachability_edges.txt | benches/reachability_edges.txt |
| benches/benches/reachability_reachable.txt | benches/reachability_reachable.txt |
| benches/benches/words_alpha.txt | benches/words_alpha.txt |
| benches/Cargo.toml | Cargo.toml |
| benches/build.rs | build.rs |
| benches/README.md | README.md |

## Running Benchmarks

### Before Migration
```bash
cd bigweaver-agent-canary-hydro-zeta
cargo bench -p benches
```

### After Migration
```bash
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench
```

## Impact Analysis

### For Hydro Development Team
- **Action Required**: Update any documentation or scripts that reference benchmark locations
- **Benefits**: 
  - Cleaner main repository without heavy benchmark dependencies
  - Faster build times when working on core Hydro features
  - Easier to maintain benchmark-specific configurations
- **Timeline**: Immediate

### For Performance Engineering Team
- **Action Required**: Update benchmark workflows to use the new repository
- **Benefits**:
  - Dedicated repository for performance testing
  - Easier to manage benchmark-specific CI/CD pipelines
  - Better isolation of performance testing concerns
- **Timeline**: Next sprint

### For CI/CD Team
- **Action Required**: Update CI/CD pipelines to handle benchmarks from the new repository
- **Benefits**:
  - Can run benchmark tests independently from main repository tests
  - More flexible benchmark scheduling
- **Timeline**: Next sprint

## Testing

The benchmarks retain all functionality from the original location:
- All 12 benchmark suites are preserved
- Performance comparison with timely and differential-dataflow is maintained
- Test data files are included

## Related Changes

This migration is part of a broader effort to modularize the Hydro project and separate concerns by moving dependencies to dedicated repositories.

## Notes

- The benchmarks reference `dfir_rs` and `sinktools` from the main Hydro repository via relative path dependencies
- The word list (`words_alpha.txt`) is from https://github.com/dwyl/english-words/blob/master/words_alpha.txt
- Criterion is configured with async_tokio and html_reports features for comprehensive benchmark reporting
