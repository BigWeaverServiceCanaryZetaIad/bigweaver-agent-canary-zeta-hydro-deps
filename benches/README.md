# Hydro Performance Comparison Benchmarks

Benchmarks for comparing Hydro with timely and differential-dataflow implementations.

## Overview

This directory contains benchmarks designed for performance comparison between Hydro-native implementations and timely/differential-dataflow alternatives. These benchmarks are separated from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to enable testing with timely and differential-dataflow dependencies without impacting the main project's build times.

## Available Benchmarks

- **micro_ops** - Micro-operations benchmark for basic dataflow operations
- **symmetric_hash_join** - Symmetric hash join performance comparison
- **words_diamond** - Word processing diamond pattern benchmark
- **futures** - Futures-based operations benchmark

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench
```

Run specific benchmarks:
```bash
cargo bench --bench micro_ops
cargo bench --bench symmetric_hash_join
cargo bench --bench words_diamond
cargo bench --bench futures
```

## Performance Comparison

These benchmarks can be used to:
1. Compare performance between timely/differential-dataflow and Hydro implementations
2. Evaluate different dataflow framework approaches
3. Identify optimization opportunities

To compare with Hydro-native implementations (without timely/differential dependencies), refer to the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository.

## Dependencies

This benchmark suite includes:
- timely-master (0.13.0-dev.1)
- differential-dataflow-master (0.13.0-dev.1)
- criterion for benchmarking framework

## Data Files

- **words_alpha.txt** - Wordlist from https://github.com/dwyl/english-words/blob/master/words_alpha.txt

## Results

Benchmark results are generated in HTML format by Criterion and can be found in `target/criterion/` after running the benchmarks.
