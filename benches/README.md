# Timely and Differential Dataflow Benchmarks

This directory contains benchmarks that compare DFIR (Hydroflow) performance against Timely Dataflow and Differential Dataflow.

## Benchmarks

The following benchmarks are included:

- **arithmetic.rs**: Basic arithmetic operations benchmark
- **fan_in.rs**: Fan-in pattern benchmark
- **fan_out.rs**: Fan-out pattern benchmark
- **fork_join.rs**: Fork-join pattern benchmark
- **identity.rs**: Identity operation benchmark
- **join.rs**: Join operations benchmark comparing different value types (usize, String)
- **reachability.rs**: Graph reachability algorithm benchmark (includes both Timely and Differential implementations)
- **upcase.rs**: String transformation operations benchmark

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
cargo bench --bench join
```

## Data Files

- `reachability_edges.txt`: Graph edges for the reachability benchmark
- `reachability_reachable.txt`: Expected reachable nodes for validation

## Dependencies

These benchmarks depend on:
- `timely` (timely-master 0.13.0-dev.1)
- `differential-dataflow` (differential-dataflow-master 0.13.0-dev.1)
- `dfir_rs` (from main hydro repository)
- `criterion` for benchmarking infrastructure
