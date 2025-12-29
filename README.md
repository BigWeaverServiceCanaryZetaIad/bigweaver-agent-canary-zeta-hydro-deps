# bigweaver-agent-canary-zeta-hydro-deps

This repository contains performance benchmarks and dependency-heavy components for the Hydro project, separated from the core functionality to maintain a cleaner dependency tree.

## Contents

### Benchmarks

The `benches` directory contains comprehensive performance benchmarks for Hydro operations, designed for comparison with established dataflow frameworks like Timely Dataflow and Differential Dataflow.

Key benchmark areas:
- Graph reachability algorithms
- Join operations with different data types
- Micro-operations (map, flat_map, union, tee, fold, sort, etc.)
- Symmetric hash join performance
- Futures and async operations
- Word processing (diamond pattern)

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench micro_ops
cargo bench -p benches --bench symmetric_hash_join
cargo bench -p benches --bench words_diamond
cargo bench -p benches --bench futures
```

## Dependencies

This repository includes:
- **timely**: Timely dataflow framework for performance comparison
- **differential-dataflow**: Differential dataflow framework for performance comparison
- **dfir_rs**: Core DFIR/Hydro implementation (referenced from main repository)
- **criterion**: Statistics-driven benchmarking library

## Purpose

Separating benchmarks and heavy dependencies into this repository:
- Keeps the main repository's dependency tree clean
- Reduces technical debt
- Makes it easier to maintain and update performance comparisons
- Allows independent evolution of benchmarking infrastructure