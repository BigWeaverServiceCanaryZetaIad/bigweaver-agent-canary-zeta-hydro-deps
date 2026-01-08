# Benchmark Migration Information

## Overview

This repository now contains benchmarks migrated from the [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository.

## Migration Date

December 19, 2024

## Purpose

This repository serves as the performance comparison and benchmarking suite for Hydro, with support for timely and differential-dataflow dependencies. The separation from the main repository provides:

1. **Isolated Dependencies**: Heavy external framework dependencies (timely, differential-dataflow) are contained here
2. **Faster Main Builds**: The main repository remains lean without benchmarking dependencies
3. **Performance Comparison**: Enables direct comparison between different dataflow implementations
4. **Flexibility**: Allows independent versioning and testing of benchmark code

## Migrated Benchmarks

The following benchmarks were moved from the main repository:
- **futures.rs** - Futures-based operations benchmark
- **micro_ops.rs** - Micro-operations benchmark
- **symmetric_hash_join.rs** - Symmetric hash join benchmark
- **words_diamond.rs** - Word processing diamond pattern benchmark

## Data Files

- **words_alpha.txt** - English word list for benchmark testing

## Getting Started

Run all benchmarks:
```bash
cargo bench
```

Run specific benchmarks:
```bash
cargo bench --bench micro_ops
cargo bench --bench symmetric_hash_join
```

View results:
- HTML reports are generated in `target/criterion/`
- Open `target/criterion/report/index.html` in a browser

## Dependencies

This repository includes:
- timely-master (0.13.0-dev.1)
- differential-dataflow-master (0.13.0-dev.1)
- criterion for benchmarking
- Supporting libraries (futures, rand, tokio, etc.)

## Related Documentation

For more information about the migration, see `BENCHMARK_MIGRATION.md` in the main repository.

## Contributing

When adding new benchmarks:
1. Add benchmark source files to `benches/benches/`
2. Register benchmarks in `benches/Cargo.toml`
3. Update `benches/README.md` with benchmark descriptions
4. Ensure benchmarks work with both Hydro-native and timely/differential implementations where applicable
