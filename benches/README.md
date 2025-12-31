# DFIR/Hydro Benchmarks with External Dependencies

This directory contains benchmarks that depend on external dataflow frameworks, specifically:
- **timely**: Timely Dataflow framework
- **differential-dataflow**: Differential Dataflow framework

These benchmarks are used for performance comparisons between DFIR/Hydro and other established dataflow systems.

## Benchmarks

### arithmetic.rs
Compares arithmetic pipeline performance across different implementations:
- Timely Dataflow
- DFIR/Hydro (compiled and surface syntax)
- Raw implementations

### fork_join.rs
Benchmarks fork-join patterns with:
- Timely Dataflow
- DFIR/Hydro (scheduled and surface syntax)
- Raw implementations

### reachability.rs
Graph reachability algorithm benchmarks comparing:
- Differential Dataflow
- DFIR/Hydro implementations

## Running Benchmarks

To run all benchmarks:
```bash
cargo bench
```

To run a specific benchmark:
```bash
cargo bench --bench arithmetic
cargo bench --bench fork_join
cargo bench --bench reachability
```

## Dependencies

These benchmarks require:
- `timely` (Timely Dataflow)
- `differential-dataflow` (Differential Dataflow)
- `dfir_rs` (from the main hydro repository)
- `criterion` (for benchmarking)
