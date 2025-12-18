# Hydro Benchmarks Suite

This directory contains ALL benchmarks for the Hydro project.

## Overview

All Hydro benchmarks are maintained in this repository to keep the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository clean and fast to build. This includes both Hydro-native implementations and the infrastructure for future performance comparisons with timely/differential-dataflow.

## Available Benchmarks

All benchmarks currently use Hydro-native (dfir_rs) implementations:
- **micro_ops** - Micro-operations benchmark
- **symmetric_hash_join** - Symmetric hash join benchmark  
- **words_diamond** - Word processing diamond pattern benchmark
- **futures** - Futures-based operations benchmark

*Note: Timely/differential-dataflow comparison implementations are planned for future work.*

## Dependencies

This benchmark suite includes:
- `dfir_rs` - Referenced from the main repository via path
- `timely` (package: timely-master, version: 0.13.0-dev.1) - for future comparison implementations
- `differential-dataflow` (package: differential-dataflow-master, version: 0.13.0-dev.1) - for future comparison implementations
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

Results are generated in `target/criterion/` with detailed HTML reports for performance analysis.

## Data Files

- `words_alpha.txt` - Wordlist from https://github.com/dwyl/english-words/blob/master/words_alpha.txt (used by words_diamond benchmark)

## Migration Notes

All benchmarks have been completely migrated from the main repository to this repository. The main repository no longer contains any benchmark code, which significantly improves build times for core development work. This repository serves as the centralized location for all Hydro performance testing.

For detailed migration history, see [BENCHMARK_MIGRATION.md](../../bigweaver-agent-canary-hydro-zeta/BENCHMARK_MIGRATION.md) in the main repository.
