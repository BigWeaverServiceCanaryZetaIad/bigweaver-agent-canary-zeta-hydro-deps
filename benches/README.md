# Timely and Differential Dataflow Benchmarks

Benchmarks comparing Hydro performance with Timely Dataflow and Differential Dataflow.

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
cargo bench -p benches --bench identity
cargo bench -p benches --bench fan_in
cargo bench -p benches --bench fan_out
cargo bench -p benches --bench fork_join
cargo bench -p benches --bench upcase
```

## Available Benchmarks

- **reachability**: Graph reachability algorithm comparing Timely, Differential, and Hydro implementations
- **join**: Hash join operations with different data types
- **arithmetic**: Pipeline arithmetic operations
- **identity**: Identity operation pipeline
- **fan_in**: Fan-in (union) operations
- **fan_out**: Fan-out (tee) operations
- **fork_join**: Fork-join pattern with multiple branches
- **upcase**: String manipulation operations
