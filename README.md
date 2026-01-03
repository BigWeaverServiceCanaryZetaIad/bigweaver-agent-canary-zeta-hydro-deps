# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and performance comparison tools for the Hydro project. It is separated from the main Hydro repository to isolate dependencies on timely-dataflow and differential-dataflow packages.

## Benchmarks

The `benches` directory contains microbenchmarks for DFIR and other frameworks including Timely Dataflow and Differential Dataflow.

### Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench join
cargo bench -p benches --bench identity
```

### Benchmark Files

- `benches/benches/join.rs` - Join operation benchmarks with timely-dataflow
- `benches/benches/identity.rs` - Identity operation benchmarks with timely-dataflow
- `benches/benches/reachability.rs` - Graph reachability benchmarks with both timely and differential-dataflow
- `benches/benches/micro_ops.rs` - Micro-operations benchmarks
- Other benchmark files for various operations

### Dependencies

The benchmarks depend on packages from the main Hydro repository:
- `dfir_rs` - The main DFIR runtime
- `sinktools` - Utility tools

These dependencies are referenced via relative paths pointing to the `bigweaver-agent-canary-hydro-zeta` repository.