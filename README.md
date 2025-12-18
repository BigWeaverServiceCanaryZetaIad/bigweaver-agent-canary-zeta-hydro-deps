# bigweaver-agent-canary-zeta-hydro-deps

Benchmarks repository with all Hydro performance tests including timely and differential-dataflow dependencies for performance comparison.

## Overview

This repository contains ALL benchmarks for the Hydro project, including both Hydro-native implementations and performance comparisons with timely and differential-dataflow. By maintaining all benchmarks in this separate repository, we keep the main development workflow fast and dependency-free.

## Structure

- `benches/` - Complete benchmark suite
  - `benches/benches/` - Individual benchmark files (Hydro-native implementations)
  - `benches/Cargo.toml` - Package configuration with timely/differential-dataflow dependencies
  - `benches/README.md` - Detailed benchmark documentation

## Available Benchmarks

All benchmarks use Hydro-native (dfir_rs) implementations:
- **micro_ops** - Micro-operations benchmarks
- **symmetric_hash_join** - Symmetric hash join benchmarks
- **words_diamond** - Word processing diamond pattern benchmarks
- **futures** - Futures-based operations benchmarks

*Note: Timely/differential-dataflow comparison implementations are planned for future work.*

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

### Running All Benchmarks
All benchmarks are maintained in this repository:
```bash
cd bigweaver-agent-canary-zeta-hydro-deps/benches
cargo bench
```

### Running Specific Benchmarks
```bash
cargo bench -p benches --bench micro_ops
cargo bench -p benches --bench symmetric_hash_join
cargo bench -p benches --bench words_diamond
cargo bench -p benches --bench futures
```

### Results
Criterion generates HTML reports in `target/criterion/` for detailed performance analysis.

## Benefits

1. **Complete Separation**: All benchmarks are maintained in this repository, keeping the main repo clean
2. **Centralized Testing**: Single location for all performance testing and comparison work
3. **Faster Main Repo Builds**: Core development builds are significantly faster without benchmark dependencies
4. **Performance Comparison Ready**: Infrastructure in place for future timely/differential-dataflow comparisons
5. **Clear Architecture**: Clean separation between core development and performance testing

## Related Repositories

- **[bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)** - Main Hydro repository with core DFIR implementations (no benchmarks)

## Migration

All benchmarks have been moved from the main repository to this repository. For detailed migration history, see the BENCHMARK_MIGRATION.md document in the main repository.