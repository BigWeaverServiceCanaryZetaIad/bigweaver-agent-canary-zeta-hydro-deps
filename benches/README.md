# Timely and Differential-Dataflow Benchmarks

This directory contains benchmarks that depend on timely and differential-dataflow packages.

## Available Benchmarks

- `arithmetic` - Arithmetic operations benchmark using timely
- `fan_in` - Fan-in pattern benchmark using timely
- `fan_out` - Fan-out pattern benchmark using timely
- `fork_join` - Fork-join pattern benchmark using timely
- `identity` - Identity operation benchmark using timely
- `join` - Join operation benchmark using timely
- `reachability` - Graph reachability benchmark using differential-dataflow
- `upcase` - Uppercase operation benchmark using timely

## Running Benchmarks

```bash
cargo bench
```

To run a specific benchmark:

```bash
cargo bench --bench <benchmark_name>
```

## Performance Comparisons

These benchmarks can be compared with the non-timely benchmarks in the main bigweaver-agent-canary-hydro-zeta repository to evaluate performance differences between implementations.
