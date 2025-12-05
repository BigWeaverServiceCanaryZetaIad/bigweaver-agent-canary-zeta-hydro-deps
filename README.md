# Hydro Timely and Differential-Dataflow Benchmarks

This repository contains performance benchmarks comparing Hydro implementations with timely and differential-dataflow implementations. These benchmarks were moved from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to maintain a clean separation of concerns and reduce the dependency footprint of the main repository.

## Purpose

The benchmarks in this repository serve to:
- Compare performance between Hydro and timely/differential-dataflow implementations
- Track performance regressions and improvements over time
- Validate that Hydro's optimizations maintain competitive performance

## Available Benchmarks

The following benchmarks are available:

- **arithmetic**: Pipeline of arithmetic operations
- **fan_in**: Multiple inputs merging into a single stream
- **fan_out**: Single input distributing to multiple streams
- **fork_join**: Fork-join pattern with filtering
- **futures**: Async operations benchmarks
- **identity**: Identity transformation (baseline)
- **join**: Join operations
- **micro_ops**: Various micro-operations
- **reachability**: Graph reachability computation
- **symmetric_hash_join**: Symmetric hash join operations
- **upcase**: String transformation operations
- **words_diamond**: Diamond pattern on word processing

## Running Benchmarks

### Run All Benchmarks

```bash
cargo bench
```

### Run Specific Benchmark

```bash
cargo bench --bench <benchmark_name>
```

For example:
```bash
cargo bench --bench reachability
cargo bench --bench arithmetic
```

### Run Specific Test Within a Benchmark

```bash
cargo bench --bench <benchmark_name> <test_pattern>
```

For example:
```bash
cargo bench --bench arithmetic dfir_rs
```

## Dependencies

This repository depends on:
- **timely-master**: Timely dataflow framework
- **differential-dataflow-master**: Differential dataflow framework  
- **dfir_rs**: DFIR (Dataflow IR) from the main Hydro repository
- **sinktools**: Utilities from the main Hydro repository
- **criterion**: Benchmarking framework

The `dfir_rs` and `sinktools` dependencies are pulled from the main Hydro repository via git dependencies to ensure benchmarks always test against the latest version.

## Benchmark Results

Benchmark results are generated in HTML format and can be found in `target/criterion/` after running the benchmarks.

## Contributing

When adding new benchmarks:
1. Add the benchmark file to the `benches/` directory
2. Register it in `Cargo.toml` under `[[bench]]` sections
3. Update this README with a description of the benchmark

## Migration

These benchmarks were migrated from the main Hydro repository. For more information on the migration, see the [BENCHMARK_MIGRATION.md](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta/blob/main/BENCHMARK_MIGRATION.md) in the main repository.