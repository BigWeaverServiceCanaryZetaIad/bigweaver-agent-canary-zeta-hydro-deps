# Timely and Differential Dataflow Benchmarks

Benchmarks comparing Hydro with timely-dataflow and differential-dataflow.

These benchmarks were moved from the main Hydro repository to avoid dependency pollution and keep the main repository focused on core functionality.

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

## Benchmarks Included

- **arithmetic**: Pipeline arithmetic operations using timely
- **fan_in**: Fan-in pattern benchmarks using timely
- **fan_out**: Fan-out pattern benchmarks using timely
- **fork_join**: Fork-join pattern benchmarks using timely
- **identity**: Identity transformation benchmarks using timely
- **join**: Join operation benchmarks using timely
- **reachability**: Graph reachability benchmarks using differential-dataflow
- **upcase**: String uppercase transformation benchmarks using timely

## Dependencies

These benchmarks depend on:
- timely-dataflow (for most benchmarks)
- differential-dataflow (for reachability benchmark)
- dfir_rs from the main Hydro repository (referenced as git dependency)

Wordlist is from https://github.com/dwyl/english-words/blob/master/words_alpha.txt
