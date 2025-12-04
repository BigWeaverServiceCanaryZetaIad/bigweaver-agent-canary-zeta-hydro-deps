# bigweaver-agent-canary-zeta-hydro-deps

This repository contains timely and differential-dataflow benchmarks that were moved from the main bigweaver-agent-canary-hydro-zeta repository to maintain separation of concerns and avoid including unnecessary dependencies in the core project.

## Benchmarks

The `benches` directory contains microbenchmarks for Hydro and related crates, comparing Hydro's DFIR with timely-dataflow and differential-dataflow implementations.

### Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench identity
```

### Available Benchmarks

- **arithmetic**: Arithmetic operations performance
- **fan_in**: Fan-in dataflow pattern
- **fan_out**: Fan-out dataflow pattern
- **fork_join**: Fork-join pattern
- **futures**: Async futures performance
- **identity**: Identity transformation
- **join**: Stream join operations
- **micro_ops**: Micro-operations performance
- **reachability**: Graph reachability analysis
- **symmetric_hash_join**: Symmetric hash join operations
- **upcase**: String uppercase transformation
- **words_diamond**: Diamond pattern with word processing

### Dependencies

This repository uses the following key dependencies:
- `timely-master`: Timely dataflow framework
- `differential-dataflow-master`: Differential dataflow framework
- `dfir_rs`: Hydro's Dataflow IR implementation
- `criterion`: Benchmarking framework

## Performance Comparison

These benchmarks allow for performance comparison between Hydro/DFIR and timely/differential-dataflow implementations. Results can be used to track performance improvements and regressions over time.

## Migration Information

These benchmarks were migrated from the main bigweaver-agent-canary-hydro-zeta repository to:
- Reduce dependencies in the core repository
- Maintain benchmark functionality in a dedicated location
- Enable independent benchmark execution and comparison

For more information about the main Hydro project, see: https://hydro.run