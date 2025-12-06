# Timely and Differential Dataflow Benchmarks

This repository contains microbenchmarks for comparing Hydro implementations with Timely Dataflow and Differential Dataflow.

## Overview

These benchmarks were separated from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to isolate dependencies on `timely` and `differential-dataflow` packages. This separation helps keep the main repository focused on core Hydro functionality while maintaining the ability to run performance comparisons.

## Benchmarks

The following benchmarks are included:

- **arithmetic**: Pipeline arithmetic operations
- **fan_in**: Multiple data sources merging into one stream
- **fan_out**: Single data source splitting into multiple streams
- **fork_join**: Parallel processing with join operations
- **identity**: Baseline identity transformation
- **join**: Stream join operations
- **reachability**: Graph reachability algorithm
- **upcase**: String transformation operations

## Running Benchmarks

### Run all benchmarks:
```bash
cargo bench -p benches
```

### Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
```

### Run benchmarks with HTML reports:
```bash
cargo bench -p benches -- --save-baseline my-baseline
```

This will generate HTML reports in `target/criterion/` showing performance metrics and charts.

## Performance Comparison with Hydro

To enable performance comparisons with Hydro implementations, use the `compare_hydro` feature:

```bash
cargo bench -p benches --features compare_hydro
```

This feature enables the optional `dfir_rs` dependency from the main Hydro repository, allowing direct performance comparisons between Timely/Differential implementations and Hydro implementations.

### Comparing Baselines

To compare performance between different versions or implementations:

```bash
# Run baseline for current implementation
cargo bench -p benches -- --save-baseline timely-current

# Make changes or switch implementations
cargo bench -p benches --features compare_hydro -- --save-baseline hydro-current

# Compare the two baselines
cargo bench -p benches -- --baseline timely-current --load-baseline hydro-current
```

## Dependencies

This benchmark suite depends on:
- `timely-master`: Timely Dataflow framework
- `differential-dataflow-master`: Differential Dataflow framework
- `criterion`: Benchmarking framework with statistical analysis
- `dfir_rs` (optional): Hydro's dataflow implementation for comparison

## Data Files

Some benchmarks use external data files:
- `reachability_edges.txt`: Graph edges for reachability benchmark
- `reachability_reachable.txt`: Expected reachable nodes for verification

## Cross-Repository Performance Testing

For comprehensive performance testing across both repositories:

1. **Clone both repositories**:
   ```bash
   git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git
   git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
   ```

2. **Run Hydro benchmarks** (if any remain in main repo):
   ```bash
   cd bigweaver-agent-canary-hydro-zeta
   cargo bench -p benches
   ```

3. **Run Timely/Differential benchmarks**:
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps
   cargo bench -p benches
   ```

4. **Compare results**:
   Review the generated reports in `target/criterion/` in each repository.

## Contributing

When adding new benchmarks:
1. Add the benchmark file to `benches/benches/`
2. Update `Cargo.toml` to include the new `[[bench]]` entry
3. Ensure the benchmark follows the existing patterns
4. Update this README to document the new benchmark

## Notes

- All benchmarks use `harness = false` to use the Criterion framework directly
- Benchmarks are compiled with optimizations enabled by default
- The `build.rs` script generates some benchmark code at compile time (e.g., `fork_join`)
