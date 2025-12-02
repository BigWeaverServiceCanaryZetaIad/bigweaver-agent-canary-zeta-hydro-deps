# Contributing to bigweaver-agent-canary-zeta-hydro-deps

## Benchmark Guidelines

This repository contains performance benchmarks comparing Hydro with timely-dataflow and differential-dataflow.

### Running Benchmarks Locally

```bash
# Run all benchmarks
cargo bench -p benches

# Run specific benchmarks
cargo bench -p benches -- dfir
cargo bench -p benches -- micro/ops/

# Generate HTML reports
cargo bench -p benches
# Results will be in target/criterion/
```

### Adding New Benchmarks

When adding a new benchmark:

1. Create a new file in `benches/benches/` (e.g., `my_benchmark.rs`)
2. Implement comparisons between Hydro and timely/differential implementations
3. Add the benchmark to `benches/Cargo.toml`:
   ```toml
   [[bench]]
   name = "my_benchmark"
   harness = false
   ```
4. Ensure fair comparison conditions (same workload, inputs, etc.)
5. Add documentation explaining what the benchmark measures
6. Test locally before submitting a PR

### Benchmark Structure

Each benchmark should:
- Compare equivalent operations across systems
- Use consistent input sizes and parameters
- Measure meaningful metrics (throughput, latency, etc.)
- Avoid system-specific optimizations that skew results
- Include comments explaining the implementation

### CI/CD Integration

Benchmarks run automatically when:
- Commit messages contain `[ci-bench]`
- PR titles or descriptions contain `[ci-bench]`
- On a daily schedule
- Manually triggered via workflow dispatch

### Dependencies

The benchmarks use git dependencies to track the main repository:
- `dfir_rs`: Core Hydro runtime
- `sinktools`: Utility tools

These dependencies are automatically updated when the main repository changes.

### Performance Regression Testing

When modifying benchmarks, ensure:
- Historical data remains comparable
- Measurement methodologies are consistent
- Changes are documented in commit messages
- Baseline measurements are established before changes

## Pull Request Process

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test locally
5. Submit a PR with:
   - Clear description of changes
   - Benchmark results (if applicable)
   - Documentation updates

## Code Style

Follow the Rust style guidelines:
- Run `cargo fmt` before committing
- Ensure `cargo clippy` passes
- Add comments for complex logic

## Questions?

For questions about benchmarks or contributing, please open an issue in this repository or contact the Hydro development team.
