# Contributing to bigweaver-agent-canary-zeta-hydro-deps

Thank you for your interest in contributing to the Hydro dependencies benchmark suite! This document provides guidelines for contributing new benchmarks, improvements, and fixes.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [How to Contribute](#how-to-contribute)
- [Benchmark Guidelines](#benchmark-guidelines)
- [Development Workflow](#development-workflow)
- [Testing](#testing)
- [Documentation](#documentation)
- [Pull Request Process](#pull-request-process)
- [Style Guidelines](#style-guidelines)

## Code of Conduct

This project follows the Rust Code of Conduct. Please be respectful and constructive in all interactions.

## Getting Started

### Prerequisites

- Rust stable toolchain (1.70+)
- Git
- Familiarity with Criterion benchmarking framework
- Understanding of timely-dataflow and/or differential-dataflow (for relevant benchmarks)

### Development Setup

1. **Fork and clone the repository**:
   ```bash
   git fork https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
   cd bigweaver-agent-canary-zeta-hydro-deps
   ```

2. **Build the project**:
   ```bash
   cargo build -p hydro-deps-benches
   ```

3. **Run existing benchmarks**:
   ```bash
   cargo bench -p hydro-deps-benches
   ```

4. **Set up integration** (optional, see [INTEGRATION_GUIDE.md](INTEGRATION_GUIDE.md)):
   ```bash
   cd ..
   git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git
   ```

## How to Contribute

### Types of Contributions

We welcome the following types of contributions:

1. **New Benchmarks**: Add benchmarks for new dataflow patterns or algorithms
2. **Performance Improvements**: Optimize existing benchmark implementations
3. **Bug Fixes**: Fix issues in existing benchmarks or build scripts
4. **Documentation**: Improve or expand documentation
5. **Test Data**: Add new test datasets for benchmarks
6. **Integration**: Improve integration with main repository

### Reporting Issues

When reporting issues, please include:

- **Description**: Clear description of the problem
- **Environment**: OS, Rust version, hardware specs
- **Reproduction**: Steps to reproduce the issue
- **Expected vs Actual**: What you expected vs what happened
- **Logs**: Relevant error messages or logs

Example:
```markdown
## Issue: Reachability benchmark fails with large datasets

**Environment**: Ubuntu 22.04, Rust 1.70, 16GB RAM

**Steps to Reproduce**:
1. Increase NUM_ITERATIONS in reachability.rs to 1000
2. Run `cargo bench -p hydro-deps-benches --bench reachability`

**Expected**: Benchmark completes successfully

**Actual**: Out of memory error after 500 iterations

**Logs**:
```
error: memory allocation failed
```
```

## Benchmark Guidelines

### Adding a New Benchmark

When creating a new benchmark, follow these guidelines:

#### 1. File Structure

Create a new file in `benches/benches/`:

```rust
// benches/benches/my_new_benchmark.rs

use criterion::{Criterion, black_box, criterion_group, criterion_main};
use timely::dataflow::operators::*;  // or differential_dataflow::*

// Constants for benchmark parameters
const DATA_SIZE: usize = 1_000_000;
const ITERATIONS: usize = 100;

/// Description of what this benchmark measures
fn benchmark_variant_1(c: &mut Criterion) {
    c.bench_function("my_benchmark/variant_1", |b| {
        b.iter(|| {
            // Benchmark implementation
            black_box(/* result */);
        });
    });
}

criterion_group!(benches, benchmark_variant_1);
criterion_main!(benches);
```

#### 2. Register in Cargo.toml

Add the benchmark to `benches/Cargo.toml`:

```toml
[[bench]]
name = "my_new_benchmark"
harness = false
```

#### 3. Documentation

Add a section to [BENCHMARK_DETAILS.md](BENCHMARK_DETAILS.md):

```markdown
### N. My New Benchmark (`my_new_benchmark.rs`)

**Purpose**: [Brief description]

**Operation**: [What it does]

**Implementations**:
- `my_benchmark/variant_1`: [Description]
- `my_benchmark/variant_2`: [Description]

**Key Metrics**:
- [Metric 1]
- [Metric 2]

**Use Case**: [When to use this benchmark]
```

### Benchmark Quality Criteria

A good benchmark should:

1. **Measure Something Specific**: Focus on one aspect of performance
2. **Be Reproducible**: Consistent results across runs
3. **Be Representative**: Reflect real-world usage patterns
4. **Have Minimal Overhead**: Measure the operation, not the measurement
5. **Include Baselines**: Compare against reference implementations
6. **Be Well-Documented**: Clear purpose and interpretation

### Benchmark Anti-Patterns

Avoid these common mistakes:

❌ **Don't**: Measure too many things in one benchmark
```rust
// BAD: Combines multiple operations
fn benchmark_everything(c: &mut Criterion) {
    c.bench_function("everything", |b| {
        b.iter(|| {
            let data = load_data();
            let processed = transform(data);
            let result = aggregate(processed);
            black_box(result);
        });
    });
}
```

✅ **Do**: Separate concerns
```rust
// GOOD: Separate benchmarks for each operation
fn benchmark_load(c: &mut Criterion) {
    c.bench_function("load", |b| {
        b.iter(|| black_box(load_data()));
    });
}

fn benchmark_transform(c: &mut Criterion) {
    let data = load_data();
    c.bench_function("transform", |b| {
        b.iter(|| black_box(transform(data.clone())));
    });
}
```

❌ **Don't**: Forget to use `black_box`
```rust
// BAD: Compiler might optimize away the computation
b.iter(|| {
    expensive_computation();  // Result unused!
});
```

✅ **Do**: Use `black_box` to prevent optimization
```rust
// GOOD: Ensures computation is actually performed
b.iter(|| {
    black_box(expensive_computation());
});
```

## Development Workflow

### Creating a Feature Branch

```bash
# Create descriptive branch name with timestamp
git checkout -b feature-add-aggregation-benchmark-20251126

# Or for bug fixes
git checkout -b fix-reachability-memory-leak-20251126
```

### Making Changes

1. **Write the code** for your new benchmark or fix
2. **Test locally**:
   ```bash
   cargo build -p hydro-deps-benches
   cargo bench -p hydro-deps-benches --bench your_benchmark
   ```
3. **Update documentation** if needed
4. **Run code formatting**:
   ```bash
   cargo fmt --all
   ```
5. **Run lints**:
   ```bash
   cargo clippy --all-targets --all-features -- -D warnings
   ```

### Committing Changes

Follow conventional commit format:

```bash
# Format: <type>(<scope>): <description>

# Examples:
git commit -m "feat(benches): add aggregation benchmark"
git commit -m "fix(reachability): fix memory leak in iteration"
git commit -m "docs(readme): update benchmark descriptions"
git commit -m "refactor(arithmetic): optimize pipeline implementation"
```

Types:
- `feat`: New feature or benchmark
- `fix`: Bug fix
- `docs`: Documentation changes
- `refactor`: Code refactoring without changing behavior
- `test`: Adding or updating tests
- `chore`: Maintenance tasks

## Testing

### Running Tests

```bash
# Build tests
cargo test -p hydro-deps-benches --no-run

# Run specific benchmark
cargo bench -p hydro-deps-benches --bench your_benchmark -- --test

# Run with verbose output
cargo bench -p hydro-deps-benches --verbose
```

### Verification Checklist

Before submitting a PR, verify:

- [ ] Benchmark builds successfully
- [ ] Benchmark runs without errors
- [ ] Results are consistent across multiple runs
- [ ] Memory usage is reasonable
- [ ] No new warnings from clippy
- [ ] Code is formatted with rustfmt
- [ ] Documentation is updated
- [ ] BENCHMARK_DETAILS.md includes new benchmark
- [ ] Cargo.toml includes new benchmark entry

## Documentation

### What to Document

When adding or modifying benchmarks:

1. **Update README.md** if adding new benchmark types
2. **Update BENCHMARK_DETAILS.md** with comprehensive description
3. **Add inline comments** explaining complex logic
4. **Document constants** and their significance
5. **Explain design decisions** in commit messages

### Documentation Style

Use clear, concise language:

```rust
// GOOD: Clear and specific
/// Measures the throughput of merging multiple input streams using
/// timely's Concatenate operator. Tests with 2 streams of 1M integers each.
fn benchmark_fan_in_timely(c: &mut Criterion) { ... }

// BAD: Vague
/// Tests fan-in
fn benchmark_fan_in_timely(c: &mut Criterion) { ... }
```

## Pull Request Process

### Before Submitting

1. **Sync with main**:
   ```bash
   git fetch origin
   git rebase origin/main
   ```

2. **Run full test suite**:
   ```bash
   cargo build -p hydro-deps-benches
   cargo bench -p hydro-deps-benches
   ```

3. **Update documentation**

### PR Description Format

Use this template:

```markdown
## Overview
Brief description of the changes (1-2 sentences)

## Task Details
- [x] Add new benchmark: [benchmark name]
- [x] Update BENCHMARK_DETAILS.md
- [x] Update Cargo.toml
- [x] Test benchmark runs successfully

## Benefits
- ✅ [Benefit 1]
- ✅ [Benefit 2]

## Testing
- ✅ Built successfully with `cargo build -p hydro-deps-benches`
- ✅ Ran benchmark: `cargo bench -p hydro-deps-benches --bench [name]`
- ✅ Results are consistent across 3 runs
- ✅ Memory usage within acceptable range

## Impact Analysis
### Changes
- Added: [new files]
- Modified: [changed files]

### Dependencies
- No new dependencies / Added [dependency] version [version]

### Performance
- [Performance characteristics of new benchmark]

## Affected Teams
- **Development Team**: [Impact and required actions]
- **Performance Testing Team**: [Impact and required actions]

## Files Changed Summary
- `benches/benches/new_benchmark.rs`: [Description]
- `benches/Cargo.toml`: Added benchmark entry
- `BENCHMARK_DETAILS.md`: Added documentation
```

### Review Process

1. **Automated checks** must pass (CI/CD if configured)
2. **Code review** by at least one team member
3. **Performance review** for new benchmarks
4. **Documentation review** for completeness
5. **Approval** and merge

### After Merge

- **Delete feature branch**: `git branch -d feature-branch-name`
- **Update local main**: `git checkout main && git pull`

## Style Guidelines

### Rust Code Style

Follow standard Rust conventions:

- Use `rustfmt` for formatting (automatically enforced)
- Follow `clippy` recommendations
- Use meaningful variable names
- Keep functions focused and small
- Add doc comments for public items

### Naming Conventions

```rust
// Constants: SCREAMING_SNAKE_CASE
const NUM_ITERATIONS: usize = 1000;

// Functions: snake_case
fn benchmark_arithmetic_timely() { }

// Benchmark names: category/variant
c.bench_function("arithmetic/timely", |b| { });
```

### File Organization

```rust
// 1. Imports
use std::collections::HashMap;
use criterion::{Criterion, criterion_group, criterion_main};
use timely::dataflow::operators::*;

// 2. Constants
const DATA_SIZE: usize = 1_000_000;

// 3. Helper functions
fn generate_data() -> Vec<i32> { }

// 4. Benchmark functions
fn benchmark_variant_1(c: &mut Criterion) { }
fn benchmark_variant_2(c: &mut Criterion) { }

// 5. Criterion setup
criterion_group!(benches, benchmark_variant_1, benchmark_variant_2);
criterion_main!(benches);
```

## Performance Considerations

When writing benchmarks:

1. **Minimize setup overhead**: Use `iter_batched` for expensive setup
2. **Use appropriate sample sizes**: Balance accuracy vs. runtime
3. **Consider warmup**: Let Criterion handle warmup automatically
4. **Avoid I/O in hot path**: Load data before benchmarking
5. **Use realistic data**: Representative sizes and distributions

## Getting Help

If you need assistance:

1. **Check documentation**: [README.md](README.md), [QUICKSTART.md](QUICKSTART.md), [BENCHMARK_DETAILS.md](BENCHMARK_DETAILS.md)
2. **Review existing benchmarks**: Learn from implemented examples
3. **Ask questions**: Open an issue with the "question" label
4. **Contact teams**: Reach out to Development or Performance Testing team

## Recognition

Contributors will be recognized in:
- Git commit history
- Release notes (for significant contributions)
- Project documentation

Thank you for contributing to the Hydro benchmark suite!

---

**Resources**:
- [Criterion.rs Documentation](https://bheisler.github.io/criterion.rs/book/)
- [Rust Performance Book](https://nnethercote.github.io/perf-book/)
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)
