# Timely and Differential Dataflow Benchmarks

Performance comparison benchmarks for Hydro vs. Timely and Differential Dataflow.

These benchmarks were moved from the main `bigweaver-agent-canary-hydro-zeta` repository to isolate the `timely` and `differential-dataflow` dependencies while maintaining the ability to run performance comparisons.

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p timely-differential-benches
```

Run specific benchmarks:
```bash
cargo bench -p timely-differential-benches --bench reachability
cargo bench -p timely-differential-benches --bench arithmetic
```

## Available Benchmarks

- **arithmetic**: Arithmetic operations comparison
- **fan_in**: Fan-in pattern benchmarks
- **fan_out**: Fan-out pattern benchmarks  
- **fork_join**: Fork-join pattern benchmarks
- **identity**: Identity transformation benchmarks
- **join**: Join operation benchmarks
- **reachability**: Graph reachability benchmarks
- **upcase**: String uppercase transformation benchmarks

## Data Files

- `reachability_edges.txt`: Input data for reachability benchmark
- `reachability_reachable.txt`: Expected output for reachability benchmark

## Dependencies

These benchmarks depend on:
- `timely-master` (v0.13.0-dev.1)
- `differential-dataflow-master` (v0.13.0-dev.1)
- `dfir_rs` from the main Hydro repository (for performance comparison)
- `sinktools` from the main Hydro repository (for performance comparison)
