# bigweaver-agent-canary-zeta-hydro-deps

This repository contains dependencies and benchmarks for the Hydro project that require external dependencies like `timely` and `differential-dataflow`.

## Benchmarks

The `benches` directory contains performance benchmarks comparing Hydro (dfir_rs) with Timely Dataflow and Differential Dataflow.

### Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench identity
cargo bench -p benches --bench join
```

### Available Benchmarks

- **arithmetic**: Arithmetic operations benchmarks
- **fan_in**: Fan-in dataflow pattern benchmarks
- **fan_out**: Fan-out dataflow pattern benchmarks
- **fork_join**: Fork-join pattern benchmarks
- **futures**: Async futures benchmarks
- **identity**: Identity/pass-through benchmarks
- **join**: Join operation benchmarks
- **micro_ops**: Micro-operations benchmarks
- **reachability**: Graph reachability benchmarks
- **symmetric_hash_join**: Symmetric hash join benchmarks
- **upcase**: String uppercase transformation benchmarks
- **words_diamond**: Word processing diamond pattern benchmarks

### Performance Comparison

These benchmarks are designed to compare the performance of:
- Hydro (dfir_rs)
- Timely Dataflow
- Differential Dataflow

Each benchmark implements equivalent operations across these systems to enable direct performance comparisons.

### Dependencies

The benchmarks depend on:
- `timely-master`: Timely Dataflow (version 0.13.0-dev.1)
- `differential-dataflow-master`: Differential Dataflow (version 0.13.0-dev.1)
- `dfir_rs`: Hydro's dataflow runtime (from adjacent repository)
- `criterion`: Benchmarking framework

### Data Files

Some benchmarks use external data files:
- `benches/benches/words_alpha.txt`: English word list from [dwyl/english-words](https://github.com/dwyl/english-words/blob/master/words_alpha.txt)
- `benches/benches/reachability_edges.txt`: Graph edges for reachability benchmark
- `benches/benches/reachability_reachable.txt`: Expected reachable nodes for verification