# Timely and Differential Dataflow Benchmarks

This directory contains benchmarks that depend on the timely and differential-dataflow packages. These benchmarks were migrated from the main bigweaver-agent-canary-hydro-zeta repository to isolate these dependencies and prevent technical debt accumulation.

## Benchmarks

The following benchmarks are included:

- **arithmetic**: Basic arithmetic operations using timely dataflow
- **fan_in**: Multiple input streams merged into one
- **fan_out**: Single stream split into multiple outputs
- **fork_join**: Fork-join pattern with filtering
- **identity**: Simple identity transformation
- **join**: Join operations on timely dataflow
- **reachability**: Graph reachability using both timely and differential-dataflow
- **upcase**: String uppercasing operations

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
```

## Performance Comparison

These benchmarks can be used to compare performance between:
- Timely/differential-dataflow implementations
- Hydroflow implementations
- Other dataflow frameworks

The benchmarks retain the ability to run performance comparisons even after being moved to this separate repository.
