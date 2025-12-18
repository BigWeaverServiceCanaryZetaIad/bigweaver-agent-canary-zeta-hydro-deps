# bigweaver-agent-canary-zeta-hydro-deps

Performance comparison repository for Hydro benchmarks with Timely and Differential Dataflow dependencies.

## Overview

This repository contains benchmarks and code that depend on Timely Dataflow and Differential Dataflow for performance comparison with Hydro-native implementations. By maintaining these benchmarks in a separate repository, the main Hydro project can avoid build-time dependencies on these external dataflow systems.

## Purpose

- **Performance Comparison** - Enable direct performance comparisons between Hydro and Timely/Differential Dataflow implementations
- **Dependency Isolation** - Keep heavy external dependencies separate from the core project
- **Faster Core Builds** - Main repository builds faster without these dependencies
- **Validation** - Verify that Hydro implementations achieve competitive performance

## Repository Structure

```
benches/
├── Cargo.toml           # Benchmark package configuration with timely/differential dependencies
├── README.md            # Detailed benchmark documentation
├── .gitignore          # Git ignore patterns
└── benches/            # Benchmark implementations
    ├── futures.rs
    ├── micro_ops.rs
    ├── symmetric_hash_join.rs
    ├── words_diamond.rs
    └── words_alpha.txt
```

## Benchmarks

The repository currently includes:

- **micro_ops** - Micro-operations benchmark (identity, unique, map, filter, flatten, etc.)
- **symmetric_hash_join** - Symmetric hash join implementation benchmark
- **words_diamond** - Word processing with diamond pattern benchmark
- **futures** - Futures-based async operations benchmark

Additional benchmarks with Timely/Differential Dataflow comparison implementations can be added.

## Running Benchmarks

```bash
# Run all benchmarks
cargo bench -p hydro-deps-benches

# Run specific benchmark
cargo bench -p hydro-deps-benches --bench micro_ops

# Run with specific filter
cargo bench -p hydro-deps-benches -- "micro/ops"
```

## Performance Comparison Workflow

1. **Run benchmarks in this repository** to get Hydro baseline performance
2. **Implement Timely/Differential versions** of the same benchmarks
3. **Compare results** using Criterion's statistical analysis and reports
4. **Analyze differences** in performance characteristics

## Dependencies

This repository includes:
- `timely-master` (0.13.0-dev.1) - Timely Dataflow
- `differential-dataflow-master` (0.13.0-dev.1) - Differential Dataflow  
- `criterion` - Benchmarking framework
- Additional utilities for benchmark implementation

**Important**: The benchmarks require access to Hydro's `dfir_rs` and `sinktools` crates. Before running benchmarks, configure these dependencies in `benches/Cargo.toml` with the appropriate path or git reference:

```toml
dfir_rs = { path = "../../path/to/dfir_rs", features = [ "debugging" ] }
sinktools = { path = "../../path/to/sinktools", version = "^0.0.1" }
```

## Related Repositories

- **[bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)** - Main Hydro repository without timely/differential dependencies

## Migration

These benchmarks were migrated from the main repository to enable:
- Independent development cycles
- Reduced build times for core development
- Optional performance comparison testing
- Clear separation of concerns

See the [main repository's BENCHMARK_MIGRATION.md](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta/blob/main/BENCHMARK_MIGRATION.md) for details on the migration process.

## Contributing

When adding new benchmarks:
1. Implement the benchmark in `benches/benches/`
2. Add the benchmark entry to `benches/Cargo.toml`
3. Update benchmark documentation in `benches/README.md`
4. Consider implementing both Hydro and Timely/Differential versions for comparison