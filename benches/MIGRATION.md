# Benchmark Migration Documentation

## Overview

The timely and differential-dataflow benchmarks have been moved from the main `bigweaver-agent-canary-hydro-zeta` repository to this `bigweaver-agent-canary-zeta-hydro-deps` repository.

## Motivation

1. **Dependency Separation**: Remove timely and differential-dataflow from the main repository's dependency tree
2. **Build Performance**: Reduce build times for the main repository
3. **Cleaner Architecture**: Separate external comparison benchmarks from core development
4. **Focused Development**: Allow the main repository to focus on Hydro/DFIR development without external dataflow dependencies

## What Was Moved

The following benchmarks were moved from `bigweaver-agent-canary-hydro-zeta/benches`:

### Benchmarks Using Timely/Differential
- `arithmetic.rs` - Arithmetic pipeline operations
- `fan_in.rs` - Fan-in patterns
- `fan_out.rs` - Fan-out patterns
- `fork_join.rs` - Fork-join patterns
- `identity.rs` - Identity operations
- `join.rs` - Join operations
- `reachability.rs` - Graph reachability
- `upcase.rs` - String operations

### Benchmarks Without Timely/Differential
- `futures.rs` - Async futures benchmarks
- `micro_ops.rs` - Micro-operation benchmarks
- `symmetric_hash_join.rs` - Hash join benchmarks
- `words_diamond.rs` - Diamond pattern benchmarks

All benchmarks were moved to maintain the ability to run performance comparisons, even though not all directly use timely/differential-dataflow.

## Dependencies Removed

From the main repository's `benches/Cargo.toml`:
```toml
differential-dataflow = { package = "differential-dataflow-master", version = "0.13.0-dev.1" }
timely = { package = "timely-master", version = "0.13.0-dev.1" }
```

## Running Benchmarks Post-Migration

### In the deps repository (this repository)
```bash
# Clone this repository
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps
cd bigweaver-agent-canary-zeta-hydro-deps

# Run all benchmarks
cargo bench -p benches

# Run specific benchmark
cargo bench -p benches --bench reachability
```

### Cross-Repository Comparisons

To compare Hydro benchmarks from the main repository with these external benchmarks:

1. Run Hydro-native benchmarks in the main repository
2. Run comparison benchmarks in this repository  
3. Compare results manually or with benchmark tooling

## Maintenance Notes

- The benchmarks in this repository depend on the main Hydro repository via git dependencies
- Updates to `dfir_rs` or `sinktools` in the main repository will automatically be picked up
- Benchmark results should be tracked separately from the main repository's performance metrics

## References

- Main repository: `bigweaver-agent-canary-hydro-zeta`
- This repository: `bigweaver-agent-canary-zeta-hydro-deps`
- Related issue/PR: (to be filled in)
