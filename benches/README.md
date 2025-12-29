# Benchmarks

Comparison benchmarks of Hydro with Timely Dataflow and Differential Dataflow.

These benchmarks were moved from the main Hydro repository to keep the main repository free of heavyweight dependencies.

## Running Benchmarks

Run all benchmarks:
```
cargo bench -p benches
```

Run specific benchmarks:
```
cargo bench -p benches --bench reachability
cargo bench -p benches --bench join
cargo bench -p benches --bench arithmetic
```

## Benchmarks Included

These benchmarks compare DFIR performance against Timely Dataflow and Differential Dataflow:

- `arithmetic.rs` - Arithmetic operations benchmark
- `fan_in.rs` - Fan-in pattern benchmark
- `fan_out.rs` - Fan-out pattern benchmark  
- `fork_join.rs` - Fork-join pattern benchmark
- `identity.rs` - Identity operation benchmark
- `join.rs` - Join operation benchmark
- `reachability.rs` - Graph reachability algorithm benchmark
- `upcase.rs` - String uppercase transformation benchmark
