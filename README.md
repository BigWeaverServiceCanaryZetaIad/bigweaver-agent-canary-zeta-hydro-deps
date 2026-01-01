# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks for Timely Dataflow and Differential Dataflow, separated from the main Hydro repository to avoid dependency entanglement.

## Benchmarks

The `benches` directory contains microbenchmarks comparing DFIR/Hydro performance with Timely Dataflow and Differential Dataflow.

### Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
```

### Benchmark Dependencies

The benchmarks depend on:
- `dfir_rs` - from the main bigweaver-agent-canary-hydro-zeta repository
- `sinktools` - from the main bigweaver-agent-canary-hydro-zeta repository
- `timely-master` - Timely Dataflow
- `differential-dataflow-master` - Differential Dataflow

These dependencies allow performance comparison testing between different dataflow frameworks.