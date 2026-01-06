# Timely and Differential Dataflow Benchmarks

Benchmarks for comparing Hydro with Timely Dataflow and Differential Dataflow.

These benchmarks were moved from the main Hydro repository to avoid including
timely and differential-dataflow as dependencies in the main project.

## Running Benchmarks

Run all benchmarks:
```
cargo bench -p benches
```

Run specific benchmarks:
```
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench fan_in
cargo bench -p benches --bench fan_out
cargo bench -p benches --bench fork_join
cargo bench -p benches --bench identity
cargo bench -p benches --bench upcase
cargo bench -p benches --bench join
cargo bench -p benches --bench reachability
```

## Benchmarks Included

- **arithmetic**: Tests arithmetic operations comparing Hydro and Timely
- **fan_in**: Tests fan-in dataflow patterns comparing Hydro and Timely
- **fan_out**: Tests fan-out dataflow patterns comparing Hydro and Timely
- **fork_join**: Tests fork-join patterns comparing Hydro and Timely
- **identity**: Tests identity operations comparing Hydro and Timely
- **upcase**: Tests string transformation operations comparing Hydro and Timely
- **join**: Tests join operations with different data types comparing Hydro and Timely
- **reachability**: Tests graph reachability algorithms comparing Hydro, Timely, and Differential Dataflow
