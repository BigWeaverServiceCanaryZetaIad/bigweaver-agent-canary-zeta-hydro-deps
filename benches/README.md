# Timely and Differential Dataflow Benchmarks

Performance comparisons between Hydro and Timely/Differential Dataflow frameworks.

These benchmarks were moved from the main bigweaver-agent-canary-hydro-zeta repository
to isolate the timely and differential-dataflow dependencies.

## Benchmarks

- **arithmetic**: Basic arithmetic operations across frameworks
- **fan_in**: Fan-in dataflow patterns and concatenation
- **fan_out**: Fan-out dataflow patterns and distribution
- **fork_join**: Fork-join parallel patterns
- **identity**: Identity transformation operations
- **join**: Hash join operations with different data types (usize, String)
- **reachability**: Graph reachability algorithms (includes test data)
- **upcase**: String uppercase transformation

Run all benchmarks:
```
cargo bench -p benches
```

Run specific benchmarks:
```
cargo bench -p benches --bench reachability
```

## Test Data

- **reachability_edges.txt**: Graph edges for reachability benchmarks
- **reachability_reachable.txt**: Expected reachable nodes for validation
