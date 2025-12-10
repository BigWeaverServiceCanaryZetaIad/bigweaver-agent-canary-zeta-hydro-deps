# Timely and Differential-Dataflow Benchmarks

This directory contains benchmarks for timely-dataflow and differential-dataflow that were moved from the main Hydro repository to avoid including these dependencies in the main codebase.

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p hydro-timely-differential-benches
```

Run specific benchmarks:
```bash
cargo bench -p hydro-timely-differential-benches --bench reachability
```

## Benchmarks

- **arithmetic**: Basic arithmetic operations using timely-dataflow
- **fan_in**: Fan-in pattern benchmarks using timely-dataflow
- **fan_out**: Fan-out pattern benchmarks using timely-dataflow
- **fork_join**: Fork-join pattern benchmarks using timely-dataflow
- **identity**: Identity operation benchmarks using timely-dataflow
- **join**: Join operation benchmarks using timely-dataflow
- **reachability**: Graph reachability benchmarks using both timely-dataflow and differential-dataflow
- **upcase**: String uppercase transformation benchmarks using timely-dataflow

## Performance Comparison

To compare performance between Hydro implementations and timely/differential implementations, you can run the benchmarks from this repository alongside benchmarks from the main Hydro repository.

From the main Hydro repository, run:
```bash
cargo bench -p benches
```

From this repository, run:
```bash
cargo bench -p hydro-timely-differential-benches
```

Criterion will save results in `target/criterion/` allowing you to compare performance across different implementations.
