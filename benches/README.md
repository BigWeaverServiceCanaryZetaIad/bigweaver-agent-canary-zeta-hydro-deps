# Timely and Differential Dataflow Benchmarks

This directory contains benchmarks for comparing Hydro with Timely and Differential Dataflow.

## Benchmarks

### fan_in.rs
Benchmarks fan-in operations using Timely dataflow, comparing with Hydro's surface API and raw iterators.

### upcase.rs
Benchmarks string transformation operations using Timely dataflow.

### reachability.rs
Benchmarks graph reachability algorithms using Differential Dataflow.

## Running Benchmarks

Run all benchmarks:
```
cargo bench -p benches
```

Run specific benchmarks:
```
cargo bench -p benches --bench fan_in
cargo bench -p benches --bench upcase
cargo bench -p benches --bench reachability
```

## Dependencies

These benchmarks depend on:
- `timely-master`: Timely dataflow framework
- `differential-dataflow-master`: Differential dataflow framework
- `dfir_rs`: Hydro's dataflow runtime (referenced from main repository)
- `criterion`: Benchmarking framework
