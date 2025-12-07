# Timely and Differential-Dataflow Benchmarks

This directory contains benchmarks that depend on timely and differential-dataflow.
These benchmarks were moved from the main bigweaver-agent-canary-hydro-zeta repository
to keep the main repository's dependencies lean.

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p hydro-benches-timely
```

Run specific benchmarks:
```bash
cargo bench -p hydro-benches-timely --bench reachability
cargo bench -p hydro-benches-timely --bench arithmetic
```

## Available Benchmarks

- **arithmetic** - Arithmetic operations using timely dataflow
- **fan_in** - Fan-in pattern benchmarks with timely
- **fan_out** - Fan-out pattern benchmarks with timely
- **fork_join** - Fork-join pattern benchmarks with timely
- **identity** - Identity operation benchmarks with timely
- **join** - Join operation benchmarks with timely
- **reachability** - Graph reachability using differential-dataflow
- **upcase** - String uppercase transformation with timely

## Performance Comparisons

These benchmarks can be used to compare performance between:
- The timely/differential-dataflow implementations
- Hydro implementations in the main repository

See the individual benchmark files for implementation details and comparison functions.
