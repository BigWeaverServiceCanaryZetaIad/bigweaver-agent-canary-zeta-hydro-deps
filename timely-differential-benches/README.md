# Timely and Differential Dataflow Benchmarks

This directory contains benchmarks for the Timely Dataflow and Differential Dataflow frameworks. These benchmarks serve as comparison baselines for evaluating the performance of Hydro and DFIR.

## Overview

The benchmarks in this directory focus exclusively on Timely and Differential Dataflow implementations, without any DFIR/Hydro code. This separation allows for:

- Clean performance comparisons between frameworks
- Easier maintenance of framework-specific code
- Independent execution of Timely/Differential benchmarks

## Available Benchmarks

### Reachability
Graph reachability computation benchmark that demonstrates:
- **Timely implementation**: Using feedback loops and stateful filtering
- **Differential implementation**: Using iterative fixed-point computation with semijoin operations

This benchmark computes all nodes reachable from a starting node in a directed graph.

### Join
Hash join benchmark that demonstrates:
- **Timely implementation**: Manual hash join using binary operators

This benchmark measures the performance of joining two collections on a common key.

## Running Benchmarks

Run all benchmarks in this package:
```bash
cargo bench -p timely-differential-benches
```

Run specific benchmarks:
```bash
cargo bench -p timely-differential-benches --bench reachability
cargo bench -p timely-differential-benches --bench join
```

## Dependencies

This package depends on:
- `timely` (timely-master): Core Timely Dataflow framework
- `differential-dataflow` (differential-dataflow-master): Differential Dataflow framework built on Timely
- `criterion`: Statistics-driven benchmarking library

## Benchmark Data

Benchmark input data files are included in the `benches/` subdirectory:
- `reachability_edges.txt`: Graph edges for reachability benchmark
- `reachability_reachable.txt`: Expected reachable nodes for verification

## Comparison with DFIR

For comparisons with DFIR/Hydro implementations of these same benchmarks, see the `benches` package in the parent directory. The DFIR benchmarks include Timely, Differential, and DFIR implementations side-by-side for direct comparison.
