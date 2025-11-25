# Timely and Differential-Dataflow Benchmarks

Microbenchmarks comparing Hydro performance with Timely Dataflow and Differential Dataflow.

## About

This directory contains benchmarks that were moved from the main `bigweaver-agent-canary-hydro-zeta` repository to isolate dependencies on `timely` and `differential-dataflow` packages. This separation helps keep the main repository lean while maintaining the ability to run performance comparisons.

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench join
```

## Available Benchmarks

### Timely Dataflow Benchmarks
- **arithmetic** - Sequential arithmetic operations
- **fan_in** - Multiple streams combining into one
- **fan_out** - One stream splitting into multiple
- **fork_join** - Fork and join patterns
- **identity** - Identity transformation (passthrough)
- **join** - Join operations between streams
- **upcase** - String uppercase transformations

### Differential Dataflow Benchmarks
- **reachability** - Graph reachability using differential dataflow iterative computation

## Benchmark Data

- `reachability_edges.txt` - Edge data for reachability benchmark
- `reachability_reachable.txt` - Expected reachable nodes for validation
- `words_alpha.txt` - English word list from https://github.com/dwyl/english-words

## Dependencies

These benchmarks require:
- `timely-master` (0.13.0-dev.1)
- `differential-dataflow-master` (0.13.0-dev.1)
- `dfir_rs` (from main hydro repository)
- `criterion` (for benchmark infrastructure)
