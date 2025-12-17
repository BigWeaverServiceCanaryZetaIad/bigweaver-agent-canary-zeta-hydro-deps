# Hydro-Native Microbenchmarks

Benchmarks for Hydro and related crates using DFIR-native implementations.

## Overview

This directory contains Hydro-native benchmarks that do not depend on timely or differential-dataflow. For benchmarks that compare Hydro with timely/differential-dataflow implementations, see the [bigweaver-agent-canary-zeta-hydro-deps](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps) repository.

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

## Performance Comparison

To compare performance with timely/differential-dataflow implementations, use the benchmarks in the [bigweaver-agent-canary-zeta-hydro-deps](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps) repository.

## Data Files

Wordlist is from https://github.com/dwyl/english-words/blob/master/words_alpha.txt
