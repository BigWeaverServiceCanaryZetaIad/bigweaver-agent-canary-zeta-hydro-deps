# Usage Guide

## Quick Start

This repository contains benchmarks that depend on `timely` and `differential-dataflow` packages. These benchmarks were separated from the main repository to maintain clean dependency management.

### Prerequisites

- Rust toolchain (see `rust-toolchain.toml` for version)
- Cargo

### Running Benchmarks

```bash
# Run all benchmarks
cargo bench -p benches

# Run a specific benchmark
cargo bench -p benches --bench arithmetic

# Run benchmarks matching a pattern
cargo bench -p benches -- filter_name
```

### Available Benchmarks

| Benchmark | Description | Dependencies |
|-----------|-------------|--------------|
| `arithmetic` | Arithmetic operations pipeline | timely |
| `fan_in` | Fan-in pattern | timely |
| `fan_out` | Fan-out pattern | timely |
| `fork_join` | Fork-join pattern | timely |
| `identity` | Identity operation | timely |
| `join` | Join operation | timely |
| `reachability` | Graph reachability | differential-dataflow, timely |
| `upcase` | String uppercase transformation | timely |

## Development Workflow

### Making Changes to Benchmarks

1. Edit benchmark files in `benches/benches/`
2. Run the specific benchmark to test:
   ```bash
   cargo bench -p benches --bench your_benchmark
   ```
3. Commit and push changes

### Adding New Benchmarks

1. Create a new `.rs` file in `benches/benches/`
2. Add the benchmark declaration to `benches/Cargo.toml`:
   ```toml
   [[bench]]
   name = "your_benchmark"
   harness = false
   ```
3. Run and verify:
   ```bash
   cargo bench -p benches --bench your_benchmark
   ```

### Code Quality

Run code formatting and linting:
```bash
# Format code
cargo fmt

# Run clippy
cargo clippy --all-targets
```

## Performance Analysis

### Viewing Results

Benchmark results are saved in `target/criterion/`. Each benchmark has:
- Console output with timing information
- HTML report at `target/criterion/<benchmark_name>/report/index.html`
- Detailed statistics and graphs

### Comparing with Main Repository

To compare performance with benchmarks in the main repository:

1. Run benchmarks here:
   ```bash
   cargo bench -p benches
   ```

2. Run benchmarks in main repository:
   ```bash
   cd /path/to/bigweaver-agent-canary-hydro-zeta
   cargo bench -p benches
   ```

3. Compare results from both `target/criterion/` directories

See [PERFORMANCE.md](PERFORMANCE.md) for detailed comparison instructions.

## Troubleshooting

### Build Failures

If you encounter build failures:

1. Check that the git dependency to the main repository is accessible
2. Verify that you have the correct Rust toolchain version
3. Try cleaning and rebuilding:
   ```bash
   cargo clean
   cargo build
   ```

### Benchmark Failures

If benchmarks fail to run:

1. Check that data files are present (e.g., `reachability_edges.txt`)
2. Verify sufficient system resources
3. Try running with additional output:
   ```bash
   RUST_BACKTRACE=1 cargo bench -p benches --bench your_benchmark
   ```

### Dependency Issues

If you have issues with timely or differential-dataflow:

1. Check that the versions in `benches/Cargo.toml` are available
2. Update `Cargo.lock`:
   ```bash
   cargo update
   ```
3. Verify network access to crates.io

## Best Practices

### Running Benchmarks

- Close unnecessary applications before benchmarking
- Run benchmarks multiple times for consistent results
- Consider CPU frequency scaling and thermal throttling
- Use the same hardware configuration for comparisons

### Performance Testing

- Establish baseline measurements
- Run benchmarks after each significant change
- Document performance characteristics
- Report regressions to the team

### Code Changes

- Keep benchmarks focused and minimal
- Document any special requirements
- Ensure benchmarks are reproducible
- Follow the existing code style

## Related Documentation

- [README.md](README.md) - Repository overview
- [PERFORMANCE.md](PERFORMANCE.md) - Detailed performance comparison guide
- [benches/README.md](benches/README.md) - Benchmark-specific documentation
- Main repository: `bigweaver-agent-canary-hydro-zeta`

## Support

For issues or questions:
1. Check the documentation in this repository
2. Review the main repository documentation
3. Check existing issues in the project
4. Reach out to the team
