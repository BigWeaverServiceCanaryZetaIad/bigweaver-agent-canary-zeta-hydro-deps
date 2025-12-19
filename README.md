# bigweaver-agent-canary-zeta-hydro-deps

Performance benchmark repository for Hydro with timely and differential-dataflow dependencies.

## Overview

This repository contains benchmarks for performance comparison between Hydro and timely/differential-dataflow implementations. It includes:

- Hydro DFIR-native benchmark implementations
- Dependencies on timely and differential-dataflow for future comparative benchmarks
- Benchmark infrastructure and test data

## Purpose

This repository is separated from the main Hydro repository to:
1. Isolate timely and differential-dataflow dependencies
2. Enable performance comparisons without adding build dependencies to the main repository
3. Maintain faster build times for core Hydro development

## Structure

```
benches/
  ├── Cargo.toml          # Benchmark package configuration
  ├── README.md           # Detailed benchmark documentation
  └── benches/            # Benchmark implementations
      ├── micro_ops.rs
      ├── symmetric_hash_join.rs
      ├── words_diamond.rs
      ├── futures.rs
      └── words_alpha.txt # Test data
```

## Prerequisites

This repository depends on the main Hydro repository. Clone both as siblings:

```bash
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
```

## Running Benchmarks

```bash
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench -p benches
```

For more details, see [benches/README.md](benches/README.md).

## Related Repositories

- **[bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)** - Main Hydro project repository without timely/differential dependencies
