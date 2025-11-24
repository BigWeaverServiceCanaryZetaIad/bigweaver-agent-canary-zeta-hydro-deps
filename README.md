# bigweaver-agent-canary-zeta-hydro-deps

This repository contains the timely-dataflow and differential-dataflow benchmarks that were moved from the [bigweaver-agent-canary-hydro-zeta](https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository. This separation allows for better dependency management and maintains a cleaner main codebase while preserving the ability to run performance comparisons.

## Overview

This repository is dedicated to housing dependencies and benchmarks that require external packages like `timely-master` and `differential-dataflow-master`. By isolating these dependencies in a separate repository, we:

1. **Reduce dependency overhead** in the main repository
2. **Maintain separation of concerns** between core functionality and performance testing
3. **Preserve performance comparison capabilities** independently
4. **Follow team strategy** of isolating components in dedicated repositories

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── benches/              # Benchmark workspace package
│   ├── benches/          # Individual benchmark implementations
│   │   ├── arithmetic.rs
│   │   ├── fan_in.rs
│   │   ├── fan_out.rs
│   │   ├── fork_join.rs
│   │   ├── futures.rs
│   │   ├── identity.rs
│   │   ├── join.rs
│   │   ├── micro_ops.rs
│   │   ├── reachability.rs
│   │   ├── symmetric_hash_join.rs
│   │   ├── upcase.rs
│   │   ├── words_diamond.rs
│   │   ├── reachability_edges.txt      # Test data
│   │   ├── reachability_reachable.txt  # Test data
│   │   └── words_alpha.txt             # Test data (~4.4MB)
│   ├── Cargo.toml        # Benchmark package configuration
│   ├── build.rs          # Build script for code generation
│   └── README.md         # Benchmark-specific documentation
├── Cargo.toml            # Workspace configuration
└── README.md             # This file
```

## Getting Started

### Prerequisites

- Rust toolchain (see `rust-toolchain.toml` in main repository for version)
- Cargo

### Running Benchmarks

#### Run All Benchmarks

```bash
cargo bench -p benches
```

#### Run Specific Benchmark

```bash
# Run reachability benchmark
cargo bench -p benches --bench reachability

# Run arithmetic benchmark
cargo bench -p benches --bench arithmetic

# Run join benchmark
cargo bench -p benches --bench join
```

#### Available Benchmarks

- **arithmetic** - Basic arithmetic operations
- **fan_in** - Fan-in dataflow patterns
- **fan_out** - Fan-out dataflow patterns
- **fork_join** - Fork-join patterns
- **futures** - Async futures operations
- **identity** - Identity transformations
- **join** - Join operations
- **micro_ops** - Micro-operation benchmarks
- **reachability** - Graph reachability algorithms
- **symmetric_hash_join** - Symmetric hash join implementations
- **upcase** - String case transformations
- **words_diamond** - Word processing diamond patterns

### Benchmark Results

Benchmark results are generated in `target/criterion/` directory with HTML reports. Open `target/criterion/report/index.html` in your browser to view detailed results.

## Dependencies

This repository includes the following key dependencies:

- **timely-master** (0.13.0-dev.1) - Timely dataflow framework
- **differential-dataflow-master** (0.13.0-dev.1) - Differential dataflow framework
- **criterion** (0.5.0) - Statistical benchmarking framework
- **dfir_rs** - Referenced from main repository via git
- **sinktools** - Referenced from main repository via git

## CI/CD Integration

This repository includes a GitHub Actions workflow (`.github/workflows/benchmark.yml`) that runs benchmarks automatically on:

- Push to `main` branch
- Push to `feature/**` branches
- Pull requests
- Daily schedule (8:35 PM PDT / 7:35 PM PST)
- Manual workflow dispatch

## Performance Comparison

These benchmarks allow comparison between different implementations:

- **Timely-dataflow** implementations
- **Differential-dataflow** implementations
- **Hydroflow/dfir_rs** implementations

This multi-framework comparison capability is essential for validating performance characteristics and optimization efforts.

## Migration History

These benchmarks were migrated from `bigweaver-agent-canary-hydro-zeta` repository to:

1. Remove `timely` and `differential-dataflow` dependencies from the main repository
2. Reduce compilation overhead and complexity in the core codebase
3. Maintain independent benchmark execution capabilities
4. Align with team's dependency isolation strategy

For more details, see the `BENCHMARK_REMOVAL.md` in the main repository.

## Contributing

When adding new benchmarks:

1. Add the benchmark implementation in `benches/benches/`
2. Update `benches/Cargo.toml` to include the new `[[bench]]` entry
3. Follow the existing benchmark structure and naming conventions
4. Include appropriate test data files if needed
5. Update this README to list the new benchmark

## Related Documentation

- Main Repository: [bigweaver-agent-canary-hydro-zeta](https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)
- Timely Dataflow: https://github.com/TimelyDataflow/timely-dataflow
- Differential Dataflow: https://github.com/TimelyDataflow/differential-dataflow

## License

Apache-2.0