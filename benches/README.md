# Timely and Differential Dataflow Benchmarks

Benchmarks comparing Hydro with Timely Dataflow and Differential Dataflow.

Run all benchmarks:
```
cargo bench -p benches
```

Run specific benchmarks:
```
cargo bench -p benches --bench reachability
```

## Available Benchmarks

- `arithmetic` - Arithmetic operations comparison with Timely
- `fan_in` - Fan-in pattern comparison with Timely
- `fan_out` - Fan-out pattern comparison with Timely
- `fork_join` - Fork-join pattern comparison with Timely
- `identity` - Identity operation comparison with Timely
- `join` - Join operations comparison with Timely
- `reachability` - Graph reachability comparison with Timely and Differential Dataflow
- `upcase` - String upcasing operations comparison with Timely
