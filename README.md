# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for the Hydro project that depend on `timely` and `differential-dataflow` packages.

## Benchmarks

The `benches/` directory contains performance benchmarks that compare Hydro implementations with timely-dataflow and differential-dataflow implementations. These benchmarks were moved from the main `bigweaver-agent-canary-hydro-zeta` repository to avoid adding timely and differential-dataflow as dependencies in the main codebase.

### Running Benchmarks

To run all benchmarks:

```bash
cargo bench
```

To run a specific benchmark:

```bash
cargo bench --bench <benchmark_name>
```

Available benchmarks:
- `arithmetic` - Pipeline arithmetic operations
- `fan_in` - Fan-in patterns
- `fan_out` - Fan-out patterns
- `fork_join` - Fork-join patterns
- `identity` - Identity transformation
- `upcase` - String uppercase transformation
- `join` - Join operations
- `reachability` - Graph reachability
- `micro_ops` - Micro-operations
- `symmetric_hash_join` - Symmetric hash join
- `words_diamond` - Word processing diamond pattern
- `futures` - Async futures benchmarks

### Performance Comparison

These benchmarks allow performance comparison between:
- Hydro (using dfir_rs)
- Timely-dataflow
- Differential-dataflow

The benchmarks can still be run to compare performance even though they are in a separate repository.