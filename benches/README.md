# Timely and Differential-Dataflow Benchmarks

This directory contains benchmarks that compare Hydro/dfir_rs performance with timely and differential-dataflow implementations.

These benchmarks were moved from the main `bigweaver-agent-canary-hydro-zeta` repository to keep the main repository free of timely and differential-dataflow dependencies while still maintaining the ability to run performance comparisons.

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench
```

Run specific benchmarks:
```bash
cargo bench --bench reachability
cargo bench --bench arithmetic
cargo bench --bench identity
```

## Available Benchmarks

- **arithmetic**: Pipeline arithmetic operations benchmark
- **fan_in**: Fan-in pattern benchmark
- **fan_out**: Fan-out pattern benchmark  
- **fork_join**: Fork-join pattern benchmark
- **identity**: Identity operation benchmark
- **join**: Join operations benchmark
- **reachability**: Graph reachability benchmark
- **upcase**: Uppercase transformation benchmark

## Dependencies

These benchmarks depend on:
- `timely-master` (v0.13.0-dev.1)
- `differential-dataflow-master` (v0.13.0-dev.1)
- `dfir_rs` (referenced from main repository via git)
- `sinktools` (referenced from main repository via git)

## Data Files

The `benches/` subdirectory contains data files used by benchmarks:
- `words_alpha.txt`: Wordlist from https://github.com/dwyl/english-words
- `reachability_edges.txt`: Graph edges for reachability benchmark
- `reachability_reachable.txt`: Expected reachability results
