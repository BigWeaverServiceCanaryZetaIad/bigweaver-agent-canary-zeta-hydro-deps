# Timely and Differential Dataflow Benchmarks

Comparative benchmarks for Hydro against Timely Dataflow and Differential Dataflow.

These benchmarks were moved from the main Hydro repository to reduce the dependency footprint and improve maintainability.

## Running Benchmarks

Run all benchmarks:
```
cargo bench
```

Run specific benchmarks:
```
cargo bench --bench reachability
cargo bench --bench fork_join
cargo bench --bench arithmetic
cargo bench --bench fan_in
cargo bench --bench fan_out
cargo bench --bench identity
cargo bench --bench join
cargo bench --bench upcase
```

## Available Benchmarks

- **arithmetic**: Pipeline operations benchmark comparing Hydro, Timely, and raw implementations
- **fan_in**: Fan-in pattern benchmark
- **fan_out**: Fan-out pattern benchmark
- **fork_join**: Fork-join pattern benchmark with Hydro and Timely comparisons
- **identity**: Identity operations benchmark
- **join**: Join operations benchmark
- **reachability**: Graph reachability benchmark comparing Hydro, Timely, and Differential Dataflow
- **upcase**: String uppercase transformation benchmark

## Data Files

- `reachability_edges.txt`: Edge list for reachability benchmark
- `reachability_reachable.txt`: Expected reachable nodes for validation
- `words_alpha.txt`: Word list from https://github.com/dwyl/english-words/blob/master/words_alpha.txt
