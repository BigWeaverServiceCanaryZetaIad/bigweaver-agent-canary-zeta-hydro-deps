# Microbenchmarks

Benchmarks for Hydro using timely and differential-dataflow.

These benchmarks were moved from the main Hydro repository to keep the main repository focused on core functionality while providing performance comparison capabilities against timely and differential-dataflow.

## Running Benchmarks

Run all benchmarks:
```
cargo bench -p benches
```

Run specific benchmarks:
```
cargo bench -p benches --bench reachability
```

## Requirements

This benchmark suite requires the following dependencies:
- timely-master
- differential-dataflow-master
- dfir_rs (from main Hydro repository)
- sinktools (from main Hydro repository)

## Note

Wordlist is from https://github.com/dwyl/english-words/blob/master/words_alpha.txt
