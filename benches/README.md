# Timely and Differential-Dataflow Benchmarks

This directory contains benchmarks that compare Hydro's performance with timely and differential-dataflow implementations.

## Purpose

These benchmarks were moved from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to avoid having timely and differential-dataflow as direct dependencies in the main codebase. This separation allows for:

- Cleaner dependency management in the main repository
- Focused performance comparison testing
- Independent benchmark execution without affecting the main codebase

## Available Benchmarks

The following benchmarks compare Hydro, timely, and differential-dataflow implementations:

- **arithmetic**: Arithmetic operations performance across multiple stages
- **fan_in**: Fan-in pattern performance (multiple inputs to single output)
- **fan_out**: Fan-out pattern performance (single input to multiple outputs)
- **fork_join**: Fork-join pattern performance
- **identity**: Identity operations performance (passthrough)
- **join**: Join operations performance
- **reachability**: Graph reachability algorithm performance
- **upcase**: String upper-casing performance

## Running Benchmarks

```bash
# Run all benchmarks
cargo bench

# Run a specific benchmark
cargo bench --bench reachability

# Run all benchmarks with specific test filter
cargo bench arithmetic
```

## Cross-Repository Comparison

To compare these benchmarks with the Hydro-native benchmarks in the main repository:

1. Ensure both repositories are cloned:
   ```bash
   git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git
   git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
   ```

2. Run benchmarks in this repository:
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps
   cargo bench
   ```

3. Run the Hydro-native benchmarks in the main repository:
   ```bash
   cd ../bigweaver-agent-canary-hydro-zeta/benches
   cargo bench
   ```

4. Compare the results from `target/criterion/` in both repositories.

## Dependencies

The benchmarks in this repository depend on:
- **timely**: High-performance dataflow system
- **differential-dataflow**: Incremental computation framework built on timely
- **dfir_rs**: Referenced from the main hydro repository via git dependency
- **criterion**: Benchmarking framework

## Notes

- The dfir_rs dependency is fetched from the main repository using a git dependency
- All benchmark data files (e.g., `reachability_edges.txt`) are included in this repository
- Results are stored in `target/criterion/` and can be viewed in the generated HTML reports
