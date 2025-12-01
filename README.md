# bigweaver-agent-canary-zeta-hydro-deps

This repository contains performance benchmarks and dependencies that rely on timely-dataflow and differential-dataflow packages. These benchmarks have been separated from the main [bigweaver-agent-canary-hydro-zeta](https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to reduce compilation time and dependency bloat in the main codebase.

## Benchmarks

The `benches` directory contains microbenchmarks comparing Hydro/DFIR performance against timely-dataflow and differential-dataflow implementations.

### Running Benchmarks

To run all benchmarks:
```bash
cargo bench -p benches
```

To run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench identity
```

Available benchmarks:
- `arithmetic` - Basic arithmetic operations
- `fan_in` - Fan-in dataflow patterns
- `fan_out` - Fan-out dataflow patterns
- `fork_join` - Fork-join patterns
- `identity` - Identity operations
- `upcase` - String uppercasing operations
- `join` - Join operations
- `reachability` - Graph reachability algorithms
- `micro_ops` - Micro-operations benchmarks
- `symmetric_hash_join` - Symmetric hash join operations
- `words_diamond` - Word processing diamond pattern
- `futures` - Futures-based async operations

### Performance Comparisons

These benchmarks allow you to compare the performance characteristics of:
- Hydro/DFIR implementations
- Timely-dataflow implementations
- Differential-dataflow implementations
- Raw implementations (baseline)

Results include throughput measurements and can generate HTML reports when using criterion's features.

## Architecture

This repository maintains the ability to run performance comparisons between different dataflow implementations while keeping the main repository free from heavy dependencies.

### Dependencies

The benchmarks depend on:
- `dfir_rs` and `sinktools` from the main bigweaver-agent-canary-hydro-zeta repository (via git)
- `timely-master` (v0.13.0-dev.1)
- `differential-dataflow-master` (v0.13.0-dev.1)
- `criterion` for benchmarking infrastructure

## Contributing

When adding new benchmarks:
1. Place benchmark files in the `benches/benches/` directory
2. Add the benchmark entry to `benches/Cargo.toml`
3. Follow existing patterns for comparing multiple implementations
4. Document the benchmark purpose and expected performance characteristics