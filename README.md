# bigweaver-agent-canary-zeta-hydro-deps

Performance comparison benchmarks for Hydro with timely and differential-dataflow dependencies.

## Overview

This repository contains benchmarks for comparing Hydro implementations with timely and differential-dataflow alternatives. These benchmarks are separated from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to avoid unnecessary build dependencies in the core project.

## Purpose

The benchmarks in this repository enable:
- Performance comparison between Hydro-native and timely/differential-dataflow implementations
- Evaluation of different dataflow framework approaches
- Isolated testing without impacting main repository build times

## Available Benchmarks

- **micro_ops** - Micro-operations benchmark comparing basic operations
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

## Dependencies

This repository includes:
- **timely-master** (version 0.13.0-dev.1) - Timely dataflow framework
- **differential-dataflow-master** (version 0.13.0-dev.1) - Differential dataflow framework
- **criterion** - Benchmarking framework
- Additional supporting libraries (futures, rand, tokio, etc.)

## Performance Comparison Workflow

1. Run benchmarks in this repository to get timely/differential-dataflow performance metrics
2. Compare results with Hydro-native implementations from the main repository
3. Analyze performance characteristics and trade-offs between approaches

## Related Repositories

- **[bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)** - Main Hydro project repository with DFIR-native implementations

## Notes

- This repository is specifically designed for performance comparison and benchmarking
- The separation allows the main repository to remain lean without heavy external dependencies
- Benchmark results can be analyzed using Criterion's HTML reports in `target/criterion/`