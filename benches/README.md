# Timely and Differential Dataflow Benchmarks

This directory contains benchmarks comparing Hydro with Timely Dataflow and Differential Dataflow.

## Benchmarks

- **fan_out.rs** - Benchmarks fan-out operations comparing dfir_rs with timely dataflow
- **upcase.rs** - Benchmarks string transformation operations using timely dataflow  
- **reachability.rs** - Benchmarks graph reachability algorithms comparing dfir_rs with timely and differential dataflow

## Running Benchmarks

Run all benchmarks:
```
cargo bench
```

Run specific benchmarks:
```
cargo bench --bench reachability
cargo bench --bench fan_out
cargo bench --bench upcase
```

## Purpose

These benchmarks have been separated from the main bigweaver-agent-canary-hydro-zeta repository to maintain clean dependency boundaries. The main repository should not have dependencies on timely and differential-dataflow packages, but we need to retain the ability to run performance comparisons.
