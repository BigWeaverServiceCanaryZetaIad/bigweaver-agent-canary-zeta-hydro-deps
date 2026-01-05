# Timely and Differential Dataflow Benchmarks

This directory contains performance comparison benchmarks for timely and differential-dataflow packages.

These benchmarks were moved from the main bigweaver-agent-canary-hydro-zeta repository to maintain a clean separation of concerns and reduce unnecessary dependencies in the main repository.

## Running Benchmarks

Run all benchmarks:
```
cargo bench -p timely-differential-benches
```

Run specific benchmarks:
```
cargo bench -p timely-differential-benches --bench reachability
cargo bench -p timely-differential-benches --bench join
cargo bench -p timely-differential-benches --bench arithmetic
```

## Available Benchmarks

- **reachability**: Graph reachability algorithms comparing Timely, Differential, and Hydroflow implementations
- **join**: Join operation benchmarks with different data types (usize, String)
- **arithmetic**: Arithmetic operation benchmarks
- **fan_in**: Fan-in pattern benchmarks
- **fan_out**: Fan-out pattern benchmarks
- **fork_join**: Fork-join pattern benchmarks
- **identity**: Identity operation benchmarks
- **upcase**: String uppercasing operation benchmarks

## Purpose

These benchmarks enable performance comparisons between:
- Timely Dataflow implementations
- Differential Dataflow implementations
- Hydroflow (dfir_rs) implementations

This allows the team to track and compare performance characteristics across different dataflow frameworks.

## Data Files

- `reachability_edges.txt`: Edge data for graph reachability benchmarks
- `reachability_reachable.txt`: Expected reachable nodes for validation
