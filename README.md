# bigweaver-agent-canary-zeta-hydro-deps

## Overview

This repository contains all benchmarks for the Hydro project, including:
- Hydro-native benchmarks (futures, micro_ops, symmetric_hash_join, words_diamond)
- Benchmarks with timely and differential-dataflow dependencies for performance comparison

## Purpose

This repository was created to:
1. Maintain all benchmarking code in a dedicated location
2. Keep timely/differential-dataflow dependencies separate from the main repository
3. Enable performance comparisons between Hydro-native and timely/differential-dataflow implementations

## Running Benchmarks

Run all benchmarks:
```bash
cd benches
cargo bench
```

Run specific benchmarks:
```bash
cd benches
cargo bench --bench micro_ops
cargo bench --bench words_diamond
```

## Related Repositories

- **[bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)** - Main Hydro project repository without dependencies on timely or differential-dataflow