# Timely/Differential-Dataflow Benchmarks

This directory contains microbenchmarks that depend on `timely` and `differential-dataflow` packages.

These benchmarks were moved from the main bigweaver-agent-canary-hydro-zeta repository to keep the main repository free of these dependencies while retaining the ability to run performance comparisons.

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
```

## Available Benchmarks

- **arithmetic**: Arithmetic operations pipeline benchmark
- **fan_in**: Fan-in pattern benchmark
- **fan_out**: Fan-out pattern benchmark
- **fork_join**: Fork-join pattern benchmark
- **identity**: Identity operation benchmark
- **join**: Join operation benchmark
- **reachability**: Graph reachability benchmark (uses differential-dataflow)
- **upcase**: String uppercase transformation benchmark

## Performance Comparisons

To compare performance with the non-timely benchmarks in the main repository, run benchmarks in both repositories and compare the results in the `target/criterion` directories.
