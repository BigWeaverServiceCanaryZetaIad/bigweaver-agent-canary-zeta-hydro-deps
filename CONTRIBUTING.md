# Contributing to bigweaver-agent-canary-zeta-hydro-deps

Thank you for your interest in contributing to the Hydro benchmarking repository! This document provides guidelines for contributing benchmarks and improvements.

## Overview

This repository contains benchmarks that compare Hydro's performance against Timely Dataflow and Differential Dataflow. When contributing, please ensure your changes maintain the comparative nature of these benchmarks.

## Getting Started

### Prerequisites

- Rust 1.91.1 or later (specified in `rust-toolchain.toml`)
- Git
- Access to the main Hydro repository (for `dfir_rs` and `sinktools` dependencies)

### Setting Up Your Development Environment

1. Clone the repository:
   ```bash
   git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
   cd bigweaver-agent-canary-zeta-hydro-deps
   ```

2. Build the project:
   ```bash
   cargo build --release
   ```

3. Run tests to verify your setup:
   ```bash
   cargo bench -p benches
   ```

## Types of Contributions

### Adding New Benchmarks

When adding a new benchmark that requires Timely or Differential Dataflow:

1. **Create the benchmark file** in `benches/benches/`:
   ```bash
   touch benches/benches/my_new_benchmark.rs
   ```

2. **Implement the benchmark** with proper structure:
   - Include Hydro implementation using `dfir_rs`
   - Include Timely/Differential implementation for comparison
   - Use Criterion for benchmark framework
   - Add proper documentation comments

3. **Add benchmark configuration** to `benches/Cargo.toml`:
   ```toml
   [[bench]]
   name = "my_new_benchmark"
   harness = false
   ```

4. **Add test data** if needed:
   - Place data files in `benches/benches/`
   - Update `.gitignore` if files are generated
   - Document data sources in the benchmark

5. **Update documentation**:
   - Add benchmark description to `benches/README.md`
   - Update main `README.md` if needed
   - Add entry to `CHANGELOG.md`

### Improving Existing Benchmarks

When modifying existing benchmarks:

1. Ensure changes maintain compatibility with historical results
2. Document why changes are needed
3. Update benchmark documentation
4. Run benchmarks before and after to compare results

### Updating Dependencies

When updating Timely or Differential Dataflow versions:

1. Update version in `benches/Cargo.toml`
2. Test all benchmarks to ensure compatibility
3. Document any breaking changes
4. Update `CHANGELOG.md`

## Code Style and Quality

### Formatting

Run `rustfmt` before committing:
```bash
cargo fmt --all
```

Configuration is in `rustfmt.toml`.

### Linting

Run `clippy` to catch common issues:
```bash
cargo clippy --all-targets --all-features
```

Configuration is in `clippy.toml`.

### Code Organization

- Keep benchmarks focused and well-documented
- Use descriptive names for functions and variables
- Include comments explaining complex logic
- Follow Rust naming conventions

## Benchmark Guidelines

### Structure

Each benchmark should:
- Compare Hydro implementation with Timely/Differential
- Use consistent data sizes and parameters
- Include warmup iterations
- Report meaningful metrics

### Example Benchmark Structure

```rust
use criterion::{Criterion, black_box, criterion_group, criterion_main};
use dfir_rs::dfir_syntax;
use timely::dataflow::operators::*;

const NUM_ELEMENTS: usize = 1_000_000;

fn benchmark_hydro(c: &mut Criterion) {
    c.bench_function("my_benchmark/hydro", |b| {
        b.iter(|| {
            // Hydro implementation
        });
    });
}

fn benchmark_timely(c: &mut Criterion) {
    c.bench_function("my_benchmark/timely", |b| {
        b.iter(|| {
            // Timely implementation
        });
    });
}

criterion_group!(benches, benchmark_hydro, benchmark_timely);
criterion_main!(benches);
```

### Performance Considerations

- Use realistic data sizes
- Avoid artificial optimizations
- Include both cold and warm cache scenarios
- Document performance characteristics

## Documentation

### Comments

- Add doc comments for public functions
- Explain benchmark purpose and methodology
- Document data sources and formats
- Include example usage

### README Updates

When adding features:
- Update `README.md` with new capabilities
- Update `benches/README.md` with benchmark details
- Keep documentation in sync with code

## Testing

### Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmark:
```bash
cargo bench -p benches --bench arithmetic
```

### Verification

Before submitting:
1. ✅ All benchmarks compile without warnings
2. ✅ Benchmarks run successfully
3. ✅ Results are reasonable and reproducible
4. ✅ Documentation is updated
5. ✅ Code is formatted and linted

## Pull Request Process

1. **Create a feature branch**:
   ```bash
   git checkout -b feature/my-new-benchmark
   ```

2. **Make your changes**:
   - Follow code style guidelines
   - Add tests/benchmarks
   - Update documentation

3. **Commit your changes**:
   ```bash
   git add .
   git commit -m "feat(benches): add my new benchmark"
   ```
   
   Follow [Conventional Commits](https://www.conventionalcommits.org/) format:
   - `feat:` for new features
   - `fix:` for bug fixes
   - `docs:` for documentation
   - `refactor:` for code refactoring
   - `perf:` for performance improvements
   - `test:` for test changes

4. **Push to your fork**:
   ```bash
   git push origin feature/my-new-benchmark
   ```

5. **Create Pull Request**:
   - Use descriptive title
   - Include detailed description
   - Reference related issues
   - Add benchmark results if applicable

### Pull Request Template

```markdown
## Overview
Brief description of changes

## Changes
- List of changes made

## Benchmarks
- Results showing performance impact

## Testing
- How changes were tested

## Documentation
- Documentation updates made
```

## Review Process

Pull requests will be reviewed for:
- Code quality and style
- Benchmark correctness
- Documentation completeness
- Performance characteristics
- Compatibility with existing benchmarks

## Code of Conduct

- Be respectful and constructive
- Focus on technical merit
- Welcome newcomers
- Assume good intentions

## Questions and Support

For questions about:
- **Benchmark design**: Open a discussion issue
- **Technical issues**: Check existing issues or create new one
- **Contribution process**: Refer to this guide

## Related Resources

- [Main Hydro Repository](https://github.com/hydro-project/hydro)
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)
- [Criterion Benchmarking](https://github.com/bheisler/criterion.rs)

## License

By contributing, you agree that your contributions will be licensed under the Apache-2.0 License.

## Acknowledgments

Thank you for helping improve Hydro benchmarking! Your contributions help ensure accurate performance comparisons and drive improvements to the Hydro project.
