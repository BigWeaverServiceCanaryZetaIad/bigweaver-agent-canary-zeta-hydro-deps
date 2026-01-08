# bigweaver-agent-canary-zeta-hydro-deps

## Overview

This repository contains benchmarks for performance comparison with timely and differential-dataflow implementations. The benchmarks were migrated from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to maintain a clean separation between core Hydro implementations and comparative benchmarking capabilities.

## Purpose

This repository serves as a dedicated location for:
- Hydro-native benchmark implementations
- Future timely/differential-dataflow comparison implementations
- Performance evaluation and comparison across different dataflow frameworks

## Benchmarks

The benchmarks are located in the `benches/` directory and include:
- **futures** - Futures-based operations benchmark
- **micro_ops** - Micro-operations benchmark
- **symmetric_hash_join** - Symmetric hash join benchmark
- **words_diamond** - Word processing diamond pattern benchmark

## Running Benchmarks

**Note:** See [SETUP.md](SETUP.md) for detailed setup instructions and dependency configuration.

Run all benchmarks:
```bash
cd benches
cargo bench
```

Run a specific benchmark:
```bash
cd benches
cargo bench --bench micro_ops
```

## Related Repositories

- **[bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)** - Main Hydro project repository without external dataflow dependencies