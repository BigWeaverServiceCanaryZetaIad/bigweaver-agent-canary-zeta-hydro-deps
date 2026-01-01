# Timely and Differential Dataflow Benchmarks

Benchmarks for comparing Timely Dataflow and Differential Dataflow with Hydro.

## Running Benchmarks

Run all benchmarks:
```
cargo bench -p benches
```

Run specific benchmarks:
```
cargo bench -p benches --bench reachability
cargo bench -p benches --bench join
cargo bench -p benches --bench fan_out
```

## Benchmark Descriptions

- **reachability**: Graph reachability benchmarks comparing Timely, Differential Dataflow, and Hydro implementations
- **join**: Join operation benchmarks comparing Timely and sequential implementations with different data types
- **fan_out**: Fan-out operation benchmarks comparing Timely, Hydro, and sequential implementations

## Dependencies

These benchmarks depend on:
- `timely` (Timely Dataflow)
- `differential-dataflow` (Differential Dataflow)
- `dfir_rs` (from the main Hydro repository)
- `criterion` (for benchmarking)
