# Hydro Benchmarks (Timely/Differential-Dataflow)

This directory contains benchmarks that depend on timely and differential-dataflow.

These benchmarks were moved from the main Hydro repository to avoid including timely and differential-dataflow as dependencies in the main codebase.

## Available Benchmarks

- `arithmetic` - Arithmetic operation benchmarks using timely dataflow
- `fan_in` - Fan-in pattern benchmarks
- `fan_out` - Fan-out pattern benchmarks
- `fork_join` - Fork-join pattern benchmarks
- `identity` - Identity operation benchmarks
- `join` - Join operation benchmarks
- `reachability` - Graph reachability benchmarks
- `upcase` - String uppercase transformation benchmarks

## Running Benchmarks

To run all benchmarks:
```bash
cargo bench
```

To run a specific benchmark:
```bash
cargo bench --bench <benchmark_name>
```

For example:
```bash
cargo bench --bench reachability
```

## Performance Comparison

To compare performance across different versions or changes:

1. Run benchmarks on the baseline:
   ```bash
   cargo bench -- --save-baseline baseline
   ```

2. Make your changes

3. Run benchmarks again and compare:
   ```bash
   cargo bench -- --baseline baseline
   ```
