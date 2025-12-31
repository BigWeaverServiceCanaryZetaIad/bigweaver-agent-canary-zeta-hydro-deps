# Microbenchmarks

Of Hydro and other crates.

## Running Benchmarks

Run all benchmarks from the benches directory:
```
cd benches
cargo bench
```

Run specific benchmarks:
```
cd benches
cargo bench --bench reachability
```

Or run from the repository root:
```
cargo bench -p benches
```

Run specific benchmark:
```
cargo bench -p benches --bench reachability
```

## Performance Comparisons

These benchmarks enable performance comparisons between DFIR and timely/differential-dataflow frameworks.

Wordlist is from https://github.com/dwyl/english-words/blob/master/words_alpha.txt
