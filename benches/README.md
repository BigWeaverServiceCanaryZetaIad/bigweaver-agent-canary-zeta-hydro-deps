# Timely and Differential Dataflow Benchmarks

This directory contains benchmarks that compare timely-dataflow and differential-dataflow implementations.

## Benchmarks

This crate contains the following benchmarks comparing timely/differential-dataflow with DFIR:

- **arithmetic** - Arithmetic operations benchmark
- **fan_in** - Fan-in pattern benchmark
- **fan_out** - Fan-out pattern benchmark
- **fork_join** - Fork-join pattern benchmark
- **identity** - Identity operation benchmark
- **join** - Join operation benchmark
- **reachability** - Graph reachability using differential-dataflow
- **upcase** - Uppercase transformation benchmark

## Running

Run all benchmarks:
```bash
cargo bench -p benches
```

Run a specific benchmark:
```bash
cargo bench -p benches --bench arithmetic
```

## Performance Comparisons

These benchmarks are used to compare DFIR performance with timely-dataflow and differential-dataflow. The benchmarks were moved from the main bigweaver-agent-canary-hydro-zeta repository to avoid introducing unnecessary dependencies in the core codebase.

## Data Files

The reachability benchmark uses data files:
- `reachability_edges.txt` - Graph edge data
- `reachability_reachable.txt` - Expected reachable nodes
