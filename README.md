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

### External Repositories
This repository depends on the main Hydro repository for dfir_rs:
- The `benches/Cargo.toml` includes a path dependency to `../../bigweaver-agent-canary-hydro-zeta/dfir_rs`
- Both repositories should be cloned as sibling directories for the benchmarks to build successfully

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

### Prerequisites
Ensure both repositories are cloned as sibling directories:
```
/your-workspace/
  ├── bigweaver-agent-canary-hydro-zeta/
  └── bigweaver-agent-canary-zeta-hydro-deps/
```

The benchmarks depend on dfir_rs from the main repository via a path dependency.

### Build and Run
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

All benchmarks are now in this repository. The benchmarks use:
- Hydro-native (dfir_rs) implementations via path dependency to the main repository
- Timely/Differential-Dataflow implementations where available

### Run All Benchmarks
From this repository:
```bash
cd bigweaver-agent-canary-zeta-hydro-deps/benches
cargo bench
```

### Compare Results
Criterion generates HTML reports in `target/criterion/` that can be used to compare performance between implementations.

## Benefits

1. **Eliminated Dependencies from Main Repo**: The main repository no longer needs timely, differential-dataflow, or benchmark dependencies
2. **Faster Build Times**: Core Hydro development builds are significantly faster
3. **Maintained Functionality**: Performance comparison capabilities are fully preserved
4. **Unified Benchmark Location**: All benchmarks in one repository for easier maintenance
5. **Clear Separation**: Clean architectural boundary between core implementation and benchmarks
6. **Flexible Comparison**: Same location for both Hydro-native and timely/differential implementations

## Related Repositories

- **[bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)** - Main Hydro repository with DFIR-native implementations (required dependency for benchmarks)

## Migration

For detailed information about the benchmark migration from the main repository, see the [BENCHMARK_MIGRATION.md](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta/blob/main/BENCHMARK_MIGRATION.md) document in the main repository.

All benchmarks, including those previously in the main repository, have been consolidated here to provide a unified location for performance testing and comparison. The main repository now focuses exclusively on core Hydro/DFIR development.