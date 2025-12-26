# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks for the Hydro project that depend on timely and differential-dataflow.

## Benchmarks

The `benches/` directory contains performance benchmarks comparing Hydro/DFIR implementations against timely and differential-dataflow:

- **join.rs** - Join operation benchmarks using timely
- **fan_in.rs** - Fan-in operation benchmarks using timely
- **reachability.rs** - Graph reachability benchmarks using differential-dataflow
- Other micro-operation benchmarks

These benchmarks were moved from the main bigweaver-agent-canary-hydro-zeta repository to isolate the timely and differential-dataflow dependencies.

## Running Benchmarks

To run the benchmarks:

```bash
cargo bench
```

To run a specific benchmark:

```bash
cargo bench --bench <benchmark_name>
```