# Microbenchmarks

Performance benchmarks for Hydro that depend on timely and differential-dataflow packages.

These benchmarks have been separated into this repository to maintain clean dependency boundaries in the main Hydro repository.

## Running Benchmarks

Run all benchmarks:
```
cargo bench -p benches
```

Run specific benchmarks:
```
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
```

## Benchmarks

- **arithmetic**: Comparison of arithmetic operations across different implementations (timely, hydroflow, raw)
- **fan_in/fan_out**: Data flow patterns with multiple inputs/outputs
- **fork_join**: Fork-join parallel patterns
- **identity**: Identity transformation benchmarks
- **join**: Join operation benchmarks  
- **reachability**: Graph reachability using differential-dataflow
- **symmetric_hash_join**: Symmetric hash join operations
- **upcase**: String transformation benchmarks
- **words_diamond**: Diamond-shaped data flow patterns
- **micro_ops**: Micro-operation benchmarks
- **futures**: Asynchronous operation benchmarks

## Data

Wordlist is from https://github.com/dwyl/english-words/blob/master/words_alpha.txt
