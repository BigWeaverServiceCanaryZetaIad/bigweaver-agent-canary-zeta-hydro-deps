# Benchmark Migration Documentation

## Overview

This document describes the migration of Timely Dataflow and Differential Dataflow benchmarks from the main `bigweaver-agent-canary-hydro-zeta` repository to this dedicated `bigweaver-agent-canary-zeta-hydro-deps` repository.

## Migration Date

January 3, 2025

## Rationale

The benchmarks were moved to achieve the following goals:

1. **Cleaner Dependency Management**: Separate external framework dependencies (Timely Dataflow and Differential Dataflow) from the main Hydro codebase
2. **Maintained Performance Comparison Capability**: Preserve the ability to run performance comparisons between Hydro and competing frameworks
3. **Reduced Build Complexity**: Minimize dependencies in the main repository to speed up builds and reduce potential conflicts
4. **Better Organization**: Create a dedicated space for comparative benchmarks against external frameworks

## Migrated Files

### Benchmark Source Files

The following benchmark files were moved from `bigweaver-agent-canary-hydro-zeta/benches/benches/` to this repository:

- `fan_in.rs` - Benchmarks comparing fan-in/union operations across Hydro, Timely Dataflow, and plain Rust iterators
- `join.rs` - Join operation benchmarks comparing Timely Dataflow implementations with plain Rust solutions
- `reachability.rs` - Graph reachability algorithm comparisons between Hydro, Timely Dataflow, and Differential Dataflow

### Data Files

The following data files were moved to support the reachability benchmark:

- `reachability_edges.txt` - Graph edge definitions (521 KB)
- `reachability_reachable.txt` - Expected reachable nodes for validation (38 KB)

### Configuration

A new Cargo workspace was created with:

- Root `Cargo.toml` - Workspace configuration with linting rules and profile settings
- `benches/Cargo.toml` - Package configuration with necessary dependencies including:
  - `timely` (timely-master 0.13.0-dev.1)
  - `differential-dataflow` (differential-dataflow-master 0.13.0-dev.1)
  - `dfir_rs` (from main Hydro repository via git dependency)
  - `criterion` for benchmarking

## Changes to Source Repository

### Removed Files

- `benches/benches/fan_in.rs`
- `benches/benches/join.rs`
- `benches/benches/reachability.rs`
- `benches/benches/reachability_edges.txt`
- `benches/benches/reachability_reachable.txt`

### Updated Files

**benches/Cargo.toml**:
- Removed `timely` dependency
- Removed `differential-dataflow` dependency
- Removed benchmark definitions for `fan_in`, `join`, and `reachability`

**benches/README.md**:
- Added section documenting the migration
- Added reference to this repository for running comparative benchmarks

## Running Benchmarks Post-Migration

### In the Main Repository (bigweaver-agent-canary-hydro-zeta)

Run Hydro-specific benchmarks:
```bash
cargo bench -p benches
```

Available benchmarks:
- arithmetic
- fan_out
- fork_join
- identity
- upcase
- micro_ops
- symmetric_hash_join
- words_diamond
- futures

### In This Repository (bigweaver-agent-canary-zeta-hydro-deps)

Run comparative benchmarks against Timely/Differential:
```bash
cargo bench -p hydro-timely-differential-benches
```

Or run specific benchmarks:
```bash
cargo bench -p hydro-timely-differential-benches --bench fan_in
cargo bench -p hydro-timely-differential-benches --bench join
cargo bench -p hydro-timely-differential-benches --bench reachability
```

## Merge Coordination

This migration requires coordinated merges across both repositories:

1. **This PR should be merged FIRST** to establish the new benchmark repository
2. The companion PR in `bigweaver-agent-canary-hydro-zeta` should be merged AFTER to remove the benchmarks from the main repository

## Verification Steps

After merging both PRs, verify:

1. The main repository builds successfully: `cargo build -p benches`
2. Main repository benchmarks run: `cargo bench -p benches`
3. This repository builds successfully: `cargo build -p hydro-timely-differential-benches`
4. Comparative benchmarks run: `cargo bench -p hydro-timely-differential-benches`
5. All benchmark results are consistent with previous runs

## Future Additions

When adding new comparative benchmarks against Timely Dataflow or Differential Dataflow:

1. Add the benchmark to this repository (`bigweaver-agent-canary-zeta-hydro-deps`)
2. Update this MIGRATION.md document to list the new benchmark
3. Follow the existing patterns for benchmark structure and naming

## Contact

For questions about this migration or issues running the benchmarks, please refer to the main Hydro project documentation or open an issue in the respective repository.
