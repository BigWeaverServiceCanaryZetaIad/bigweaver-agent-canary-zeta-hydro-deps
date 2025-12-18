# Timely and Differential-Dataflow Benchmarks

This directory contains benchmarks for performance comparison with timely and differential-dataflow implementations.

## Overview

These benchmarks are maintained separately from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to avoid pulling in timely and differential-dataflow dependencies for the core Hydro development workflow.

## Available Benchmarks

**Current Status**: All benchmarks currently use Hydro-native (dfir_rs) implementations. The repository is configured with timely and differential-dataflow dependencies to enable future implementation of alternative versions for performance comparison.

- **micro_ops** - Micro-operations benchmark (currently Hydro-native)
- **symmetric_hash_join** - Symmetric hash join benchmark (currently Hydro-native)
- **words_diamond** - Word processing diamond pattern benchmark (currently Hydro-native)
- **futures** - Futures-based operations benchmark (currently Hydro-native)

## Dependencies

This benchmark suite is configured with:
- `timely` (package: timely-master, version: 0.13.0-dev.1)
- `differential-dataflow` (package: differential-dataflow-master, version: 0.13.0-dev.1)
- `dfir_rs` (Hydro's DFIR implementation, referenced from main repository)
- `criterion` for benchmarking framework
- Supporting libraries (futures, rand, tokio, etc.)

**Note**: Current benchmark implementations use dfir_rs (Hydro-native). The timely and differential-dataflow dependencies are configured and available for future implementation of alternative benchmark versions for performance comparison.

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
Currently, both repositories run Hydro-native (dfir_rs) benchmark implementations. Results can be compared between repositories to verify consistency. In the future, when timely/differential-dataflow implementations are added to this repository, results can be compared to evaluate performance characteristics between:
- Hydro-native implementations (main repository and current implementations in this repository)
- Timely/Differential-Dataflow implementations (future implementations in this repository)

## Data Files

- `words_alpha.txt` - Wordlist from https://github.com/dwyl/english-words/blob/master/words_alpha.txt (used by words_diamond benchmark)

## Migration Notes

These benchmarks were migrated from the main repository to reduce build dependencies and improve build times for core development. The Hydro-native implementations remain in the main repository for development and testing.

For more information about the benchmark migration, see [BENCHMARK_MIGRATION.md](../BENCHMARK_MIGRATION.md) in the main repository.
