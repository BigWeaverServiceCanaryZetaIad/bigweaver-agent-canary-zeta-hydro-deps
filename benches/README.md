# Timely and Differential Dataflow Benchmarks

This directory contains benchmarks that compare Hydro (dfir_rs) performance against Timely Dataflow and Differential Dataflow.

## Benchmarks Included

These benchmarks were moved from the main `bigweaver-agent-canary-hydro-zeta` repository to isolate the timely and differential-dataflow dependencies:

- **arithmetic.rs** - Basic arithmetic operations benchmark comparing Hydro vs Timely
- **fan_in.rs** - Fan-in pattern benchmark comparing Hydro vs Timely
- **fan_out.rs** - Fan-out pattern benchmark comparing Hydro vs Timely
- **fork_join.rs** - Fork-join pattern benchmark comparing Hydro vs Timely
- **identity.rs** - Identity transformation benchmark comparing Hydro vs Timely
- **join.rs** - Join operation benchmark comparing Hydro vs Timely
- **reachability.rs** - Graph reachability benchmark comparing Hydro vs Differential Dataflow
- **upcase.rs** - String transformation benchmark comparing Hydro vs Timely

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p hydro-timely-benchmarks
```

Run a specific benchmark:
```bash
cargo bench -p hydro-timely-benchmarks --bench reachability
```

## Performance Comparison

These benchmarks maintain the ability to compare performance between:
- Hydro (dfir_rs) - the dataflow framework from the main repository
- Timely Dataflow - a low-latency cyclic dataflow computational model
- Differential Dataflow - an incremental computation framework built on Timely

The Hydro implementation is pulled from the main repository as a git dependency, allowing for performance comparisons while keeping the main repository free of timely/differential dependencies.
