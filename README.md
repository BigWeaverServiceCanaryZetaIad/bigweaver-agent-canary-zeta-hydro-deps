# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for the Hydro project that depend on timely and differential-dataflow.

## Benchmarks

The `benches/` directory contains performance benchmarks that compare Hydro implementations with timely and differential-dataflow implementations.

### Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
```

### Available Benchmarks

- `arithmetic` - Arithmetic operations benchmark
- `fan_in` - Fan-in pattern benchmark
- `fan_out` - Fan-out pattern benchmark
- `fork_join` - Fork-join pattern benchmark
- `identity` - Identity transformation benchmark
- `upcase` - Uppercase transformation benchmark
- `join` - Join operation benchmark
- `reachability` - Reachability analysis benchmark
- `micro_ops` - Micro-operations benchmark
- `symmetric_hash_join` - Symmetric hash join benchmark
- `words_diamond` - Words diamond pattern benchmark
- `futures` - Futures-based operations benchmark

## Migration

These benchmarks were moved from the main `bigweaver-agent-canary-hydro-zeta` repository to keep the main repository free of timely and differential-dataflow dependencies while maintaining the ability to run performance comparisons.