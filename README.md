# bigweaver-agent-canary-zeta-hydro-deps

This repository contains dependencies and benchmarks for the Hydro project that depend on timely and differential-dataflow packages. These have been separated from the main bigweaver-agent-canary-hydro-zeta repository to avoid dependency bloat while maintaining the ability to run performance comparisons.

## Contents

### Benchmarks

The `benches/` directory contains microbenchmarks that use timely and differential-dataflow:

- **arithmetic**: Pipeline arithmetic operations benchmark
- **fan_in**: Fan-in dataflow pattern benchmark
- **fan_out**: Fan-out dataflow pattern benchmark
- **fork_join**: Fork-join pattern benchmark
- **identity**: Identity transformation benchmark
- **join**: Join operation benchmark
- **reachability**: Graph reachability benchmark
- **upcase**: String transformation benchmark

## Running Benchmarks

To run benchmarks from this repository:

```bash
cargo bench -p benches
```

To run a specific benchmark:

```bash
cargo bench -p benches --bench reachability
```

## Dependencies

This repository maintains git dependencies to the main Hydro repository for:
- `dfir_rs`: Core Hydro dataflow framework
- `sinktools`: Utilities for sink operations

## Purpose

Separating these benchmarks maintains a clean separation of concerns:
- The main repository avoids timely/differential-dataflow dependencies
- Performance comparison capabilities are preserved
- Benchmark code remains accessible and maintainable
