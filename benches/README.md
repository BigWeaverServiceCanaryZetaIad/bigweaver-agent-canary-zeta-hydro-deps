# Microbenchmarks

Benchmarks for Hydro that depend on timely and differential-dataflow.

These benchmarks were moved from the main bigweaver-agent-canary-hydro-zeta repository to avoid unnecessary dependencies on timely and differential-dataflow packages.

## Running Benchmarks

Run all benchmarks:
```
cargo bench
```

Run specific benchmarks:
```
cargo bench --bench reachability
```

## Performance Comparisons

To compare performance with the main repository, you can run benchmarks from both repositories and compare results. The main repository contains benchmarks: futures, micro_ops, symmetric_hash_join, and words_diamond.

## Included Benchmarks

This repository includes the following benchmarks:
- `arithmetic` - Arithmetic operations benchmark
- `fan_in` - Fan-in pattern benchmark  
- `fan_out` - Fan-out pattern benchmark
- `fork_join` - Fork-join pattern benchmark
- `identity` - Identity transformation benchmark
- `join` - Join operations benchmark
- `reachability` - Graph reachability benchmark (uses differential-dataflow)
- `upcase` - Uppercase transformation benchmark
