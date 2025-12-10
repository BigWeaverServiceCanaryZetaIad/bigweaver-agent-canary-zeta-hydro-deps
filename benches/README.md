# Timely and Differential-Dataflow Benchmarks

Benchmarks comparing Hydro/DFIR with timely and differential-dataflow implementations.

These benchmarks were moved from the main bigweaver-agent-canary-hydro-zeta repository to isolate the timely and differential-dataflow dependencies while maintaining the ability to run performance comparisons.

## Running Benchmarks

Run all benchmarks:
```
cargo bench -p benches
```

Run specific benchmarks:
```
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench fan_in
cargo bench -p benches --bench fan_out
cargo bench -p benches --bench fork_join
cargo bench -p benches --bench identity
cargo bench -p benches --bench join
cargo bench -p benches --bench upcase
```

## Benchmark Descriptions

- **reachability**: Graph reachability using differential-dataflow
- **arithmetic**: Basic arithmetic operations comparison
- **fan_in**: Multiple inputs converging to single output
- **fan_out**: Single input diverging to multiple outputs
- **fork_join**: Split and rejoin pattern
- **identity**: Pass-through operations
- **join**: Join operations on streams
- **upcase**: String transformation operations
