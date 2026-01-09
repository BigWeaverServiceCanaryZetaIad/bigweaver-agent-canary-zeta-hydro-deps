# Benchmarks with Timely and Differential-Dataflow Dependencies

This directory contains benchmarks that use timely and differential-dataflow dependencies for performance comparison against Hydro implementations.

## Running Benchmarks

Run all benchmarks:
```
cargo bench
```

Run specific benchmarks:
```
cargo bench --bench reachability
cargo bench --bench arithmetic
cargo bench --bench fan_in
cargo bench --bench fan_out
cargo bench --bench fork_join
cargo bench --bench identity
cargo bench --bench join
cargo bench --bench upcase
```

## Benchmark List

- **arithmetic.rs** - Arithmetic operations benchmark
- **fan_in.rs** - Fan-in pattern benchmark
- **fan_out.rs** - Fan-out pattern benchmark
- **fork_join.rs** - Fork-join pattern benchmark
- **identity.rs** - Identity operation benchmark
- **join.rs** - Join operation benchmark
- **reachability.rs** - Graph reachability benchmark (uses reachability_edges.txt and reachability_reachable.txt)
- **upcase.rs** - Uppercase transformation benchmark
