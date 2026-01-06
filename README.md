# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks for Hydro that depend on timely and differential-dataflow packages. These benchmarks were moved from the main bigweaver-agent-canary-hydro-zeta repository to manage dependencies separately and maintain a cleaner separation of concerns.

## Purpose

This repository maintains performance testing capabilities for:
- **Timely dataflow benchmarks**: Testing performance with timely-master package
- **Differential dataflow benchmarks**: Testing performance with differential-dataflow-master package

## Benchmarks

The benchmarks in this repository include:

### Timely Dataflow Benchmarks
- `arithmetic.rs` - Pipeline arithmetic operations
- `fan_in.rs` - Fan-in pattern with concatenation
- `fan_out.rs` - Fan-out pattern with mapping
- `fork_join.rs` - Fork-join pattern with filtering
- `identity.rs` - Identity operations pipeline
- `join.rs` - Join operations
- `upcase.rs` - String uppercase transformations

### Differential Dataflow Benchmarks
- `reachability.rs` - Graph reachability computation with iteration

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
```

## Dependencies

The benchmarks depend on:
- `timely-master` (0.13.0-dev.1) - Timely dataflow system
- `differential-dataflow-master` (0.13.0-dev.1) - Differential dataflow system
- `dfir_rs` - Hydro DFIR runtime (from main Hydro repository)
- `sinktools` - Sink utilities (from main Hydro repository)
- `criterion` - Benchmarking framework

## Performance Comparison

These benchmarks maintain the performance comparison functionality from the original repository, allowing you to:
- Track performance changes over time
- Compare different implementations
- Generate HTML reports with criterion

## Relationship to Main Repository

These benchmarks were moved from `bigweaver-agent-canary-hydro-zeta/benches/` to maintain architectural integrity and separate specialized dependencies from the main codebase. The main Hydro repository continues to contain benchmarks that don't require timely or differential-dataflow dependencies.