# Contributing to Hydro Benchmarks

Thank you for your interest in contributing to the Hydro benchmarks repository! This document provides guidelines for contributing.

## Getting Started

### Prerequisites

- Rust toolchain (version 1.91.1 or later)
- Git
- Familiarity with at least one of: Hydroflow, Timely Dataflow, or Differential Dataflow

### Setting Up Development Environment

```bash
# Clone the repository
git clone https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps

# Build the benchmarks
cargo build -p benchmarks --release

# Run a test benchmark
cargo bench -p benchmarks --bench identity
```

## Types of Contributions

We welcome several types of contributions:

### 1. New Benchmarks

Add new benchmarks that:
- Compare Hydroflow/DFIR with Timely and/or Differential Dataflow
- Test meaningful dataflow patterns or algorithms
- Provide insights into performance characteristics
- Include all three implementations when possible

### 2. Benchmark Improvements

- Optimize existing implementations
- Fix bugs or incorrect implementations
- Improve statistical methodology
- Add missing framework implementations

### 3. Documentation

- Improve benchmark descriptions
- Add performance analysis
- Update guides and tutorials
- Fix typos or unclear explanations

### 4. Infrastructure

- Improve CI/CD workflows
- Add new analysis tools
- Enhance result visualization
- Improve build processes

## Contributing Guidelines

### Code Style

We follow Rust standard style with some customizations:

```bash
# Format your code
cargo fmt

# Check for common mistakes
cargo clippy
```

Configuration:
- `rustfmt.toml` - Formatting rules
- `clippy.toml` - Linting rules

### Benchmark Structure

Each benchmark should:

1. **Test one concept** - Focus on a specific pattern or operation
2. **Include multiple implementations** - At least two frameworks for comparison
3. **Use realistic data** - Synthetic data should reflect real-world scenarios
4. **Be reproducible** - Same input should give same output
5. **Be documented** - Explain what is being measured and why

### File Organization

```
benchmarks/
├── Cargo.toml              # Package configuration
├── build.rs                # Build scripts (if needed)
├── README.md               # Quick reference
└── benches/
    ├── your_benchmark.rs   # Your benchmark implementation
    └── your_data.txt       # Supporting data files (if needed)
```

### Benchmark Template

Use this template for new benchmarks:

```rust
use criterion::{Criterion, criterion_group, criterion_main, black_box};
use dfir_rs::dfir_syntax;
use differential_dataflow::input::Input;
use differential_dataflow::operators::*;
use timely::dataflow::operators::*;

// Constants for configuration
const INPUT_SIZE: usize = 10_000;

// Helper functions and data structures
// ...

/// Benchmark using Timely Dataflow
fn benchmark_timely(c: &mut Criterion) {
    c.bench_function("your_benchmark/timely", |b| {
        b.iter(|| {
            // Timely implementation
            black_box(result);
        });
    });
}

/// Benchmark using Differential Dataflow
fn benchmark_differential(c: &mut Criterion) {
    c.bench_function("your_benchmark/differential", |b| {
        b.iter(|| {
            // Differential implementation
            black_box(result);
        });
    });
}

/// Benchmark using Hydroflow/DFIR
fn benchmark_hydroflow(c: &mut Criterion) {
    c.bench_function("your_benchmark/hydroflow", |b| {
        b.iter(|| {
            // Hydroflow implementation
            black_box(result);
        });
    });
}

criterion_group!(benches, 
    benchmark_timely, 
    benchmark_differential, 
    benchmark_hydroflow
);
criterion_main!(benches);
```

### Adding Your Benchmark

1. **Create the benchmark file**
   ```bash
   touch benchmarks/benches/your_benchmark.rs
   ```

2. **Add to Cargo.toml**
   ```toml
   [[bench]]
   name = "your_benchmark"
   harness = false
   ```

3. **Implement all framework versions**
   - Try to make implementations semantically equivalent
   - Document any differences or limitations

4. **Test your benchmark**
   ```bash
   cargo bench -p benchmarks --bench your_benchmark
   ```

5. **Update documentation**
   - Add description to `BENCHMARK_GUIDE.md`
   - Update README if needed

### Commit Guidelines

We follow conventional commit format:

```
type(scope): brief description

Detailed description if needed

Fixes #issue_number
```

Types:
- `feat`: New feature or benchmark
- `fix`: Bug fix
- `docs`: Documentation changes
- `perf`: Performance improvements
- `refactor`: Code refactoring
- `test`: Test updates
- `chore`: Maintenance tasks

Examples:
```
feat(benchmarks): add graph coloring benchmark

Implements graph coloring in Timely, Differential, and Hydroflow
for comparing constraint satisfaction algorithms.

perf(reachability): optimize hash set operations

Reduces memory allocations by reusing hash sets across iterations.
Improves performance by ~15%.

docs(guide): add section on interpreting variance

Explains what high variance means and how to reduce it.
```

### Pull Request Process

1. **Create a feature branch**
   ```bash
   git checkout -b feature/your-benchmark-name
   ```

2. **Make your changes**
   - Follow code style
   - Add tests/benchmarks
   - Update documentation

3. **Test thoroughly**
   ```bash
   cargo fmt --check
   cargo clippy
   cargo bench -p benchmarks --bench your_benchmark
   ```

4. **Commit with good messages**
   ```bash
   git add .
   git commit -m "feat(benchmarks): add your benchmark"
   ```

5. **Push and create PR**
   ```bash
   git push origin feature/your-benchmark-name
   ```

6. **Fill out PR template**
   - Describe what you changed
   - Explain why it's useful
   - Show benchmark results
   - Link related issues

### PR Review Process

Your PR will be reviewed for:
- ✅ Correctness of implementations
- ✅ Performance characteristics
- ✅ Code quality and style
- ✅ Documentation completeness
- ✅ Test coverage

Reviewers may request changes. Please address feedback promptly.

## Benchmarking Best Practices

### Statistical Rigor

1. **Use appropriate sample sizes**
   - Default: Let Criterion choose
   - For fast operations: Increase sample size
   - For slow operations: May need to decrease

2. **Handle warmup**
   - Criterion handles this automatically
   - For JIT-heavy code, consider manual warmup

3. **Avoid measurement bias**
   - Use `black_box()` to prevent optimization
   - Don't include setup in measurement
   - Pre-allocate data structures

### Performance Considerations

1. **Use realistic workloads**
   - Data sizes that match real usage
   - Distribution patterns from real data
   - Edge cases and corner cases

2. **Measure what matters**
   - Throughput AND latency
   - Memory usage
   - CPU utilization
   - Scaling characteristics

3. **Document assumptions**
   - Input data characteristics
   - Hardware assumptions
   - Expected performance range

### Common Pitfalls

❌ **Don't:**
- Include I/O in hot path
- Test implementation details instead of interfaces
- Compare incompatible semantics
- Ignore warmup effects
- Assume results generalize across hardware

✅ **Do:**
- Pre-load all data
- Test meaningful patterns
- Ensure semantic equivalence
- Allow proper warmup
- Test on multiple systems

## Code Review Checklist

Before submitting, verify:

- [ ] Code follows project style (`cargo fmt`)
- [ ] No clippy warnings (`cargo clippy`)
- [ ] All benchmarks run successfully
- [ ] Documentation is updated
- [ ] Commit messages follow conventions
- [ ] PR description is complete
- [ ] Benchmarks show expected results
- [ ] No unnecessary dependencies added
- [ ] Code is well-commented
- [ ] Test data is included (if needed)

## Getting Help

- 📖 Read the [Benchmark Guide](BENCHMARK_GUIDE.md)
- 📖 Check the [Migration Documentation](MIGRATION.md)
- 🔍 Look at existing benchmarks for examples
- 💬 Ask questions in issues or PRs
- 📚 Consult framework documentation:
  - [Hydroflow](https://hydro.run/)
  - [Timely](https://github.com/TimelyDataflow/timely-dataflow)
  - [Differential](https://github.com/TimelyDataflow/differential-dataflow)
  - [Criterion.rs](https://bheisler.github.io/criterion.rs/book/)

## Reporting Issues

### Bug Reports

When reporting bugs, include:
- Benchmark name
- Expected behavior
- Actual behavior
- Steps to reproduce
- System information (OS, Rust version)
- Error messages or logs

### Performance Issues

When reporting performance issues:
- Benchmark results showing the issue
- Hardware specifications
- Comparison with expected performance
- Any recent changes that might have caused regression

### Feature Requests

When requesting features:
- Clear description of the feature
- Use cases and motivation
- Example of how it would be used
- Any relevant prior art

## Recognition

Contributors will be recognized in:
- Git commit history
- Release notes
- Project acknowledgments

Significant contributions may be highlighted in documentation and announcements.

## Code of Conduct

### Our Standards

- Be respectful and inclusive
- Welcome newcomers
- Accept constructive criticism
- Focus on what's best for the project
- Show empathy towards others

### Unacceptable Behavior

- Harassment or discrimination
- Trolling or insulting comments
- Personal attacks
- Publishing private information
- Unprofessional conduct

## License

By contributing, you agree that your contributions will be licensed under Apache-2.0, the same license as the project.

## Questions?

If you have questions not covered here:
1. Check existing documentation
2. Search closed issues and PRs
3. Open a new issue with the question
4. Tag it appropriately

Thank you for contributing! 🎉
