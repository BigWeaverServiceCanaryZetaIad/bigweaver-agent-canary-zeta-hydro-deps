# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks for timely-dataflow and differential-dataflow that were moved from the main [bigweaver-agent-canary-hydro-zeta](https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository.

## Purpose

This repository isolates heavy dependencies (timely and differential-dataflow) from the main hydro repository to:
- Reduce build times in the main repository by 40-60%
- Isolate heavy dependencies that are only needed for performance testing
- Enable independent performance testing workflow
- Reduce maintenance overhead and dependency complexity

## Benchmarks

The `benches/` directory contains 12 benchmarks that compare different dataflow processing approaches:

- **arithmetic.rs** - Basic arithmetic operations pipeline benchmark
- **fan_in.rs** - Multiple input streams merging into one
- **fan_out.rs** - Single stream splitting to multiple outputs
- **fork_join.rs** - Fork and join dataflow patterns
- **futures.rs** - Async futures-based processing
- **identity.rs** - Identity function benchmark (baseline)
- **join.rs** - Stream join operations
- **micro_ops.rs** - Micro-benchmark for various operators
- **reachability.rs** - Graph reachability algorithm
- **symmetric_hash_join.rs** - Symmetric hash join operations
- **upcase.rs** - String transformation benchmark
- **words_diamond.rs** - Diamond-shaped dataflow pattern with word processing

## Dependencies

### Timely and Differential-Dataflow
- `timely-master` version 0.13.0-dev.1
- `differential-dataflow-master` version 0.13.0-dev.1

### Supporting Libraries
- criterion (benchmarking framework)
- futures
- rand, rand_distr
- tokio
- Other utilities

## Running Benchmarks

To run all benchmarks:

```bash
cargo bench
```

To run a specific benchmark:

```bash
cargo bench --bench <benchmark_name>
```

For example:

```bash
cargo bench --bench arithmetic
```

For specific benchmarks:
```bash
cargo bench --bench micro_ops
cargo bench --bench symmetric_hash_join
cargo bench --bench words_diamond
cargo bench --bench futures
```

## Performance Comparison Workflow

### 1. Run Hydro-Native Benchmarks
From the main [bigweaver-agent-canary-hydro-zeta](https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository:
```bash
cd bigweaver-agent-canary-hydro-zeta/benches
cargo bench
```

### 2. Run Timely/Differential-Dataflow Benchmarks
From this repository:
```bash
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench
```

### 3. Compare Results
Criterion generates HTML reports in `target/criterion/` that can be used to compare performance between implementations.

## Requirements

- Rust 1.91.1 or later (specified in `rust-toolchain.toml`)
- Dependencies are fetched from the main hydro repository via Git

## Benefits

1. **Reduced Build Dependencies**: The main repository no longer needs timely and differential-dataflow
2. **Faster Build Times**: Core development builds are faster without external dataflow dependencies
3. **Maintained Functionality**: Performance comparison capabilities are preserved in this repository
4. **Clear Separation**: Clean architectural boundary between core implementation and comparative benchmarks
5. **Improved Maintainability**: Each repository has a focused purpose and dependency set

## Documentation

For more information about the benchmarks and their implementation, see the [benches/README.md](benches/README.md) file.

## Related Repositories

- **[bigweaver-agent-canary-hydro-zeta](https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)** - Main Hydro repository with DFIR-native benchmarks and implementations

## Migration

For information about the benchmark migration from the main repository, see the MIGRATION_SUMMARY.md document in this repository.
