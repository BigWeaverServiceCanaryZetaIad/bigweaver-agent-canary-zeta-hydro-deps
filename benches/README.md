# Timely and Differential Dataflow Benchmarks

This repository contains benchmarks that compare Hydro/DFIR performance against Timely Dataflow and Differential Dataflow frameworks.

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench join
cargo bench -p benches --bench arithmetic
```

## Available Benchmarks

- **reachability**: Graph reachability algorithms comparing Timely, Differential, and Hydro implementations
- **join**: Join operations with different data types (usize, String)
- **arithmetic**: Arithmetic operations performance
- **fan_in**: Fan-in dataflow patterns
- **fan_out**: Fan-out dataflow patterns
- **fork_join**: Fork-join patterns with multiple operations
- **identity**: Identity transformation benchmarks
- **upcase**: String uppercase transformation benchmarks

## Dependencies

These benchmarks require:
- `timely` (Timely Dataflow)
- `differential-dataflow` (Differential Dataflow)
- `dfir_rs` (Hydro/DFIR framework)
- `criterion` (benchmarking framework)

## Purpose

These benchmarks are maintained separately to isolate the Timely and Differential Dataflow dependencies from the main Hydro repository, following the project's architectural principle of clean dependency management.
