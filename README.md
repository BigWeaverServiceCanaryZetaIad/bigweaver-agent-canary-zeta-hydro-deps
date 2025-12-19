# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmark dependencies for the [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) project, specifically focusing on timely and differential-dataflow benchmarks for performance comparison.

## Purpose

This repository was created to:
1. Reduce build dependencies in the main bigweaver-agent-canary-hydro-zeta repository
2. Maintain the ability to run performance comparisons between Hydro-native implementations and timely/differential-dataflow implementations
3. Provide a standalone environment for testing and benchmarking dataflow operations

## Contents

### Benchmarks (`benches/`)

The repository contains a comprehensive suite of benchmarks comparing:
- **Timely/Differential-Dataflow implementations** - Classic dataflow framework implementations
- **Hydro (DFIR) implementations** - Modern Rust-native dataflow implementations

Benchmark categories include:
- Arithmetic and micro-operations
- Join operations (hash join, symmetric join)
- Graph algorithms (reachability)
- Pattern processing (fan-in, fan-out, fork-join)
- String transformations
- Complex dataflow patterns (diamond, futures)

See the [benches/README.md](benches/README.md) for detailed documentation on available benchmarks and usage.

## Quick Start

### Prerequisites

- Rust toolchain (edition 2021 or later)
- Cargo

### Running Benchmarks

```bash
cd benches
cargo bench
```

Run specific benchmark:
```bash
cargo bench --bench arithmetic
cargo bench --bench reachability
```

### Performance Comparison Workflow

1. **Run timely/differential benchmarks** (this repository):
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps/benches
   cargo bench
   ```

2. **Run Hydro-native benchmarks** (main repository):
   ```bash
   cd bigweaver-agent-canary-hydro-zeta
   cargo bench -p benches
   ```

3. **Compare results** from `target/criterion/` in both repositories

## Key Dependencies

- **timely-master** (v0.13.0-dev.1) - Timely dataflow framework
- **differential-dataflow-master** (v0.13.0-dev.1) - Incremental dataflow computations
- **dfir_rs** - Hydro's DFIR runtime (from main repository)
- **criterion** - Benchmarking framework with statistical analysis

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── README.md                          # This file
└── benches/                           # Benchmark suite
    ├── Cargo.toml                     # Package configuration
    ├── README.md                      # Benchmark documentation
    ├── build.rs                       # Build script for code generation
    └── benches/                       # Benchmark implementations
        ├── .gitignore                 # Ignore generated files
        ├── arithmetic.rs              # Arithmetic operations benchmark
        ├── fan_in.rs                  # Fan-in pattern benchmark
        ├── fan_out.rs                 # Fan-out pattern benchmark
        ├── fork_join.rs               # Fork-join pattern benchmark
        ├── futures.rs                 # Futures-based operations
        ├── identity.rs                # Identity transformation
        ├── join.rs                    # Join operations
        ├── micro_ops.rs               # Micro-operations
        ├── reachability.rs            # Graph reachability
        ├── symmetric_hash_join.rs     # Symmetric hash join
        ├── upcase.rs                  # String transformation
        ├── words_diamond.rs           # Word processing patterns
        ├── reachability_edges.txt     # Test data
        ├── reachability_reachable.txt # Test data
        └── words_alpha.txt            # Word list data
```

## Migration History

This repository was established to separate timely/differential-dataflow benchmarks from the main repository:

- **December 17, 2024**: Initial migration of timely/differential benchmarks
- **December 18, 2024**: Added Hydro-native benchmarks for future comparison implementations
- **December 19, 2024**: Completed benchmark migration with all dependencies and documentation

For detailed migration information, see BENCHMARK_MIGRATION.md in the main repository.

## Related Repositories

- [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) - Main Hydro project repository

## Contributing

When contributing benchmarks:

1. Ensure benchmarks include both timely/differential and DFIR implementations where applicable
2. Follow existing benchmark structure and naming conventions
3. Update documentation in both `benches/README.md` and this file
4. Include test data files if needed
5. Verify benchmarks run successfully with `cargo bench`

## License

This project follows the same license as the main bigweaver-agent-canary-hydro-zeta repository.