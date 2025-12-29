# Timely and Differential Dataflow Benchmarks

This directory contains benchmarks that compare DFIR/Hydro performance with Timely Dataflow and Differential Dataflow implementations.

These benchmarks were moved from the `bigweaver-agent-canary-hydro-zeta` repository to reduce compilation dependencies in the main codebase while maintaining the ability to run cross-implementation performance comparisons.

## Included Benchmarks

- **arithmetic.rs** - Basic arithmetic operations and data pipeline transformations
- **fan_in.rs** - Multiple input merging patterns
- **fan_out.rs** - Single to multiple output distribution
- **fork_join.rs** - Fork and join patterns
- **identity.rs** - Identity transformation operations
- **join.rs** - Join operations with different data types
- **reachability.rs** - Graph reachability algorithms with edge data
- **upcase.rs** - String transformation operations

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p timely-differential-benches
```

Run specific benchmarks:
```bash
cargo bench -p timely-differential-benches --bench reachability
cargo bench -p timely-differential-benches --bench arithmetic
```

## Dependencies

The benchmarks require:
- `timely` (package: "timely-master", version: "0.13.0-dev.1")
- `differential-dataflow` (package: "differential-dataflow-master", version: "0.13.0-dev.1")
- `dfir_rs` (from bigweaver-agent-canary-hydro-zeta repository)
- `sinktools` (from bigweaver-agent-canary-hydro-zeta repository)
- `criterion` for benchmarking infrastructure

## Cross-Repository Benchmarking

To run cross-repository benchmark comparisons:

1. Clone both `bigweaver-agent-canary-hydro-zeta` and `bigweaver-agent-canary-zeta-hydro-deps` side-by-side
2. Optionally configure path dependencies in `Cargo.toml` for local development
3. Run benchmarks from this directory

## Data Files

- **reachability_edges.txt** - Edge data for graph reachability benchmarks
- **reachability_reachable.txt** - Expected reachable nodes for validation
