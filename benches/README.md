# Timely/Differential-Dataflow Benchmarks

Benchmarks for comparing Hydro with timely and differential-dataflow implementations.

## Overview

This directory contains benchmarks that depend on timely and differential-dataflow packages. These benchmarks enable performance comparisons between Hydro-native implementations (in the main bigweaver-agent-canary-hydro-zeta repository) and timely/differential-dataflow implementations.

## Available Benchmarks

- **arithmetic** - Arithmetic operations benchmark
- **fan_in** - Fan-in pattern benchmark
- **fan_out** - Fan-out pattern benchmark
- **fork_join** - Fork-join pattern benchmark (with code generation via build.rs)
- **identity** - Identity transformation benchmark
- **join** - Join operations benchmark
- **reachability** - Graph reachability benchmark (uses data files)
- **upcase** - String transformation benchmark

## Dependencies

This benchmark suite requires:
- `timely-master` (version 0.13.0-dev.1)
- `differential-dataflow-master` (version 0.13.0-dev.1)
- `criterion` for benchmarking framework
- Additional utilities: `futures`, `rand`, `tokio`

**Note:** Some benchmarks include comparative tests with Hydro/DFIR implementations. These benchmarks reference `dfir_rs` and `sinktools` crates which are part of the main Hydro workspace. To run comparative benchmarks, you would need to set up this repository within or alongside the main Hydro workspace.

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench join
cargo bench -p benches --bench reachability
```

## Performance Comparison

To compare performance with Hydro-native implementations:

1. Run benchmarks in this repository (timely/differential implementations):
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps
   cargo bench -p benches
   ```

2. Run benchmarks in the main repository (Hydro-native implementations):
   ```bash
   cd bigweaver-agent-canary-hydro-zeta
   cargo bench -p benches
   ```

3. Compare the results from both runs to evaluate performance characteristics

## Data Files

- `reachability_edges.txt` - Graph edge data for reachability benchmark
- `reachability_reachable.txt` - Expected reachability results for verification

## Build Process

The `fork_join` benchmark uses a build script (`build.rs`) that generates code at build time. Generated files matching the pattern `fork_join_*.hf` are ignored by git (see `.gitignore`).

## Related Repositories

- **[bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)** - Main repository with Hydro-native benchmarks that do not depend on timely or differential-dataflow
