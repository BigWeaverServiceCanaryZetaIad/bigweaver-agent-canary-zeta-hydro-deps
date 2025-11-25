# Timely and Differential-Dataflow Benchmarks

This directory contains microbenchmarks for [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow) and [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow), comparing their performance with Hydro (dfir_rs).

## Overview

These benchmarks were migrated from the main `bigweaver-agent-canary-hydro-zeta` repository to keep dependency-related benchmarks in a separate repository, maintaining clean separation of concerns.

## Benchmarks

The following benchmarks are included:

### Timely Dataflow Benchmarks

- **arithmetic** - Tests arithmetic operations through a pipeline
- **fan_in** - Tests merging multiple streams
- **fan_out** - Tests splitting data to multiple consumers
- **fork_join** - Tests forking and joining data streams
- **identity** - Tests data passing with minimal transformations
- **join** - Tests join operations on data streams
- **upcase** - Tests string transformation operations

### Differential Dataflow Benchmarks

- **reachability** - Tests graph reachability computation using differential dataflow
  - Uses data files: `reachability_edges.txt` and `reachability_reachable.txt`

## Running Benchmarks

### Run All Benchmarks

```bash
cargo bench -p timely-benchmarks
```

### Run Specific Benchmark

```bash
cargo bench -p timely-benchmarks --bench reachability
cargo bench -p timely-benchmarks --bench arithmetic
cargo bench -p timely-benchmarks --bench join
```

### Run Multiple Benchmarks

```bash
cargo bench -p timely-benchmarks --bench reachability --bench arithmetic --bench join
```

## Dependencies

The benchmarks depend on:
- `timely` (timely-master) - Timely Dataflow framework
- `differential-dataflow` (differential-dataflow-master) - Differential Dataflow framework
- `dfir_rs` - Hydro's dataflow runtime (from main repository)
- `criterion` - Benchmarking framework
- Various supporting crates (futures, rand, tokio, etc.)

## Benchmark Structure

Each benchmark compares different implementations:
1. **Timely/Differential implementation** - Using the respective dataflow framework
2. **Hydro implementation** - Using dfir_rs (compiled and surface syntax)
3. **Baseline implementations** - Raw Rust, iterators, or channels for comparison

## Performance Comparisons

These benchmarks enable performance comparisons between:
- Timely Dataflow
- Differential Dataflow  
- Hydro (dfir_rs)
- Standard Rust implementations

Results are generated in HTML format by Criterion and saved in the `target/criterion/` directory.

## Migration Notes

These benchmarks were moved from `bigweaver-agent-canary-hydro-zeta/benches` to this repository on 2024-11-25 to maintain better separation between core functionality and dependency benchmarks.

For migration details, see [MIGRATION.md](../MIGRATION.md).
