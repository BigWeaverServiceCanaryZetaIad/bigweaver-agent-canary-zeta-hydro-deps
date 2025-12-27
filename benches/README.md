# Performance Comparison Benchmarks

Benchmarks comparing Hydro/DFIR performance against Timely Dataflow and Differential Dataflow frameworks.

## Overview

This package contains benchmarks that measure the performance of DFIR/Hydro operations against established dataflow frameworks (Timely Dataflow and Differential Dataflow). These benchmarks ensure competitive performance and help identify optimization opportunities.

## Running Benchmarks

Run all benchmarks:
```
cargo bench -p benches
```

Run specific benchmarks:
```
cargo bench -p benches --bench reachability
cargo bench -p benches --bench join
```

## Available Benchmarks

### Reachability
Graph reachability algorithm comparing DFIR/Hydro implementations against Timely and Differential Dataflow.

### Join Operations
Hash join implementations comparing different data types (usize and String) across frameworks.

### Micro Operations
Various micro-benchmarks for basic dataflow operations:
- **arithmetic**: Basic arithmetic operations in a dataflow
- **fan_in**: Multiple inputs converging to a single operator
- **fan_out**: Single input branching to multiple operators
- **fork_join**: Fork-join pattern implementations
- **identity**: Identity operation (passthrough)
- **upcase**: String uppercase transformation

## Data Files

- `reachability_edges.txt`: Graph edge data for reachability benchmarks
- `reachability_reachable.txt`: Expected reachable nodes for validation

## Dependencies

This package depends on:
- `timely` (timely-master): Timely Dataflow framework
- `differential-dataflow` (differential-dataflow-master): Differential Dataflow framework
- `criterion`: Statistics-driven benchmarking library

These dependencies are kept separate from the main Hydro repository to prevent dependency bloat while maintaining performance comparison capabilities.
