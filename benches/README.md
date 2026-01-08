# Timely and Differential Dataflow Benchmarks

This repository contains benchmarks for timely and differential-dataflow dependencies that were moved from the main hydro repository to keep those dependencies separate.

## Benchmarks

- `fork_join.rs` - Timely dataflow benchmark
- `identity.rs` - Timely dataflow benchmark  
- `reachability.rs` - Differential-dataflow benchmark

## Running Benchmarks

Run all benchmarks:
```
cargo bench -p benches
```

Run specific benchmarks:
```
cargo bench -p benches --bench fork_join
cargo bench -p benches --bench identity
cargo bench -p benches --bench reachability
```

## Performance Comparisons

These benchmarks can be used to compare performance across different implementations. Each benchmark includes comparisons between dfir_rs, timely, differential-dataflow, and raw implementations where applicable.
