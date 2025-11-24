# Contributing to bigweaver-agent-canary-zeta-hydro-deps

Thank you for your interest in contributing to this repository! This document provides guidelines for contributing to the timely-dataflow and differential-dataflow benchmarks.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Repository Structure](#repository-structure)
- [Adding New Benchmarks](#adding-new-benchmarks)
- [Modifying Existing Benchmarks](#modifying-existing-benchmarks)
- [Testing Your Changes](#testing-your-changes)
- [Submitting Changes](#submitting-changes)
- [Benchmark Guidelines](#benchmark-guidelines)
- [Performance Considerations](#performance-considerations)

## Code of Conduct

We are committed to providing a welcoming and inclusive environment. Please be respectful and professional in all interactions.

## Getting Started

1. Clone the repository
2. Ensure you have Rust installed (rustup recommended)
3. Run `cargo build` to ensure everything compiles
4. Run `cargo bench -p benches --bench identity` to verify your setup

See [QUICK_START.md](QUICK_START.md) for detailed setup instructions.

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── benches/              # Benchmark workspace package
│   ├── benches/          # Benchmark implementations
│   ├── Cargo.toml        # Package configuration
│   ├── build.rs          # Build script
│   └── README.md         # Benchmark documentation
├── .github/
│   └── workflows/
│       └── benchmark.yml # CI/CD configuration
├── Cargo.toml            # Workspace configuration
├── README.md             # Main documentation
├── QUICK_START.md        # Quick start guide
└── CONTRIBUTING.md       # This file
```

## Adding New Benchmarks

To add a new benchmark:

### 1. Create the Benchmark File

Create a new file in `benches/benches/` with a descriptive name:

```bash
touch benches/benches/my_new_benchmark.rs
```

### 2. Implement the Benchmark

Follow the structure of existing benchmarks. Here's a template:

```rust
use criterion::{black_box, criterion_group, criterion_main, Criterion};

fn my_benchmark_timely(c: &mut Criterion) {
    c.bench_function("my_benchmark/timely", |b| {
        b.iter(|| {
            // Your timely-dataflow implementation
            black_box(/* result */);
        });
    });
}

fn my_benchmark_differential(c: &mut Criterion) {
    c.bench_function("my_benchmark/differential", |b| {
        b.iter(|| {
            // Your differential-dataflow implementation
            black_box(/* result */);
        });
    });
}

fn my_benchmark_hydroflow(c: &mut Criterion) {
    c.bench_function("my_benchmark/hydroflow", |b| {
        b.iter(|| {
            // Your hydroflow implementation
            black_box(/* result */);
        });
    });
}

criterion_group!(benches, my_benchmark_timely, my_benchmark_differential, my_benchmark_hydroflow);
criterion_main!(benches);
```

### 3. Register the Benchmark

Add the benchmark to `benches/Cargo.toml`:

```toml
[[bench]]
name = "my_new_benchmark"
harness = false
```

### 4. Add Test Data (if needed)

If your benchmark requires test data files:

1. Add the data file to `benches/benches/`
2. Document the data source and format in comments
3. Keep data files reasonably sized (< 10 MB if possible)

### 5. Document the Benchmark

Update the following documentation:

- Add a description in `benches/README.md`
- Add the benchmark to the list in the main `README.md`
- Include comments in your benchmark code explaining the algorithm and comparison points

## Modifying Existing Benchmarks

When modifying existing benchmarks:

1. **Preserve comparability**: Ensure changes don't invalidate historical comparisons
2. **Document changes**: Update comments to explain modifications
3. **Test thoroughly**: Run the benchmark multiple times to ensure stability
4. **Consider baselines**: Save a baseline before making changes for comparison

## Testing Your Changes

### Build Check
```bash
cargo build --release -p benches --all-targets
```

### Run Your Specific Benchmark
```bash
cargo bench -p benches --bench my_new_benchmark
```

### Run All Benchmarks
```bash
cargo bench -p benches
```

### Validate Against Baseline
```bash
# Save baseline before changes
cargo bench -p benches -- --save-baseline before

# Make your changes

# Compare
cargo bench -p benches -- --baseline before
```

## Submitting Changes

### Pull Request Process

1. **Create a feature branch**
   ```bash
   git checkout -b feature/my-benchmark-addition
   ```

2. **Make your changes**
   - Follow the guidelines above
   - Ensure code compiles
   - Test your changes

3. **Commit with conventional commits format**
   ```
   feat(benches): add my_new_benchmark for testing X pattern
   
   - Implements timely-dataflow version
   - Implements differential-dataflow version
   - Implements hydroflow version
   - Adds test data file (source: URL)
   ```

4. **Push and create pull request**
   ```bash
   git push origin feature/my-benchmark-addition
   ```

5. **Pull request description should include**:
   - Overview of the benchmark
   - Why it's being added/modified
   - Performance characteristics observed
   - Any dependencies or setup requirements

## Benchmark Guidelines

### Naming Conventions

- Use snake_case for file and benchmark names
- Use descriptive names that indicate the pattern being tested
- Prefix benchmark IDs with the benchmark name

### Code Style

- Follow Rust standard formatting (`cargo fmt`)
- Address clippy warnings (`cargo clippy`)
- Use meaningful variable names
- Add comments explaining non-obvious logic

### Performance Considerations

- **Use `black_box`**: Prevent compiler optimizations from eliminating benchmark code
- **Appropriate iteration counts**: Balance between statistical significance and runtime
- **Deterministic inputs**: Use seeded RNGs for reproducible results
- **Realistic workloads**: Benchmark scenarios that reflect actual use cases

### Benchmark Structure

Each benchmark should ideally compare three implementations:

1. **Timely-dataflow**: The timely framework implementation
2. **Differential-dataflow**: The differential framework implementation  
3. **Hydroflow/dfir_rs**: The hydroflow implementation

This tri-way comparison helps validate performance characteristics across frameworks.

## Performance Considerations

### Compilation Time

Be mindful of compilation overhead:
- Avoid unnecessary dependencies
- Use feature flags to conditionally compile expensive code
- Consider build time impact on CI/CD

### Runtime Performance

- Benchmarks should complete in reasonable time (< 5 minutes each)
- Use sampling for long-running operations
- Consider memory usage, especially for data-intensive benchmarks

### Statistical Validity

- Run benchmarks multiple times to ensure consistency
- Document variance and outliers
- Use criterion's built-in statistical analysis

## Questions or Issues?

- Check existing benchmarks for examples
- Review the main repository documentation
- Open an issue for clarification or discussion

Thank you for contributing to our benchmarking efforts!
