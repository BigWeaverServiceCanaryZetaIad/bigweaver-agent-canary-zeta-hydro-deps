# Hydro Benchmarks with Timely/Differential Dataflow

This directory contains performance benchmarks that compare Hydro (DFIR) with timely-dataflow and differential-dataflow implementations.

## Running Benchmarks

To run all benchmarks:
```bash
cargo bench
```

To run a specific benchmark:
```bash
cargo bench --bench <benchmark_name>
```

## Available Benchmarks

- **arithmetic**: Pipeline arithmetic operations
- **fan_in**: Fan-in pattern benchmarks
- **fan_out**: Fan-out pattern benchmarks
- **fork_join**: Fork-join pattern benchmarks
- **identity**: Identity transformation benchmarks
- **join**: Join operation benchmarks
- **reachability**: Graph reachability benchmarks using differential-dataflow
- **upcase**: String uppercase transformation benchmarks

## Dependencies

These benchmarks depend on:
- `timely-dataflow` (timely-master package)
- `differential-dataflow` (differential-dataflow-master package)
- `dfir_rs` (from the main Hydro repository)

These dependencies were moved to this separate repository to avoid polluting the main Hydro codebase with heavy benchmark dependencies.
