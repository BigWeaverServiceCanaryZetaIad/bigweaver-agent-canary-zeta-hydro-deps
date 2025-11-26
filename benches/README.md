# Timely and Differential Dataflow Benchmarks

This directory contains benchmarks specifically for the `timely` and `differential-dataflow` dependencies. These benchmarks were moved here from the main hydro repository to isolate these dependencies and maintain a cleaner dependency structure.

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench
```

Run specific benchmarks:
```bash
cargo bench --bench reachability
cargo bench --bench arithmetic
cargo bench --bench fan_in
cargo bench --bench fan_out
cargo bench --bench fork_join
cargo bench --bench identity
cargo bench --bench join
cargo bench --bench upcase
```

## Benchmarks

### arithmetic
Tests arithmetic operations (addition) through a pipeline of operations.

### fan_in
Tests concatenation of multiple streams (fan-in pattern).

### fan_out
Tests distribution of a single stream to multiple consumers (fan-out pattern).

### fork_join
Tests a pattern of repeatedly splitting and joining streams.

### identity
Tests identity operations (no transformation) through a pipeline.

### join
Tests hash join operations with different key and value types (usize and String).

### upcase
Tests string transformation operations (uppercasing).

### reachability
Tests graph reachability algorithms using both timely and differential-dataflow.
Includes benchmark data files:
- `reachability_edges.txt`: Graph edges
- `reachability_reachable.txt`: Expected reachable nodes

## Dependencies

These benchmarks depend on:
- `timely-master` (v0.13.0-dev.1)
- `differential-dataflow-master` (v0.13.0-dev.1)
- `criterion` for benchmarking framework
