# Timely and Differential Dataflow Benchmarks

This directory contains benchmarks that compare Hydro/dfir_rs performance against Timely Dataflow and Differential Dataflow.

These benchmarks are maintained in a separate repository to avoid adding timely and differential-dataflow as dependencies to the main Hydro repository.

## Running Benchmarks

Run all benchmarks:
```
cargo bench -p benches
```

Run specific benchmarks:
```
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
```

## Available Benchmarks

### Timely Dataflow Comparisons
- `arithmetic` - Basic arithmetic operations
- `fan_in` - Data aggregation patterns
- `fan_out` - Data distribution patterns
- `fork_join` - Fork-join parallelism patterns
- `identity` - Identity transformation
- `join` - Stream joining operations
- `upcase` - String transformation

### Differential Dataflow Comparisons
- `reachability` - Graph reachability computation

## Data Files

- `reachability_edges.txt` - Edge data for reachability benchmark
- `reachability_reachable.txt` - Expected reachability results
