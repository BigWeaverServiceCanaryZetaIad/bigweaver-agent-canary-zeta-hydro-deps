# Timely and Differential Dataflow Benchmarks

This directory contains benchmarks that use timely-dataflow and differential-dataflow dependencies for performance testing.

## Overview

These benchmarks were migrated from the main repository to separate the timely and differential-dataflow dependencies from the core codebase. The benchmarks focus exclusively on timely and differential-dataflow performance characteristics.

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p timely-differential-benches
```

Run specific benchmarks:
```bash
cargo bench -p timely-differential-benches --bench arithmetic
cargo bench -p timely-differential-benches --bench fan_in
cargo bench -p timely-differential-benches --bench fan_out
cargo bench -p timely-differential-benches --bench fork_join
cargo bench -p timely-differential-benches --bench identity
cargo bench -p timely-differential-benches --bench join
cargo bench -p timely-differential-benches --bench reachability
cargo bench -p timely-differential-benches --bench upcase
cargo bench -p timely-differential-benches --bench zip
```

## Benchmark Descriptions

- **arithmetic** - Arithmetic operations benchmark using timely-dataflow
- **fan_in** - Fan-in pattern benchmark for data aggregation using timely-dataflow
- **fan_out** - Fan-out pattern benchmark for data distribution using timely-dataflow
- **fork_join** - Fork-join pattern benchmark using timely-dataflow
- **identity** - Identity operation benchmark (data pass-through) using timely-dataflow
- **join** - Join operation benchmark using timely-dataflow
- **reachability** - Graph reachability computation benchmark using timely-dataflow
- **upcase** - String uppercase transformation benchmark using timely-dataflow
- **zip** - Zip operation benchmark using timely-dataflow

## Data Files

- `reachability_edges.txt` - Edge data for reachability benchmark
- `reachability_reachable.txt` - Expected reachable nodes for verification

## Cross-Repository Comparison

To compare performance between this repository and the main repository, use the comparison script in the parent directory:

```bash
cd ..
./scripts/compare_benchmarks.sh
```
