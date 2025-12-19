# bigweaver-agent-canary-zeta-hydro-deps

Performance benchmarks for Timely Dataflow and Differential Dataflow implementations, separated from the main Hydro repository for reduced build dependencies and focused testing.

## Overview

This repository contains benchmarks that were migrated from [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) to provide a standalone environment for performance comparisons using Timely Dataflow and Differential Dataflow frameworks.

## Purpose

This repository serves as a dedicated benchmarking environment that:

- **Reduces Build Dependencies**: Keeps Timely/Differential dependencies separate from the main Hydro codebase
- **Enables Performance Comparison**: Provides baseline implementations for comparing against Hydro-native code
- **Maintains Test Isolation**: Allows independent testing and optimization of dataflow implementations
- **Preserves Historical Benchmarks**: Keeps reference implementations for long-term performance tracking

## Quick Start

### Prerequisites

- Rust toolchain (1.70+)
- Cargo

### Running Benchmarks

```bash
# Clone the repository
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps

# Run all benchmarks
cargo bench -p benches

# Run specific benchmark
cargo bench -p benches --bench arithmetic

# View HTML reports
open target/criterion/report/index.html
```

## Available Benchmarks

### Core Benchmarks (Timely/Differential)

- **arithmetic** - Sequential arithmetic operations on streams
- **fan_in** - Multiple streams merging to one (fan-in pattern)
- **fan_out** - Single stream splitting to multiple (fan-out pattern)
- **fork_join** - Fork-join parallel execution pattern
- **identity** - Pass-through transformation overhead measurement
- **join** - Stream join operations
- **reachability** - Graph reachability using differential dataflow
- **upcase** - String transformation operations

### Additional Benchmarks

- **futures** - Futures-based async operations
- **micro_ops** - Micro-operations benchmarking
- **symmetric_hash_join** - Symmetric hash join implementation
- **words_diamond** - Diamond-pattern word processing

See [`benches/README.md`](benches/README.md) for detailed documentation on each benchmark.

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── Cargo.toml              # Workspace configuration
├── README.md               # This file
└── benches/                # Benchmark package
    ├── Cargo.toml          # Dependencies and benchmark definitions
    ├── README.md           # Detailed benchmark documentation
    ├── build.rs            # Build-time code generation
    └── benches/            # Benchmark implementations and data
        ├── .gitignore
        ├── *.rs            # Benchmark source files
        └── *.txt           # Test data files
```

## Dependencies

The benchmark suite depends on:

- **timely-master** (0.13.0-dev.1) - Timely Dataflow framework
- **differential-dataflow-master** (0.13.0-dev.1) - Differential Dataflow
- **criterion** (0.5.0) - Benchmarking framework
- **tokio** (1.29.0) - Async runtime
- Support libraries: rand, futures, seq-macro, etc.

## Performance Comparison Workflow

### Comparing with Hydro-Native Implementations

1. **Run Timely/Differential benchmarks** (this repository):
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps
   cargo bench -p benches
   ```

2. **Run Hydro-native benchmarks** (main repository):
   ```bash
   cd bigweaver-agent-canary-hydro-zeta
   cargo bench -p benches
   ```

3. **Compare results** using Criterion's HTML reports or saved baselines

### Using Baselines

```bash
# Save current results as baseline
cargo bench -p benches -- --save-baseline dec-2024

# After optimization, compare against baseline
cargo bench -p benches -- --baseline dec-2024
```

## Development

### Adding New Benchmarks

1. Create benchmark file in `benches/benches/your_benchmark.rs`
2. Add entry to `benches/Cargo.toml`:
   ```toml
   [[bench]]
   name = "your_benchmark"
   harness = false
   ```
3. Run: `cargo bench -p benches --bench your_benchmark`

See the [detailed development guide](benches/README.md#development) for more information.

## Migration Background

These benchmarks were migrated from the main Hydro repository to:

1. Reduce build times for the main codebase
2. Eliminate Timely/Differential dependencies from primary development
3. Maintain performance comparison capabilities
4. Create clear architectural separation

For migration details, see `BENCHMARK_MIGRATION.md` in the [main repository](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta/blob/main/BENCHMARK_MIGRATION.md).

## Documentation

- **[Benchmark Documentation](benches/README.md)** - Comprehensive guide to running and understanding benchmarks
- **[Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)** - Timely framework documentation
- **[Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)** - Differential framework documentation
- **[Criterion.rs](https://bheisler.github.io/criterion.rs/book/)** - Benchmarking framework guide

## Contributing

When contributing benchmarks:

1. Follow existing code patterns
2. Include baseline comparisons in PR description
3. Document benchmark purpose and parameters
4. Ensure benchmarks are deterministic where possible
5. Add appropriate test data files to `benches/benches/`

## License

Apache-2.0

## Related Repositories

- **[bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)** - Main Hydro implementation repository

## Contact

For questions or issues:
- Open an issue in this repository
- See the main repository for general Hydro questions