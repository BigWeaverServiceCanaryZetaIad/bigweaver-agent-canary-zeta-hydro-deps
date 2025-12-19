# bigweaver-agent-canary-zeta-hydro-deps

Companion repository for [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) containing benchmarks with timely and differential-dataflow dependencies.

## Overview

This repository maintains benchmarks that use timely and differential-dataflow dependencies for performance comparison with Hydro-native implementations. By separating these benchmarks from the main repository, we:

- Reduce build dependencies and improve build times for core development
- Maintain the ability to run comprehensive performance comparisons
- Provide a clear architectural boundary between implementations
- Enable independent evolution of benchmarking strategies

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── README.md                          # This file
└── benches/                           # Benchmark package
    ├── Cargo.toml                     # Package configuration with timely/differential dependencies
    ├── README.md                      # Detailed benchmark documentation
    └── benches/                       # Benchmark implementations
        ├── futures.rs                 # Futures-based operations benchmark
        ├── micro_ops.rs               # Micro-operations benchmark
        ├── symmetric_hash_join.rs     # Symmetric hash join benchmark
        ├── words_diamond.rs           # Word processing diamond pattern benchmark
        └── words_alpha.txt            # Test data for word benchmarks
```

## Quick Start

### Running Benchmarks

```bash
# Clone the repository
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps

# Run all benchmarks
cargo bench -p benches

# Run a specific benchmark
cargo bench -p benches --bench micro_ops
```

### Performance Comparison Workflow

1. **Run Hydro-native benchmarks** from the main repository:
   ```bash
   cd bigweaver-agent-canary-hydro-zeta
   cargo bench -p benches
   ```

2. **Run timely/differential benchmarks** from this repository:
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps
   cargo bench -p benches
   ```

3. **Compare results** using Criterion's output in `target/criterion/` directories

## Available Benchmarks

- **micro_ops** - Micro-operations benchmark for basic dataflow operations
- **symmetric_hash_join** - Symmetric hash join benchmark
- **words_diamond** - Word processing with diamond-shaped dataflow pattern
- **futures** - Futures-based asynchronous operations benchmark

Each benchmark currently contains Hydro-native implementations and is ready for timely/differential-dataflow comparison implementations to be added.

## Dependencies

Key dependencies included in this repository:
- `differential-dataflow-master` (0.13.0-dev.1)
- `timely-master` (0.13.0-dev.1)
- `criterion` (benchmarking framework)
- `tokio` (async runtime)
- `futures` (async utilities)

## Documentation

For detailed benchmark documentation, see [benches/README.md](benches/README.md).

## Related Repositories

- **[bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)** - Main Hydro repository with DFIR-native implementations

## Benefits of This Architecture

1. **Reduced Build Dependencies** - The main repository doesn't depend on timely/differential-dataflow
2. **Faster Build Times** - Core development builds are faster without external dataflow dependencies
3. **Maintained Functionality** - Performance comparison capabilities are fully preserved
4. **Clear Separation** - Clean architectural boundary between core and comparative implementations
5. **Improved Maintainability** - Each repository has a focused purpose and minimal dependencies

## Contributing

When adding new benchmarks:

1. Implement the benchmark in the main repository first (Hydro-native)
2. Copy the benchmark structure to this repository
3. Add timely/differential-dataflow comparison implementations
4. Update documentation in both repositories
5. Ensure both versions use compatible test data and parameters for fair comparison

## License

Apache-2.0