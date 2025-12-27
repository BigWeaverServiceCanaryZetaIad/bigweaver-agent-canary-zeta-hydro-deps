# Timely and Differential Dataflow Comparison Benchmarks

Benchmarks comparing Hydro performance with Timely Dataflow and Differential Dataflow.

## Running Benchmarks

Run all benchmarks:
```
cargo bench -p hydro-deps-benches
```

Run specific benchmarks:
```
cargo bench -p hydro-deps-benches --bench reachability
cargo bench -p hydro-deps-benches --bench join
cargo bench -p hydro-deps-benches --bench arithmetic
```

## Available Benchmarks

- **arithmetic** - Arithmetic operations comparison
- **fan_in** - Fan-in pattern comparison
- **fan_out** - Fan-out pattern comparison
- **fork_join** - Fork-join pattern comparison
- **identity** - Identity/passthrough comparison
- **join** - Join operations comparison
- **reachability** - Graph reachability algorithm comparison
- **upcase** - String case conversion comparison

These benchmarks compare Hydro's performance against established dataflow frameworks (Timely Dataflow and Differential Dataflow) to ensure competitive performance.
