# Timely and Differential Dataflow Comparison Benchmarks

This directory contains benchmarks comparing Hydro's performance against Timely Dataflow and Differential Dataflow frameworks.

## Benchmarks

### Core Benchmarks
- **arithmetic**: Tests pipeline arithmetic operations across frameworks
- **fan_in**: Compares fan-in dataflow patterns
- **fan_out**: Compares fan-out dataflow patterns
- **fork_join**: Tests fork-join patterns
- **identity**: Benchmarks identity transformations
- **join**: Compares join operations with different data types (usize, String)
- **reachability**: Tests graph reachability algorithms (includes both Timely and Differential implementations)
- **upcase**: Compares string uppercase operations

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run a specific benchmark:
```bash
cargo bench -p benches --bench reachability
```

Run benchmarks with a specific name pattern:
```bash
cargo bench -p benches reachability/timely
```

## Data Files

- `reachability_edges.txt`: Graph edges for reachability benchmarks
- `reachability_reachable.txt`: Expected reachable nodes for verification
- `words_alpha.txt`: Wordlist from https://github.com/dwyl/english-words/blob/master/words_alpha.txt

## Dependencies

These benchmarks require:
- `timely` (timely-master package v0.13.0-dev.1)
- `differential-dataflow` (differential-dataflow-master package v0.13.0-dev.1)
- `criterion` for benchmark harness
- `dfir_rs` and `sinktools` from the main Hydro repository
