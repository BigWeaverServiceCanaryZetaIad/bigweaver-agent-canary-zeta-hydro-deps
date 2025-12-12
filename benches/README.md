# Benchmarks - Timely and Differential-Dataflow Comparisons

This directory contains benchmarks comparing Hydro/DFIR with timely-dataflow and differential-dataflow.

## Overview

These benchmarks were moved from the main bigweaver-agent-canary-hydro-zeta repository to isolate the timely and differential-dataflow dependencies.

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench
```

Run specific benchmarks:
```bash
cargo bench --bench reachability
cargo bench --bench arithmetic
cargo bench --bench fan_in
cargo bench --bench fan_out
cargo bench --bench fork_join
cargo bench --bench identity
cargo bench --bench join
cargo bench --bench upcase
```

## Benchmark Descriptions

- **arithmetic** - Compares basic arithmetic operations between DFIR and timely/differential
- **fan_in** - Tests fan-in patterns (multiple inputs converging)
- **fan_out** - Tests fan-out patterns (single input splitting to multiple outputs)
- **fork_join** - Tests fork-join patterns with generated code
- **identity** - Tests identity transformations
- **join** - Compares join operations
- **reachability** - Graph reachability using edges data
- **upcase** - String uppercase transformation benchmarks

## Performance Comparison

To compare with the DFIR-only benchmarks from the main repository:

1. Run benchmarks here: `cargo bench`
2. Run benchmarks in bigweaver-agent-canary-hydro-zeta: `cargo bench -p benches`
3. Compare the criterion output for matching benchmark names

## Data Files

- `reachability_edges.txt` - Graph edges for reachability benchmark
- `reachability_reachable.txt` - Expected reachable nodes for validation
