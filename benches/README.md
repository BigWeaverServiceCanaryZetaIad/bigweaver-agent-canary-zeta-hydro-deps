# Timely and Differential-Dataflow Benchmarks

Benchmarks that test Hydro against Timely Dataflow and Differential Dataflow implementations.

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

## Available Benchmarks

- **arithmetic**: Arithmetic operations pipeline comparison
- **fan_in**: Fan-in pattern benchmark
- **fan_out**: Fan-out pattern benchmark
- **fork_join**: Fork-join pattern benchmark
- **identity**: Identity transformation benchmark
- **join**: Join operations benchmark
- **reachability**: Graph reachability benchmark
- **upcase**: String uppercasing benchmark

## Data Files

- `words_alpha.txt`: Wordlist from https://github.com/dwyl/english-words/blob/master/words_alpha.txt
- `reachability_edges.txt`: Graph edges for reachability benchmark
- `reachability_reachable.txt`: Expected reachability results

## Dependencies

These benchmarks require:
- **timely** (timely-master): Core timely dataflow library
- **differential-dataflow** (differential-dataflow-master): Differential dataflow library
- **dfir_rs**: Hydro's dataflow implementation for comparison
- **criterion**: Benchmarking framework
