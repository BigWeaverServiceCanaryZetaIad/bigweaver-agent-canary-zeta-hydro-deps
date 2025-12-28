# Timely and Differential Dataflow Benchmarks

This repository contains benchmarks comparing Hydro performance with Timely Dataflow and Differential Dataflow.

These benchmarks were moved from the main bigweaver-agent-canary-hydro-zeta repository to avoid including timely and differential-dataflow as dependencies in the main codebase.

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

- `arithmetic` - Pipeline arithmetic operations
- `fan_in` - Fan-in dataflow patterns
- `fan_out` - Fan-out dataflow patterns
- `fork_join` - Fork-join patterns
- `identity` - Identity transformation
- `join` - Join operations
- `reachability` - Graph reachability algorithms
- `upcase` - String uppercasing operations

## Data Files

- `words_alpha.txt` - From https://github.com/dwyl/english-words/blob/master/words_alpha.txt
- `reachability_edges.txt` - Graph edges for reachability benchmark
- `reachability_reachable.txt` - Expected reachable nodes for reachability benchmark
