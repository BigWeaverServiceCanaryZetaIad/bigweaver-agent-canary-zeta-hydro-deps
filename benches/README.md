# Timely and Differential-Dataflow Benchmarks

This directory contains benchmarks for timely and differential-dataflow dependencies.

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p timely-differential-benches
```

Run specific benchmarks:
```bash
cargo bench -p timely-differential-benches --bench reachability
cargo bench -p timely-differential-benches --bench arithmetic
cargo bench -p timely-differential-benches --bench join
```

## Available Benchmarks

### Timely Benchmarks
- **arithmetic** - Basic arithmetic operations in timely dataflow
- **fan_in** - Fan-in pattern benchmark
- **fan_out** - Fan-out pattern benchmark
- **fork_join** - Fork-join pattern benchmark
- **identity** - Identity transformation benchmark
- **join** - Join operations benchmark
- **upcase** - String uppercase transformation benchmark

### Differential-Dataflow Benchmarks
- **reachability** - Graph reachability computation using differential dataflow

## Data Files

- `reachability_edges.txt` - Edge data for reachability benchmark
- `reachability_reachable.txt` - Expected reachable nodes for verification

## Performance Comparison

These benchmarks support performance comparison functionality with the main Hydro benchmarks.
To compare performance across implementations, run benchmarks in both repositories and compare
the generated reports in `target/criterion/`.

## Migration Notes

These benchmarks were moved from the main bigweaver-agent-canary-hydro-zeta repository to maintain
a cleaner separation of dependencies and improve build times. For migration details, see `MIGRATION_NOTES.md`.
