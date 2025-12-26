# Contributing to bigweaver-agent-canary-zeta-hydro-deps

Thank you for your interest in contributing to the Hydro benchmark repository! This document provides guidelines for contributing benchmarks and improvements.

## Purpose of This Repository

This repository contains benchmarks that compare Hydro (DFIR) performance with external dataflow frameworks (timely and differential-dataflow). It exists as a separate repository to:

1. Isolate external framework dependencies from the main Hydro codebase
2. Enable performance comparisons without cluttering the main repository
3. Allow independent evolution of benchmark code

## When to Add Benchmarks Here

Add benchmarks to this repository when they:

- **Require timely or differential-dataflow dependencies**
- **Compare Hydro performance with external frameworks**
- **Test operations that have equivalent implementations in multiple frameworks**

Add benchmarks to the main bigweaver-agent-canary-hydro-zeta repository when they:

- Only test Hydro/DFIR internal operations
- Don't require external dataflow framework dependencies
- Test Hydro-specific features without framework comparison

## Adding a New Benchmark

### 1. Create the Benchmark File

Add your benchmark to `benches/benches/your_benchmark.rs`:

```rust
use criterion::{Criterion, black_box, criterion_group, criterion_main};
use timely::dataflow::operators::*;  // If using timely
use differential_dataflow::operators::*;  // If using differential
use dfir_rs::dfir_syntax;

// Implement benchmark for each framework
fn benchmark_timely(c: &mut Criterion) {
    c.bench_function("your_benchmark/timely", |b| {
        b.iter(|| {
            // Your timely implementation
            black_box(result);
        });
    });
}

fn benchmark_dfir(c: &mut Criterion) {
    c.bench_function("your_benchmark/dfir", |b| {
        b.iter(|| {
            // Your DFIR implementation
            black_box(result);
        });
    });
}

criterion_group!(benches, benchmark_timely, benchmark_dfir);
criterion_main!(benches);
```

### 2. Register the Benchmark

Add an entry to `benches/Cargo.toml`:

```toml
[[bench]]
name = "your_benchmark"
harness = false
```

### 3. Add Data Files (if needed)

If your benchmark requires data files:

1. Place them in `benches/benches/`
2. Use `include_bytes!()` or `include_str!()` to embed them
3. Document the data source and format

### 4. Test Your Benchmark

```bash
# Check compilation
cargo check -p benches

# Run your benchmark
cargo bench -p benches --bench your_benchmark

# Run quick test
cargo bench -p benches --bench your_benchmark -- --quick
```

### 5. Document Your Benchmark

Update relevant documentation:

- Add entry to `benches/README.md`
- Add detailed description to `BENCHMARK_GUIDE.md`
- Include purpose, operation, and data characteristics

## Benchmark Best Practices

### Fair Comparisons

- Implement the **same logical operation** in each framework
- Use **equivalent data structures** across implementations
- Apply **similar optimizations** to all implementations
- Avoid framework-specific optimizations that don't reflect real usage

### Appropriate Sizing

- Use **realistic data sizes** that reflect actual use cases
- Avoid too-small datasets (< 1000 items) that may not show meaningful differences
- Avoid too-large datasets that make benchmarks take too long
- Document why you chose specific sizes

### Statistical Validity

- Let Criterion run enough iterations for statistical significance
- Use `black_box()` to prevent compiler optimizations from eliminating code
- Avoid setup/teardown overhead in the measurement loop
- Use `iter_batched()` for expensive setup operations

### Code Style

- Follow existing code conventions (use `cargo fmt`)
- Pass clippy checks (use `cargo clippy`)
- Use clear variable names
- Add comments for non-obvious operations

## Code Review Process

### Before Submitting

1. Run `cargo fmt --all` to format code
2. Run `cargo clippy --all-targets` and address warnings
3. Run `cargo bench -p benches` to verify all benchmarks work
4. Update documentation to reflect changes
5. Test on a clean checkout if possible

### Pull Request Guidelines

- **Title**: Use conventional commit format: `feat(benches): add XYZ benchmark`
- **Description**: Include:
  - Purpose of the benchmark
  - What operations are being compared
  - Expected performance characteristics
  - Any dependencies or prerequisites
  - Sample benchmark output

### Review Criteria

Reviewers will check:

- Does the benchmark measure what it claims to measure?
- Are comparisons fair across frameworks?
- Is the code clear and maintainable?
- Is documentation adequate?
- Do results make sense?

## Dependency Management

### Updating Framework Versions

When updating timely or differential-dataflow:

1. Update versions in `benches/Cargo.toml`
2. Test all benchmarks with new versions
3. Check for API changes that require code updates
4. Document any breaking changes

### DFIR/Hydro Dependency

The `dfir_rs` dependency references the main repository via git:

```toml
dfir_rs = { git = "https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git", features = [ "debugging" ] }
```

Consider:
- Pinning to specific commit for stability
- Using branch for development
- Coordinating updates with main repository

## Performance Considerations

### Benchmark Performance

- Benchmarks should complete in reasonable time (< 5 minutes each)
- Use `--quick` mode for development/testing
- Save baselines for tracking performance over time:
  ```bash
  cargo bench -p benches -- --save-baseline initial
  ```

### Profiling

For detailed performance analysis:

```bash
# Build with profiling symbols
cargo bench -p benches --profile profile

# Use external profilers
perf record cargo bench -p benches --bench your_benchmark
```

## Common Issues

### Compilation Errors

**Issue**: timely/differential-dataflow version conflicts

**Solution**: Check that versions are compatible, update Cargo.toml

**Issue**: dfir_rs API changes

**Solution**: Update benchmark code to match new API, or pin dfir_rs to specific commit

### Runtime Errors

**Issue**: Benchmark panics or produces wrong results

**Solution**: Add validation, compare with known-good implementation

**Issue**: Benchmark takes too long

**Solution**: Reduce data size, optimize implementation, or split into multiple benchmarks

### Statistical Issues

**Issue**: High variance in results

**Solution**: Reduce system load, increase sample size, check for non-determinism

**Issue**: Unrealistic results

**Solution**: Verify `black_box()` usage, check for compiler optimizations

## Getting Help

If you need assistance:

1. Check existing benchmarks for examples
2. Review Criterion documentation: https://bheisler.github.io/criterion.rs/book/
3. Read timely/differential-dataflow documentation
4. Open an issue describing your question
5. Reach out to the team in communication channels

## Code of Conduct

- Be respectful and constructive in reviews
- Focus on code quality and correctness
- Help others learn and improve
- Acknowledge contributions from others

## License

By contributing, you agree that your contributions will be licensed under the Apache-2.0 license, consistent with the main Hydro project.
