# Timely and Differential-Dataflow Benchmarks

This repository contains benchmarks that depend on timely and differential-dataflow packages. These benchmarks were moved from the main bigweaver-agent-canary-hydro-zeta repository to maintain clean separation of concerns and reduce technical debt.

## Benchmarks Included

### Timely Benchmarks
- **arithmetic**: Arithmetic operation pipeline performance comparisons
- **fan_in**: Fan-in pattern performance
- **fan_out**: Fan-out pattern performance  
- **fork_join**: Fork-join pattern performance
- **identity**: Identity transformation performance
- **upcase**: String uppercasing performance
- **join**: Join operation performance

### Differential-Dataflow Benchmarks
- **reachability**: Graph reachability computation using differential-dataflow

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
```

## Performance Comparisons

Each benchmark includes multiple implementations for performance comparison:
- Raw Rust implementations
- Iterator-based implementations
- Timely/Differential-Dataflow implementations
- DFIR (Hydro) implementations

This allows for direct performance comparisons between different dataflow processing approaches.

## Dependencies

The benchmarks depend on:
- `timely-master`: Timely dataflow processing framework
- `differential-dataflow-master`: Differential dataflow computation framework
- `dfir_rs`: DFIR runtime for Rust (used by Hydro)
- `sinktools`: Sink utilities for dataflow operations
- `criterion`: Benchmarking framework

## Data Files

Some benchmarks use preloaded data files:
- `reachability_edges.txt`: Graph edges for reachability benchmark
- `reachability_reachable.txt`: Expected reachable nodes for validation
