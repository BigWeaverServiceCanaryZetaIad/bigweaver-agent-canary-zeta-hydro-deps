# bigweaver-agent-canary-zeta-hydro-deps

This repository contains dependency-related benchmarks for the Hydro project, separated from the main `bigweaver-agent-canary-hydro-zeta` repository to reduce dependency footprint and improve build times.

## Purpose

This repository maintains benchmarks for external dependencies like `timely` and `differential-dataflow` that are used to compare performance characteristics of Hydro against these baseline implementations. By separating these benchmarks:

- The main Hydro repository remains free of these heavy dependencies
- Build times for the main repository are significantly reduced
- Performance engineers can work on optimizations without impacting core development
- Benchmark suites can evolve independently of the main codebase

## Structure

- `benchmarks/` - Contains all dependency-related benchmarks
  - `timely_reachability.rs` - Benchmarks for timely dataflow reachability computations
  - `differential_dataflow_ops.rs` - Benchmarks for differential dataflow operations

## Running Benchmarks

To run all benchmarks:
```bash
cargo bench
```

To run a specific benchmark:
```bash
cargo bench --bench timely_reachability
cargo bench --bench differential_dataflow_ops
```

## Performance Comparisons

To perform performance comparisons between Hydro and these baseline implementations:

1. Run the benchmarks in this repository to establish baseline metrics
2. Run equivalent Hydro benchmarks in the main repository
3. Compare results to measure performance improvements or regressions

## Dependencies

This repository includes:
- `timely` (v0.12) - For timely dataflow benchmarks
- `differential-dataflow` (v0.12) - For differential dataflow benchmarks
- `criterion` (v0.5) - For benchmark harness

## Contributing

When adding new dependency benchmarks:
1. Create a new benchmark file in `benchmarks/benches/`
2. Add the benchmark configuration to `benchmarks/Cargo.toml`
3. Document the benchmark purpose and expected performance characteristics
4. Update this README with usage instructions