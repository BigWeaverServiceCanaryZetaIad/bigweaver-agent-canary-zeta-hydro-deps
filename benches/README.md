# Timely/Differential-Dataflow Benchmarks

Benchmarks for comparing performance between Hydro and Timely/Differential-Dataflow implementations.

## Overview

This directory contains benchmarks that depend on timely and differential-dataflow packages. These benchmarks enable performance comparisons between different dataflow implementations.

## Available Benchmarks

### Timely/Differential-Dataflow Specific
- **arithmetic** - Arithmetic operations benchmark
- **fan_in** - Fan-in pattern benchmark  
- **fan_out** - Fan-out pattern benchmark
- **fork_join** - Fork-join pattern benchmark
- **identity** - Identity transformation benchmark
- **join** - Join operations benchmark
- **reachability** - Graph reachability benchmark
- **upcase** - String transformation benchmark

### Cross-Implementation Benchmarks
The following benchmarks support both Hydro-native and Timely/Differential implementations:
- **futures** - Futures-based operations benchmark
- **micro_ops** - Micro-operations benchmark
- **symmetric_hash_join** - Symmetric hash join benchmark
- **words_diamond** - Word processing diamond pattern benchmark

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench reachability
cargo bench -p benches --bench join
```

## Performance Comparison

To compare performance with Hydro-native implementations, run the benchmarks in the [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository.

### Workflow for Performance Comparison

1. Run Timely/Differential benchmarks in this repository:
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps
   cargo bench -p benches
   ```

2. Run Hydro-native benchmarks in the main repository:
   ```bash
   cd bigweaver-agent-canary-hydro-zeta
   cargo bench -p benches
   ```

3. Compare the benchmark results to evaluate performance characteristics

## Data Files

- `reachability_edges.txt` - Test data for reachability benchmark
- `reachability_reachable.txt` - Expected results for reachability benchmark
- `words_alpha.txt` - Wordlist from https://github.com/dwyl/english-words/blob/master/words_alpha.txt

## Build Configuration

The `build.rs` script generates code for the fork_join benchmark at build time. Generated files are ignored by git (see `.gitignore`).

## Setup Requirements

This repository has path dependencies on the main bigweaver-agent-canary-hydro-zeta repository. Both repositories should be cloned in the same parent directory:

```
parent-directory/
├── bigweaver-agent-canary-hydro-zeta/
│   ├── dfir_rs/
│   ├── sinktools/
│   └── ...
└── bigweaver-agent-canary-zeta-hydro-deps/
    └── benches/
```

If you have both repositories, the path dependencies will resolve correctly.

## Dependencies

This package depends on:
- `criterion` - Benchmarking framework
- `dfir_rs` - Hydro's DFIR implementation (from main repository)
- `differential-dataflow-master` (version 0.13.0-dev.1)
- `sinktools` - Hydro sink utilities (from main repository)
- `timely-master` (version 0.13.0-dev.1)
- `futures`
- `nameof`
- `rand`
- `rand_distr`
- `seq-macro`
- `static_assertions`
- `tokio`

## Migration History

These benchmarks were migrated from the main bigweaver-agent-canary-hydro-zeta repository on December 17-18, 2024 to separate timely/differential-dataflow dependencies from the core Hydro development repository. See the [BENCHMARK_MIGRATION.md](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta/blob/main/BENCHMARK_MIGRATION.md) in the main repository for details.
