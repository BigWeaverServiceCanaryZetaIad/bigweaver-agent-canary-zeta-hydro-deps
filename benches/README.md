# Timely and Differential-Dataflow Benchmarks

This directory contains benchmarks for performance comparison with timely and differential-dataflow implementations.

## Overview

These benchmarks are maintained separately from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to avoid pulling in timely and differential-dataflow dependencies for the core Hydro development workflow.

## Available Benchmarks

- **micro_ops** - Micro-operations benchmark with timely/differential-dataflow dependencies
- **symmetric_hash_join** - Symmetric hash join benchmark with timely/differential-dataflow dependencies
- **words_diamond** - Word processing diamond pattern benchmark with timely/differential-dataflow dependencies
- **futures** - Futures-based operations benchmark with timely/differential-dataflow dependencies

## Dependencies

This benchmark suite includes:
- `timely` (package: timely-master, version: 0.13.0-dev.1)
- `differential-dataflow` (package: differential-dataflow-master, version: 0.13.0-dev.1)
- `criterion` for benchmarking framework
- Supporting libraries (futures, rand, tokio, etc.)

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench micro_ops
cargo bench -p benches --bench symmetric_hash_join
cargo bench -p benches --bench words_diamond
cargo bench -p benches --bench futures
```

## Performance Comparison

### Running Hydro-Native Benchmarks
From the main repository:
```bash
cd bigweaver-agent-canary-hydro-zeta
cargo bench -p benches
```

### Running Timely/Differential-Dataflow Benchmarks
From this repository:
```bash
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench -p benches
```

### Comparing Results
Results from both repositories can be compared to evaluate performance characteristics between:
- Hydro-native implementations (main repository)
- Timely/Differential-Dataflow implementations (this repository)

## Data Files

- `words_alpha.txt` - Wordlist from https://github.com/dwyl/english-words/blob/master/words_alpha.txt (used by words_diamond benchmark)

## Migration Notes

These benchmarks were migrated from the main repository to reduce build dependencies and improve build times for core development. The Hydro-native implementations remain in the main repository for development and testing.

For more information about the benchmark migration, see [BENCHMARK_MIGRATION.md](../BENCHMARK_MIGRATION.md) in the main repository.
