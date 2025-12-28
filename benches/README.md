# Timely and Differential Dataflow Benchmarks

This repository contains benchmarks comparing Hydro/DFIR with Timely Dataflow and Differential Dataflow frameworks.

## Benchmarks

The following benchmarks are included:

- **arithmetic**: Basic arithmetic operations comparison
- **fan_in**: Multiple input streams merging comparison
- **fan_out**: Single stream splitting to multiple outputs comparison  
- **fork_join**: Fork and join pattern comparison
- **identity**: Simple identity transformation comparison
- **join**: Join operations with different data types (usize, String)
- **reachability**: Graph reachability algorithms (includes both timely and differential implementations)
- **upcase**: String transformation operations

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p timely-differential-benches
```

Run specific benchmarks:
```bash
cargo bench -p timely-differential-benches --bench reachability
cargo bench -p timely-differential-benches --bench join
```

## Data Files

- `reachability_edges.txt`: Graph edges for reachability benchmarks
- `reachability_reachable.txt`: Expected reachable nodes for validation
- `words_alpha.txt`: English word list from https://github.com/dwyl/english-words/blob/master/words_alpha.txt

## Dependencies

This benchmark suite depends on:
- `timely-master`: Timely Dataflow framework
- `differential-dataflow-master`: Differential Dataflow framework
- `dfir_rs`: Hydro/DFIR framework for comparison
- `criterion`: Benchmarking framework
