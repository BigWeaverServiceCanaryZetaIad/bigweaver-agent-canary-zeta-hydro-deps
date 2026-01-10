# Benchmark Guide

This guide explains how to use the timely and differential-dataflow benchmarks that were moved from the main `bigweaver-agent-canary-hydro-zeta` repository.

## Overview

The benchmarks in this repository test various aspects of the Hydro dataflow system's performance, particularly operations that depend on timely-dataflow and differential-dataflow.

## Prerequisites

- Rust toolchain (compatible with the main Hydro repository)
- Cargo (for running benchmarks)

## Installation

Clone this repository:
```bash
git clone <repository-url>
cd bigweaver-agent-canary-zeta-hydro-deps
```

## Running Benchmarks

### Run All Benchmarks

To run all benchmarks in the suite:
```bash
cargo bench -p benches
```

### Run Specific Benchmarks

To run a specific benchmark:
```bash
cargo bench -p benches --bench <benchmark-name>
```

Available benchmarks:
- `arithmetic` - Tests arithmetic operations performance
- `fan_in` - Tests fan-in dataflow patterns
- `fan_out` - Tests fan-out dataflow patterns
- `fork_join` - Tests fork-join patterns
- `futures` - Tests async futures operations
- `identity` - Tests identity transformations
- `join` - Tests join operations
- `micro_ops` - Tests micro-operations
- `reachability` - Tests graph reachability algorithms
- `symmetric_hash_join` - Tests symmetric hash join operations
- `upcase` - Tests string transformations
- `words_diamond` - Tests diamond dataflow pattern with word processing

### Examples

```bash
# Run the reachability benchmark
cargo bench -p benches --bench reachability

# Run the arithmetic benchmark
cargo bench -p benches --bench arithmetic

# Run the join benchmark
cargo bench -p benches --bench join
```

## Benchmark Results

Benchmark results are generated using the [Criterion](https://github.com/bheisler/criterion.rs) benchmarking framework and are saved in the `target/criterion` directory. The results include:

- HTML reports with performance graphs
- Statistical analysis of performance metrics
- Comparison with previous runs (when available)

To view the HTML reports, open `target/criterion/report/index.html` in a web browser after running benchmarks.

## Performance Comparison

### Comparing with Historical Data

If you have historical benchmark data, you can compare new results with previous runs:

1. Run benchmarks and save the baseline:
   ```bash
   cargo bench -p benches -- --save-baseline my-baseline
   ```

2. Make changes to the code

3. Run benchmarks again and compare:
   ```bash
   cargo bench -p benches -- --baseline my-baseline
   ```

### Comparing Across Branches

To compare performance across different branches:

1. On branch A, save a baseline:
   ```bash
   git checkout branch-a
   cargo bench -p benches -- --save-baseline branch-a
   ```

2. Switch to branch B and compare:
   ```bash
   git checkout branch-b
   cargo bench -p benches -- --baseline branch-a
   ```

## Benchmark Data Files

The benchmark suite includes test data files:

- **words_alpha.txt** - A comprehensive English word list from [dwyl/english-words](https://github.com/dwyl/english-words/blob/master/words_alpha.txt)
- **reachability_edges.txt** - Graph edges for reachability testing
- **reachability_reachable.txt** - Expected reachability results for verification

These files are used by various benchmarks to test performance on realistic data.

## Dependencies

The benchmarks depend on:

- **timely-master (timely-dataflow)** - For timely dataflow processing
- **differential-dataflow-master** - For differential dataflow processing
- **criterion** - For benchmarking framework
- **dfir_rs** - Referenced from the main Hydro repository (via git)
- **sinktools** - Referenced from the main Hydro repository (via git)

## Troubleshooting

### Build Errors

If you encounter build errors related to dependencies:

1. Ensure you have the latest Rust toolchain
2. Clear the cargo cache and rebuild:
   ```bash
   cargo clean
   cargo bench -p benches
   ```

### Missing Dependencies

If benchmarks fail due to missing dependencies from the main repository, ensure that:
1. The git URL in `benches/Cargo.toml` is correct
2. You have network access to fetch the dependencies
3. The main repository is accessible

## Contributing

When adding new benchmarks:

1. Create a new `.rs` file in `benches/benches/`
2. Add a `[[bench]]` entry in `benches/Cargo.toml`
3. Follow the existing benchmark patterns
4. Document the benchmark purpose and usage
5. Include test data files if needed

## Migration from Main Repository

These benchmarks were previously located in the main `bigweaver-agent-canary-hydro-zeta` repository under the `benches/` directory. They were moved to this separate repository to:

- Reduce dependency footprint in the main repository
- Improve build times for the main repository
- Better separate concerns between core functionality and performance testing
- Maintain the ability to run performance comparisons

All benchmark functionality and performance comparison capabilities have been preserved in the migration.
