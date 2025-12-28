# Timely and Differential Dataflow Benchmarks

This repository contains benchmarks comparing Hydro's performance with Timely Dataflow and Differential Dataflow implementations.

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

The following benchmarks compare Hydro implementations against Timely and Differential Dataflow:

- **arithmetic** - Basic arithmetic operations
- **fan_in** - Fan-in pattern (multiple inputs to single output)
- **fan_out** - Fan-out pattern (single input to multiple outputs)
- **fork_join** - Fork-join pattern with filters
- **identity** - Identity mapping operations
- **join** - Hash join operations on different data types
- **reachability** - Graph reachability algorithms using differential dataflow
- **upcase** - String transformation operations

## Dependencies

These benchmarks depend on:
- `timely` (timely-master) - Timely Dataflow framework
- `differential-dataflow` (differential-dataflow-master) - Differential Dataflow framework
- `dfir_rs` - Hydro's DFIR implementation (from main hydro repository)
- `criterion` - Benchmarking framework
