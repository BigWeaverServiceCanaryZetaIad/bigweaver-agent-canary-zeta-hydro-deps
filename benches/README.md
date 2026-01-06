# Hydroflow vs Timely/Differential-Dataflow Performance Benchmarks

This repository contains microbenchmarks that compare the performance of Hydroflow (DFIR) with Timely Dataflow and Differential Dataflow.

## Purpose

These benchmarks were moved from the main Hydroflow repository to separate the dependencies on `timely` and `differential-dataflow` packages, allowing the main repository to remain lightweight while still maintaining the ability to compare performance across different dataflow frameworks.

## Benchmarks

The following benchmarks compare Hydroflow implementations against Timely Dataflow:

- **arithmetic** - Sequential arithmetic operations
- **fan_in** - Multiple input streams merging
- **fan_out** - Broadcasting to multiple streams
- **fork_join** - Splitting and rejoining streams
- **identity** - Simple pass-through operations
- **join** - Hash join operations
- **reachability** - Graph reachability computation
- **upcase** - String transformation operations

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench
```

Run specific benchmark:
```bash
cargo bench --bench arithmetic
```

Run benchmarks for a specific framework:
```bash
cargo bench -- timely
cargo bench -- dfir
```

## Dependencies

These benchmarks depend on:
- `dfir_rs` (Hydroflow) - from the main Hydroflow repository
- `timely` (Timely Dataflow)
- `differential-dataflow` (Differential Dataflow)
- `criterion` - for benchmark framework
