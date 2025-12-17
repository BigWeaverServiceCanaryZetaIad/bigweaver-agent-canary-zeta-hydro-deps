# Hydro Comparison Benchmarks

This directory contains benchmarks comparing DFIR/Hydro with timely-dataflow and differential-dataflow.

## Purpose

These benchmarks were moved from the main `bigweaver-agent-canary-hydro-zeta` repository to:
1. Avoid introducing timely-dataflow and differential-dataflow as dependencies in the main codebase
2. Keep performance comparison capabilities available for evaluation
3. Maintain a clean separation between core functionality and external framework comparisons

## Benchmarks

This repository includes the following comparison benchmarks:

- **arithmetic** - Basic arithmetic operations across dataflow frameworks
- **fan_in** - Fan-in dataflow patterns performance comparison
- **fan_out** - Fan-out dataflow patterns performance comparison
- **fork_join** - Fork-join pattern implementations
- **identity** - Identity transformation benchmarks
- **join** - Join operation performance across frameworks
- **reachability** - Graph reachability algorithm comparisons (includes differential-dataflow)
- **upcase** - String transformation benchmarks

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p hydro-deps-benches
```

Run a specific benchmark:
```bash
cargo bench -p hydro-deps-benches --bench reachability
```

Run specific framework comparison within a benchmark:
```bash
cargo bench -p hydro-deps-benches --bench fan_in -- dfir
cargo bench -p hydro-deps-benches --bench fan_in -- timely
```

## Dependencies

This crate depends on:
- `dfir_rs` - The main Hydro/DFIR implementation (from upstream repository)
- `timely` - Timely dataflow framework
- `differential-dataflow` - Differential dataflow framework
- `criterion` - Benchmarking harness

## Results Interpretation

Benchmarks use the Criterion framework which provides:
- Statistical analysis of performance
- HTML reports in `target/criterion/`
- Comparison with previous runs
- Detection of performance regressions

View detailed results:
```bash
open target/criterion/report/index.html
```

## Migrating Back to Main Repository

If you need to move these benchmarks back to the main repository:

1. Copy benchmark files from `benches/benches/` to the main repo's `benches/benches/`
2. Add timely and differential-dataflow dependencies to main repo's `benches/Cargo.toml`
3. Update the benchmark declarations in `Cargo.toml`
4. Update documentation to reflect the change
