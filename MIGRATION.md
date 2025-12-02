# Migration Documentation

## Overview

This document describes the migration of timely and differential-dataflow benchmarks from the main Hydro repository (`bigweaver-agent-canary-hydro-zeta`) to this dedicated dependencies repository (`bigweaver-agent-canary-zeta-hydro-deps`).

## Migration Date

December 2, 2025

## Files Migrated

### Benchmark Suite

The following files were moved from the main repository's `benches/` directory:

**Configuration Files:**
- `Cargo.toml` - Benchmark package configuration (updated to use git dependencies)
- `README.md` - Benchmark documentation
- `build.rs` - Build script for benchmark generation
- `.gitignore` - Git ignore patterns for benchmark artifacts

**Benchmark Source Files:**
- `benches/arithmetic.rs` - Arithmetic operation benchmarks
- `benches/fan_in.rs` - Fan-in pattern benchmarks
- `benches/fan_out.rs` - Fan-out pattern benchmarks
- `benches/fork_join.rs` - Fork-join pattern benchmarks
- `benches/futures.rs` - Async futures benchmarks
- `benches/identity.rs` - Identity operation benchmarks
- `benches/join.rs` - Join operation benchmarks
- `benches/micro_ops.rs` - Micro-operation benchmarks
- `benches/reachability.rs` - Graph reachability benchmarks
- `benches/symmetric_hash_join.rs` - Symmetric hash join benchmarks
- `benches/upcase.rs` - String case conversion benchmarks
- `benches/words_diamond.rs` - Diamond pattern benchmarks

**Supporting Data Files:**
- `benches/reachability_edges.txt` - Test data for reachability benchmarks (533 KB)
- `benches/reachability_reachable.txt` - Expected results for reachability (38 KB)
- `benches/words_alpha.txt` - Word list for string benchmarks (3.9 MB)

## Changes Made

### Source Repository (bigweaver-agent-canary-hydro-zeta)

1. **Documentation Added:**
   - `BENCHMARKS_MOVED.md` - Comprehensive migration guide
   - Updated `CONTRIBUTING.md` to reference benchmark migration
   - Updated `README.md` to link to this repository

2. **Workspace Configuration:**
   - Removed `benches` from workspace members (already done)
   - Removed timely/differential dependencies from Cargo.lock (will be done on next build)

### Destination Repository (bigweaver-agent-canary-zeta-hydro-deps)

1. **New Files Created:**
   - `Cargo.toml` - Workspace configuration
   - `.gitignore` - Repository-specific ignore patterns
   - `README.md` - Repository documentation
   - `MIGRATION.md` - This file

2. **Benchmark Files:**
   - All benchmark files migrated with full history preserved
   - Updated `benches/Cargo.toml` to use git dependencies for dfir_rs and sinktools

## Dependency Changes

### Removed from Main Repository

The following dependencies are no longer in the main repository:
- `timely` (package: `timely-master`, version: 0.13.0-dev.1)
- `differential-dataflow` (package: `differential-dataflow-master`, version: 0.13.0-dev.1)
- Associated sub-crates:
  - `timely-bytes-master`
  - `timely-communication-master`
  - `timely-container-master`
  - `timely-logging-master`

### Added to Deps Repository

The benchmarks in this repository depend on:
- `timely-master` (version 0.13.0-dev.1)
- `differential-dataflow-master` (version 0.13.0-dev.1)
- `dfir_rs` (from main repository via git)
- `sinktools` (from main repository via git)
- Other supporting dependencies (criterion, futures, tokio, etc.)

## Verification Steps

To verify the migration was successful:

1. **Clone this repository:**
   ```bash
   git clone https://github.com/hydro-project/bigweaver-agent-canary-zeta-hydro-deps.git
   cd bigweaver-agent-canary-zeta-hydro-deps
   ```

2. **Verify all files are present:**
   ```bash
   find benches -type f
   ```

3. **Run benchmarks (requires Rust toolchain):**
   ```bash
   cargo bench -p benches
   ```

4. **Run specific benchmark:**
   ```bash
   cargo bench -p benches --bench arithmetic
   ```

## Performance Comparison Capability

The migration preserves full performance comparison functionality:
- All benchmark code is intact
- All test data files are included
- Benchmark harness configuration is preserved
- Results can be compared across runs using Criterion's built-in comparison

## Impact Assessment

### Build Time Improvements

Expected improvements to main repository:
- Faster incremental builds (no timely/differential compilation)
- Reduced CI/CD time
- Smaller dependency tree
- Faster clean builds

### Team Impact

- **Development Team:** Continues using main repository for core development
- **Performance Engineering:** Uses this repository for timely/differential benchmarks
- **CI/CD:** Can optionally run benchmarks from this repository
- **Documentation:** Clear separation of concerns

## Rollback Plan

If issues arise, the benchmarks can be restored to the main repository:

1. Extract benchmark files from this repository
2. Add `benches` to main repository workspace members
3. Update Cargo.toml to use path dependencies
4. Revert documentation changes

## Future Additions

New benchmarks requiring timely or differential-dataflow should be added to this repository, not the main repository. Follow the pattern established in existing benchmarks:

1. Create benchmark file in `benches/benches/`
2. Add `[[bench]]` entry to `benches/Cargo.toml`
3. Update documentation as needed

## Questions or Issues

For issues related to:
- **Benchmark execution:** Open issue in this repository
- **Benchmark functionality:** Check with Performance Engineering team
- **Migration questions:** Refer to main repository's `BENCHMARKS_MOVED.md`

## Related Documentation

- Main repository migration guide: `bigweaver-agent-canary-hydro-zeta/BENCHMARKS_MOVED.md`
- Benchmark usage: `README.md` in this repository
- Original benchmark docs: `benches/README.md`
