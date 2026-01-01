# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks for the Hydro project, including performance comparisons with Timely Dataflow and Differential Dataflow.

## Benchmarks

The `benches` directory contains microbenchmarks for Hydro and other crates.

### Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench upcase
```

### Available Benchmarks

- **arithmetic.rs**: Arithmetic operation benchmarks
- **reachability.rs**: Graph reachability algorithm benchmarks
- **upcase.rs**: String uppercase operation benchmarks
- **join.rs**: Join operation benchmarks
- **symmetric_hash_join.rs**: Symmetric hash join benchmarks
- **micro_ops.rs**: Micro-operation benchmarks (map, flat_map, union, tee, fold, sort, etc.)
- **fan_in.rs** / **fan_out.rs**: Fan-in and fan-out pattern benchmarks
- **fork_join.rs**: Fork-join pattern benchmarks
- **identity.rs**: Identity operation benchmarks
- **words_diamond.rs**: Word processing diamond pattern benchmarks
- **futures.rs**: Async futures benchmarks

### Dependencies

This repository depends on:
- `dfir_rs` from the main Hydro repository
- `sinktools` from the main Hydro repository
- `timely-master`: Timely Dataflow
- `differential-dataflow-master`: Differential Dataflow
- `criterion`: Benchmarking framework

### Data Files

The benchmarks include test data files:
- `reachability_edges.txt`: Graph edges for reachability tests
- `reachability_reachable.txt`: Expected reachable nodes
- `words_alpha.txt`: English word list from [dwyl/english-words](https://github.com/dwyl/english-words/blob/master/words_alpha.txt)
