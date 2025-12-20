# Timely/Differential Dataflow Comparison Benchmarks

This repository contains performance comparison benchmarks that compare Hydro implementations against Timely Dataflow and Differential Dataflow implementations.

## Overview

These benchmarks were moved from the main Hydro repository to reduce build dependencies. They specifically test:
- Timely Dataflow implementations
- Differential Dataflow implementations  
- Hydro/DFIR implementations (for comparison)

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p hydro-benches-comparison
```

Run specific benchmarks:
```bash
cargo bench -p hydro-benches-comparison --bench reachability
```

## Available Benchmarks

- **arithmetic**: Arithmetic operations performance comparison
- **fan_in**: Fan-in pattern performance (multiple inputs to single output)
- **fan_out**: Fan-out pattern performance (single input to multiple outputs)
- **fork_join**: Fork-join pattern performance
- **identity**: Identity (pass-through) operation performance
- **join**: Join operation performance
- **reachability**: Graph reachability computation performance
- **upcase**: String uppercase transformation performance

## Cross-Repository Performance Comparison

To compare performance between this repository and the main Hydro repository:

1. Run benchmarks in this repository and note the results
2. Run corresponding benchmarks in bigweaver-agent-canary-hydro-zeta repository
3. Compare the benchmark results

The main Hydro repository contains DFIR-native benchmarks that don't require Timely/Differential dependencies:
- `micro_ops`: Micro-operations benchmark
- `futures`: Futures-based operations
- `symmetric_hash_join`: Symmetric hash join implementation
- `words_diamond`: Word processing diamond pattern

## Dependencies

This repository includes dependencies on:
- `timely-master`: Timely Dataflow framework
- `differential-dataflow-master`: Differential Dataflow framework
- `dfir_rs`: Hydro's DFIR (Dataflow IR) implementation from the main repository

## Data Files

- `reachability_edges.txt`: Graph edge data for reachability benchmark
- `reachability_reachable.txt`: Expected reachable nodes for verification
