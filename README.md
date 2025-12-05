# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks for the Hydro project that depend on external dataflow systems such as Timely and Differential Dataflow.

## Overview

These benchmarks were moved from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to avoid adding those dependencies to the core codebase. This separation allows for:

- Cleaner dependency management in the main repository
- Focused performance comparison capabilities
- Independent versioning of benchmark code

## Benchmarks

The following benchmarks are included:

- **arithmetic**: Arithmetic operations performance comparison
- **fan_in**: Fan-in pattern performance (multiple sources to single operator)
- **fan_out**: Fan-out pattern performance (single source to multiple operators)
- **fork_join**: Fork-join pattern performance
- **identity**: Identity/pass-through operation performance
- **join**: Join operation performance
- **reachability**: Graph reachability algorithm performance
- **upcase**: String uppercase transformation performance

Each benchmark compares the performance of Hydro (dfir_rs) against Timely Dataflow and/or Differential Dataflow implementations.

## Running Benchmarks

To run all benchmarks:

```bash
cargo bench
```

To run a specific benchmark:

```bash
cargo bench --bench <benchmark_name>
```

For example:

```bash
cargo bench --bench reachability
```

## Requirements

- Rust toolchain (see rust-toolchain.toml in the main repository)
- Timely and Differential Dataflow dependencies (automatically fetched by Cargo)

## Related Repositories

- [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) - Main Hydro project repository

## Migration Guide

For details on how these benchmarks were migrated, see [BENCHMARK_MIGRATION.md](BENCHMARK_MIGRATION.md) in the main repository.
