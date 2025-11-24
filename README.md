# Hydro Dependencies - Timely and Differential-Dataflow Benchmarks

This repository contains performance benchmarks for comparing Hydro (DFIR) with timely-dataflow and differential-dataflow implementations.

## Overview

The benchmarks in this repository were migrated from the main [bigweaver-agent-canary-hydro-zeta](https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git) repository to:
- Reduce dependency footprint in the main repository
- Enable independent performance testing
- Maintain clean separation of concerns between core functionality and benchmark dependencies
- Preserve the ability to run performance comparisons between different dataflow frameworks

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── Cargo.toml              # Workspace configuration
├── rust-toolchain.toml     # Rust toolchain specification
├── rustfmt.toml           # Rust formatting configuration
├── clippy.toml            # Clippy linting configuration
├── README.md              # This file
└── benches/               # Benchmark package
    ├── Cargo.toml         # Benchmark dependencies
    ├── README.md          # Benchmark-specific documentation
    ├── build.rs           # Build script for generated benchmarks
    └── benches/           # Benchmark implementations
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
        └── *.txt          # Test data files
```

## Prerequisites

- Rust toolchain (specified in `rust-toolchain.toml`)
- Git access to the main Hydro repository (for dfir_rs and sinktools dependencies)

## Getting Started

### Clone the Repository

```bash
git clone https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps
```

### Running Benchmarks

#### Run All Benchmarks

```bash
cargo bench -p benches
```

#### Run Specific Benchmarks

```bash
# Run a single benchmark
cargo bench -p benches --bench identity

# Run reachability benchmark
cargo bench -p benches --bench reachability

# Run arithmetic operations benchmark
cargo bench -p benches --bench arithmetic
```

#### Quick Benchmark Run

For a faster run with fewer samples:

```bash
cargo bench -p benches -- --quick
```

### Available Benchmarks

The following benchmarks compare Hydro/DFIR implementations against timely-dataflow and differential-dataflow:

- **arithmetic**: Basic arithmetic operations across different frameworks
- **fan_in**: Multiple streams merging into a single stream
- **fan_out**: Single stream splitting into multiple streams
- **fork_join**: Fork-join dataflow patterns
- **futures**: Async/futures-based operations
- **identity**: Identity transformation (pass-through) operations
- **join**: Join operations between streams
- **micro_ops**: Micro-benchmarks for basic operations
- **reachability**: Graph reachability algorithms
- **symmetric_hash_join**: Symmetric hash join implementations
- **upcase**: String transformation operations
- **words_diamond**: Diamond-shaped dataflow patterns with word processing

## Dependencies

### Key Dependencies

- **timely-dataflow**: Timely dataflow framework (timely-master 0.13.0-dev.1)
- **differential-dataflow**: Differential dataflow framework (differential-dataflow-master 0.13.0-dev.1)
- **dfir_rs**: Hydro's Dataflow IR implementation (from main repository via git)
- **sinktools**: Utilities for Hydro (from main repository via git)
- **criterion**: Benchmark framework with statistical analysis

### Git Dependencies

The benchmarks reference `dfir_rs` and `sinktools` from the main Hydro repository:

```toml
dfir_rs = { git = "https://...", features = [ "debugging" ] }
sinktools = { git = "https://..." }
```

This ensures benchmarks always test against the current version of Hydro.

## Performance Comparison Capabilities

The benchmarks enable direct performance comparisons between:

1. **Hydro/DFIR**: The core dataflow IR from the main repository
2. **Timely Dataflow**: The timely-dataflow framework
3. **Differential Dataflow**: The differential-dataflow framework
4. **Raw Rust**: Baseline implementations

Each benchmark typically includes multiple implementations to facilitate fair comparisons.

## Building

To verify that the benchmarks compile without running them:

```bash
cargo build --release -p benches
```

## Testing

Run tests for the benchmark package:

```bash
cargo test -p benches
```

## Benchmark Results

Benchmark results are generated in the `target/criterion` directory and include:
- HTML reports with statistical analysis
- Comparison plots
- Historical performance tracking

## Migration History

These benchmarks were migrated from the main Hydro repository to:
- Remove heavy dependencies (timely and differential-dataflow) from the main codebase
- Enable optional performance testing (clone only when needed)
- Support independent benchmark development and versioning
- Reduce CI/CD build times for the main repository

## Contributing

When adding new benchmarks:

1. Create a new `.rs` file in `benches/benches/`
2. Add a `[[bench]]` section to `benches/Cargo.toml`
3. Use the same structure as existing benchmarks
4. Include implementations for multiple frameworks when possible
5. Document the benchmark purpose and expected performance characteristics

## License

Apache-2.0

## Related Repositories

- [Main Hydro Repository](https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git): Core Hydro framework and DFIR implementation

## Support

For questions or issues:
- Check the main Hydro repository documentation
- Review benchmark-specific README in `benches/README.md`
- Consult the Hydro documentation at the project website