# Timely and Differential-Dataflow Benchmarks

Benchmarks for comparing performance between Hydro and timely/differential-dataflow implementations.

These benchmarks were moved from the main hydro repository to isolate external dependencies and maintain a clean separation of concerns.

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p hydro-deps-benches
```

Run specific benchmarks:
```bash
cargo bench -p hydro-deps-benches --bench reachability
```

## Available Benchmarks

- **arithmetic**: Basic arithmetic operations benchmark
- **fan_in**: Fan-in pattern benchmark
- **fan_out**: Fan-out pattern benchmark
- **fork_join**: Fork-join pattern benchmark
- **identity**: Identity operation benchmark
- **join**: Join operation benchmark
- **reachability**: Graph reachability benchmark
- **upcase**: String uppercase operation benchmark

Each benchmark compares implementations across:
- Timely dataflow
- Differential dataflow
- Hydro (dfir_rs)

## Data Files

- `reachability_edges.txt`: Graph edges data for reachability benchmark
- `reachability_reachable.txt`: Expected reachable nodes for verification
