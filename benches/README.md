# Timely and Differential-Dataflow Benchmarks

Microbenchmarks for Hydro that depend on timely and differential-dataflow packages.

## Running Benchmarks

Run all benchmarks:
```
cargo bench -p benches
```

Run specific benchmarks:
```
cargo bench -p benches --bench reachability
cargo bench -p benches --bench join
cargo bench -p benches --bench fan_in
```

## Available Benchmarks

- **arithmetic.rs** - Arithmetic operations benchmark using timely
- **fan_in.rs** - Fan-in dataflow pattern benchmark using timely
- **fan_out.rs** - Fan-out dataflow pattern benchmark using timely
- **fork_join.rs** - Fork-join pattern benchmark using timely
- **identity.rs** - Identity operation benchmark using timely
- **join.rs** - Join operations benchmark using timely
- **reachability.rs** - Graph reachability benchmark using differential-dataflow
- **upcase.rs** - Uppercase transformation benchmark using timely

## Data Files

- **reachability_edges.txt** - Input edges for reachability benchmark
- **reachability_reachable.txt** - Expected reachable nodes for validation
