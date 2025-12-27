# Timely and Differential Dataflow Benchmarks

These benchmarks compare DFIR/Hydro performance against Timely Dataflow and Differential Dataflow frameworks.

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p hydro-deps-benches
```

Run specific benchmarks:
```bash
cargo bench -p hydro-deps-benches --bench reachability
cargo bench -p hydro-deps-benches --bench join
```

## Available Benchmarks

- **arithmetic.rs** - Arithmetic operations
- **fan_in.rs** - Fan-in dataflow patterns
- **fan_out.rs** - Fan-out dataflow patterns  
- **fork_join.rs** - Fork-join patterns
- **identity.rs** - Identity transformations
- **join.rs** - Join operations with various data types
- **reachability.rs** - Graph reachability algorithms
- **upcase.rs** - String transformation operations

## Data Files

- `reachability_edges.txt` - Graph edges for reachability benchmarks
- `reachability_reachable.txt` - Expected reachable nodes

## Note

These benchmarks require dependencies on external dataflow frameworks (Timely and Differential Dataflow) which are not required by the main Hydro repository. They have been separated to keep the main repository's dependency tree minimal.
