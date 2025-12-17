# Timely and Differential-Dataflow Benchmarks

This repository contains benchmarks that use timely and differential-dataflow dependencies for performance comparison with Hydro implementations.

## Overview

These benchmarks were separated from the main bigweaver-agent-canary-hydro-zeta repository to:
- Reduce build dependencies in the main repository
- Improve build times for core development
- Maintain the ability to run performance comparisons with Timely/Differential implementations

## Available Benchmarks

- **arithmetic** - Arithmetic operations benchmark
- **fan_in** - Fan-in pattern benchmark
- **fan_out** - Fan-out pattern benchmark
- **fork_join** - Fork-join pattern benchmark
- **identity** - Identity transformation benchmark
- **join** - Join operations benchmark
- **reachability** - Graph reachability benchmark (includes test data files)
- **upcase** - String transformation benchmark

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
```

## Performance Comparison

These benchmarks can be used to compare performance characteristics between:
- Timely/Differential-Dataflow implementations
- Hydro-native implementations (in the main repository)

## Data Files

- `reachability_edges.txt` - Test data for reachability benchmark
- `reachability_reachable.txt` - Expected results for reachability benchmark

## Build Requirements

The `build.rs` file generates code for the fork_join benchmark during the build process.
