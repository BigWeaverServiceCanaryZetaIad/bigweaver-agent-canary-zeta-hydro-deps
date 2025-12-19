# Timely and Differential-Dataflow Benchmarks

This directory contains benchmarks for comparing timely/differential-dataflow implementations with Hydro (DFIR) implementations. These benchmarks were migrated from the [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to reduce build dependencies in the main project.

## Overview

The benchmarks in this repository include both timely/differential-dataflow implementations and Hydro-native (DFIR) implementations, allowing for direct performance comparisons between the two dataflow frameworks.

## Available Benchmarks

### Timely/Differential-Dataflow Benchmarks
- **arithmetic** - Arithmetic operations pipeline benchmark
- **fan_in** - Fan-in pattern benchmark (multiple inputs to one output)
- **fan_out** - Fan-out pattern benchmark (one input to multiple outputs)
- **fork_join** - Fork-join pattern benchmark with dynamic code generation
- **identity** - Identity transformation benchmark (pass-through operations)
- **join** - Join operations benchmark
- **reachability** - Graph reachability benchmark with test data
- **upcase** - String transformation (uppercase) benchmark

### Hydro-Native Benchmarks
- **futures** - Futures-based operations benchmark
- **micro_ops** - Micro-operations benchmark testing fundamental operations
- **symmetric_hash_join** - Symmetric hash join benchmark
- **words_diamond** - Word processing diamond pattern benchmark

## Running Benchmarks

### Run All Benchmarks
```bash
cd benches
cargo bench
```

### Run Specific Benchmark
```bash
cargo bench --bench arithmetic
cargo bench --bench reachability
cargo bench --bench micro_ops
```

### Run Category of Benchmarks
```bash
# Run only timely/differential benchmarks
cargo bench --bench arithmetic --bench fan_in --bench fan_out --bench fork_join --bench identity --bench join --bench reachability --bench upcase

# Run only Hydro-native benchmarks
cargo bench --bench futures --bench micro_ops --bench symmetric_hash_join --bench words_diamond
```

## Build Process

The `fork_join` benchmark uses a build script (`build.rs`) to dynamically generate code at build time. The generated file `fork_join_20.hf` is created in the `benches/` directory and is excluded from version control via `.gitignore`.

## Data Files

The benchmarks include several data files for testing:

- **reachability_edges.txt** - Graph edge data for the reachability benchmark
- **reachability_reachable.txt** - Expected reachable nodes for verification
- **words_alpha.txt** - English word list from [dwyl/english-words](https://github.com/dwyl/english-words/blob/master/words_alpha.txt) used by the words_diamond benchmark

## Dependencies

This benchmark suite depends on:

- **timely-master** (v0.13.0-dev.1) - Timely dataflow framework
- **differential-dataflow-master** (v0.13.0-dev.1) - Differential dataflow framework
- **dfir_rs** - Hydro's DFIR runtime (from main repository via git)
- **sinktools** - Sink utilities for dataflow operations (from main repository via git)
- **criterion** - Benchmarking framework
- Additional support libraries (futures, tokio, rand, etc.)

## Performance Comparison

To compare performance between Hydro-native and timely/differential-dataflow implementations:

1. Run benchmarks in this repository (timely/differential versions)
2. Run benchmarks in the [main repository](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) (Hydro-native versions)
3. Compare the criterion output reports generated in `target/criterion/`

Example:
```bash
# In deps repository
cd bigweaver-agent-canary-zeta-hydro-deps/benches
cargo bench --bench arithmetic

# In main repository
cd bigweaver-agent-canary-hydro-zeta
cargo bench -p benches --bench micro_ops
```

## Benchmark Details

### Arithmetic
Tests pipeline processing with arithmetic operations, comparing:
- Raw channel-based pipeline
- Timely dataflow implementation
- DFIR implementation

### Fan-In / Fan-Out
Tests merge and split patterns commonly used in dataflow processing.

### Fork-Join
Tests parallel processing patterns with conditional branching and merging. Uses code generation to create configurable pipeline depths.

### Join Operations
Tests various join implementations including:
- Hash joins
- Symmetric hash joins
- Cross joins
- Anti-joins

### Reachability
Tests graph algorithms, specifically transitive closure for computing reachable nodes in a directed graph.

### Words Diamond
Tests complex dataflow patterns with multiple transformations on word data, including:
- Filtering
- Mapping
- Grouping
- Aggregation

## Architecture Notes

The benchmarks use Criterion's benchmarking framework with custom configurations:
- Async tokio support for async benchmarks
- HTML report generation for visualization
- Black-box operations to prevent compiler optimizations from skewing results

Each benchmark is configured with `harness = false` to allow Criterion to manage the benchmarking process.

## Migration History

These benchmarks were migrated from the main bigweaver-agent-canary-hydro-zeta repository on December 17-18, 2024. See [BENCHMARK_MIGRATION.md](../BENCHMARK_MIGRATION.md) in the main repository for complete migration details.

## Contributing

When adding new benchmarks:

1. Add the `.rs` file to `benches/benches/`
2. Update `Cargo.toml` to include a `[[bench]]` entry
3. Include both timely/differential and DFIR implementations where applicable
4. Add any required data files to `benches/benches/`
5. Update this README with benchmark description and usage
