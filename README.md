# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks comparing Hydro (DFIR) performance with Timely and Differential Dataflow implementations.

## Running Benchmarks

To run all benchmarks:
```bash
cargo bench -p benches
```

To run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench fork_join
```

## Benchmark Categories

The benchmarks include comparisons for:
- Graph reachability algorithms
- Fork-join patterns
- Various micro-operations (map, flat_map, union, etc.)
- Join operations
- Data transformation patterns

## Dependencies

The benchmarks depend on:
- `dfir_rs` from the sibling `bigweaver-agent-canary-hydro-zeta` repository
- `timely-master` for Timely Dataflow comparisons
- `differential-dataflow-master` for Differential Dataflow comparisons
