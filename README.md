# Hydro Timely/Differential-Dataflow Comparison Benchmarks

This repository contains benchmarks that compare Hydro's DFIR with [timely-dataflow](https://github.com/TimelyDataflow/timely-dataflow) and [differential-dataflow](https://github.com/TimelyDataflow/differential-dataflow).

## Purpose

These benchmarks are separated from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to avoid introducing timely and differential-dataflow as dependencies in the main codebase. This separation allows for:

- Cleaner dependency management in the main repository
- Faster build times for the core Hydro project
- Focused performance comparison testing
- Preservation of benchmark history and comparison capabilities

## Available Benchmarks

The following benchmarks compare DFIR performance against timely-dataflow and differential-dataflow:

- **arithmetic**: Arithmetic operations pipeline
- **fan_in**: Fan-in dataflow patterns
- **fan_out**: Fan-out dataflow patterns  
- **fork_join**: Fork-join patterns
- **identity**: Identity operation (baseline)
- **join**: Join operations
- **reachability**: Graph reachability computation
- **upcase**: String uppercase transformation

## Running Benchmarks

To run all benchmarks:

```bash
cargo bench
```

To run a specific benchmark:

```bash
cargo bench --bench arithmetic
```

To run with a specific pattern:

```bash
cargo bench fan
```

## Benchmark Results

Benchmark results are stored in `target/criterion/` and include:

- HTML reports with performance graphs
- Statistical analysis of performance data
- Comparison across different runs

View the HTML reports by opening `target/criterion/report/index.html` in a web browser after running the benchmarks.

## Comparing with Hydro-Native Benchmarks

The main Hydro repository contains native benchmarks that don't require external dependencies. To compare:

1. Run these comparison benchmarks:
   ```bash
   cargo bench
   ```

2. In the main bigweaver-agent-canary-hydro-zeta repository, run the native benchmarks:
   ```bash
   cargo bench -p benches
   ```

3. Compare the results from both `target/criterion/` directories

## Adding New Benchmarks

To add a new comparison benchmark:

1. Create a new file in `benches/` directory
2. Implement benchmarks comparing DFIR with timely/differential-dataflow
3. Add a `[[bench]]` section to `Cargo.toml`
4. Update this README with the benchmark description

## Dependencies

This repository depends on:

- **dfir_rs**: Referenced from the main Hydro repository via git
- **timely-dataflow**: For comparison benchmarking
- **differential-dataflow**: For comparison benchmarking
- **criterion**: For benchmark framework and reporting

## Related Repositories

- [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta): Main Hydro repository with native benchmarks