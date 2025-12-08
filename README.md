# bigweaver-agent-canary-zeta-hydro-deps

This repository contains external dependencies and benchmarks for the Hydro project that have been separated from the main repository to maintain a cleaner architecture and dependency isolation.

## Contents

### Benchmarks (`benches/`)

Performance benchmarks comparing Hydro with Timely Dataflow and Differential Dataflow. These benchmarks were moved from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to:

1. **Isolate Dependencies**: Keep external dependencies (timely-master, differential-dataflow-master) separate from the core Hydro framework
2. **Cleaner Architecture**: Maintain a clear distinction between Hydro's internal implementation and external performance comparisons
3. **Focused Development**: Allow the main repository to focus on Hydro framework development

See the [benches/README.md](benches/README.md) for detailed documentation on available benchmarks and how to run them.

## Quick Start

### Running Benchmarks

```bash
# Run all benchmarks
cargo bench -p benches

# Run a specific benchmark
cargo bench -p benches --bench reachability

# Run benchmarks matching a pattern
cargo bench -p benches --bench micro_ops
```

## Performance Comparisons

The benchmarks enable direct performance comparisons between:
- **Hydro (dfir_rs)**: The Hydro dataflow framework
- **Timely Dataflow**: Timely dataflow implementations
- **Differential Dataflow**: Differential dataflow implementations

Each benchmark typically includes implementations for multiple frameworks to enable fair comparisons.

## Available Benchmarks

### Timely Dataflow Benchmarks
- `arithmetic` - Arithmetic operations
- `fan_in` - Fan-in dataflow patterns
- `fan_out` - Fan-out dataflow patterns
- `fork_join` - Fork-join patterns
- `identity` - Identity transformations
- `join` - Join operations
- `upcase` - String transformations

### Differential Dataflow Benchmarks
- `reachability` - Graph reachability computations

### Hydro Comparison Benchmarks
- `futures` - Async futures benchmarks
- `micro_ops` - Micro-operation comparisons
- `symmetric_hash_join` - Hash join implementations
- `words_diamond` - Word processing patterns

## Dependencies

The benchmarks depend on:
- `dfir_rs` and `sinktools` from the main Hydro repository (referenced via git)
- `timely-master` - Timely Dataflow framework
- `differential-dataflow-master` - Differential Dataflow framework

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── README.md                    # This file
└── benches/                     # Benchmark suite
    ├── README.md                # Detailed benchmark documentation
    ├── Cargo.toml               # Benchmark package configuration
    ├── build.rs                 # Build script
    └── benches/                 # Individual benchmark files
        ├── arithmetic.rs
        ├── fan_in.rs
        ├── fan_out.rs
        ├── fork_join.rs
        ├── futures.rs
        ├── identity.rs
        ├── join.rs
        ├── micro_ops.rs
        ├── reachability.rs
        ├── symmetric_hash_join.rs
        ├── upcase.rs
        ├── words_diamond.rs
        ├── reachability_edges.txt      # Test data
        ├── reachability_reachable.txt  # Test data
        └── words_alpha.txt             # Test data
```

## Related Repositories

- [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) - Main Hydro repository

## Migration

These benchmarks were migrated from the main Hydro repository. For historical context and migration details, see the benchmark migration documentation in the main repository.

## License

Apache-2.0