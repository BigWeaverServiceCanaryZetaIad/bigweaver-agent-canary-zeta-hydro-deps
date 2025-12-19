# Hydro Performance Benchmarks with Timely/Differential-Dataflow

Benchmarks for performance comparison between Hydro and timely/differential-dataflow implementations.

## Overview

This repository contains benchmarks that enable performance comparison between:
- Hydro's DFIR-native implementation
- Timely and differential-dataflow implementations (where applicable)

The benchmarks currently use Hydro's DFIR-native implementation and include dependencies on timely and differential-dataflow for future comparative benchmark implementations.

## Available Benchmarks

- **micro_ops** - Micro-operations benchmark
- **symmetric_hash_join** - Symmetric hash join benchmark
- **words_diamond** - Word processing diamond pattern benchmark
- **futures** - Futures-based operations benchmark

## Prerequisites

This repository depends on the main Hydro repository for dfir_rs and sinktools. Clone both repositories as siblings:

```bash
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
```

## Running Benchmarks

From the repository root:

```bash
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench micro_ops
cargo bench -p benches --bench symmetric_hash_join
cargo bench -p benches --bench words_diamond
cargo bench -p benches --bench futures
```

## Dependencies

This repository includes:
- **Hydro dependencies**: dfir_rs, sinktools (from main Hydro repository)
- **Comparison dependencies**: timely-master, differential-dataflow-master
- **Benchmark framework**: criterion
- **Utilities**: futures, rand, tokio, etc.

## Data Files

- **words_alpha.txt** - Wordlist from https://github.com/dwyl/english-words/blob/master/words_alpha.txt

## Related Repositories

- **[bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)** - Main Hydro project repository (DFIR-native implementations without timely/differential dependencies)
