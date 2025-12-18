# Timely and Differential-Dataflow Benchmarks

This directory contains benchmarks that compare Hydro implementations with Timely and Differential-Dataflow implementations for performance evaluation.

## Overview

These benchmarks were migrated from the [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to separate the timely and differential-dataflow dependencies from the main codebase.

## Available Benchmarks

- **arithmetic** - Arithmetic operations benchmark comparing different implementations
- **fan_in** - Fan-in pattern benchmark
- **fan_out** - Fan-out pattern benchmark
- **fork_join** - Fork-join pattern benchmark
- **identity** - Identity transformation benchmark
- **join** - Join operations benchmark
- **reachability** - Graph reachability benchmark
- **upcase** - String transformation benchmark

## Dependencies

This benchmark suite depends on:
- `timely-master` (version 0.13.0-dev.1) - Timely dataflow framework
- `differential-dataflow-master` (version 0.13.0-dev.1) - Differential dataflow framework
- `criterion` - Benchmarking framework
- `dfir_rs` - Hydro's DFIR implementation (from main repository)
- `sinktools` - Hydro's sink utilities (from main repository)

### Setup Requirements

Most benchmarks perform performance comparisons between Hydro and Timely/Differential-Dataflow implementations, which requires access to the Hydro source code (`dfir_rs` and `sinktools` crates).

**Option 1: Side-by-side repositories (Recommended)**
```bash
# Clone both repositories side-by-side
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git

# The Cargo.toml is configured to find dfir_rs and sinktools in ../bigweaver-agent-canary-hydro-zeta/
```

**Option 2: Standalone benchmarks**
The following benchmarks can run without Hydro dependencies (only Timely/Differential):
- `join.rs`
- `upcase.rs`

**Option 3: Custom hydro path**
If your Hydro repository is located elsewhere, update the paths in `benches/Cargo.toml`:
```toml
dfir_rs = { path = "/path/to/hydro/dfir_rs", features = [ "debugging" ] }
sinktools = { path = "/path/to/hydro/sinktools", version = "^0.0.1" }
```

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench fork_join
cargo bench -p benches --bench reachability
```

## Performance Comparison

To compare with Hydro-native implementations, run the benchmarks in the main repository:
```bash
cd ../bigweaver-agent-canary-hydro-zeta
cargo bench -p benches
```

## Data Files

- **reachability_edges.txt** - Input edges for the reachability benchmark
- **reachability_reachable.txt** - Expected reachable nodes for verification

## Build Script

The `build.rs` script generates code for the fork_join benchmark at build time, creating test cases with different parallelism factors.

## Migration History

These benchmarks were migrated from the main repository on December 18, 2024, to:
1. Reduce build dependencies in the main repository
2. Improve build times for core development
3. Maintain the ability to run performance comparisons with Timely/Differential implementations
4. Provide clear separation between core implementation and comparative benchmarks

For more details, see the [BENCHMARK_MIGRATION.md](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta/blob/main/BENCHMARK_MIGRATION.md) in the main repository.
