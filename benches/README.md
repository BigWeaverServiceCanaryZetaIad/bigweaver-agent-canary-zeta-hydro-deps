# Timely and Differential Dataflow Benchmarks

This directory contains performance comparison benchmarks for Timely Dataflow, Differential Dataflow, and Hydro implementations.

These benchmarks were moved from the main bigweaver-agent-canary-hydro-zeta repository to isolate the dependencies on timely and differential-dataflow packages.

## Running Benchmarks

Run all benchmarks:
```
cargo bench -p hydro-deps-benches
```

Run specific benchmarks:
```
cargo bench -p hydro-deps-benches --bench reachability
cargo bench -p hydro-deps-benches --bench arithmetic
```

## Available Benchmarks

- **arithmetic**: Arithmetic operations pipeline comparison
- **fan_in**: Fan-in pattern performance
- **fan_out**: Fan-out pattern performance  
- **fork_join**: Fork-join pattern performance
- **identity**: Identity transformation performance
- **join**: Join operations comparison
- **reachability**: Graph reachability algorithms
- **upcase**: String uppercase transformation

Each benchmark typically includes implementations for:
- Timely Dataflow
- Differential Dataflow (where applicable)
- Hydro (dfir_rs) - multiple variants

## Performance Comparison

These benchmarks enable direct performance comparisons between different dataflow frameworks while keeping the dependency footprint isolated from the main Hydro project.

## Notes

Wordlist for benchmarks is from https://github.com/dwyl/english-words/blob/master/words_alpha.txt
