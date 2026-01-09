# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks that compare Hydro with timely and differential-dataflow implementations.

## Purpose

To avoid having timely and differential-dataflow as dependencies in the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository, these comparison benchmarks have been moved to this separate repository. This allows for:

- Clean separation of concerns between Hydro-native functionality and external comparisons
- Independent testing and performance evaluation
- Reduced dependency complexity in the main codebase

## Repository Structure

```
.
├── benches/          # Benchmark suite comparing Hydro with timely/differential-dataflow
│   ├── benches/      # Individual benchmark implementations
│   ├── Cargo.toml    # Benchmark package configuration
│   └── README.md     # Detailed benchmark documentation
├── Cargo.toml        # Workspace configuration
└── README.md         # This file
```

## Benchmarks

The `benches` directory contains microbenchmarks comparing Hydro's performance with timely and differential-dataflow implementations:

- **arithmetic**: Arithmetic operations performance
- **fan_in**: Fan-in pattern performance
- **fan_out**: Fan-out pattern performance  
- **fork_join**: Fork-join pattern performance
- **identity**: Identity operations performance
- **join**: Join operations performance
- **reachability**: Reachability algorithm performance
- **upcase**: String upper-casing performance

## Quick Start

```bash
# Clone the repository
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps

# Run all benchmarks
cargo bench

# Run a specific benchmark
cargo bench --bench reachability
```

## Cross-Repository Comparison

For instructions on comparing performance between this repository and the Hydro-native benchmarks in the main bigweaver-agent-canary-hydro-zeta repository, see [benches/README.md](benches/README.md).

## Dependencies

The benchmarks reference the main Hydro repository via git dependencies to access `dfir_rs` and related packages. This allows the benchmarks to compare against the latest Hydro implementation without requiring manual synchronization.

## Documentation

For more detailed information about the benchmarks, including how to run them and interpret results, see the [benches/README.md](benches/README.md) file.