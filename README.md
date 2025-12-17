# bigweaver-agent-canary-zeta-hydro-deps

Benchmarks and code with timely/differential-dataflow dependencies for performance comparison.

## Overview

This repository contains benchmarks that compare Hydro implementations with timely and differential-dataflow. The benchmarks are kept separate from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to reduce build dependencies and improve build times for core development.

## Purpose

This separation allows:
1. **Reduced Build Dependencies**: The main repository remains free of timely/differential-dataflow dependencies
2. **Faster Core Development**: Developers working on Hydro don't need to build external dataflow dependencies
3. **Maintained Performance Comparisons**: Ability to benchmark and compare Hydro with timely/differential-dataflow implementations
4. **Clear Architectural Boundary**: Separation between core implementation and comparative benchmarks

## Benchmarks

The `benches/` directory contains benchmarks that test various dataflow patterns and operations:
- Arithmetic operations
- Fan-in and fan-out patterns
- Fork-join patterns
- Join operations
- Graph reachability
- String transformations

See [benches/README.md](benches/README.md) for detailed information about running benchmarks.

## Running Benchmarks

```bash
cd benches
cargo bench
```

## Performance Comparison Workflow

1. Run benchmarks in this repository (with timely/differential-dataflow dependencies):
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps
   cargo bench -p benches
   ```

2. Run Hydro-native benchmarks in the main repository:
   ```bash
   cd bigweaver-agent-canary-hydro-zeta
   cargo bench -p benches
   ```

3. Compare the results to evaluate performance characteristics between implementations

## Related Repositories

- **[bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)** - Main Hydro project repository with DFIR-native implementations

## Migration Documentation

For details about the benchmark migration from the main repository, see [BENCHMARK_MIGRATION.md](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta/blob/main/BENCHMARK_MIGRATION.md) in the main repository.