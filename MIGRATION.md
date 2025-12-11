# Benchmark Migration Documentation

## Overview

This document describes the migration of timely-dataflow and differential-dataflow benchmarks from the bigweaver-agent-canary-hydro-zeta repository to this separate bigweaver-agent-canary-zeta-hydro-deps repository.

## Rationale

The benchmarks were separated to:

1. **Reduce Dependencies**: Remove timely-dataflow and differential-dataflow from the main Hydro repository
2. **Maintain Comparisons**: Keep the ability to compare DFIR performance against timely/differential
3. **Improve Build Times**: Reduce compilation time for the main repository
4. **Cleaner Architecture**: Separate external dependency benchmarks from core functionality

## Migrated Benchmarks

The following benchmarks were moved to this repository:

### Timely/Differential Benchmarks
- `arithmetic.rs` - Basic arithmetic operations comparing DFIR and timely/differential
- `fan_in.rs` - Fan-in pattern benchmarks
- `fan_out.rs` - Fan-out pattern benchmarks
- `fork_join.rs` - Fork-join pattern (uses generated code via build.rs)
- `identity.rs` - Identity transformation benchmarks
- `join.rs` - Join operation benchmarks
- `reachability.rs` - Graph reachability benchmarks
- `upcase.rs` - String uppercase transformation benchmarks

### Supporting Files
- `build.rs` - Build script for generating fork_join benchmark code
- `reachability_edges.txt` - Test data for reachability benchmark
- `reachability_reachable.txt` - Expected results for reachability benchmark

## Benchmarks Remaining in Main Repository

The following DFIR-only benchmarks remain in bigweaver-agent-canary-hydro-zeta:

- `futures.rs` - Futures/async benchmarks
- `micro_ops.rs` - Micro-operation benchmarks
- `symmetric_hash_join.rs` - Symmetric hash join benchmarks
- `words_diamond.rs` - Word processing diamond pattern
- `words_alpha.txt` - Test data for words_diamond

## Dependencies

### Added to this repository:
- `timely = { package = "timely-master", version = "0.13.0-dev.1" }`
- `differential-dataflow = { package = "differential-dataflow-master", version = "0.13.0-dev.1" }`

### Removed from main repository:
- `timely` (all references removed)
- `differential-dataflow` (all references removed)

### Kept in main repository:
- `criterion` - For DFIR-only benchmarks
- `dfir_rs` - The main DFIR runtime
- Other DFIR dependencies

## Running Comparisons

To compare DFIR performance with timely/differential:

1. Run benchmarks in this repository:
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps
   cargo bench
   ```

2. Run DFIR benchmarks in the main repository:
   ```bash
   cd bigweaver-agent-canary-hydro-zeta
   cargo bench -p benches
   ```

3. Compare the results from both runs

## Build Configuration

This repository uses the same build configuration as the main repository:
- Edition: 2024
- Rust toolchain: Matches main repository (see rust-toolchain.toml)
- Formatting: Uses same rustfmt.toml
- Linting: Uses same clippy.toml

## CI/CD Considerations

When setting up CI/CD:
- This repository can be built and tested independently
- Benchmark results can be compared across repositories
- No DFIR source code dependencies are needed (benchmarks use published DFIR versions or git dependencies)

## Future Work

- Consider adding more comprehensive performance comparison tooling
- Potentially add automated performance regression detection
- Document best practices for adding new comparison benchmarks
