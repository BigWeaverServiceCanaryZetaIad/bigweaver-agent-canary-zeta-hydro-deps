# bigweaver-agent-canary-zeta-hydro-deps

This repository contains performance benchmarks for Hydro and other dataflow frameworks (Timely Dataflow and Differential Dataflow). The benchmarks have been separated from the main Hydro repository to avoid having unnecessary dependencies in the main codebase.

## Benchmarks

The `benches` directory contains microbenchmarks for DFIR and other frameworks, including:
- Graph reachability algorithms
- Join operations with different data types
- Micro-operations (map, flat_map, union, tee, fold, sort, etc.)
- And other performance comparisons

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

### Dependencies

The benchmarks depend on:
- `dfir_rs` from the main Hydro repository
- `sinktools` from the main Hydro repository
- `timely` (Timely Dataflow)
- `differential-dataflow` (Differential Dataflow)

These dependencies are pulled from the main Hydro repository via git to ensure benchmarks stay synchronized with the latest codebase.