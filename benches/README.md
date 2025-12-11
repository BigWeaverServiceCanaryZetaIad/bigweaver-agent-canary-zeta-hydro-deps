# Timely and Differential Dataflow Benchmarks

This directory contains benchmarks that compare Hydro (dfir_rs) performance against Timely Dataflow and Differential Dataflow.

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench fork_join
```

## Benchmarks

- **arithmetic** - Basic arithmetic operations comparison
- **fan_in** - Multiple stream concatenation patterns
- **fan_out** - Stream splitting and mapping patterns
- **fork_join** - Fork-join pattern with filtering
- **identity** - Identity transformation benchmarks
- **join** - Join operation comparisons
- **upcase** - String transformation benchmarks
- **reachability** - Graph reachability algorithms (uses differential-dataflow)

## Migration Note

These benchmarks were moved from the main `bigweaver-agent-canary-hydro-zeta` repository to isolate the timely and differential-dataflow dependencies, keeping the main repository cleaner while retaining the ability to run performance comparisons.
