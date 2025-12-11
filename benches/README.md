# Timely and Differential Dataflow Benchmarks

This directory contains benchmarks for comparing timely and differential-dataflow performance with Hydro project implementations.

## Overview

These benchmarks were moved from the main `bigweaver-agent-canary-hydro-zeta` repository to separate the external dependency comparisons from the core Hydro project code. This allows for:

- Clean separation of concerns
- Independent benchmarking without adding dependencies to the main project
- Performance comparison capabilities between timely/differential-dataflow and Hydro implementations

## Available Benchmarks

- **arithmetic**: Basic arithmetic operations with multiple map stages
- **fan_in**: Multiple streams concatenating into one
- **fan_out**: One stream branching into multiple consumers
- **fork_join**: Fork-join pattern with filtering and concatenation
- **identity**: Identity mapping (passthrough) operations
- **join**: Hash join operations on different data types
- **reachability**: Graph reachability using both timely and differential-dataflow
- **upcase**: String manipulation benchmarks (uppercase, concatenation)

## Running Benchmarks

To run all benchmarks:

```bash
cargo bench
```

To run a specific benchmark:

```bash
cargo bench --bench arithmetic
cargo bench --bench reachability
```

## Dependencies

The benchmarks depend on:

- `timely`: Timely dataflow system
- `differential-dataflow`: Incremental computation framework built on timely
- `criterion`: Benchmark harness
- `dfir_rs`: From the main bigweaver-agent-canary-hydro-zeta repository (for future comparison benchmarks)

## Note

These benchmarks focus specifically on timely and differential-dataflow implementations. Hydro-specific benchmarks remain in the main repository.
