# bigweaver-agent-canary-zeta-hydro-deps

Benchmarks repository with timely and differential-dataflow dependencies for performance comparison.

## Overview

This repository contains benchmarks that depend on timely and differential-dataflow for comparing performance with Hydro-native implementations. By maintaining these benchmarks separately, we avoid adding timely and differential-dataflow dependencies to the main development workflow.

## Structure

- `benches/` - Benchmark suite with timely/differential-dataflow implementations
  - `benches/benches/` - Individual benchmark files
  - `benches/Cargo.toml` - Package configuration with timely/differential-dataflow dependencies
  - `benches/README.md` - Detailed benchmark documentation

## Available Benchmarks

- **micro_ops** - Micro-operations benchmarks
- **symmetric_hash_join** - Symmetric hash join benchmarks
- **words_diamond** - Word processing diamond pattern benchmarks
- **futures** - Futures-based operations benchmarks

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

```bash
cd benches
cargo bench
```

For specific benchmarks:
```bash
cargo bench -p benches --bench micro_ops
cargo bench -p benches --bench symmetric_hash_join
cargo bench -p benches --bench words_diamond
cargo bench -p benches --bench futures
```

## Performance Comparison Workflow

### 1. Run Hydro-Native Benchmarks
From the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository:
```bash
cd bigweaver-agent-canary-hydro-zeta/benches
cargo bench
```

### 2. Run Timely/Differential-Dataflow Benchmarks
From this repository:
```bash
cd bigweaver-agent-canary-zeta-hydro-deps/benches
cargo bench
```

### 3. Compare Results
Criterion generates HTML reports in `target/criterion/` that can be used to compare performance between implementations.

## Benefits

1. **Reduced Build Dependencies**: The main repository no longer needs timely and differential-dataflow
2. **Faster Build Times**: Core development builds are faster without external dataflow dependencies
3. **Maintained Functionality**: Performance comparison capabilities are preserved in this repository
4. **Clear Separation**: Clean architectural boundary between core implementation and comparative benchmarks
5. **Improved Maintainability**: Each repository has a focused purpose and dependency set

## Related Repositories

- **[bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)** - Main Hydro repository with DFIR-native benchmarks and implementations

## Migration

For information about the benchmark migration from the main repository, see the BENCHMARK_MIGRATION.md document in the main repository.