# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks comparing DFIR/Hydro with other frameworks including timely and differential-dataflow.

## Microbenchmarks

The `benches` directory contains microbenchmarks for DFIR and other frameworks.

### Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench join
```

### Benchmark Contents

The benchmarks include:
- Graph reachability algorithms
- Join operations with different data types
- Micro-operations (map, flat_map, union, tee, fold, sort, etc.)
- Performance comparisons with Timely Dataflow and Differential Dataflow

### Dependencies

The benchmarks depend on `dfir_rs` and `sinktools` from the main `bigweaver-agent-canary-hydro-zeta` repository. Ensure both repositories are checked out in the same parent directory for the benchmarks to work correctly.
