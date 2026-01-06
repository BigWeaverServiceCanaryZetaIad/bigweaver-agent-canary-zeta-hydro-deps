# Timely and Differential Dataflow Benchmarks

Benchmarks comparing Hydro with Timely Dataflow and Differential Dataflow.

## Running Benchmarks

Run all benchmarks:
```
cargo bench -p benches
```

Run specific benchmarks:
```
cargo bench -p benches --bench reachability
cargo bench -p benches --bench fan_in
cargo bench -p benches --bench join
```

## Available Benchmarks

- **arithmetic.rs** - Arithmetic operations benchmark
- **fan_in.rs** - Fan-in pattern benchmark
- **fan_out.rs** - Fan-out pattern benchmark
- **fork_join.rs** - Fork-join pattern benchmark
- **identity.rs** - Identity/passthrough benchmark
- **join.rs** - Join operations benchmark
- **reachability.rs** - Graph reachability benchmark (uses reachability_edges.txt and reachability_reachable.txt)
- **upcase.rs** - String uppercase transformation benchmark

## Dependencies

These benchmarks depend on:
- `timely-master` - Timely Dataflow library
- `differential-dataflow-master` - Differential Dataflow library
- `dfir_rs` - Hydro's dataflow runtime (from main hydro repository)
- `criterion` - Benchmarking framework
