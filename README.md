# bigweaver-agent-canary-zeta-hydro-deps

Performance Benchmarking Repository for Hydro Project

## Overview

This repository contains all performance benchmarks for the Hydro project, including both Hydro-native implementations and benchmarks with timely/differential-dataflow dependencies for comparative analysis.

## Purpose

This repository serves as the centralized location for:
- Performance benchmarking infrastructure
- Hydro-native benchmark implementations
- Comparative benchmarks with timely/differential-dataflow
- Performance tracking and analysis

## Benchmarks

### Hydro-Native Benchmarks

Located in `benches/benches/`:

- **micro_ops.rs** - Micro-operations benchmark testing basic DFIR operations (identity, unique, map, filter, fold, join, sort)
- **symmetric_hash_join.rs** - Symmetric hash join benchmark testing various join scenarios
- **words_diamond.rs** - Word processing diamond pattern benchmark using a large word list
- **futures.rs** - Futures-based operations benchmark testing async operations

### Data Files

- **words_alpha.txt** - English word list (370,000+ words) used by the words_diamond benchmark

## Running Benchmarks

### Run All Benchmarks

```bash
cd benches
cargo bench
```

### Run Specific Benchmarks

```bash
cargo bench --bench micro_ops
cargo bench --bench symmetric_hash_join
cargo bench --bench words_diamond
cargo bench --bench futures
```

### Run Specific Test Within a Benchmark

```bash
cargo bench --bench micro_ops -- "micro/ops/map"
cargo bench --bench words_diamond -- "dfir_rs_diamond"
```

## Requirements

The benchmarks require:
- Rust toolchain (edition 2021 or later)
- Access to `dfir_rs` and `sinktools` dependencies (via path or git)
- Criterion benchmarking framework

## Performance Analysis

Benchmark results are generated in `target/criterion/` with:
- HTML reports for visualization
- Statistical analysis of performance
- Comparison with previous runs

## Related Repositories

- **[bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)** - Main Hydro project repository with core implementation

## Documentation

See `benches/README.md` for detailed benchmark documentation.

## Migration History

All benchmarks were migrated from the main repository to this dedicated benchmarking repository on December 17, 2024. See the main repository's `BENCHMARK_MIGRATION.md` for complete migration documentation.