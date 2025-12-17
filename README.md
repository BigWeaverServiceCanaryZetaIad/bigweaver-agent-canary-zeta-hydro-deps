# bigweaver-agent-canary-zeta-hydro-deps

Companion repository for benchmarks and code that depend on timely and differential-dataflow.

## Overview

This repository contains benchmarks and implementations that depend on timely and differential-dataflow packages. It serves as a companion to the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository, enabling performance comparisons between Hydro-native implementations and timely/differential-dataflow implementations.

## Purpose

The separation of these dependencies allows:
- **Reduced Build Dependencies**: The main repository avoids depending on timely and differential-dataflow
- **Faster Build Times**: Core development builds are faster without external dataflow dependencies
- **Maintained Functionality**: Performance comparison capabilities are preserved in this repository
- **Clear Separation**: Clean architectural boundary between core implementation and comparative benchmarks

## Benchmarks

The `benches/` directory contains performance benchmarks comparing Hydro with timely/differential-dataflow implementations. See [benches/README.md](benches/README.md) for detailed information about available benchmarks and how to run them.

### Available Benchmarks

- arithmetic - Arithmetic operations
- fan_in - Fan-in patterns
- fan_out - Fan-out patterns
- fork_join - Fork-join patterns
- identity - Identity transformations
- join - Join operations
- reachability - Graph reachability
- upcase - String transformations

## Running Benchmarks

```bash
cd benches
cargo bench
```

## Performance Comparison Workflow

1. Run benchmarks in this repository (with timely/differential-dataflow):
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps
   cargo bench -p benches
   ```

2. Run benchmarks in the main repository (Hydro-native):
   ```bash
   cd bigweaver-agent-canary-hydro-zeta
   cargo bench -p benches
   ```

3. Compare results to evaluate performance characteristics

## Related Repositories

- **[bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)** - Main Hydro project repository with DFIR-native implementations