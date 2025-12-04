# Timely and Differential-Dataflow Benchmarks

Microbenchmarks for Hydro using timely and differential-dataflow frameworks.

These benchmarks were moved from the main Hydro repository to keep it free of timely and differential-dataflow dependencies while maintaining the ability to run performance comparisons.

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench micro_ops
cargo bench -p benches --bench arithmetic
```

## Available Benchmarks

- **arithmetic**: Arithmetic operation benchmarks
- **fan_in**: Fan-in pattern benchmarks
- **fan_out**: Fan-out pattern benchmarks
- **fork_join**: Fork-join pattern benchmarks
- **futures**: Futures-based async benchmarks
- **identity**: Identity operation benchmarks
- **join**: Join operation benchmarks
- **micro_ops**: Micro-operation benchmarks
- **reachability**: Graph reachability benchmarks
- **symmetric_hash_join**: Symmetric hash join benchmarks
- **upcase**: String uppercase operation benchmarks
- **words_diamond**: Diamond pattern with word processing benchmarks

## Notes

- Wordlist is from https://github.com/dwyl/english-words/blob/master/words_alpha.txt
- These benchmarks use timely-master and differential-dataflow-master packages
