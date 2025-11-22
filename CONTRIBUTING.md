# Contributing Guide

Thank you for your interest in contributing to the Hydro benchmarks repository! This document provides guidelines for contributing.

## Code of Conduct

Please be respectful and constructive in all interactions. We aim to maintain a welcoming and inclusive environment.

## Types of Contributions

We welcome various types of contributions:

1. **New Benchmarks**: Add benchmarks for untested scenarios
2. **Bug Fixes**: Fix issues in existing benchmarks
3. **Documentation**: Improve or expand documentation
4. **Performance Improvements**: Optimize benchmark implementations
5. **Infrastructure**: Improve build scripts, CI/CD, etc.

## Getting Started

### Prerequisites

- Read [README.md](README.md) and [QUICKSTART.md](QUICKSTART.md)
- Complete [SETUP_VERIFICATION.md](SETUP_VERIFICATION.md)
- Understand the existing benchmarks

### Fork and Clone

```bash
# Fork on GitHub, then clone your fork
git clone https://github.com/YOUR_USERNAME/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps

# Add upstream remote
git remote add upstream https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
```

## Development Workflow

### 1. Create a Branch

```bash
git checkout -b feature/your-feature-name
# or
git checkout -b fix/your-bug-fix
```

Use descriptive branch names:
- `feature/add-windowing-benchmark`
- `fix/reachability-data-loading`
- `docs/improve-quickstart`

### 2. Make Changes

Follow these guidelines when making changes:

#### Code Style

- **Follow Rust conventions**: Use `rustfmt` and `clippy`
- **Consistent formatting**: Run before committing:
  ```bash
  cargo fmt -p benches
  cargo clippy -p benches -- -D warnings
  ```

#### Benchmark Structure

New benchmarks should follow this pattern:

```rust
use criterion::{black_box, criterion_group, criterion_main, Criterion};

fn my_benchmark(c: &mut Criterion) {
    // Setup
    let data = setup_test_data();
    
    // Benchmark group
    let mut group = c.benchmark_group("my_feature");
    
    // Hydro implementation
    group.bench_function("hydro", |b| {
        b.iter(|| {
            // Your Hydro implementation
            black_box(hydro_implementation(&data));
        });
    });
    
    // Timely implementation (if applicable)
    group.bench_function("timely", |b| {
        b.iter(|| {
            // Your Timely implementation
            black_box(timely_implementation(&data));
        });
    });
    
    group.finish();
}

criterion_group!(benches, my_benchmark);
criterion_main!(benches);
```

#### Documentation

- **Add doc comments**: Explain what the benchmark tests
- **Include examples**: Show expected usage
- **Document assumptions**: State any limitations or constraints

### 3. Test Your Changes

```bash
# Check compilation
cargo check -p benches

# Run formatting
cargo fmt -p benches

# Run linter
cargo clippy -p benches

# Test the specific benchmark
cargo bench -p benches --bench your_benchmark -- --sample-size 10

# Ensure all benchmarks still work
cargo bench -p benches -- --sample-size 10
```

### 4. Commit Changes

Follow these commit message guidelines:

#### Commit Message Format

```
<type>(<scope>): <subject>

<body>

<footer>
```

**Types:**
- `feat`: New feature or benchmark
- `fix`: Bug fix
- `docs`: Documentation changes
- `perf`: Performance improvements
- `test`: Test additions or fixes
- `refactor`: Code refactoring
- `chore`: Maintenance tasks

**Examples:**
```
feat(benches): add windowing operations benchmark

Add benchmark comparing windowing implementations across
Hydro, Timely, and Differential frameworks.

Includes tumbling, sliding, and session windows.

fix(reachability): correct edge data loading

The reachability benchmark was loading edge data incorrectly,
causing invalid results. Fixed the parsing logic.

Fixes #42

docs(README): clarify setup instructions

Expand the setup section with more detailed steps for
configuring repository paths.
```

### 5. Push and Create Pull Request

```bash
# Push to your fork
git push origin feature/your-feature-name

# Create pull request on GitHub
```

## Pull Request Guidelines

### PR Title

Follow the same format as commit messages:
```
feat(benches): add windowing operations benchmark
```

### PR Description

Include:

1. **Purpose**: What does this PR do?
2. **Changes**: What was changed?
3. **Testing**: How was it tested?
4. **Results**: Any benchmark results?
5. **Related Issues**: Link to related issues

**Template:**
```markdown
## Purpose
Brief description of what this PR accomplishes.

## Changes
- Added new benchmark for X
- Updated documentation for Y
- Fixed bug in Z

## Testing
- [ ] All benchmarks compile
- [ ] New benchmark runs successfully
- [ ] Existing benchmarks still work
- [ ] Documentation updated

## Results
(Include any relevant benchmark results or comparisons)

## Related Issues
Fixes #123
Related to #456
```

### Review Process

1. **Automated checks**: CI will run basic checks
2. **Code review**: Maintainers will review your code
3. **Feedback**: Address any requested changes
4. **Approval**: Once approved, PR will be merged

### Responding to Feedback

```bash
# Make requested changes
git add .
git commit -m "address review feedback"
git push origin feature/your-feature-name
```

## Adding New Benchmarks

### 1. Create Benchmark File

```bash
touch benches/benches/your_benchmark.rs
```

### 2. Implement Benchmark

```rust
// See benchmark structure example above
```

### 3. Register in Cargo.toml

```toml
[[bench]]
name = "your_benchmark"
harness = false
```

### 4. Add Documentation

- Add entry to main README.md
- Document in benches/README.md
- Include inline documentation

### 5. Include Test Data

If your benchmark needs data:

```bash
# Add data files to benches/benches/
# Keep data files reasonably sized (< 5MB if possible)
```

### 6. Test Thoroughly

```bash
# Run multiple times to ensure consistency
for i in {1..3}; do
    cargo bench -p benches --bench your_benchmark
done
```

## Documentation Contributions

### Types of Documentation

- **README files**: High-level overviews
- **Code comments**: Inline explanations
- **Guides**: Step-by-step tutorials
- **API docs**: Function/module documentation

### Documentation Standards

- **Clear and concise**: Avoid jargon when possible
- **Examples**: Include practical examples
- **Accurate**: Keep documentation in sync with code
- **Complete**: Cover all major features

### Updating Documentation

```bash
# Make changes
vim README.md

# Preview if possible
# Commit with appropriate message
git commit -m "docs: update benchmark descriptions"
```

## Reporting Issues

### Before Reporting

1. **Search existing issues**: Check if already reported
2. **Verify the issue**: Ensure it's reproducible
3. **Gather information**: Collect relevant details

### Issue Template

```markdown
## Description
Clear description of the issue.

## Steps to Reproduce
1. Step one
2. Step two
3. Step three

## Expected Behavior
What you expected to happen.

## Actual Behavior
What actually happened.

## Environment
- OS: 
- Rust version: 
- Benchmark version: 

## Additional Context
Any other relevant information.
```

## Performance Contributions

### Optimizing Benchmarks

When optimizing:

1. **Measure first**: Establish baseline
2. **Profile**: Identify bottlenecks
3. **Optimize**: Make targeted improvements
4. **Verify**: Confirm improvements
5. **Document**: Explain changes

### Benchmark Results

When submitting performance improvements:

```markdown
## Performance Improvement

### Before
- Mean: 45.2ms
- Throughput: 221 ops/sec

### After
- Mean: 38.7ms  (-14.4%)
- Throughput: 258 ops/sec  (+16.7%)

### Changes
- Optimized data structure X
- Reduced allocations in Y
- Improved algorithm Z
```

## Code Review

### As a Reviewer

- **Be constructive**: Focus on improving the code
- **Be specific**: Point to exact issues
- **Be timely**: Review promptly
- **Be thorough**: Check all aspects

### As an Author

- **Be receptive**: Consider all feedback
- **Ask questions**: Clarify unclear feedback
- **Explain decisions**: Justify your choices
- **Update promptly**: Address feedback quickly

## Release Process

Maintainers handle releases, but contributors should:

1. **Update CHANGELOG**: Document significant changes
2. **Version bumps**: Follow semantic versioning
3. **Migration guides**: Document breaking changes

## Questions?

If you have questions:

1. **Check documentation**: README, guides, etc.
2. **Search issues**: Look for similar questions
3. **Ask in issues**: Create a question issue
4. **Contact maintainers**: Reach out directly if needed

## Recognition

Contributors are recognized:

- Listed in CONTRIBUTORS file
- Mentioned in release notes
- Appreciated in the community!

## License

By contributing, you agree that your contributions will be licensed under the Apache-2.0 license.

---

Thank you for contributing to Hydro benchmarks! 🎉
