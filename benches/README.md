# Microbenchmarks

Benchmarks for Hydro and related crates, including timely-dataflow and differential-dataflow.

**Note**: These benchmarks have been moved from the main Hydro repository to keep timely and differential-dataflow dependencies separate.

## Running Benchmarks

Run all benchmarks:
```
cargo bench -p benches
```

Run specific benchmarks:
```
cargo bench -p benches --bench reachability
```

## Data Files

Wordlist is from https://github.com/dwyl/english-words/blob/master/words_alpha.txt
