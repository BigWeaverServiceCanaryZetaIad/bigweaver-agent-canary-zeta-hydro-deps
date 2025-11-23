# Contributing to bigweaver-agent-canary-zeta-hydro-deps

Thank you for your interest in contributing to the Hydroflow external dependency benchmarks!

## Getting Started

1. Fork this repository
2. Clone your fork locally
3. Create a new branch for your changes
4. Make your changes and commit them
5. Push to your fork and submit a pull request

## Development Setup

### Prerequisites

- Rust toolchain (specified in `rust-toolchain.toml`)
- Git access to the main bigweaver-agent-canary-hydro-zeta repository
- Familiarity with Criterion.rs benchmarking framework

### Building

```bash
cargo check -p hydro-deps-benches
```

### Running Benchmarks

```bash
# Run all benchmarks
cargo bench -p hydro-deps-benches

# Run specific benchmark
cargo bench -p hydro-deps-benches --bench arithmetic

# Quick test run
cargo bench -p hydro-deps-benches -- --quick
```

## Adding New Benchmarks

When contributing a new benchmark:

### 1. Create the Benchmark File

Create a new file in `benches/benches/` with your benchmark implementation. Follow the pattern of existing benchmarks:

```rust
use criterion::{Criterion, black_box, criterion_group, criterion_main};
use dfir_rs::dfir_syntax;
use timely::dataflow::operators::*;

// Your benchmark functions here

fn benchmark_hydroflow(c: &mut Criterion) {
    c.bench_function("your_bench/hydroflow", |b| {
        // Implementation
    });
}

fn benchmark_timely(c: &mut Criterion) {
    c.bench_function("your_bench/timely", |b| {
        // Implementation
    });
}

criterion_group!(benches, benchmark_hydroflow, benchmark_timely);
criterion_main!(benches);
```

### 2. Update Cargo.toml

Add your benchmark configuration to `benches/Cargo.toml`:

```toml
[[bench]]
name = "your_benchmark"
harness = false
```

### 3. Document Your Benchmark

Update `benches/README.md` with:
- Description of what the benchmark tests
- How to run it
- What metrics it measures
- Any special considerations

### 4. Test Your Benchmark

Ensure your benchmark:
- Compiles successfully
- Runs without errors
- Produces meaningful results
- Has consistent performance across runs

## Code Style

This project follows standard Rust conventions:

- Run `cargo fmt` before committing
- Run `cargo clippy` and address warnings
- Follow the existing code patterns
- Add comments for complex logic

Configuration files are provided:
- `rustfmt.toml` - Code formatting rules
- `clippy.toml` - Linting configuration

## Commit Messages

Follow the Conventional Commits format:

```
type(scope): description

[optional body]

[optional footer]
```

Types:
- `feat`: New benchmark or feature
- `fix`: Bug fix in existing benchmark
- `docs`: Documentation changes
- `refactor`: Code refactoring
- `perf`: Performance improvements
- `test`: Test-related changes
- `chore`: Maintenance tasks

Examples:
```
feat(benches): add new sorting benchmark
fix(reachability): correct data file path
docs(readme): add troubleshooting section
refactor(join): simplify join benchmark implementation
```

## Pull Request Guidelines

### Before Submitting

- [ ] Code compiles without errors
- [ ] All benchmarks run successfully
- [ ] Code is formatted (`cargo fmt`)
- [ ] Clippy warnings are addressed (`cargo clippy`)
- [ ] Documentation is updated
- [ ] Commit messages follow conventions

### PR Description

Include in your PR description:

1. **Overview**: What does this PR do?
2. **Motivation**: Why is this change needed?
3. **Changes Made**: List of specific changes
4. **Testing**: How was this tested?
5. **Performance Impact**: Any performance considerations

### PR Review Process

1. Automated checks will run
2. Maintainers will review your code
3. Address any feedback or requested changes
4. Once approved, your PR will be merged

## Benchmark Guidelines

### Statistical Significance

- Use sufficient sample sizes for statistical significance
- Account for variance in measurements
- Use Criterion's built-in statistical analysis
- Document expected performance characteristics

### Reproducibility

- Benchmarks should be reproducible
- Document any environmental dependencies
- Use fixed seeds for random data generation
- Avoid system-dependent assumptions

### Comparison Fairness

When comparing Hydroflow with timely/differential:
- Use equivalent algorithms
- Match data structures where possible
- Document any implementation differences
- Explain any unavoidable discrepancies

### Performance Notes

- Run benchmarks on consistent hardware
- Close unnecessary applications
- Consider disabling CPU frequency scaling
- Document the benchmark environment

## Testing Changes

Before submitting, test your changes:

```bash
# Check compilation
cargo check -p hydro-deps-benches

# Run formatters and linters
cargo fmt --all -- --check
cargo clippy --all-targets -- -D warnings

# Run benchmarks
cargo bench -p hydro-deps-benches -- --quick

# For full benchmark run
cargo bench -p hydro-deps-benches
```

## Documentation

Update documentation for any changes:

- `README.md` - Main repository documentation
- `benches/README.md` - Benchmark-specific documentation
- Inline code comments for complex logic
- Commit messages explaining the why, not just the what

## Getting Help

If you need help:

1. Check existing documentation
2. Look at similar benchmarks for examples
3. Open an issue for questions
4. Reference the main Hydroflow repository for Hydroflow-specific questions

## Code of Conduct

- Be respectful and inclusive
- Focus on constructive feedback
- Help others learn and grow
- Maintain a welcoming environment

## Questions?

If you have questions about contributing, please:
- Open an issue for discussion
- Reference the main repository's contributing guidelines
- Reach out to the maintainers

Thank you for contributing to Hydroflow benchmarks!
