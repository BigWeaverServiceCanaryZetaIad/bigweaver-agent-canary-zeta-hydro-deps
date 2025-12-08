# Contributing to Hydro Benchmarks

This repository contains benchmarks that were separated from the main Hydro repository to avoid unwanted dependencies on `timely` and `differential-dataflow` in the main codebase.

## Development Setup

### Prerequisites

- Rust toolchain (see `rust-toolchain.toml` for the specific version)
- Git

### Building

```bash
# Build all benchmarks
cargo build --release

# Check formatting
cargo fmt --check

# Run linting
cargo clippy --all-targets --all-features
```

## Running Benchmarks

### Run All Benchmarks

```bash
cargo bench -p benches
```

### Run Specific Benchmarks

```bash
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench join
cargo bench -p benches --bench reachability
```

### Benchmark Options

Criterion (the benchmarking framework) supports various options:

```bash
# Save a baseline
cargo bench -p benches -- --save-baseline my-baseline

# Compare against baseline
cargo bench -p benches -- --baseline my-baseline

# Run quick benchmarks (fewer samples)
cargo bench -p benches -- --quick

# Filter benchmarks by name
cargo bench -p benches -- identity
```

## Adding New Benchmarks

To add a new benchmark:

1. Create a new file in `benches/benches/` (e.g., `my_benchmark.rs`)
2. Add the benchmark to `benches/Cargo.toml`:
   ```toml
   [[bench]]
   name = "my_benchmark"
   harness = false
   ```
3. Write your benchmark using Criterion (see existing benchmarks for examples)
4. Test it: `cargo bench -p benches --bench my_benchmark`

## Code Style

This repository follows the same code style as the main Hydro repository:

- Use `cargo fmt` to format code (configuration in `rustfmt.toml`)
- Use `cargo clippy` for linting (configuration in `clippy.toml`)
- Follow Rust best practices and idioms

## Dependencies

The benchmarks depend on:
- `dfir_rs` and `sinktools` from the main Hydro repository (via git)
- `timely-master` and `differential-dataflow-master` for comparison benchmarks
- `criterion` for benchmarking infrastructure

If the main repository's API changes, benchmarks may need to be updated accordingly.

## Performance Comparison Guidelines

When comparing performance:

1. **Consistent environment**: Run benchmarks on the same hardware with minimal background processes
2. **Multiple runs**: Run benchmarks multiple times to ensure consistency
3. **Save baselines**: Always save a baseline before making changes
4. **Document results**: Document any significant performance changes and their causes

## Questions or Issues

For questions or issues:
- Benchmark-specific issues: File an issue in this repository
- Hydro API or functionality issues: File an issue in the main bigweaver-agent-canary-hydro-zeta repository
