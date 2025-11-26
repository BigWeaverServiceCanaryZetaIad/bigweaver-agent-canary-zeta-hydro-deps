# Timely and Differential Dataflow Benchmarks

Performance benchmarks for timely dataflow and differential-dataflow libraries.

## Overview

This package contains benchmarks that measure the performance of various dataflow patterns using:
- **Timely Dataflow**: A low-latency data-parallel dataflow system
- **Differential Dataflow**: An incremental computation framework built on timely dataflow

These benchmarks have been moved from the main hydro repository to isolate dependencies and maintain a clean dependency structure.

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p timely-benchmarks
```

Run specific benchmarks:
```bash
cargo bench -p timely-benchmarks --bench reachability
cargo bench -p timely-benchmarks --bench arithmetic
cargo bench -p timely-benchmarks --bench join
```

## Available Benchmarks

### Timely Dataflow Benchmarks

- **arithmetic**: Tests map operations with arithmetic computations
- **identity**: Tests identity operations through the dataflow
- **fan_in**: Tests combining multiple streams into one
- **fan_out**: Tests broadcasting a stream to multiple consumers
- **fork_join**: Tests splitting and recombining streams
- **join**: Tests hash join operations
- **upcase**: Tests string transformations

### Differential Dataflow Benchmarks

- **reachability**: Graph reachability using differential dataflow's incremental computation

## Benchmark Structure

Each benchmark compares the performance of:
1. **Timely/Differential implementation**: The dataflow-based approach
2. **Baseline implementations**: Raw Rust implementations (iterators, loops, etc.) for comparison

## Performance Comparisons

The benchmarks are designed to enable performance comparisons between:
- Timely dataflow vs. baseline implementations
- Different dataflow patterns and operators
- Incremental vs. batch computation (differential dataflow)

## Data Files

Some benchmarks use external data files:
- `reachability_edges.txt`: Graph edges for reachability benchmark
- `reachability_reachable.txt`: Expected reachable nodes
