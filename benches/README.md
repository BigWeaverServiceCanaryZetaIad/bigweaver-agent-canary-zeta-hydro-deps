# Timely and Differential Dataflow Benchmarks

This repository contains benchmarks comparing Hydro/DFIR with Timely Dataflow and Differential Dataflow.

These benchmarks were moved from the main `bigweaver-agent-canary-hydro-zeta` repository to avoid unnecessary dependencies on `timely` and `differential-dataflow` packages in the core repository.

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p timely-differential-benches
```

Run specific benchmarks:
```bash
cargo bench -p timely-differential-benches --bench reachability
cargo bench -p timely-differential-benches --bench join
cargo bench -p timely-differential-benches --bench arithmetic
```

## Available Benchmarks

The following benchmarks compare performance between Hydro/DFIR and Timely/Differential:

- **arithmetic**: Basic arithmetic operations
- **fan_in**: Fan-in data patterns
- **fan_out**: Fan-out data patterns
- **fork_join**: Fork-join patterns
- **identity**: Identity transformation
- **join**: Hash join operations with different data types
- **reachability**: Graph reachability algorithms
- **upcase**: String uppercasing operations

## Performance Comparisons

These benchmarks enable performance comparisons between:
- Hydro/DFIR implementations
- Timely Dataflow implementations
- Differential Dataflow implementations

Results are generated using the Criterion benchmarking framework and include detailed statistics and HTML reports.
