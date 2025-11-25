# Timely and Differential Dataflow Benchmarks

This directory contains performance benchmarks for timely dataflow and differential-dataflow operations. These benchmarks were moved from the main bigweaver-agent-canary-hydro-zeta repository to isolate dependencies and maintain cleaner separation of concerns.

## Overview

The benchmarks measure performance of various dataflow patterns using timely and differential-dataflow:

### Timely Dataflow Benchmarks
- **arithmetic.rs** - Arithmetic operations in dataflow pipelines
- **fan_in.rs** - Fan-in pattern (multiple inputs to one output)
- **fan_out.rs** - Fan-out pattern (one input to multiple outputs)
- **fork_join.rs** - Fork-join pattern with filtering
- **identity.rs** - Identity transformation (baseline performance)
- **join.rs** - Join operations using custom operators
- **upcase.rs** - String manipulation operations (uppercase, concatenation)

### Differential Dataflow Benchmarks
- **reachability.rs** - Graph reachability using differential dataflow with iterative computation

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p timely-benchmarks
```

Run specific benchmarks:
```bash
cargo bench -p timely-benchmarks --bench reachability
cargo bench -p timely-benchmarks --bench arithmetic
```

Run a specific benchmark function:
```bash
cargo bench -p timely-benchmarks --bench upcase -- upcase_in_place/timely
```

## Benchmark Data Files

- **reachability_edges.txt** - Graph edges for reachability benchmark
- **reachability_reachable.txt** - Expected reachable nodes for validation

## Dependencies

The benchmarks use:
- **timely-master** (v0.13.0-dev.1) - Timely dataflow framework
- **differential-dataflow-master** (v0.13.0-dev.1) - Differential dataflow framework
- **criterion** (v0.5.0) - Benchmarking framework with statistical analysis

## Performance Comparison

These benchmarks enable performance comparisons between:
1. Raw Rust implementations
2. Iterator-based implementations
3. Timely dataflow implementations
4. Differential dataflow implementations

## Migration Note

These benchmarks were migrated from `bigweaver-agent-canary-hydro-zeta/benches` to maintain cleaner dependency management. See `BENCHMARK_MIGRATION_GUIDE.md` in the repository root for details.
