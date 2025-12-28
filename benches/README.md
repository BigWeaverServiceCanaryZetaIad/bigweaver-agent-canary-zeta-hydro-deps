# Timely and Differential Dataflow Benchmarks

Benchmarks comparing Hydro with Timely Dataflow and Differential Dataflow.

These benchmarks were moved from the main `bigweaver-agent-canary-hydro-zeta` repository to separate the dependencies on `timely` and `differential-dataflow` packages.

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench join
```

## Available Benchmarks

- **arithmetic**: Pipeline operation benchmarks
- **fan_in**: Fan-in pattern benchmarks
- **fan_out**: Fan-out pattern benchmarks
- **fork_join**: Fork-join pattern benchmarks
- **identity**: Identity operation benchmarks
- **join**: Join operation benchmarks
- **reachability**: Graph reachability benchmarks comparing Timely, Differential, and Hydro
- **upcase**: String uppercase operation benchmarks

## Dependencies

These benchmarks require:
- Access to the `bigweaver-agent-canary-hydro-zeta` repository for `dfir_rs` and `sinktools` dependencies
- `timely-master` and `differential-dataflow-master` packages

## Note

For benchmarks that don't use Timely or Differential Dataflow, see the `benches` directory in the `bigweaver-agent-canary-hydro-zeta` repository.
