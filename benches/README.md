# Unified Benchmark Repository

This directory contains ALL benchmarks for Hydro and related crates, including both Hydro-native (dfir_rs) implementations and timely/differential-dataflow comparison implementations.

## Overview

As of December 19, 2024, all benchmarks have been consolidated in this repository. The main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository no longer contains any benchmarks, allowing it to focus exclusively on core Hydro/DFIR development without benchmark overhead or dependencies.

## Available Benchmarks

### Currently Implemented (Hydro-native)
- **micro_ops** - Micro-operations benchmark using dfir_rs
- **symmetric_hash_join** - Symmetric hash join benchmark using dfir_rs
- **words_diamond** - Word processing diamond pattern benchmark using dfir_rs
- **futures** - Futures-based operations benchmark using dfir_rs

### Future Work
These benchmarks currently use Hydro-native (dfir_rs) implementations. Future work will add timely/differential-dataflow implementations alongside the Hydro-native ones for direct performance comparison.

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

**Complete Migration (December 19, 2024):**
All benchmarks have been moved from the main repository to this repository, including:
- All benchmark source files
- All data files (words_alpha.txt, etc.)
- All benchmark configuration and dependencies

Benefits:
- **Eliminated Dependencies**: The main repository has zero benchmark dependencies
- **Faster Build Times**: Core Hydro development builds are significantly faster
- **Unified Location**: All benchmarks (both Hydro-native and future timely/differential implementations) are in one place
- **Maintained Functionality**: Full performance comparison capabilities are preserved
- **Clear Separation**: Clean architectural boundary between core implementation and benchmarking

The main repository now focuses exclusively on core Hydro/DFIR development without any benchmark overhead.

For detailed migration information, see [BENCHMARK_MIGRATION.md](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta/blob/main/BENCHMARK_MIGRATION.md) in the main repository.
