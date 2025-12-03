# Microbenchmarks

Benchmarks comparing Hydro/DFIR with Timely and Differential Dataflow implementations.

These benchmarks depend on `timely` and `differential-dataflow` packages and have been separated from the main Hydro repository to reduce dependency bloat.

## Running Benchmarks

Run all benchmarks:
```
cargo bench -p benches
```

Run specific benchmarks:
```
cargo bench -p benches --bench reachability
```

## Benchmarks

- **arithmetic**: Basic arithmetic operations
- **fan_in**: Multiple sources converging
- **fan_out**: Single source diverging  
- **fork_join**: Fork and join patterns
- **futures**: Async futures handling
- **identity**: Pass-through operations
- **join**: Join operations
- **micro_ops**: Micro-operation benchmarks
- **reachability**: Graph reachability algorithms
- **symmetric_hash_join**: Symmetric hash join operations
- **upcase**: String transformation
- **words_diamond**: Diamond pattern with word processing

## Performance Comparison

These benchmarks can be used to compare Hydro's performance against native timely/differential-dataflow implementations, helping maintain performance parity and identify optimization opportunities.

## Data Sources

Wordlist is from https://github.com/dwyl/english-words/blob/master/words_alpha.txt
