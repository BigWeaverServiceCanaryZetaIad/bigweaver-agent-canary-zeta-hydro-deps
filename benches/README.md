# Timely Dataflow and Differential Dataflow Benchmarks

This repository contains benchmarks comparing Hydroflow with Timely Dataflow and Differential Dataflow frameworks.

## Overview

These benchmarks were moved from the main `bigweaver-agent-canary-hydro-zeta` repository to isolate the timely and differential-dataflow dependencies and enable performance comparisons between Hydroflow and these established dataflow frameworks.

## Prerequisites

To run these benchmarks, you need to have the main `bigweaver-agent-canary-hydro-zeta` repository checked out as a sibling directory, as these benchmarks depend on `dfir_rs` and `sinktools` from that repository.

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench
```

Run specific benchmarks:
```bash
cargo bench --bench reachability
cargo bench --bench join
cargo bench --bench arithmetic
```

## Available Benchmarks

- **arithmetic**: Arithmetic operations pipeline comparison
- **fan_in**: Fan-in pattern performance
- **fan_out**: Fan-out pattern performance
- **fork_join**: Fork-join pattern comparison
- **identity**: Identity/pass-through operations
- **join**: Join operations with different data types
- **reachability**: Graph reachability algorithm comparison
- **upcase**: String uppercase transformation

## Dependencies

These benchmarks use:
- `timely` (timely-master v0.13.0-dev.1)
- `differential-dataflow` (differential-dataflow-master v0.13.0-dev.1)
- `criterion` for benchmarking infrastructure
- `dfir_rs` from the main Hydroflow repository

## Data Files

- `reachability_edges.txt`: Graph edges for reachability benchmarks
- `reachability_reachable.txt`: Reachable nodes for verification
