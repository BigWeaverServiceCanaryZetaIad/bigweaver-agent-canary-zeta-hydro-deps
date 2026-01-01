# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks for comparing Hydro with Timely Dataflow and Differential Dataflow.

## Contents

- **benches/**: Benchmark suite comparing performance of Timely Dataflow, Differential Dataflow, and Hydro implementations

## Running Benchmarks

To run all benchmarks:
```bash
cargo bench -p benches
```

To run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench join
cargo bench -p benches --bench fan_out
```

## Dependencies

The benchmarks in this repository depend on:
- Timely Dataflow (timely-master)
- Differential Dataflow (differential-dataflow-master)
- Hydro (`dfir_rs` and `sinktools` from the main Hydro repository)

The path dependencies point to the main `bigweaver-agent-canary-hydro-zeta` repository to access Hydro's implementation.