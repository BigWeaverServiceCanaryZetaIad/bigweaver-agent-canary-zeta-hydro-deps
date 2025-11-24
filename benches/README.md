# Timely and Differential Dataflow Benchmarks

This directory contains benchmarks that depend on the timely and differential-dataflow packages. These benchmarks were moved from the main bigweaver-agent-canary-hydro-zeta repository to isolate dependencies and maintain a cleaner codebase structure.

## Benchmarks Included

- **arithmetic.rs**: Arithmetic operations using Timely dataflow
- **fan_in.rs**: Fan-in pattern using Timely dataflow
- **fan_out.rs**: Fan-out pattern using Timely dataflow
- **fork_join.rs**: Fork-join pattern using Timely dataflow
- **identity.rs**: Identity operations using Timely dataflow
- **join.rs**: Join operations using Timely dataflow
- **reachability.rs**: Graph reachability using Differential dataflow
- **upcase.rs**: String uppercase operations using Timely dataflow

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
```

## Performance Comparisons

These benchmarks can be used to compare performance between different implementations and versions. The benchmarks are maintained separately to avoid unnecessary dependencies in the main repository while retaining the ability to run performance comparisons.
