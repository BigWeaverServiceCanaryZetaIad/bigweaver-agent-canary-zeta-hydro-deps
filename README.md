# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks comparing Hydro's performance against Timely Dataflow and Differential Dataflow frameworks.

## Benchmarks

The benchmarks in this repository include comparisons with Timely Dataflow and Differential Dataflow:

- **arithmetic**: Pipeline arithmetic operations
- **fan_in**: Fan-in dataflow patterns
- **fan_out**: Fan-out dataflow patterns
- **fork_join**: Fork-join patterns
- **identity**: Identity transformations
- **join**: Join operations with different data types
- **reachability**: Graph reachability algorithms (includes both Timely and Differential implementations)
- **upcase**: String uppercase operations

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
```

## Dependencies

This repository includes dependencies on:
- `timely` (timely-master package)
- `differential-dataflow` (differential-dataflow-master package)

These dependencies are intentionally separated from the main Hydro repository to avoid unnecessary dependencies in the core codebase while maintaining comprehensive performance comparison capabilities.