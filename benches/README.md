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
- `dfir_rs` - Hydro's DFIR implementation (path dependency to main repository)
- `timely` (package: timely-master, version: 0.13.0-dev.1)
- `differential-dataflow` (package: differential-dataflow-master, version: 0.13.0-dev.1)
- `criterion` for benchmarking framework
- Supporting libraries (futures, rand, tokio, etc.)

### Repository Structure
The benchmarks require both repositories to be cloned as sibling directories:
```
/your-workspace/
  ├── bigweaver-agent-canary-hydro-zeta/    (contains dfir_rs)
  └── bigweaver-agent-canary-zeta-hydro-deps/  (this repository)
```

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

All benchmarks are consolidated in this repository. They include:
- Hydro-native (dfir_rs) implementations
- Timely/Differential-Dataflow implementations (where available)

### Running Benchmarks
From this repository:
```bash
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench -p benches
```

### Comparing Results
Results can be compared to evaluate performance characteristics between Hydro-native and Timely/Differential-Dataflow implementations.

## Data Files

- `words_alpha.txt` - Wordlist from https://github.com/dwyl/english-words/blob/master/words_alpha.txt (used by words_diamond benchmark)

## Migration Notes

All benchmarks, including those previously in the main repository, have been migrated here to:
- Reduce build dependencies in the main Hydro repository
- Improve build times for core development
- Provide a unified location for all performance testing
- Enable side-by-side comparison of Hydro-native and timely/differential implementations

The main repository now focuses exclusively on core Hydro/DFIR development without any benchmark overhead.

For more information about the benchmark migration, see [BENCHMARK_MIGRATION.md](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta/blob/main/BENCHMARK_MIGRATION.md) in the main repository.
