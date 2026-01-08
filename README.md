# bigweaver-agent-canary-zeta-hydro-deps

## Overview

This repository contains benchmarks for the Hydro project that were migrated from the main bigweaver-agent-canary-hydro-zeta repository. The migration helps reduce build dependencies and improve build times for the core repository while maintaining comprehensive benchmark capabilities.

## Benchmarks

The `benches/` directory contains performance benchmarks:
- **micro_ops** - Micro-operations benchmark testing basic Hydro operations
- **symmetric_hash_join** - Symmetric hash join benchmark
- **words_diamond** - Word processing diamond pattern benchmark
- **futures** - Futures-based operations benchmark

See [benches/README.md](benches/README.md) for detailed benchmark documentation.

## Running Benchmarks

```bash
# Run all benchmarks
cargo bench -p benches

# Run specific benchmark
cargo bench -p benches --bench micro_ops
```

## Related Repositories

- **[bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)** - Main Hydro project repository