# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks for Hydro that depend on external dependencies like `timely` and `differential-dataflow`. These benchmarks were moved from the main `bigweaver-agent-canary-hydro-zeta` repository to avoid dependency bloat while maintaining the ability to run performance comparisons.

## Benchmarks

The `benches/` directory contains microbenchmarks for Hydro and related crates. These benchmarks use `timely-dataflow` and `differential-dataflow` for performance comparison purposes.

### Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench identity
cargo bench -p benches --bench arithmetic
```

### Available Benchmarks

- `arithmetic` - Basic arithmetic operations
- `fan_in` - Fan-in dataflow patterns
- `fan_out` - Fan-out dataflow patterns
- `fork_join` - Fork-join patterns
- `futures` - Async futures handling
- `identity` - Identity transformations
- `join` - Join operations
- `micro_ops` - Micro-operations benchmarks
- `reachability` - Graph reachability algorithms
- `symmetric_hash_join` - Symmetric hash join operations
- `upcase` - String transformation benchmarks
- `words_diamond` - Diamond pattern with word processing

### Performance Comparisons

To compare performance between this repository and the main Hydro repository:

1. Run benchmarks in this repository and save results:
   ```bash
   cargo bench -p benches -- --save-baseline deps-repo
   ```

2. Run equivalent benchmarks in the main repository (if available)

3. Compare the results using Criterion's comparison tools

## Dependencies

This repository includes the following key dependencies:

- `timely-dataflow` (via `timely-master` package)
- `differential-dataflow` (via `differential-dataflow-master` package)
- `dfir_rs` - Core DFIR runtime
- `criterion` - Benchmarking framework

## Contributing

When adding new benchmarks:

1. Add the benchmark file in `benches/benches/`
2. Add a `[[bench]]` entry in `benches/Cargo.toml`
3. Ensure the benchmark follows existing patterns
4. Update this README with the new benchmark description