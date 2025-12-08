# Timely and Differential-Dataflow Benchmarks

This repository contains benchmarks for Hydro that depend on the `timely` and `differential-dataflow` packages.

These benchmarks were migrated from the main Hydro repository to avoid polluting it with unnecessary dependencies while retaining the ability to run performance comparisons.

## Running Benchmarks

Run all benchmarks:
```
cargo bench -p hydro-timely-benchmarks
```

Run specific benchmarks:
```
cargo bench -p hydro-timely-benchmarks --bench reachability
```

## Available Benchmarks

- `arithmetic`: Arithmetic operations benchmarks comparing different execution models
- `fan_in`: Fan-in pattern benchmarks
- `fan_out`: Fan-out pattern benchmarks
- `fork_join`: Fork-join pattern benchmarks
- `identity`: Identity operation benchmarks
- `join`: Join operation benchmarks
- `reachability`: Graph reachability benchmarks
- `upcase`: String uppercase transformation benchmarks

## Data Files

Wordlist is from https://github.com/dwyl/english-words/blob/master/words_alpha.txt
