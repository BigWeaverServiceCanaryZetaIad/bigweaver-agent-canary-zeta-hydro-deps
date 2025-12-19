# bigweaver-agent-canary-zeta-hydro-deps

**Unified Benchmarks Repository** - All Hydro benchmarks with timely and differential-dataflow dependencies for performance comparison.

## Overview

As of December 19, 2024, this repository contains ALL benchmarks for Hydro and related crates. The main repository no longer contains any benchmarks, allowing it to focus exclusively on core Hydro/DFIR development. By consolidating all benchmarks here, we eliminate build dependencies from the main development workflow while maintaining comprehensive performance testing capabilities.

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

1. **Complete Elimination of Benchmark Dependencies**: The main repository has zero benchmark-related dependencies (no timely, differential-dataflow, criterion, or supporting libs)
2. **Significantly Faster Build Times**: Core Hydro development builds are much faster without any benchmark overhead
3. **Maintained Functionality**: Full performance comparison capabilities are preserved
4. **Unified Benchmark Location**: ALL benchmarks consolidated in one repository for easier maintenance and comparison
5. **Clear Separation**: Clean architectural boundary between core implementation and all benchmarking activities
6. **Flexible Comparison**: Single location for both Hydro-native and timely/differential implementations

## Related Repositories

- **[bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)** - Main Hydro repository with DFIR-native implementations (required dependency for benchmarks)

## Migration

**Complete Migration (December 19, 2024):**
For detailed information about the benchmark migration from the main repository, see the [BENCHMARK_MIGRATION.md](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta/blob/main/BENCHMARK_MIGRATION.md) document in the main repository.

All benchmarks have been moved from the main repository to this repository, including all source files, data files, and configuration. The main repository now contains no benchmark-related code or dependencies, focusing exclusively on core Hydro/DFIR development.