# Timely and Differential Dataflow Benchmarks

Performance comparison benchmarks between Hydro (dfir_rs) and Timely/Differential Dataflow.

These benchmarks were moved from the main Hydro repository to isolate the dependencies on
timely and differential-dataflow packages while retaining performance comparison functionality.

## Running Benchmarks

Run all benchmarks:
```
cargo bench -p timely-differential-benches
```

Run specific benchmarks:
```
cargo bench -p timely-differential-benches --bench reachability
cargo bench -p timely-differential-benches --bench arithmetic
```

## Benchmarks

- **arithmetic** - Pipeline arithmetic operations comparison
- **fan_in** - Fan-in pattern benchmark
- **fan_out** - Fan-out pattern benchmark
- **fork_join** - Fork-join pattern benchmark
- **identity** - Identity transformation benchmark
- **join** - Join operations benchmark
- **reachability** - Graph reachability algorithm comparison
- **upcase** - String uppercase transformation benchmark

## Data Sources

- Wordlist is from https://github.com/dwyl/english-words/blob/master/words_alpha.txt
