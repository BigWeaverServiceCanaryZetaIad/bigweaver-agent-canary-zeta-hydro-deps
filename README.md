# bigweaver-agent-canary-zeta-hydro-deps

## Overview

This repository contains benchmarks and code that depend on timely and differential-dataflow packages for performance comparison with Hydro-native implementations.

## Purpose

This repository serves as a companion to [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta), maintaining benchmarks that require external dataflow dependencies. This separation:

- Reduces build dependencies in the main repository
- Improves build times for core development
- Maintains performance comparison capabilities
- Provides clear architectural boundaries

## Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── README.md              # This file
├── MIGRATION_VERIFICATION.md  # Migration verification documentation
└── benches/              # Benchmark package (to be added)
    ├── Cargo.toml        # Package configuration with timely/differential dependencies
    ├── README.md         # Benchmark-specific documentation
    └── benches/          # Individual benchmark files
```

## Running Benchmarks

Once benchmarks are added, you can run them using:

```bash
# Run all benchmarks
cargo bench -p benches

# Run specific benchmark
cargo bench -p benches --bench <benchmark_name>
```

## Performance Comparison

To compare performance between Hydro-native and timely/differential-dataflow implementations:

1. **Run Hydro-native benchmarks** in the main repository:
   ```bash
   cd ../bigweaver-agent-canary-hydro-zeta
   cargo bench -p benches
   ```

2. **Run timely/differential benchmarks** in this repository:
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps
   cargo bench -p benches
   ```

3. Compare results from both runs to evaluate performance characteristics

## Dependencies

This repository includes dependencies on:
- `timely` (or `timely-master`) - Timely dataflow framework
- `differential-dataflow` (or `differential-dataflow-master`) - Differential dataflow framework
- Additional benchmarking and utility crates as needed

## Related Repositories

- **[bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)** - Main Hydro project repository with DFIR-native implementations and Hydro-native benchmarks