# Timely and Differential-Dataflow Benchmarks

This directory contains benchmarks for performance comparison with timely and differential-dataflow implementations.

## Overview

These benchmarks are maintained separately from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to avoid pulling in timely and differential-dataflow dependencies for the core Hydro development workflow.

## Available Benchmarks

### Benchmarks with Timely/Differential-Dataflow Implementations
These benchmarks include implementations using both Hydro-native (dfir_rs) and timely/differential-dataflow for performance comparison:

- **arithmetic** - Arithmetic operations benchmark
- **fan_in** - Fan-in pattern benchmark  
- **fan_out** - Fan-out pattern benchmark
- **fork_join** - Fork-join pattern benchmark (with code generation via build.rs)
- **identity** - Identity transformation benchmark
- **join** - Join operations benchmark
- **reachability** - Graph reachability benchmark (with test data files)
- **upcase** - String transformation benchmark

### Hydro-Native Reference Benchmarks
These benchmarks use Hydro-native (dfir_rs) implementations and are also available in the main repository:

- **futures** - Futures-based operations benchmark
- **micro_ops** - Micro-operations benchmark
- **symmetric_hash_join** - Symmetric hash join benchmark
- **words_diamond** - Word processing diamond pattern benchmark

## Dependencies

This benchmark suite includes:
- `dfir_rs` - Hydro's DFIR implementation (path dependency to main repository)
- `timely` (package: timely-master, version: 0.13.0-dev.1)
- `differential-dataflow` (package: differential-dataflow-master, version: 0.13.0-dev.1)
- `criterion` for benchmarking framework
- Supporting libraries (futures, rand, tokio, etc.)

### Repository Structure
The benchmarks require both repositories to be cloned as sibling directories:
```
/your-workspace/
  ├── bigweaver-agent-canary-hydro-zeta/    (contains dfir_rs)
  └── bigweaver-agent-canary-zeta-hydro-deps/  (this repository)
```

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
# Timely/differential-dataflow benchmarks
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench fan_in
cargo bench -p benches --bench fan_out
cargo bench -p benches --bench fork_join
cargo bench -p benches --bench identity
cargo bench -p benches --bench join
cargo bench -p benches --bench reachability
cargo bench -p benches --bench upcase

# Hydro-native reference benchmarks
cargo bench -p benches --bench futures
cargo bench -p benches --bench micro_ops
cargo bench -p benches --bench symmetric_hash_join
cargo bench -p benches --bench words_diamond
```

## Performance Comparison

All benchmarks are consolidated in this repository. They include:
- Hydro-native (dfir_rs) implementations
- Timely/Differential-Dataflow implementations (where available)

### Running Benchmarks
From this repository:
```bash
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench -p benches
```

### Comparing Results
Results can be compared to evaluate performance characteristics between Hydro-native and Timely/Differential-Dataflow implementations.

## Data Files

- `words_alpha.txt` - Wordlist from https://github.com/dwyl/english-words/blob/master/words_alpha.txt (used by words_diamond benchmark)
- `reachability_edges.txt` - Test data for reachability benchmark
- `reachability_reachable.txt` - Expected results for reachability benchmark

## Build Configuration

- `build.rs` - Build script that generates code for the fork_join benchmark at build time
- Generated files (e.g., `fork_join_*.hf`) are gitignored

## Migration Notes

All benchmarks with timely/differential-dataflow dependencies have been migrated here to:
- Reduce build dependencies in the main Hydro repository
- Improve build times for core development
- Provide a unified location for performance testing with timely/differential-dataflow
- Enable side-by-side comparison of Hydro-native and timely/differential implementations

The benchmarks in this repository include:
- **8 benchmarks with actual timely/differential-dataflow implementations** for performance comparison
- **4 Hydro-native reference benchmarks** (also available in main repository) to support future comparative implementations

The main repository now focuses exclusively on core Hydro/DFIR development with only Hydro-native benchmarks.

For more information about the benchmark migration, see [BENCHMARK_MIGRATION.md](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta/blob/main/BENCHMARK_MIGRATION.md) in the main repository.
