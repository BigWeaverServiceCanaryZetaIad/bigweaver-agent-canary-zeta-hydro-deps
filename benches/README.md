# Timely and Differential-Dataflow Benchmarks

This directory contains performance comparison benchmarks for Hydro/DFIR against Timely Dataflow and Differential Dataflow.

## Purpose

These benchmarks allow us to:
- Compare performance of Hydro/DFIR implementations against Timely and Differential Dataflow
- Track performance improvements over time
- Identify performance regressions

## Running Benchmarks

To run all benchmarks:
```bash
cargo bench
```

To run a specific benchmark:
```bash
cargo bench --bench <benchmark_name>
```

For example:
```bash
cargo bench --bench reachability
cargo bench --bench arithmetic
cargo bench --bench fan_in
```

## Available Benchmarks

- **arithmetic**: Simple arithmetic operations
- **fan_in**: Multiple inputs merging into one stream
- **fan_out**: One input splitting into multiple streams
- **fork_join**: Fork-join patterns with filtering
- **futures**: Future-based asynchronous operations
- **identity**: Pass-through/identity operations
- **join**: Stream join operations
- **micro_ops**: Micro-benchmarks for basic operations
- **reachability**: Graph reachability computation
- **symmetric_hash_join**: Symmetric hash join implementation
- **upcase**: String transformation operations
- **words_diamond**: Diamond-shaped dataflow patterns with string manipulation

## Dependencies

These benchmarks require:
- `timely` (Timely Dataflow)
- `differential-dataflow` (Differential Dataflow)
- `dfir_rs` (from the main Hydro repository)
- `criterion` (for benchmarking framework)

The benchmarks reference `dfir_rs` and `sinktools` from the main repository via git dependencies.
