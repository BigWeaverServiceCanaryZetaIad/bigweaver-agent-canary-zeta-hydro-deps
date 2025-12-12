# Contributing to Hydro Deps Repository

Thank you for your interest in contributing to the Hydro benchmark dependencies repository!

## Overview

This repository houses benchmarks and performance testing code that require external dataflow dependencies such as `timely` and `differential-dataflow`. It is a companion repository to [bigweaver-agent-canary-hydro-zeta](../bigweaver-agent-canary-hydro-zeta).

## Getting Started

### Prerequisites

- Rust (stable toolchain recommended)
- Cargo
- Git

### Setup

```bash
# Clone the repository
git clone <repository-url>
cd bigweaver-agent-canary-zeta-hydro-deps

# Build all benchmarks (when they exist)
cargo build --all

# Run tests
cargo test --all

# Run benchmarks
cargo bench --all
```

## Contributing Benchmarks

### When to Add Benchmarks Here

Add benchmarks to this repository when they:

1. Require `timely` or `differential-dataflow` dependencies
2. Would significantly increase build times in the main repository
3. Test integration with external dataflow systems
4. Require specialized benchmark infrastructure

### Creating a New Benchmark

#### Step 1: Create the Benchmark Crate

```bash
cargo new --lib benchmarks/my_benchmark
cd benchmarks/my_benchmark
```

#### Step 2: Set Up Cargo.toml

```toml
[package]
name = "my_benchmark"
version = "0.1.0"
edition = "2024"
publish = false

[dependencies]
# External dataflow dependencies
timely = "0.12"
differential-dataflow = "0.12"

# Benchmark infrastructure
criterion = { version = "0.5", features = ["html_reports"] }

# Core dependencies (adjust versions as needed)
serde = { version = "1.0", features = ["derive"] }
tokio = { version = "1.29.0", features = ["full"] }

[[bench]]
name = "my_benchmark"
harness = false
```

#### Step 3: Implement the Benchmark

Create `benches/my_benchmark.rs`:

```rust
use criterion::{black_box, criterion_group, criterion_main, Criterion};

fn benchmark_my_operation(c: &mut Criterion) {
    c.bench_function("my_operation", |b| {
        b.iter(|| {
            // Your benchmark code here
            black_box(perform_operation())
        })
    });
}

criterion_group!(benches, benchmark_my_operation);
criterion_main!(benches);
```

#### Step 4: Add to Workspace

Edit the root `Cargo.toml`:

```toml
[workspace]
members = [
    "benchmarks/my_benchmark",
    # ... existing members
]
```

#### Step 5: Test Your Benchmark

```bash
# Build the benchmark
cargo build --package my_benchmark

# Run the benchmark
cargo bench --package my_benchmark
```

#### Step 6: Document Your Benchmark

Add documentation to `BENCHMARKS.md`:

```markdown
### My Benchmark

**Location**: `benchmarks/my_benchmark`

**Purpose**: Measures performance of [describe what you're testing]

**Dependencies**:
- timely: 0.12
- differential-dataflow: 0.12

**Usage**:
\`\`\`bash
cargo bench --package my_benchmark
\`\`\`

**Expected Results**: [Describe expected performance characteristics]
```

## Code Quality Standards

### Formatting

```bash
# Format your code
cargo fmt --all

# Check formatting
cargo fmt --all -- --check
```

### Linting

```bash
# Run clippy
cargo clippy --all --all-targets -- -D warnings
```

### Testing

```bash
# Run all tests
cargo test --all

# Run tests for specific package
cargo test --package my_benchmark
```

## Pull Request Process

1. **Create a branch** from `main`:
   ```bash
   git checkout -b feature/my-benchmark
   ```

2. **Make your changes**:
   - Add benchmark code
   - Update documentation
   - Add tests if applicable

3. **Ensure quality**:
   ```bash
   cargo fmt --all
   cargo clippy --all --all-targets
   cargo test --all
   cargo bench --all --no-fail-fast
   ```

4. **Commit your changes**:
   ```bash
   git add .
   git commit -m "feat(benchmarks): add my_benchmark for testing X"
   ```

   Follow [Conventional Commits](https://www.conventionalcommits.org/):
   - `feat(scope): description` - New features
   - `fix(scope): description` - Bug fixes
   - `docs(scope): description` - Documentation changes
   - `chore(scope): description` - Maintenance tasks

5. **Push and create PR**:
   ```bash
   git push origin feature/my-benchmark
   ```

6. **PR Description**: Include:
   - Purpose of the benchmark
   - What it measures
   - Dependencies required
   - How to run it
   - Expected results
   - Any special considerations

### PR Template

```markdown
## Description
[Describe what this benchmark does]

## Changes Made
- Added benchmark for [feature]
- Updated BENCHMARKS.md documentation
- Added necessary dependencies

## Testing
- [ ] Benchmark builds successfully
- [ ] Benchmark runs without errors
- [ ] Documentation is complete
- [ ] Code is formatted (cargo fmt)
- [ ] Clippy passes (cargo clippy)

## Performance Results
[Include any initial benchmark results]

## Related Issues
Closes #[issue number]
```

## Code Review Guidelines

When reviewing benchmarks:

1. **Correctness**: Does the benchmark measure what it claims to?
2. **Isolation**: Is the benchmark properly isolated from external factors?
3. **Documentation**: Is it well-documented and easy to understand?
4. **Dependencies**: Are all dependencies necessary and properly versioned?
5. **Performance**: Does it run in a reasonable amount of time?

## Benchmark Best Practices

### 1. Measure One Thing at a Time

```rust
// Good: Focused benchmark
fn bench_hash_insertion(c: &mut Criterion) {
    c.bench_function("hash_insert", |b| {
        let mut map = HashMap::new();
        b.iter(|| {
            black_box(map.insert(black_box(42), black_box(100)))
        })
    });
}

// Avoid: Testing multiple operations
fn bench_everything(c: &mut Criterion) {
    c.bench_function("multiple_ops", |b| {
        b.iter(|| {
            let mut map = HashMap::new(); // Setup in iteration
            map.insert(42, 100);
            map.get(&42);
            map.remove(&42);
        })
    });
}
```

### 2. Use black_box Appropriately

```rust
// Prevents compiler from optimizing away operations
b.iter(|| {
    black_box(expensive_operation(black_box(input)))
})
```

### 3. Handle Setup Correctly

```rust
// Setup outside the measured section
c.bench_function("operation", |b| {
    let data = prepare_test_data();
    b.iter(|| {
        process(black_box(&data))
    })
});
```

### 4. Document Expected Performance

```rust
/// Benchmark for hash map insertion
/// 
/// Expected performance: ~50ns per insertion on modern hardware
/// Factors affecting performance:
/// - Hash function quality
/// - Load factor
/// - Key size
fn bench_hash_insertion(c: &mut Criterion) {
    // ...
}
```

## Continuous Integration

All PRs must pass CI checks:

- ✅ Code formatting (`cargo fmt`)
- ✅ Linting (`cargo clippy`)
- ✅ All tests pass (`cargo test`)
- ✅ All benchmarks build (`cargo build --all`)
- ✅ Benchmarks run successfully (`cargo bench --all`)

## Communication

- **Questions**: Open an issue with the `question` label
- **Bugs**: Open an issue with the `bug` label
- **Features**: Open an issue with the `enhancement` label
- **Discussions**: Use GitHub Discussions for general topics

## Release Process

(To be defined as the repository matures)

## Resources

- [Criterion.rs Documentation](https://bheisler.github.io/criterion.rs/book/)
- [Rust Performance Book](https://nnethercote.github.io/perf-book/)
- [Main Repository](../bigweaver-agent-canary-hydro-zeta)
- [BENCHMARKS.md](BENCHMARKS.md) - Detailed benchmark documentation

## License

By contributing, you agree that your contributions will be licensed under the Apache-2.0 license.

## Questions?

If you have any questions, please:
1. Check the documentation
2. Search existing issues
3. Open a new issue with the `question` label

Thank you for contributing to the Hydro project!
