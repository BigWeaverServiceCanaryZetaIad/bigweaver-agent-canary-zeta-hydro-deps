# Migration Notes: Timely and Differential-Dataflow Benchmarks

## Overview

This document describes the migration of timely and differential-dataflow benchmarks from the `bigweaver-agent-canary-hydro-zeta` repository to this dedicated `bigweaver-agent-canary-zeta-hydro-deps` repository.

## Reason for Migration

The benchmarks were moved to:
1. Isolate timely and differential-dataflow dependencies from the main repository
2. Reduce the complexity and dependency footprint of the main codebase
3. Maintain the ability to run performance comparisons without impacting the main development workflow
4. Create a cleaner architecture with better separation of concerns

## What Was Migrated

### Files Recovered from Git History

All files were recovered from commit `b161bc10` (parent commit before removal) in the main repository:

**Benchmark Files:**
- `benches/Cargo.toml` - Benchmark crate configuration
- `benches/README.md` - Benchmark documentation
- `benches/build.rs` - Build script for generating benchmark code
- `benches/benches/.gitignore` - Git ignore for benchmark artifacts
- `benches/benches/arithmetic.rs` - Arithmetic operation benchmarks
- `benches/benches/fan_in.rs` - Fan-in pattern benchmarks
- `benches/benches/fan_out.rs` - Fan-out pattern benchmarks
- `benches/benches/fork_join.rs` - Fork-join pattern benchmarks
- `benches/benches/futures.rs` - Futures-based benchmarks
- `benches/benches/identity.rs` - Identity operation benchmarks
- `benches/benches/join.rs` - Join operation benchmarks
- `benches/benches/micro_ops.rs` - Micro-operation benchmarks
- `benches/benches/reachability.rs` - Graph reachability benchmarks
- `benches/benches/reachability_edges.txt` - Test data (521KB)
- `benches/benches/reachability_reachable.txt` - Test data (38KB)
- `benches/benches/symmetric_hash_join.rs` - Symmetric hash join benchmarks
- `benches/benches/upcase.rs` - String uppercase benchmarks
- `benches/benches/words_alpha.txt` - Word list data (3.7MB)
- `benches/benches/words_diamond.rs` - Diamond pattern benchmarks

**CI/CD and Documentation:**
- `.github/workflows/benchmark.yml` - GitHub Actions workflow for automated benchmark runs
- `.github/gh-pages/index.md` - GitHub Pages index for benchmark results

### Dependencies

The benchmarks depend on:
- `criterion` - For benchmark framework
- `dfir_rs` - Referenced from main repository via git dependency
- `differential-dataflow-master` - Differential dataflow library
- `futures` - Async programming
- `nameof` - Name reflection
- `rand` and `rand_distr` - Random number generation
- `seq-macro` - Sequence macros
- `sinktools` - Referenced from main repository via git dependency
- `static_assertions` - Compile-time assertions
- `timely-master` - Timely dataflow library
- `tokio` - Async runtime

## Configuration Changes

### Cargo.toml Updates

The `benches/Cargo.toml` was updated to:
- Change `dfir_rs` from path dependency to git dependency pointing to the main repository
- Change `sinktools` from path dependency to git dependency pointing to the main repository
- Remove the comment about differential-dataflow git source (using crates.io version)

### Workspace Structure

A new workspace `Cargo.toml` was created at the repository root with:
- Workspace package metadata (edition, license, repository)
- Workspace lints matching the main repository standards
- Single member: `benches`

## How to Use

### Running Benchmarks

```bash
# Run all benchmarks
cargo bench

# Run specific benchmark
cargo bench --bench arithmetic

# Run benchmarks matching a pattern
cargo bench join
```

### Performance Comparisons

Criterion automatically generates comparison reports when benchmarks are run multiple times. Results are stored in `target/criterion/` with HTML reports for visualization.

### Dependencies on Main Repository

The benchmarks have git dependencies on the main repository for:
- `dfir_rs` - The main dataflow library
- `sinktools` - Utility tools

When running benchmarks, Cargo will automatically fetch these dependencies from the main repository at the specified git URL.

## Verification

To verify the benchmarks are properly configured:

1. Check that all benchmark files exist in `benches/benches/`
2. Verify data files are present and non-empty
3. Ensure `Cargo.toml` has all required dependencies
4. Confirm workspace structure is correct

## Future Maintenance

When updating benchmarks:
1. Ensure git dependency versions remain synchronized with the main repository
2. Update benchmark implementations as needed for new patterns
3. Maintain performance comparison capabilities
4. Keep documentation up to date

## Related Commits

- Original removal commit in main repo: `b161bc10` (chore(benches): remove timely/differential-dataflow dependencies and benchmarks)
- Recovery from parent commit: `b161bc10^`
