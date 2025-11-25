# Integration Guide

This guide explains how to work with the benchmark dependencies repository and integrate it with the main Hydro repository.

## Overview

This repository contains performance comparison benchmarks that compare Hydro (dfir_rs) implementations against timely-dataflow and differential-dataflow. The benchmarks were separated from the main repository to:

1. Reduce build times for the core Hydro project
2. Isolate external dependencies
3. Maintain clean separation of concerns
4. Keep performance comparison functionality available

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── benches/
│   ├── benches/          # Benchmark source files
│   ├── Cargo.toml        # Benchmark dependencies
│   ├── README.md         # Benchmark documentation
│   └── build.rs          # Build script
├── Cargo.toml            # Workspace configuration
├── README.md             # Main documentation
├── INTEGRATION_GUIDE.md  # This file
└── verify_benchmarks.sh  # Verification script
```

## Setup Instructions

### Prerequisites

- Rust toolchain (1.70 or later recommended)
- Git
- Access to GitHub (for pulling dependencies)

### Clone and Build

```bash
# Clone the repository
git clone https://github.com/hydro-project/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps

# Run verification script
./verify_benchmarks.sh

# Build benchmarks
cargo build --benches

# Run all benchmarks
cargo bench
```

## Dependencies

### External Dependencies

- **timely-master**: Timely dataflow framework for performance comparison
- **differential-dataflow-master**: Differential dataflow framework for performance comparison
- **criterion**: Benchmarking framework with statistical analysis

### Hydro Dependencies

The benchmarks depend on the main Hydro repository for:
- **dfir_rs**: Core dataflow runtime implementation
- **sinktools**: Utility tools for sink operations

These are pulled from the main GitHub repository:
```toml
dfir_rs = { git = "https://github.com/hydro-project/hydro", branch = "main", features = [ "debugging" ] }
sinktools = { git = "https://github.com/hydro-project/hydro", branch = "main" }
```

## Running Benchmarks

### Run All Benchmarks

```bash
cargo bench
```

This will run all available benchmarks and generate HTML reports in `target/criterion/`.

### Run Specific Benchmark

```bash
# Run a specific benchmark file
cargo bench --bench reachability

# Run benchmarks matching a pattern
cargo bench arithmetic
```

### Run Specific Implementation

Each benchmark typically includes multiple implementations (timely, differential, dfir_rs). You can filter by implementation:

```bash
# Run only timely implementations
cargo bench timely

# Run only differential implementations
cargo bench differential

# Run only Hydro (dfir_rs) implementations
cargo bench dfir_rs
```

## Benchmark Output

Criterion generates detailed output including:
- Statistical analysis (mean, std dev, outliers)
- Performance comparison with previous runs
- HTML reports with graphs (in `target/criterion/`)

Example output:
```
reachability/timely     time:   [125.43 ms 126.89 ms 128.52 ms]
reachability/differential time: [98.234 ms 99.123 ms 100.21 ms]
reachability/dfir_rs    time:   [87.123 ms 88.456 ms 89.891 ms]
```

## Development Workflow

### Adding New Benchmarks

1. Create a new `.rs` file in `benches/benches/`
2. Implement benchmark functions using criterion
3. Add benchmark definition to `benches/Cargo.toml`:
   ```toml
   [[bench]]
   name = "my_new_benchmark"
   harness = false
   ```
4. Run verification: `./verify_benchmarks.sh`

### Updating Hydro Version

The benchmarks automatically pull from the main branch of the Hydro repository. To use a specific version:

1. Edit `benches/Cargo.toml`
2. Change the git reference:
   ```toml
   # Use a specific commit
   dfir_rs = { git = "https://github.com/hydro-project/hydro", rev = "abc123", features = [ "debugging" ] }
   
   # Use a specific branch
   dfir_rs = { git = "https://github.com/hydro-project/hydro", branch = "feature-branch", features = [ "debugging" ] }
   
   # Use a specific tag
   dfir_rs = { git = "https://github.com/hydro-project/hydro", tag = "v0.1.0", features = [ "debugging" ] }
   ```
3. Run `cargo update`

### Local Development

For local development with the main Hydro repository:

1. Clone both repositories side-by-side:
   ```bash
   parent-dir/
   ├── bigweaver-agent-canary-hydro-zeta/
   └── bigweaver-agent-canary-zeta-hydro-deps/
   ```

2. Edit `benches/Cargo.toml` to use local paths:
   ```toml
   dfir_rs = { path = "../../bigweaver-agent-canary-hydro-zeta/dfir_rs", features = [ "debugging" ] }
   sinktools = { path = "../../bigweaver-agent-canary-hydro-zeta/sinktools" }
   ```

3. Make your changes and test
4. Revert to git dependencies before committing

## CI/CD Integration

### Continuous Testing

Add to your CI pipeline:

```yaml
# .github/workflows/benchmarks.yml
name: Benchmark Tests

on: [push, pull_request]

jobs:
  check:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: actions-rs/toolchain@v1
        with:
          toolchain: stable
      - name: Check benchmarks compile
        run: cargo check --benches
```

### Performance Tracking

Use criterion's compare feature to track performance over time:

```bash
# Baseline
cargo bench --bench reachability -- --save-baseline main

# After changes
cargo bench --bench reachability -- --baseline main
```

## Troubleshooting

### Common Issues

1. **Build failures**: Ensure you have the latest Rust toolchain
   ```bash
   rustup update stable
   ```

2. **Git dependency errors**: Clear cargo cache and retry
   ```bash
   cargo clean
   rm -rf ~/.cargo/git
   cargo build --benches
   ```

3. **Missing data files**: Ensure all data files are committed (check `.gitignore`)

4. **Performance variations**: Run benchmarks multiple times and use criterion's statistical analysis

### Getting Help

- Check the [main repository issues](https://github.com/hydro-project/hydro/issues)
- Review [criterion documentation](https://bheisler.github.io/criterion.rs/book/)
- File an issue in this repository

## Performance Comparison Guidelines

When comparing implementations:

1. **Warm-up**: Criterion handles warm-up automatically
2. **Sample size**: Use sufficient iterations (criterion default: 100)
3. **System state**: Close unnecessary applications
4. **Consistency**: Run on the same hardware for comparisons
5. **Documentation**: Document any performance findings

## Best Practices

1. **Keep benchmarks focused**: Each benchmark should test one specific aspect
2. **Use realistic data**: Data size and distribution should match real-world usage
3. **Document assumptions**: Add comments explaining benchmark setup
4. **Verify correctness**: Include assertions to ensure implementations are correct
5. **Track changes**: Commit baseline results for historical tracking

## Related Documentation

- [Main Hydro Repository](https://github.com/hydro-project/hydro)
- [Benchmark Migration Summary](../bigweaver-agent-canary-hydro-zeta/benches/BENCHMARK_MIGRATION_SUMMARY.md)
- [Criterion.rs Documentation](https://bheisler.github.io/criterion.rs/book/)
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)

## Contributing

Contributions are welcome! Please:

1. Follow the existing benchmark structure
2. Add documentation for new benchmarks
3. Run the verification script before submitting
4. Include performance results in PR descriptions
5. Update this guide if adding new features

## License

Apache-2.0 - See LICENSE file for details
