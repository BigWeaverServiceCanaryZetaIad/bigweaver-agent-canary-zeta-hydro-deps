# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for testing timely and differential-dataflow performance.

## Benchmarks

The `benches/` directory contains microbenchmarks for Hydro and related crates, including benchmarks that depend on timely and differential-dataflow.

Run all benchmarks:
```
cargo bench -p benches
```

Run specific benchmarks:
```
cargo bench -p benches --bench reachability
```

## Structure

- `benches/` - Benchmark suite with timely and differential-dataflow dependencies
- `dfir_rs/`, `dfir_lang/`, `dfir_macro/` - Core Hydro dataflow infrastructure
- `lattices/`, `lattices_macro/` - Lattice types for distributed systems
- `sinktools/` - Sink utilities
- `variadics/`, `variadics_macro/` - Variadic utilities