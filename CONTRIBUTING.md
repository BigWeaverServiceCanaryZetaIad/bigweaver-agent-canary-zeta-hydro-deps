# Contributing to bigweaver-agent-canary-zeta-hydro-deps

Thank you for your interest in contributing to the benchmark suite! This document provides guidelines for contributing benchmarks and improvements to this repository.

## Table of Contents

- [Getting Started](#getting-started)
- [Repository Structure](#repository-structure)
- [Adding New Benchmarks](#adding-new-benchmarks)
- [Updating Existing Benchmarks](#updating-existing-benchmarks)
- [Testing](#testing)
- [Documentation](#documentation)
- [Pull Request Process](#pull-request-process)
- [Code Style](#code-style)
- [Benchmark Best Practices](#benchmark-best-practices)

## Getting Started

### Prerequisites

- Rust 1.70 or later
- Cargo
- Basic understanding of timely and differential dataflow
- Familiarity with Criterion.rs benchmarking

### Setup

1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd bigweaver-agent-canary-zeta-hydro-deps
   ```

2. Build the project:
   ```bash
   cargo build
   ```

3. Run the tests and benchmarks:
   ```bash
   cargo test
   cargo bench
   ```

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── Cargo.toml                  # Workspace configuration
├── README.md                   # Repository overview
├── BENCHMARKS.md              # Detailed benchmark documentation
├── CONTRIBUTING.md            # This file
├── compare_benchmarks.sh      # Comparison script
└── benches/                   # Benchmark crate
    ├── Cargo.toml             # Benchmark dependencies
    ├── README.md              # Benchmark overview
    └── benches/               # Benchmark implementations
        ├── arithmetic.rs      # Example benchmark
        ├── reachability.rs    # Example with data files
        ├── reachability_edges.txt
        └── ...
```

## Adding New Benchmarks

### Step 1: Create the Benchmark File

Create a new `.rs` file in `benches/benches/`:

```rust
use criterion::{Criterion, black_box, criterion_group, criterion_main};
use timely::dataflow::operators::*;

fn benchmark_my_feature(c: &mut Criterion) {
    c.bench_function("my_feature/timely", |b| {
        b.iter(|| {
            // Your timely implementation
        })
    });
    
    c.bench_function("my_feature/raw", |b| {
        b.iter(|| {
            // Baseline implementation
        })
    });
}

criterion_group!(my_feature_bench, benchmark_my_feature);
criterion_main!(my_feature_bench);
```

### Step 2: Register the Benchmark

Add the benchmark to `benches/Cargo.toml`:

```toml
[[bench]]
name = "my_feature"
harness = false
```

### Step 3: Add Dependencies

If your benchmark needs additional dependencies, add them to `benches/Cargo.toml`:

```toml
[dev-dependencies]
# Add your dependencies here
```

### Step 4: Document the Benchmark

Add a detailed description to `BENCHMARKS.md`:

```markdown
#### my_feature.rs

**Purpose**: Brief description of what this benchmark tests

**What it measures**:
- Specific aspect 1
- Specific aspect 2

**Implementations**:
- `my_feature/timely` - Timely implementation
- `my_feature/raw` - Baseline implementation

**How to run**:
\`\`\`bash
cargo bench --bench my_feature
\`\`\`
```

### Step 5: Test the Benchmark

```bash
# Verify it compiles
cargo build --benches

# Run your benchmark
cargo bench --bench my_feature

# Run a quick test
cargo bench --bench my_feature -- --quick
```

## Updating Existing Benchmarks

When updating existing benchmarks:

1. **Preserve comparability**: Don't change the fundamental operation being measured
2. **Document changes**: Update BENCHMARKS.md with any significant changes
3. **Save baselines**: Before major changes, save a baseline:
   ```bash
   cargo bench -- --save-baseline before-change
   ```
4. **Compare results**: After changes:
   ```bash
   cargo bench -- --baseline before-change
   ```

## Testing

### Running Tests

```bash
# Run all tests
cargo test

# Run specific benchmark (without full measurement)
cargo bench --bench arithmetic --profile-time 1
```

### Validation Checklist

Before submitting:
- [ ] Benchmark compiles without warnings
- [ ] Benchmark runs successfully
- [ ] Results are consistent across multiple runs
- [ ] Baseline implementations are included
- [ ] Documentation is updated
- [ ] Code follows style guidelines

## Documentation

### Required Documentation

For each benchmark, provide:

1. **In-code comments**: Explain non-obvious implementation details
2. **BENCHMARKS.md entry**: Detailed description and usage
3. **README.md update**: If adding new categories or significant changes

### Documentation Style

- Use clear, concise language
- Include code examples where appropriate
- Explain the "why" not just the "what"
- Link to relevant external documentation

## Pull Request Process

### Before Submitting

1. **Test thoroughly**:
   ```bash
   cargo test
   cargo bench
   cargo clippy -- -D warnings
   cargo fmt -- --check
   ```

2. **Update documentation**:
   - BENCHMARKS.md
   - README.md (if needed)
   - In-code comments

3. **Commit messages**: Follow conventional commits format:
   ```
   feat(benches): add new benchmark for feature X
   fix(arithmetic): correct data size calculation
   docs(benchmarks): update reachability documentation
   ```

### Pull Request Template

Use this template for your PR description:

```markdown
## Description
Brief description of changes

## Type of Change
- [ ] New benchmark
- [ ] Benchmark update
- [ ] Bug fix
- [ ] Documentation update
- [ ] Infrastructure/tooling

## Benchmarks Added/Modified
- benchmark_name: description

## Testing
- [ ] Benchmarks compile
- [ ] Benchmarks run successfully
- [ ] Results are consistent
- [ ] Documentation updated

## Performance Impact
Describe any performance changes or comparisons

## Checklist
- [ ] Code follows style guidelines
- [ ] Documentation updated
- [ ] Tests pass
- [ ] No new warnings
```

### Review Process

1. Automated checks will run (if CI is configured)
2. Maintainers will review the code
3. Address any feedback
4. Once approved, your PR will be merged

## Code Style

### Rust Style

Follow the Rust style guide and use rustfmt:

```bash
cargo fmt
```

### Benchmark-Specific Guidelines

1. **Use `black_box`**: Prevent compiler optimizations from skipping work:
   ```rust
   use criterion::black_box;
   
   b.iter(|| {
       let result = expensive_operation(black_box(input));
       black_box(result);
   });
   ```

2. **Configuration constants**: Define at the top of the file:
   ```rust
   const NUM_ITEMS: usize = 10_000;
   const NUM_ITERATIONS: usize = 100;
   ```

3. **Naming conventions**:
   - Benchmark functions: `benchmark_<feature>`
   - Criterion groups: `<feature>_bench`
   - Benchmark IDs: `<feature>/<implementation>`

4. **Data setup**: Use `iter_batched` for setup-heavy benchmarks:
   ```rust
   use criterion::BatchSize;
   
   b.iter_batched(
       || expensive_setup(),
       |data| benchmark_operation(data),
       BatchSize::LargeInput
   );
   ```

## Benchmark Best Practices

### Performance Testing

1. **Minimize setup in measurements**: Use `iter_batched` to exclude setup
2. **Appropriate data sizes**: Large enough to measure, small enough to complete
3. **Multiple implementations**: Always include baseline for comparison
4. **Realistic workloads**: Use representative data and patterns

### Statistical Validity

1. **Sufficient samples**: Let Criterion determine sample size
2. **Warm-up**: Criterion handles this automatically
3. **Outlier detection**: Criterion filters outliers by default
4. **Confidence intervals**: Check that CI is narrow enough

### Resource Management

1. **Memory leaks**: Ensure benchmarks don't leak memory
2. **Thread cleanup**: Join spawned threads
3. **File handles**: Close files properly
4. **Deterministic results**: Use seeded RNGs for reproducibility:
   ```rust
   use rand::{SeedableRng, rngs::StdRng};
   let mut rng = StdRng::seed_from_u64(42);
   ```

### Common Pitfalls to Avoid

1. **Dead code elimination**: Always use `black_box`
2. **Optimization differences**: Be aware of debug vs release builds
3. **Timing variability**: Run on consistent hardware
4. **Cache effects**: Consider cache warming for realistic results
5. **Async overhead**: Account for async runtime overhead in async benchmarks

## Relationship with Main Repository

This repository is designed to work alongside `bigweaver-agent-canary-hydro-zeta`:

### Coordination

- Keep benchmark patterns consistent with main repository
- Coordinate data formats and test data
- Maintain compatible benchmark naming schemes
- Document cross-repository comparisons

### When to Add Benchmarks Here vs Main Repository

**Add to this repository (bigweaver-agent-canary-zeta-hydro-deps):**
- Benchmarks using timely or differential-dataflow
- Performance comparisons with these frameworks
- Baseline implementations for comparison

**Add to main repository:**
- Benchmarks using Hydroflow (dfir_rs)
- Pure Hydroflow features
- Benchmarks without heavy dependencies

## Questions and Support

- **Issues**: Open an issue on the repository
- **Discussions**: Use GitHub discussions for questions
- **Documentation**: Check BENCHMARKS.md and README.md first

## License

By contributing, you agree that your contributions will be licensed under the same license as the project (Apache-2.0).

## Acknowledgments

Thank you for contributing to the benchmark suite! Your work helps improve the performance and reliability of dataflow systems.
