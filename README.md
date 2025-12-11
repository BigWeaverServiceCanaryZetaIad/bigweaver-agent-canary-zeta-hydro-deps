# bigweaver-agent-canary-zeta-hydro-deps

This repository contains dependencies and benchmarks for the BigWeaver Agent Canary Hydro Zeta project that require external dependencies like Timely Dataflow and Differential Dataflow.

## Structure

- **benches/** - Performance benchmarks comparing Hydro against Timely and Differential Dataflow

## Purpose

This repository serves to isolate external dependencies (timely, differential-dataflow) from the main `bigweaver-agent-canary-hydro-zeta` repository while maintaining the ability to run performance comparisons and benchmarks.

## Running Benchmarks

```bash
# Run all benchmarks
cargo bench -p benches

# Run a specific benchmark
cargo bench -p benches --bench reachability
```

## Related Repository

Main project: [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)