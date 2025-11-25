# Hydro Dependencies and Benchmarks

This repository contains benchmark code and dependencies for the Hydro project that have been separated from the main [bigweaver-agent-canary-hydro-zeta](https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository. This separation helps maintain a cleaner main codebase by isolating performance testing concerns and comparative benchmarks with external frameworks.

## Repository Contents

### Benchmarks

The `benches/` directory contains microbenchmarks comparing Hydro/DFIR with timely-dataflow and differential-dataflow. These benchmarks help track performance characteristics and validate optimization decisions.

**Available Benchmarks:**
- **arithmetic** - Arithmetic operations pipeline benchmarks
- **fan_in** - Fan-in dataflow pattern benchmarks
- **fan_out** - Fan-out dataflow pattern benchmarks
- **fork_join** - Fork-join pattern benchmarks
- **identity** - Identity operation benchmarks
- **join** - Join operation benchmarks
- **reachability** - Graph reachability algorithm benchmarks
- **symmetric_hash_join** - Symmetric hash join benchmarks
- **upcase** - String uppercase transformation benchmarks
- **words_diamond** - Word processing diamond pattern benchmarks
- **micro_ops** - Micro-operation benchmarks
- **futures** - Futures-based async operation benchmarks

## Quick Start

### Prerequisites

- Rust toolchain 1.91.1 or later (automatically configured via `rust-toolchain.toml`)
- Cargo

### Running Benchmarks

**Run all benchmarks:**
```bash
cargo bench -p benches
```

**Run a specific benchmark:**
```bash
cargo bench -p benches --bench reachability
```

**Run benchmarks with specific pattern matching:**
```bash
cargo bench -p benches --bench arithmetic -- pipeline
```

### Viewing Benchmark Results

Benchmark results are generated using Criterion and include:
- HTML reports in `target/criterion/`
- Statistical analysis of performance
- Comparison with previous runs

Open `target/criterion/report/index.html` in a browser to view detailed results.

## Repository Structure

```
.
├── benches/              # Benchmark package
│   ├── benches/          # Benchmark source files
│   │   ├── arithmetic.rs
│   │   ├── fan_in.rs
│   │   ├── fan_out.rs
│   │   ├── fork_join.rs
│   │   ├── identity.rs
│   │   ├── join.rs
│   │   ├── reachability.rs
│   │   ├── symmetric_hash_join.rs
│   │   ├── upcase.rs
│   │   ├── words_diamond.rs
│   │   ├── micro_ops.rs
│   │   ├── futures.rs
│   │   ├── reachability_edges.txt
│   │   ├── reachability_reachable.txt
│   │   └── words_alpha.txt
│   ├── build.rs          # Build script for code generation
│   ├── Cargo.toml        # Benchmark package configuration
│   └── README.md         # Benchmark-specific documentation
├── Cargo.toml            # Workspace configuration
├── rust-toolchain.toml   # Rust toolchain specification
├── rustfmt.toml          # Code formatting configuration
├── clippy.toml           # Linting configuration
└── README.md             # This file
```

## Migration Information

This repository was created by extracting benchmark code from the main Hydro repository to:

1. **Reduce Dependencies**: Eliminate timely-dataflow and differential-dataflow dependencies from the main repository
2. **Faster Build Times**: Reduce compilation time for the main repository
3. **Better Separation of Concerns**: Keep core implementation separate from comparative performance testing
4. **Easier Maintenance**: Simplify dependency management in both repositories

### Migrated Components

- All comparative benchmark code from `benches/` directory
- Build scripts for benchmark code generation
- Test data files (word lists, graph data)

### Dependencies

The benchmarks depend on:
- **dfir_rs**: Core DFIR implementation (from main repo)
- **sinktools**: Sink utilities (from main repo)
- **timely-dataflow**: For comparative benchmarks
- **differential-dataflow**: For comparative benchmarks
- **criterion**: Benchmarking framework

## Development

### Code Style

This repository follows the same code style as the main Hydro repository:
- Code formatting via `rustfmt` (configured in `rustfmt.toml`)
- Linting via `clippy` (configured in `clippy.toml`)

**Format code:**
```bash
cargo fmt --all
```

**Run linter:**
```bash
cargo clippy --all-targets --all-features
```

### Adding New Benchmarks

1. Create a new benchmark file in `benches/benches/`
2. Add a `[[bench]]` entry in `benches/Cargo.toml`
3. Implement benchmark using the Criterion framework
4. Run and verify the benchmark works correctly
5. Update documentation

### Testing

Verify the workspace builds correctly:
```bash
cargo check --workspace
cargo test --workspace
```

## Performance Comparisons

The benchmarks in this repository compare three implementations:
1. **Raw Rust** - Baseline performance using standard Rust constructs
2. **DFIR/Hydro** - Hydro's dataflow implementation
3. **Timely/Differential** - Timely-dataflow and differential-dataflow

This allows tracking how Hydro's performance compares to both raw implementations and established dataflow frameworks.

## Related Repositories

- **Main Repository**: [bigweaver-agent-canary-hydro-zeta](https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)
- **Documentation**: [hydro.run](https://hydro.run)

## Contributing

For contribution guidelines and development practices, please refer to the main repository's CONTRIBUTING.md.

## License

Apache-2.0

## Resources

- **Hydro Documentation**: https://hydro.run/docs/hydro/
- **DFIR Documentation**: https://hydro.run/docs/dfir/
- **Criterion Documentation**: https://bheisler.github.io/criterion.rs/book/
- **Word List Source**: https://github.com/dwyl/english-words/blob/master/words_alpha.txt