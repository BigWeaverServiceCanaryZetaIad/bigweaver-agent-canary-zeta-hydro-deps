# Timely and Differential Dataflow Benchmarks

This directory contains performance comparison benchmarks for Hydro against Timely Dataflow and Differential Dataflow.

These benchmarks were moved from the main Hydro repository to maintain functionality while reducing dependencies in the primary codebase.

## Running Benchmarks

Run all benchmarks:
```
cargo bench -p hydro-deps-benches
```

Run specific benchmarks:
```
cargo bench -p hydro-deps-benches --bench reachability
cargo bench -p hydro-deps-benches --bench join
cargo bench -p hydro-deps-benches --bench arithmetic
cargo bench -p hydro-deps-benches --bench fan_in
cargo bench -p hydro-deps-benches --bench fan_out
cargo bench -p hydro-deps-benches --bench fork_join
cargo bench -p hydro-deps-benches --bench identity
cargo bench -p hydro-deps-benches --bench upcase
```

## Benchmark Files

The following benchmarks compare Hydro performance against Timely and Differential Dataflow:

- **reachability.rs** - Graph reachability algorithms
- **join.rs** - Join operations with different data types
- **arithmetic.rs** - Arithmetic operations
- **fan_in.rs** - Fan-in dataflow patterns
- **fan_out.rs** - Fan-out dataflow patterns
- **fork_join.rs** - Fork-join patterns
- **identity.rs** - Identity transformations
- **upcase.rs** - String case transformations

## Data Files

- `reachability_edges.txt` - Graph edge data for reachability benchmarks
- `reachability_reachable.txt` - Expected reachable nodes for validation
