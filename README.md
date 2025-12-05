# Hydro Performance Benchmarks

This repository contains performance comparison benchmarks for Hydro against timely-dataflow and differential-dataflow.

## Background

These benchmarks were moved from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to avoid including timely and differential-dataflow as dependencies in the main Hydro codebase while still maintaining the ability to run performance comparisons.

## Available Benchmarks

The following benchmarks are available:
- **arithmetic** - Basic arithmetic operations
- **fan_in** - Multiple streams merging into one
- **fan_out** - One stream splitting into multiple
- **fork_join** - Fork-join patterns
- **futures** - Async/await performance
- **identity** - Simple passthrough operations
- **join** - Stream join operations
- **micro_ops** - Micro-benchmarks for individual operations
- **reachability** - Graph reachability algorithms
- **symmetric_hash_join** - Symmetric hash join operations
- **upcase** - String transformation benchmarks
- **words_diamond** - Diamond-shaped dataflow patterns

## Running Benchmarks

### Run All Benchmarks
```bash
cargo bench
```

### Run Specific Benchmarks
```bash
cargo bench --bench reachability
cargo bench --bench arithmetic
cargo bench --bench join
```

### Performance Comparison

Each benchmark compares the performance of:
- Hydro (dfir_rs)
- timely-dataflow
- differential-dataflow
- Raw Rust implementations (where applicable)

Results are output in HTML format in `target/criterion/`.

## Dependencies

This repository depends on:
- The main Hydro repository (via git dependency)
- timely-dataflow
- differential-dataflow

## Contributing

For questions or contributions related to these benchmarks, please open an issue in this repository or the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository.