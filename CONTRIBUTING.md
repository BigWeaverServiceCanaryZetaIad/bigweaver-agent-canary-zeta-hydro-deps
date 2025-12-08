# Contributing to Hydro Dependencies Benchmarks

Thank you for your interest in contributing to the Hydro benchmarks! This document provides guidelines for adding new benchmarks, improving existing ones, and maintaining the benchmark suite.

## Quick Start

1. Clone the repository
2. Ensure Rust toolchain is installed (see `rust-toolchain.toml` for version)
3. Run existing benchmarks to verify setup: `cargo bench -p benches`

## Adding New Benchmarks

### 1. Create the Benchmark File

Create a new file in `benches/benches/` directory:

```bash
touch benches/benches/my_new_benchmark.rs
```

### 2. Write the Benchmark

Follow the pattern of existing benchmarks:

```rust
use criterion::{Criterion, criterion_group, criterion_main};
use dfir_rs::dfir_syntax;
// Add other necessary imports

fn benchmark_hydro(c: &mut Criterion) {
    c.bench_function("my_benchmark/hydro", |b| {
        b.iter(|| {
            // Your Hydro implementation
        });
    });
}

fn benchmark_timely(c: &mut Criterion) {
    c.bench_function("my_benchmark/timely", |b| {
        b.iter(|| {
            // Your Timely implementation for comparison
        });
    });
}

criterion_group!(benches, benchmark_hydro, benchmark_timely);
criterion_main!(benches);
```

### 3. Register the Benchmark

Add an entry in `benches/Cargo.toml`:

```toml
[[bench]]
name = "my_new_benchmark"
harness = false
```

### 4. Document the Benchmark

Update `benches/README.md` to describe:
- What the benchmark tests
- Which implementations are included
- Any special data requirements

### 5. Test the Benchmark

```bash
cargo bench -p benches --bench my_new_benchmark
```

## Benchmark Design Guidelines

### Do's ✅

- **Compare Multiple Implementations**: Include Hydro, Timely, and/or Differential implementations when relevant
- **Use Realistic Workloads**: Design benchmarks that reflect real-world usage patterns
- **Document Assumptions**: Clearly document any assumptions or constraints
- **Include Test Data**: Provide necessary test data files in `benches/benches/`
- **Use Appropriate Sizes**: Choose data sizes that complete in reasonable time but are large enough to be meaningful
- **Follow Naming Conventions**: Use descriptive names that indicate what's being tested

### Don'ts ❌

- **Don't Optimize for One Framework**: Keep comparisons fair and balanced
- **Don't Use Hardcoded Paths**: Use `include_bytes!()` or relative paths
- **Don't Add Unnecessary Dependencies**: Only add dependencies that are essential
- **Don't Ignore Statistical Variance**: Use sufficient sample sizes
- **Don't Commit Generated Files**: Add build artifacts to `.gitignore`

## Code Style

### Formatting

Use `rustfmt` to format code:

```bash
cargo fmt --all
```

### Linting

Run `clippy` to catch common issues:

```bash
cargo clippy --all-targets --all-features
```

### Structure

Organize benchmarks clearly:

```rust
// 1. Imports
use criterion::{...};

// 2. Constants
const DATA_SIZE: usize = 1000;

// 3. Helper functions (if needed)
fn generate_test_data() -> Vec<i32> { ... }

// 4. Individual benchmarks
fn benchmark_scenario_1(c: &mut Criterion) { ... }
fn benchmark_scenario_2(c: &mut Criterion) { ... }

// 5. Group registration
criterion_group!(benches, benchmark_scenario_1, benchmark_scenario_2);
criterion_main!(benches);
```

## Test Data

### Adding Test Data Files

1. Place files in `benches/benches/` directory
2. Use `include_bytes!()` or `include_str!()` to embed them
3. Document the source and format in comments
4. Add attribution if the data is from external sources

Example:

```rust
// Word list from https://github.com/dwyl/english-words
static WORDS: LazyLock<Vec<String>> = LazyLock::new(|| {
    let data = include_str!("words_alpha.txt");
    data.lines().map(String::from).collect()
});
```

### Large Data Files

- Keep individual files under 5MB when possible
- For larger datasets, consider:
  - Generating data programmatically
  - Providing download scripts
  - Using compressed formats

## Dependencies

### Adding Dependencies

Add dependencies to `benches/Cargo.toml` under `[dev-dependencies]`:

```toml
[dev-dependencies]
# Core benchmarking
criterion = { version = "0.5.0", features = [ "async_tokio", "html_reports" ] }

# Frameworks being compared
dfir_rs = { git = "https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git", features = [ "debugging" ] }
timely = { package = "timely-master", version = "0.13.0-dev.1" }

# Your additional dependencies
my_crate = "1.0.0"
```

### Dependency Guidelines

- Use git dependencies for `dfir_rs` and `sinktools` to stay in sync with main repo
- Specify exact versions for external dependencies when possible
- Document why each dependency is needed

## Documentation

### Inline Documentation

Add comments explaining non-obvious code:

```rust
// Process edges in batches of 1000 to reduce memory pressure
for chunk in edges.chunks(1000) {
    // ...
}
```

### README Updates

When adding or modifying benchmarks, update:
- `benches/README.md` - Benchmark descriptions
- `README.md` - Quick reference if needed
- `BENCHMARK_MIGRATION.md` - If related to migration

## Performance Considerations

### Benchmark Stability

Make benchmarks produce consistent results:

```rust
// Good: Deterministic random seed
use rand::SeedableRng;
let mut rng = rand::rngs::StdRng::seed_from_u64(42);

// Avoid: System-dependent behavior
// let data = read_from_system_cache();
```

### Measurement Accuracy

```rust
use criterion::black_box;

c.bench_function("my_test", |b| {
    b.iter(|| {
        // Use black_box to prevent compiler optimization
        let result = expensive_computation(black_box(input));
        black_box(result);
    });
});
```

## Testing

Before submitting:

```bash
# Format code
cargo fmt --all

# Run lints
cargo clippy --all-targets

# Build benchmarks
cargo build -p benches --release

# Run benchmarks
cargo bench -p benches

# Verify specific benchmark works
cargo bench -p benches --bench my_new_benchmark
```

## Pull Request Process

1. **Fork and Branch**: Create a feature branch from main
2. **Make Changes**: Implement your benchmark or improvements
3. **Test Thoroughly**: Ensure all benchmarks still work
4. **Document**: Update relevant documentation
5. **Commit**: Use clear, descriptive commit messages
6. **Submit PR**: Provide context and rationale in PR description

### Commit Message Format

Follow conventional commits:

```
feat(benches): add graph traversal benchmark

- Implements breadth-first search benchmark
- Compares Hydro vs Timely implementations
- Includes synthetic graph test data generator

Closes #123
```

### PR Description Template

```markdown
## Description
Brief description of changes

## Type of Change
- [ ] New benchmark
- [ ] Benchmark improvement
- [ ] Bug fix
- [ ] Documentation update
- [ ] Dependency update

## Testing
- [ ] Ran `cargo bench -p benches`
- [ ] Verified new benchmark produces consistent results
- [ ] Updated documentation

## Checklist
- [ ] Code follows style guidelines
- [ ] Comments added for complex logic
- [ ] Documentation updated
- [ ] No unnecessary dependencies added
```

## Review Process

Maintainers will review your PR for:

1. **Correctness**: Does the benchmark accurately measure what it claims?
2. **Fairness**: Are comparisons between frameworks fair and unbiased?
3. **Performance**: Does the benchmark complete in reasonable time?
4. **Quality**: Is the code clean, documented, and maintainable?
5. **Documentation**: Are changes properly documented?

## Questions?

- **General Questions**: Open a discussion in the repository
- **Bug Reports**: Open an issue with details and reproduction steps
- **Feature Requests**: Open an issue describing the proposed feature

## Resources

- [Criterion.rs Documentation](https://bheisler.github.io/criterion.rs/book/)
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)
- [Hydro Documentation](https://hydro.run)
- [Main Hydro Repository](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)

Thank you for contributing! 🎉
