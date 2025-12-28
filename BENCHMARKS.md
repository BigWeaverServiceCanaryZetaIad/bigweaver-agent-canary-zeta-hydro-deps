# Benchmark Organization

This document explains how benchmarks are organized in the Hydro project.

## Background

Previously, all benchmarks were located in a single `benches` directory in the main Hydro repository. This included both:
1. Benchmarks specific to Hydro functionality
2. Benchmarks comparing Hydro with Timely Dataflow and Differential Dataflow

The latter group required dependencies on `timely` and `differential-dataflow` packages, which were not needed for core Hydro development.

## Current Organization

Benchmarks are now split across two repositories:

### 1. bigweaver-agent-canary-hydro-zeta (This Repository)

**Location**: `benches/`

**Contains**: Benchmarks for Hydro-specific functionality that don't require external dataflow framework dependencies.

**Benchmarks**:
- `futures.rs` - Async/await and future handling
- `micro_ops.rs` - Micro-operations (map, flat_map, filter, fold, etc.)
- `symmetric_hash_join.rs` - Symmetric hash join operations
- `words_diamond.rs` - Diamond-pattern dataflow with word processing

**Running**:
```bash
cargo bench -p benches
```

**CI/CD**: Runs via `.github/workflows/benchmark.yml`

### 2. bigweaver-agent-canary-zeta-hydro-deps

**Location**: `benches/`

**Contains**: Benchmarks comparing Hydro with Timely Dataflow and Differential Dataflow.

**Benchmarks**:
- `arithmetic.rs` - Pipeline operation benchmarks
- `fan_in.rs` - Fan-in pattern benchmarks
- `fan_out.rs` - Fan-out pattern benchmarks
- `fork_join.rs` - Fork-join pattern benchmarks
- `identity.rs` - Identity operation benchmarks
- `join.rs` - Join operation benchmarks
- `reachability.rs` - Graph reachability benchmarks
- `upcase.rs` - String uppercase operation benchmarks

**Running**:
```bash
# From the hydro-deps repository
cargo bench -p benches
```

**CI/CD**: Runs via `.github/workflows/benchmark.yml` in that repository

## Dependencies

The hydro-deps benchmarks depend on:
- `dfir_rs` and `sinktools` from the main Hydro repository (via relative path)
- `timely-master` and `differential-dataflow-master` packages
- Standard benchmark dependencies (criterion, futures, etc.)

## Rationale for Split

1. **Cleaner Dependencies**: The main Hydro repository no longer needs timely/differential-dataflow dependencies
2. **Faster Builds**: Developers working on core Hydro don't need to build external framework dependencies
3. **Clear Separation**: Makes it explicit which benchmarks are framework comparisons vs. internal benchmarks
4. **Easier Maintenance**: Each repository can evolve its benchmarks independently

## Migration Details

The following files were moved from `bigweaver-agent-canary-hydro-zeta/benches/benches/` to `bigweaver-agent-canary-zeta-hydro-deps/benches/benches/`:
- All `.rs` benchmark files that used timely or differential-dataflow
- Associated data files (`reachability_edges.txt`, `reachability_reachable.txt`)
- A copy of `words_alpha.txt` (also kept in main repo for `words_diamond.rs`)
- The `build.rs` script (used by `fork_join.rs`)

The main repository's `benches/Cargo.toml` was updated to:
- Remove `timely` and `differential-dataflow` dependencies
- Remove `seq-macro`, `static_assertions`, and `sinktools` dependencies (no longer needed)
- Remove benchmark targets for moved benchmarks

## Running All Benchmarks

To run the complete benchmark suite:

1. From the main repository:
```bash
cd bigweaver-agent-canary-hydro-zeta
cargo bench -p benches
```

2. From the hydro-deps repository:
```bash
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench -p benches
```

## CI/CD Integration

Both repositories have their own benchmark workflows:
- Main repository: Runs Hydro-specific benchmarks
- Hydro-deps repository: Runs Timely/Differential comparison benchmarks

Both can be triggered with `[ci-bench]` in commit messages or PR titles/bodies.
