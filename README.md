# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and test code that depend on timely and differential-dataflow. These components were moved from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to reduce dependency bloat and improve build times.

## Contents

### Benchmarks (`benches/`)

Microbenchmarks comparing Hydro implementations with timely and differential-dataflow:

- **arithmetic** - Arithmetic operations benchmark
- **fan_in** - Fan-in pattern benchmark
- **fan_out** - Fan-out pattern benchmark
- **fork_join** - Fork-join pattern benchmark
- **identity** - Identity operation benchmark
- **join** - Join operation benchmark
- **reachability** - Graph reachability using differential-dataflow
- **upcase** - String uppercase transformation benchmark

### Benchmark Client (`hydro_std/src/bench_client/`)

Benchmark client utilities for measuring latency and throughput in distributed systems:
- Histogram-based latency tracking
- Rolling average throughput calculation
- Transaction workload benchmarking framework

### Integration Tests (`hydro_test/src/cluster/`)

- **paxos_bench.rs** - Paxos consensus protocol benchmarks
- **two_pc_bench.rs** - Two-phase commit protocol benchmarks

## Running Benchmarks

```bash
# Run all benchmarks
cargo bench -p hydro-benches-timely

# Run specific benchmark
cargo bench -p hydro-benches-timely --bench reachability

# Generate detailed reports
cargo bench -p hydro-benches-timely -- --verbose
```

## Performance Comparisons

These benchmarks enable performance comparisons between:
- Timely/differential-dataflow implementations
- Hydro implementations in the main repository

The benchmark framework allows you to run the same workload on both implementations and compare results.

## Dependencies

This repository depends on:
- `timely-master` (0.13.0-dev.1)
- `differential-dataflow-master` (0.13.0-dev.1)

For dependencies on the main Hydro codebase, configure git dependencies pointing to the main repository.

## Documentation

See individual benchmark files and the [benches/README.md](benches/README.md) for more details about specific benchmarks.