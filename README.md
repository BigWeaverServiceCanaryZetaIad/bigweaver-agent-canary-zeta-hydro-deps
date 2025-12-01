# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for the Hydro project that have external dependencies on timely and differential-dataflow packages.

## Benchmarks

The `benches` directory contains microbenchmarks for Hydro and related crates, specifically those that depend on timely and differential-dataflow.

### Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench identity
```

### Available Benchmarks

- **arithmetic**: Pipeline arithmetic operations
- **fan_in**: Fan-in data flow patterns
- **fan_out**: Fan-out data flow patterns
- **fork_join**: Fork-join patterns
- **futures**: Async futures benchmarks
- **identity**: Identity transformation benchmarks
- **join**: Join operation benchmarks
- **micro_ops**: Micro-operations benchmarks
- **reachability**: Graph reachability algorithms
- **symmetric_hash_join**: Symmetric hash join benchmarks
- **upcase**: String case transformation benchmarks
- **words_diamond**: Word processing with diamond pattern

### Performance Comparison

These benchmarks are designed to enable performance comparisons between Hydro and timely/differential-dataflow implementations. The benchmarks retain the ability to run performance comparisons across different implementations.

### Dependencies

The benchmarks depend on:
- **timely**: Timely dataflow system
- **differential-dataflow**: Differential dataflow computations
- **dfir_rs**: Hydro's DFIR runtime (referenced from main repository)
- **criterion**: Benchmarking framework

### Data Files

Some benchmarks use external data files:
- `benches/benches/words_alpha.txt`: English word list from https://github.com/dwyl/english-words
- `benches/benches/reachability_edges.txt`: Graph edges for reachability tests
- `benches/benches/reachability_reachable.txt`: Expected reachability results