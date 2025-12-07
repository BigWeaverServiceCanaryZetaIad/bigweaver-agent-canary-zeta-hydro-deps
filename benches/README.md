# Timely and Differential-Dataflow Benchmarks

This repository contains benchmarks that use timely and differential-dataflow dependencies, which have been separated from the main Hydro repository.

## Running Benchmarks

Run all benchmarks:
```
cargo bench -p benches
```

Run specific benchmarks:
```
cargo bench -p benches --bench reachability
```

## Available Benchmarks

- **arithmetic**: Pipeline arithmetic operations benchmark
- **fan_in**: Fan-in dataflow pattern benchmark
- **fan_out**: Fan-out dataflow pattern benchmark
- **fork_join**: Fork-join pattern benchmark
- **identity**: Identity transformation benchmark
- **join**: Join operation benchmark
- **reachability**: Graph reachability benchmark
- **upcase**: String transformation benchmark

## Note

These benchmarks depend on the main Hydro repository via git dependencies for dfir_rs and sinktools packages.
