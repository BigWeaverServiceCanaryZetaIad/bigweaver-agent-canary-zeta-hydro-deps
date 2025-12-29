# Timely and Differential Dataflow Benchmarks

Benchmarks for comparing Hydro performance with Timely and Differential Dataflow.

These benchmarks have been separated from the main Hydro repository to avoid including heavy dependencies like `timely` and `differential-dataflow` in the core repository.

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
```

## Benchmarks

This repository contains the following benchmarks that compare Hydro with Timely/Differential Dataflow:

- **arithmetic**: Arithmetic operations pipeline comparison
- **fan_in**: Fan-in pattern performance
- **fan_out**: Fan-out pattern performance  
- **fork_join**: Fork-join pattern performance
- **identity**: Identity dataflow performance
- **join**: Join operations performance
- **reachability**: Graph reachability computation
- **upcase**: String uppercase operations

## Data Files

- `reachability_edges.txt` - Graph edges for reachability benchmark
- `reachability_reachable.txt` - Expected reachable nodes
- `words_alpha.txt` - Word list from https://github.com/dwyl/english-words/blob/master/words_alpha.txt

## Relation to Main Repository

These benchmarks use dependencies from the main [Hydro repository](https://github.com/hydro-project/hydro):
- `dfir_rs` - DFIR runtime
- `sinktools` - Sink utilities

The benchmarks can be used to compare performance between Hydro and Timely/Differential Dataflow implementations.
