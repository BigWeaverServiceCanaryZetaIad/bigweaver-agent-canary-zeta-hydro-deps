# Timely and Differential-Dataflow Benchmarks

This directory contains benchmarks that depend on the timely and differential-dataflow packages. These benchmarks were moved from the main bigweaver-agent-canary-hydro-zeta repository to isolate these dependencies.

## Running Benchmarks

To run all benchmarks:

```bash
cargo bench
```

To run a specific benchmark:

```bash
cargo bench --bench <benchmark_name>
```

## Available Benchmarks

- **arithmetic**: Pipeline arithmetic operations using timely
- **fan_in**: Fan-in pattern benchmarks using timely
- **fan_out**: Fan-out pattern benchmarks using timely
- **fork_join**: Fork-join pattern benchmarks using timely
- **identity**: Identity transformation benchmarks using timely
- **join**: Join operation benchmarks using timely
- **reachability**: Graph reachability benchmarks using differential-dataflow
- **upcase**: String uppercase transformation benchmarks using timely

## Performance Comparisons

These benchmarks can be used to compare performance across different implementations and configurations. Results are generated in HTML format and can be found in the `target/criterion` directory after running the benchmarks.
