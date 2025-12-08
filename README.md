# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for the Hydro project that depend on `timely` and `differential-dataflow`.

## Purpose

This repository was created to isolate benchmarks that depend on `timely` and `differential-dataflow` packages from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository. This separation:

- Keeps the main repository's codebase cleaner by preventing unnecessary dependencies
- Maintains the ability to run performance comparisons with timely/differential-dataflow implementations
- Provides better isolation between core Hydro functionality and external framework benchmarks

## Contents

### Benchmarks (`benches/`)

Microbenchmarks comparing Hydro/DFIR implementations with timely and differential-dataflow. These benchmarks include:

- **arithmetic**: Pipeline arithmetic operations
- **fan_in**: Fan-in dataflow patterns
- **fan_out**: Fan-out dataflow patterns  
- **fork_join**: Fork-join patterns
- **futures**: Future-based async operations
- **identity**: Identity transformations
- **join**: Join operations
- **micro_ops**: Micro-operations benchmarks
- **reachability**: Graph reachability algorithms
- **symmetric_hash_join**: Symmetric hash join operations
- **upcase**: String case transformations
- **words_diamond**: Word processing in diamond pattern

## Running Benchmarks

### Prerequisites

Ensure you have Rust and Cargo installed. The benchmarks use Criterion for performance measurement.

### Run All Benchmarks

```bash
cargo bench -p benches
```

### Run Specific Benchmark

```bash
cargo bench -p benches --bench reachability
```

### Run Specific Benchmark Function

```bash
cargo bench -p benches --bench arithmetic -- pipeline
```

## Performance Comparisons

To compare Hydro/DFIR performance with the benchmarks in this repository:

1. Run benchmarks in this repository to establish baseline measurements
2. Run equivalent benchmarks in the main Hydro repository
3. Use Criterion's built-in comparison tools to analyze results

Criterion automatically saves benchmark results and can compare them across runs:

```bash
# Run baseline in this repo
cargo bench -p benches --bench arithmetic

# Then compare with main repo benchmarks or subsequent runs
# Criterion will show performance differences
```

## Dependencies

The benchmarks depend on:

- **dfir_rs**: Core DFIR runtime from the main Hydro repository
- **sinktools**: Utility tools from the main Hydro repository  
- **timely**: Timely dataflow framework
- **differential-dataflow**: Differential dataflow framework
- **criterion**: Benchmarking framework

Dependencies on the main Hydro repository (`dfir_rs`, `sinktools`) are referenced via Git to ensure compatibility while maintaining repository separation.

## Migration Notes

These benchmarks were migrated from the main `bigweaver-agent-canary-hydro-zeta` repository to maintain cleaner separation of concerns. The migration:

- Removed timely/differential-dataflow dependencies from the main repository
- Retained all benchmark code and test data
- Preserved the ability to run performance comparisons
- Uses Git dependencies to reference required components from the main repository

## Contributing

When adding new benchmarks:

1. Add the benchmark file to `benches/benches/`
2. Register it in `benches/Cargo.toml` under `[[bench]]` sections
3. Follow existing patterns for comparing Hydro/DFIR with timely/differential implementations
4. Update this README with a description of the new benchmark

## Data Files

Some benchmarks use test data files:

- `reachability_edges.txt`: Graph edges for reachability benchmark
- `reachability_reachable.txt`: Expected reachability results
- `words_alpha.txt`: English word list (from https://github.com/dwyl/english-words)

## License

Apache-2.0 (same as the main Hydro project)