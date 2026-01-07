# Timely and Differential Dataflow Benchmarks

This package contains performance comparison benchmarks between Hydro and Timely/Differential Dataflow frameworks.

## Benchmarks

The following benchmarks compare Hydro implementations with their Timely/Differential Dataflow equivalents:

- **arithmetic**: Basic arithmetic operations
- **fan_in**: Fan-in dataflow patterns
- **fan_out**: Fan-out dataflow patterns
- **fork_join**: Fork-join patterns
- **identity**: Identity transformation
- **join**: Join operations with different data types (usize and String)
- **reachability**: Graph reachability algorithms (includes both Timely and Differential implementations)
- **upcase**: String uppercase transformation

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p hydro-deps-benches
```

Run a specific benchmark:
```bash
cargo bench -p hydro-deps-benches --bench reachability
```

## Migration Notice

These benchmarks were moved from the main Hydro repository to maintain performance comparison capabilities while removing direct dependencies on `timely` and `differential-dataflow` packages from the main codebase. This separation allows for cleaner dependency management while retaining the ability to run performance comparisons when needed.

## Data Files

- `reachability_edges.txt`: Edge data for graph reachability benchmarks
- `reachability_reachable.txt`: Expected reachable vertices for validation
