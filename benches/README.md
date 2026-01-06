# Timely and Differential Dataflow Benchmarks

Microbenchmarks for Hydro components that depend on timely and differential-dataflow.

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench identity
```

## Benchmark Categories

### Timely Dataflow Benchmarks
These benchmarks test various patterns using the timely dataflow system:
- **arithmetic** - Pipeline of arithmetic operations
- **fan_in** - Fan-in pattern with concatenation
- **fan_out** - Fan-out pattern with mapping
- **fork_join** - Fork-join pattern with filtering
- **identity** - Identity operations pipeline
- **join** - Join operations between streams
- **upcase** - String uppercase transformations

### Differential Dataflow Benchmarks
These benchmarks test differential dataflow capabilities:
- **reachability** - Graph reachability computation using iteration

## Data Files

- `reachability_edges.txt` - Edge list for reachability benchmark
- `reachability_reachable.txt` - Expected reachable nodes for validation

## Dependencies

These benchmarks require specialized dependencies:
- `timely-master` (package = timely-master)
- `differential-dataflow-master` (package = differential-dataflow-master)
