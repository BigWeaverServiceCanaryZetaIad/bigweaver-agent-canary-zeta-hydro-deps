# bigweaver-agent-canary-zeta-hydro-deps

Hydro benchmarks and code with external dependencies for performance comparison.

## Overview

This repository contains benchmarks for the Hydro project. These benchmarks can be used for performance testing and comparison.

## Benchmarks

This repository contains the following benchmarks in the `benches/` directory:

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
cargo bench -p benches --bench symmetric_hash_join
cargo bench -p benches --bench words_diamond
cargo bench -p benches --bench futures
```

## Related Repositories

- **[bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)** - Main Hydro project repository