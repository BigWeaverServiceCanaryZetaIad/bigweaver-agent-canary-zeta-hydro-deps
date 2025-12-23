# Timely and Differential Dataflow Benchmarks

This directory contains benchmarks that use timely-dataflow and differential-dataflow dependencies for performance comparison with the main bigweaver-agent-canary-hydro-zeta repository.

## Overview

These benchmarks were migrated from the main repository to separate the timely and differential-dataflow dependencies from the core codebase while maintaining the ability to run performance comparisons.

## Dependencies

This benchmark package depends on:

### External Dependencies (from crates.io)
- **timely** (0.12) - Low-latency data-parallel dataflow system
- **differential-dataflow** (0.12) - Incremental computation based on timely-dataflow
- **criterion** (0.3) - Benchmarking framework
- Supporting libraries: lazy_static, rand, seq-macro, tokio

### Path Dependencies (from main repository)
The benchmarks require the following implementations from `bigweaver-agent-canary-hydro-zeta`:
- **babyflow** - Custom dataflow implementation
- **hydroflow** - Alternative dataflow implementation  
- **spinachflow** - Another dataflow implementation variant

These path dependencies allow the benchmarks to compare performance across all implementations.

## Prerequisites

Both repositories must be cloned side-by-side:
```
workspace/
├── bigweaver-agent-canary-hydro-zeta/
│   ├── babyflow/
│   ├── hydroflow/
│   └── spinachflow/
└── bigweaver-agent-canary-zeta-hydro-deps/
    └── timely-differential-benches/    (this directory)
```

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

- **arithmetic** - Arithmetic operations benchmark comparing different dataflow frameworks
- **fan_in** - Fan-in pattern benchmark for data aggregation
- **fan_out** - Fan-out pattern benchmark for data distribution
- **fork_join** - Fork-join pattern benchmark
- **identity** - Identity operation benchmark (data pass-through)
- **join** - Join operation benchmark
- **reachability** - Graph reachability computation benchmark
- **upcase** - String uppercase transformation benchmark
- **zip** - Zip operation benchmark

## Data Files

- `reachability_edges.txt` - Edge data for reachability benchmark
- `reachability_reachable.txt` - Expected reachable nodes for verification

## Cross-Repository Comparison

To compare performance between this repository and the main repository, use the comparison script in the parent directory:

```bash
cd ..
./scripts/compare_benchmarks.sh
```
