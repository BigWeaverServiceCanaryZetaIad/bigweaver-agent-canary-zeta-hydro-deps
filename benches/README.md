# Microbenchmarks with Timely and Differential Dataflow Dependencies

This repository contains benchmarks that compare Hydro performance against Timely Dataflow and Differential Dataflow implementations.

## Why these benchmarks are separate

These benchmarks require `timely` and `differential-dataflow` dependencies, which are not needed in the main Hydro repository. To keep the main repository lean and avoid unnecessary dependencies, these comparison benchmarks have been moved to this separate repository.

## Running the benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench fan_in
cargo bench -p benches --bench fan_out
cargo bench -p benches --bench fork_join
cargo bench -p benches --bench identity
cargo bench -p benches --bench join
cargo bench -p benches --bench upcase
```

## Available benchmarks

- **arithmetic**: Arithmetic operations pipeline comparison
- **fan_in**: Fan-in pattern performance
- **fan_out**: Fan-out pattern performance
- **fork_join**: Fork-join pattern comparison
- **identity**: Identity transformation benchmark
- **join**: Join operation performance
- **reachability**: Graph reachability benchmark using Differential Dataflow
- **upcase**: String uppercase transformation benchmark

## Performance Comparison

These benchmarks allow you to compare the performance of Hydro implementations against their Timely Dataflow and Differential Dataflow equivalents, helping to validate optimizations and identify performance gaps.
