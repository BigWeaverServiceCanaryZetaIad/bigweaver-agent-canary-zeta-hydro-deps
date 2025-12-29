# Timely and Differential Dataflow Benchmarks

This repository contains benchmarks that compare Hydro/DFIR performance against Timely Dataflow and Differential Dataflow.

## Overview

These benchmarks were moved from the main Hydro repository to separate the heavy dependencies (timely and differential-dataflow) and enable independent benchmark execution.

## Benchmarks

### Timely Dataflow Comparisons
- **arithmetic.rs** - Pipeline arithmetic operations with multiple map stages
- **fan_in.rs** - Fan-in dataflow patterns
- **fan_out.rs** - Fan-out dataflow patterns
- **fork_join.rs** - Fork-join dataflow patterns
- **identity.rs** - Identity/passthrough operations
- **join.rs** - Join operations with different data types
- **upcase.rs** - String transformation operations

### Differential Dataflow Comparisons
- **reachability.rs** - Graph reachability algorithms comparing Timely, Differential, and Hydro implementations

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p hydro-deps-benches
```

Run specific benchmarks:
```bash
cargo bench -p hydro-deps-benches --bench reachability
cargo bench -p hydro-deps-benches --bench arithmetic
```

## Data Files

- **reachability_edges.txt** - Graph edges for reachability benchmark
- **reachability_reachable.txt** - Expected reachable vertices for validation
- **words_alpha.txt** - Wordlist from https://github.com/dwyl/english-words/blob/master/words_alpha.txt

## Performance Comparison

These benchmarks provide performance comparisons between:
- Hydro/DFIR (surface syntax and compiled variants)
- Timely Dataflow
- Differential Dataflow
- Raw Rust implementations (for baseline comparison)

The benchmarks use Criterion for statistical analysis and HTML report generation.

## Dependencies

The benchmarks depend on:
- `dfir_rs` - The main Hydro dataflow library
- `timely` - Timely Dataflow framework
- `differential-dataflow` - Differential Dataflow framework
- `criterion` - Benchmarking framework with statistics
- `sinktools` - Hydro sink utilities

These dependencies are fetched from their respective sources to ensure compatibility.
