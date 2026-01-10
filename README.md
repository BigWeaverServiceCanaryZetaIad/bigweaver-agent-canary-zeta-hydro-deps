# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks for the Hydro project that depend on timely-dataflow and differential-dataflow. These benchmarks were separated from the main `bigweaver-agent-canary-hydro-zeta` repository to reduce dependencies and improve build times in the main repository.

## Benchmarks

The repository contains microbenchmarks for Hydro and related crates. These benchmarks test various aspects of dataflow performance including:

- **arithmetic.rs**: Arithmetic operations benchmarks
- **fan_in.rs**: Fan-in pattern benchmarks
- **fan_out.rs**: Fan-out pattern benchmarks
- **fork_join.rs**: Fork-join pattern benchmarks
- **futures.rs**: Futures-based operations
- **identity.rs**: Identity operation benchmarks
- **join.rs**: Join operation benchmarks
- **micro_ops.rs**: Micro-operation benchmarks
- **reachability.rs**: Graph reachability benchmarks
- **symmetric_hash_join.rs**: Symmetric hash join benchmarks
- **upcase.rs**: String transformation benchmarks
- **words_diamond.rs**: Word processing with diamond pattern

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

## Dependencies

The benchmarks depend on:
- **timely-dataflow**: For timely dataflow processing
- **differential-dataflow**: For differential dataflow processing
- **dfir_rs**: Referenced from the main Hydro repository
- **sinktools**: Referenced from the main Hydro repository

## Data Files

The benchmark suite includes test data files:
- `words_alpha.txt`: English word list from https://github.com/dwyl/english-words
- `reachability_edges.txt`: Graph edges for reachability tests
- `reachability_reachable.txt`: Expected reachability results

## Performance Comparison

These benchmarks maintain the ability to run performance comparisons even though they're in a separate repository. Results can be compared with historical data from the main repository.