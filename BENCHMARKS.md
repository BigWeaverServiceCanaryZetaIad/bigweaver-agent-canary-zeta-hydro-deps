# Timely and Differential Dataflow Benchmarks

Benchmarks comparing Hydro/DFIR performance with Timely Dataflow and Differential Dataflow.

These benchmarks were moved from the main bigweaver-agent-canary-hydro-zeta repository to maintain clean dependency separation, as they require `timely` and `differential-dataflow` dependencies that are not needed by the core Hydro/DFIR codebase.

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench
```

Run specific benchmarks:
```bash
cargo bench --bench reachability
cargo bench --bench join
cargo bench --bench arithmetic
```

## Available Benchmarks

The following benchmarks compare Hydro/DFIR implementations with Timely/Differential Dataflow:

- **arithmetic**: Arithmetic operations performance comparison
- **fan_in**: Fan-in pattern performance
- **fan_out**: Fan-out pattern performance  
- **fork_join**: Fork-join pattern performance
- **identity**: Identity transformation performance
- **join**: Join operations with different data types
- **reachability**: Graph reachability algorithms
- **upcase**: String uppercase transformation performance

## Performance Comparison

These benchmarks help validate that Hydro/DFIR maintains competitive performance relative to established dataflow frameworks like Timely Dataflow and Differential Dataflow. They are used to identify regressions, demonstrate competitive performance, and guide optimization efforts.
