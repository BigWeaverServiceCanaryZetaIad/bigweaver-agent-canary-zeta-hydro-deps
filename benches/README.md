# Timely and Differential Dataflow Comparison Benchmarks

This directory contains benchmarks that compare Hydro's performance against Timely Dataflow and Differential Dataflow.

These benchmarks have been separated from the main `bigweaver-agent-canary-hydro-zeta` repository to avoid 
introducing dependencies on timely and differential-dataflow packages in the main codebase.

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

## Benchmarks

- **arithmetic** - Basic arithmetic operations
- **fan_in** - Multiple inputs converging to a single output
- **fan_out** - Single input distributed to multiple outputs
- **fork_join** - Fork-join pattern
- **identity** - Identity transformation (pass-through)
- **join** - Join operations with different data types
- **reachability** - Graph reachability algorithms
- **upcase** - String manipulation operations

Each benchmark compares Hydro's implementation against equivalent Timely/Differential implementations
to measure relative performance.
