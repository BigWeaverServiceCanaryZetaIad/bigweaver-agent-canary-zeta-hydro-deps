# Timely and Differential-Dataflow Benchmarks

This repository contains performance benchmarks comparing Hydro (DFIR) with timely-dataflow and differential-dataflow frameworks.

## Overview

These benchmarks were moved from the main bigweaver-agent-canary-hydro-zeta repository to isolate the external dependencies (timely and differential-dataflow) required for performance comparisons.

## Available Benchmarks

- **arithmetic**: Pipeline arithmetic operations benchmark
- **fan_in**: Fan-in pattern benchmark
- **fan_out**: Fan-out pattern benchmark  
- **fork_join**: Fork-join pattern benchmark
- **identity**: Identity operation benchmark
- **join**: Join operation benchmark
- **reachability**: Graph reachability benchmark
- **upcase**: String uppercase transformation benchmark

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench
```

Run specific benchmarks:
```bash
cargo bench --bench reachability
cargo bench --bench arithmetic
```

## Performance Comparisons

These benchmarks typically include implementations for:
- **pipeline**: Raw channel-based pipeline
- **timely**: Timely-dataflow implementation
- **differential**: Differential-dataflow implementation
- **dfir_rs**: Hydro/DFIR implementation (compiled and surface syntax)

Results can be compared to evaluate relative performance characteristics across frameworks.

## Dependencies

This repository requires:
- `timely-dataflow` (via timely-master package)
- `differential-dataflow` (via differential-dataflow-master package)
- `dfir_rs` (from hydro repository for comparison)
- `criterion` for benchmarking harness
