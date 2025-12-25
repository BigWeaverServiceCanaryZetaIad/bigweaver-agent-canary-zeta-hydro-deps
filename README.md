# bigweaver-agent-canary-zeta-hydro-deps

This repository contains dependencies and benchmarks for the Hydroflow project that require external dataflow framework dependencies (Timely Dataflow and Differential Dataflow).

## Contents

### Benchmarks (`/benches`)

Performance comparison benchmarks between Hydroflow and other dataflow frameworks (Timely Dataflow and Differential Dataflow). These benchmarks were separated from the main Hydroflow repository to keep the core repository lightweight and avoid unnecessary dependencies.

See the [benchmarks README](benches/README.md) for more details on running the performance comparisons.

## Purpose

This repository serves to:
1. Maintain performance comparison capabilities between Hydroflow and other dataflow frameworks
2. Isolate dependencies on `timely` and `differential-dataflow` packages from the main repository
3. Provide a dedicated space for benchmarking and performance analysis

## Related Repositories

- [hydro-project/hydro](https://github.com/hydro-project/hydro) - Main Hydroflow repository