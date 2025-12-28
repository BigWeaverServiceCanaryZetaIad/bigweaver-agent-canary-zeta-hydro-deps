# Benchmark Migration Notes

## Overview

This document describes the migration of Timely Dataflow and Differential Dataflow benchmarks from the main Hydro repository to the dedicated `bigweaver-agent-canary-zeta-hydro-deps` repository.

## Motivation

The main Hydro repository (`bigweaver-agent-canary-hydro-zeta`) focuses on core Hydro/DFIR functionality. However, performance comparison benchmarks required dependencies on `timely` and `differential-dataflow` packages, which are not needed for the core functionality.

To avoid these unnecessary dependencies while maintaining the ability to run performance comparisons, these benchmarks have been moved to a separate repository.

## What Was Moved

### Benchmarks Moved to bigweaver-agent-canary-zeta-hydro-deps

The following benchmark files were moved from `bigweaver-agent-canary-hydro-zeta/benches/` to `bigweaver-agent-canary-zeta-hydro-deps/benches/`:

- `arithmetic.rs` - Basic arithmetic operations benchmarks
- `fan_in.rs` - Fan-in pattern benchmarks
- `fan_out.rs` - Fan-out pattern benchmarks
- `fork_join.rs` - Fork-join pattern benchmarks
- `identity.rs` - Identity transformation benchmarks
- `join.rs` - Hash join operations with different data types
- `reachability.rs` - Graph reachability algorithm benchmarks
- `upcase.rs` - String uppercasing benchmarks
- `reachability_edges.txt` - Test data for reachability benchmarks
- `reachability_reachable.txt` - Expected results for reachability benchmarks
- `build.rs` - Build script for generating fork_join benchmark code

### Benchmarks Remaining in bigweaver-agent-canary-hydro-zeta

These benchmarks do not depend on timely/differential and remain in the main repository:

- `futures.rs` - Async/futures benchmarks
- `micro_ops.rs` - Micro-operation benchmarks
- `symmetric_hash_join.rs` - Symmetric hash join benchmarks
- `words_diamond.rs` - Diamond pattern benchmarks with word data
- `words_alpha.txt` - Word list data file

## Dependencies Removed

From `bigweaver-agent-canary-hydro-zeta/benches/Cargo.toml`:

```toml
differential-dataflow = { package = "differential-dataflow-master", version = "0.13.0-dev.1" }
timely = { package = "timely-master", version = "0.13.0-dev.1" }
```

## Running Benchmarks After Migration

### Main Repository Benchmarks

From the `bigweaver-agent-canary-hydro-zeta` repository:

```bash
# Run all remaining benchmarks
cargo bench -p benches

# Run specific benchmarks
cargo bench -p benches --bench micro_ops
cargo bench -p benches --bench symmetric_hash_join
cargo bench -p benches --bench words_diamond
cargo bench -p benches --bench futures
```

### Timely/Differential Comparison Benchmarks

From the `bigweaver-agent-canary-zeta-hydro-deps` repository:

```bash
# Run all comparison benchmarks
cargo bench -p timely-differential-benches

# Run specific comparison benchmarks
cargo bench -p timely-differential-benches --bench reachability
cargo bench -p timely-differential-benches --bench join
cargo bench -p timely-differential-benches --bench arithmetic
cargo bench -p timely-differential-benches --bench fan_in
cargo bench -p timely-differential-benches --bench fan_out
cargo bench -p timely-differential-benches --bench fork_join
cargo bench -p timely-differential-benches --bench identity
cargo bench -p timely-differential-benches --bench upcase
```

## Performance Comparison Workflow

To run complete performance comparisons between Hydro/DFIR and Timely/Differential:

1. Clone both repositories:
   ```bash
   git clone https://github.com/hydro-project/bigweaver-agent-canary-hydro-zeta.git
   git clone https://github.com/hydro-project/bigweaver-agent-canary-zeta-hydro-deps.git
   ```

2. Run main repository benchmarks:
   ```bash
   cd bigweaver-agent-canary-hydro-zeta
   cargo bench -p benches
   ```

3. Run comparison benchmarks:
   ```bash
   cd ../bigweaver-agent-canary-zeta-hydro-deps
   cargo bench -p timely-differential-benches
   ```

4. Compare results from the generated Criterion reports in `target/criterion/`

## Integration with dfir_rs and sinktools

The moved benchmarks reference `dfir_rs` and `sinktools` from the main Hydro repository via git dependencies:

```toml
dfir_rs = { git = "https://github.com/hydro-project/hydro.git", features = [ "debugging" ] }
sinktools = { git = "https://github.com/hydro-project/hydro.git", version = "^0.0.1" }
```

This ensures the benchmarks always use the latest versions from the main repository without requiring local path dependencies.

## Maintaining Both Repositories

When making changes that affect benchmarks:

1. **Changes to Hydro/DFIR core**: Make in `bigweaver-agent-canary-hydro-zeta`
2. **Changes to benchmark implementations**: 
   - For non-comparison benchmarks: `bigweaver-agent-canary-hydro-zeta/benches`
   - For timely/differential comparisons: `bigweaver-agent-canary-zeta-hydro-deps/benches`
3. **Adding new comparison benchmarks**: Add to `bigweaver-agent-canary-zeta-hydro-deps`
4. **Adding new Hydro-only benchmarks**: Add to `bigweaver-agent-canary-hydro-zeta/benches`

## Benefits

1. **Reduced dependencies**: The main repository no longer requires timely/differential packages
2. **Faster builds**: Main repository builds are faster without external dataflow dependencies
3. **Cleaner separation**: Core functionality is separate from comparison benchmarks
4. **Maintained comparisons**: Performance comparison capability is fully retained
5. **Clearer purpose**: Each repository has a well-defined scope

## Migration Date

This migration was completed on December 28, 2024.
