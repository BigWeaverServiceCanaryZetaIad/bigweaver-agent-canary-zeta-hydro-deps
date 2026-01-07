# Benchmark Migration

This document describes the migration of benchmarks from the bigweaver-agent-canary-hydro-zeta repository to bigweaver-agent-canary-zeta-hydro-deps.

## Overview

The benches directory has been moved from bigweaver-agent-canary-hydro-zeta to bigweaver-agent-canary-zeta-hydro-deps to:
- Separate benchmark-specific dependencies (timely-master, differential-dataflow-master)
- Reduce dependency bloat in the main repository
- Maintain ability to run performance comparisons

## Included Benchmarks

The following benchmarks are available in this repository:

### 1. **join.rs** - Timely Dataflow Join Benchmark
- Uses timely operators for hash join operations
- Compares timely dataflow implementation with native Rust implementation
- Benchmarks with different value types (usize, String)

### 2. **reachability.rs** - Graph Reachability Benchmarks
- Uses both timely and differential-dataflow operators
- Contains two benchmark variants:
  - `benchmark_timely`: Uses timely dataflow operators
  - `benchmark_differential`: Uses differential-dataflow operators (iterate, semijoin, distinct)
- Includes test data files:
  - `reachability_edges.txt`: Graph edges
  - `reachability_reachable.txt`: Expected reachable nodes

### 3. **upcase.rs** - String Transformation Benchmark
- Simple string uppercasing benchmark
- Uses timely dataflow operators

## Dependencies

Key dependencies specified in Cargo.toml:
- `timely = { package = "timely-master", version = "0.13.0-dev.1" }`
- `differential-dataflow = { package = "differential-dataflow-master", version = "0.13.0-dev.1" }`
- `criterion = { version = "0.5.0", features = [ "async_tokio", "html_reports" ] }`

## Running Benchmarks

To run the benchmarks:

```bash
cargo bench
```

To run a specific benchmark:

```bash
cargo bench --bench join
cargo bench --bench reachability
cargo bench --bench upcase
```

## Changes from Original

The following changes were made during migration:
1. Removed path dependencies on `dfir_rs` and `sinktools` (not available in this repository)
2. Modified `reachability.rs` to only include benchmarks that don't depend on dfir_rs:
   - Kept: `benchmark_timely`, `benchmark_differential`
   - Removed: `benchmark_hydroflow_scheduled`, `benchmark_hydroflow`, `benchmark_hydroflow_surface`, `benchmark_hydroflow_surface_cheating`
3. Removed benchmark entries for tests that depend on dfir_rs (arithmetic, fan_in, fan_out, fork_join, identity, micro_ops, symmetric_hash_join, words_diamond, futures)

## Repository Structure

```
benches/
├── Cargo.toml          # Benchmark package configuration
├── README.md           # General benchmark information
├── MIGRATION.md        # This file
├── build.rs            # Build script
└── benches/
    ├── join.rs                     # Join benchmark
    ├── reachability.rs             # Reachability benchmark
    ├── reachability_edges.txt      # Test data
    ├── reachability_reachable.txt  # Test data
    ├── upcase.rs                   # Upcase benchmark
    ├── words_alpha.txt             # Test data
    └── [other benchmark files]
```

## Related Pull Requests

This migration is part of a coordinated change across two repositories:
1. bigweaver-agent-canary-hydro-zeta: Remove benches directory
2. bigweaver-agent-canary-zeta-hydro-deps: Add benches directory (this repository)
