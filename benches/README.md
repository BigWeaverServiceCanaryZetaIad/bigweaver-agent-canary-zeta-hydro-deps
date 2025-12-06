# Timely and Differential-Dataflow Benchmarks

Microbenchmarks for Hydro that depend on timely-dataflow and differential-dataflow.

These benchmarks were moved from the main Hydro repository to allow the main repository
to avoid heavy dependencies on timely-next and differential-dataflow packages.

## Running Benchmarks

Run all benchmarks:
```
cargo bench -p benches
```

Run specific benchmarks:
```
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench join
```

## Available Benchmarks

- **arithmetic** - Basic arithmetic operations benchmark
- **fan_in** - Fan-in dataflow pattern benchmark
- **fan_out** - Fan-out dataflow pattern benchmark
- **fork_join** - Fork-join pattern benchmark
- **identity** - Identity operation benchmark
- **join** - Join operation benchmark
- **reachability** - Graph reachability benchmark (uses differential-dataflow)
- **upcase** - String uppercase transformation benchmark

## Performance Comparisons

To compare performance between different versions or configurations:

1. Run benchmarks in this repository (with timely/differential-dataflow)
2. Run benchmarks in the main repository (non-timely benchmarks only)
3. Use Criterion's comparison features to analyze results

## Data Files

- `reachability_edges.txt` - Edge data for reachability benchmark
- `reachability_reachable.txt` - Expected reachable nodes for reachability benchmark
