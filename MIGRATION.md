# Migration Documentation

## Benches Directory Migration

This document describes the migration of the benchmarks from the main Hydro repository to this separate repository.

### Background

The benchmarks have been moved to the `bigweaver-agent-canary-zeta-hydro-deps` repository to isolate dependencies on `timely-dataflow` and `differential-dataflow` packages. This separation helps maintain a cleaner dependency structure in the main Hydro repository.

### What Was Moved

The entire `benches` directory from `bigweaver-agent-canary-hydro-zeta` repository, including:

- **benches/Cargo.toml** - Package manifest with timely and differential-dataflow dependencies
- **benches/README.md** - Documentation for running benchmarks
- **benches/build.rs** - Build script for generating benchmark code
- **benches/benches/** - Directory containing all benchmark implementations:
  - `arithmetic.rs` - Arithmetic operation benchmarks
  - `fan_in.rs` - Fan-in operation benchmarks
  - `fan_out.rs` - Fan-out operation benchmarks
  - `fork_join.rs` - Fork-join pattern benchmarks
  - `futures.rs` - Futures-based benchmarks
  - `identity.rs` - Identity operation benchmarks with benchmark_timely functions
  - `join.rs` - Join operation benchmarks with benchmark_timely functions
  - `micro_ops.rs` - Micro-operations benchmarks
  - `reachability.rs` - Graph reachability benchmarks with benchmark_timely and benchmark_differential functions
  - `symmetric_hash_join.rs` - Symmetric hash join benchmarks
  - `upcase.rs` - Upcase operation benchmarks
  - `words_diamond.rs` - Words diamond pattern benchmarks
  - `reachability_edges.txt` - Test data for reachability benchmarks
  - `reachability_reachable.txt` - Expected results for reachability tests
  - `words_alpha.txt` - Word list for word-based benchmarks

### Changes Made

1. **In bigweaver-agent-canary-zeta-hydro-deps repository:**
   - Added complete `benches` directory structure
   - Created `Cargo.toml` workspace configuration
   - Updated `benches/Cargo.toml` to reference main repository packages via relative paths:
     - `dfir_rs` → `../../bigweaver-agent-canary-hydro-zeta/dfir_rs`
     - `sinktools` → `../../bigweaver-agent-canary-hydro-zeta/sinktools`
   - Added configuration files: `rust-toolchain.toml`, `rustfmt.toml`, `clippy.toml`
   - Updated `README.md` with comprehensive documentation

2. **In bigweaver-agent-canary-hydro-zeta repository:**
   - Removed the `benches` directory entirely
   - Updated `Cargo.toml` workspace members to remove `benches` entry
   - Updated `CONTRIBUTING.md` to reference the new repository location

### Running Benchmarks After Migration

The benchmarks can still be run from the new repository location with the same commands:

```bash
cd bigweaver-agent-canary-zeta-hydro-deps

# Run all benchmarks
cargo bench -p benches

# Run specific benchmarks
cargo bench -p benches --bench reachability
cargo bench -p benches --bench join
cargo bench -p benches --bench identity
```

### Functionality Preserved

All benchmark functionality has been retained:
- Performance comparison capabilities between DFIR and other frameworks
- Timely Dataflow benchmarks (via `benchmark_timely` functions)
- Differential Dataflow benchmarks (via `benchmark_differential` functions)
- All test data and word lists
- Build scripts for generated benchmarks

### Dependencies

The benchmarks maintain dependencies on the main Hydro repository packages through relative path references, ensuring they continue to test against the current codebase.
