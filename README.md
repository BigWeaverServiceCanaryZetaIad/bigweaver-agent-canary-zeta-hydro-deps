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

### Benchmarks with Timely/Differential-Dataflow Implementations
- **arithmetic** - Arithmetic operations benchmarks
- **fan_in** - Fan-in pattern benchmarks
- **fan_out** - Fan-out pattern benchmarks
- **fork_join** - Fork-join pattern benchmarks (with code generation)
- **identity** - Identity transformation benchmarks
- **join** - Join operations benchmarks
- **reachability** - Graph reachability benchmarks
- **upcase** - String transformation benchmarks

### Hydro-Native Reference Benchmarks
- **futures** - Futures-based operations benchmarks
- **micro_ops** - Micro-operations benchmarks
- **symmetric_hash_join** - Symmetric hash join benchmarks
- **words_diamond** - Word processing diamond pattern benchmarks

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
# Timely/differential-dataflow benchmarks
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench fan_in
cargo bench -p benches --bench fan_out
cargo bench -p benches --bench fork_join
cargo bench -p benches --bench identity
cargo bench -p benches --bench join
cargo bench -p benches --bench reachability
cargo bench -p benches --bench upcase

# Hydro-native reference benchmarks
cargo bench -p benches --bench futures
cargo bench -p benches --bench micro_ops
cargo bench -p benches --bench symmetric_hash_join
cargo bench -p benches --bench words_diamond
```

## Performance Comparison Workflow

The benchmarks in this repository support performance comparison between Hydro-native and timely/differential-dataflow implementations.

### Benchmarks with Both Implementations
The following 8 benchmarks include both Hydro-native and timely/differential-dataflow implementations for direct performance comparison:
- arithmetic, fan_in, fan_out, fork_join, identity, join, reachability, upcase

### Run All Benchmarks
From this repository:
```bash
cd bigweaver-agent-canary-zeta-hydro-deps/benches
cargo bench
```

### Compare Results
Criterion generates HTML reports in `target/criterion/` that can be used to compare performance between implementations. Each benchmark that includes multiple implementations will show comparative results.

## Benefits

1. **Eliminated Dependencies from Main Repo**: The main repository no longer needs timely or differential-dataflow dependencies
2. **Faster Build Times**: Core Hydro development builds are significantly faster without these dependencies
3. **Maintained Functionality**: Performance comparison capabilities are fully preserved with 8 benchmarks that include both implementations
4. **Unified Benchmark Location**: All comparative benchmarks in one repository for easier maintenance
5. **Clear Separation**: Clean architectural boundary between core implementation and performance testing
6. **Flexible Comparison**: Direct performance comparison between Hydro-native and timely/differential implementations

## Related Repositories

- **[bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)** - Main Hydro repository with DFIR-native implementations (required dependency for benchmarks)

## Migration

For detailed information about the benchmark migration from the main repository, see the [BENCHMARK_MIGRATION.md](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta/blob/main/BENCHMARK_MIGRATION.md) document in the main repository.

All benchmarks with timely/differential-dataflow dependencies have been consolidated here:
- **8 benchmarks with actual timely/differential implementations** for performance testing
- **4 Hydro-native reference benchmarks** to support future comparative work

The main repository now contains only the 4 Hydro-native benchmarks, focusing exclusively on core Hydro/DFIR development.