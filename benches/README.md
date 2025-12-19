# Performance Comparison Benchmarks

Benchmarks for Hydro and related crates, designed for performance comparison with timely and differential-dataflow implementations.

## Overview

This directory contains benchmarks that can be used to compare Hydro-native implementations with timely/differential-dataflow. The benchmarks were migrated from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to enable independent performance evaluation and comparison.

## Available Benchmarks

- **micro_ops** - Micro-operations benchmark
- **symmetric_hash_join** - Symmetric hash join benchmark
- **words_diamond** - Word processing diamond pattern benchmark
- **futures** - Futures-based operations benchmark

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench micro_ops
cargo bench -p benches --bench words_diamond
```

## Future Enhancements

Future work may include adding timely/differential-dataflow implementations alongside the Hydro-native implementations to enable direct performance comparisons.

## Data Files

Wordlist is from https://github.com/dwyl/english-words/blob/master/words_alpha.txt
