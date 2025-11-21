# Contributing to Hydro Benchmarks

Thank you for your interest in contributing to the Hydro benchmarks repository! This document provides guidelines for contributing new benchmarks, improvements, and fixes.

## Table of Contents

- [Getting Started](#getting-started)
- [Adding New Benchmarks](#adding-new-benchmarks)
- [Improving Existing Benchmarks](#improving-existing-benchmarks)
- [Documentation](#documentation)
- [Testing](#testing)
- [Code Style](#code-style)
- [Submitting Changes](#submitting-changes)

## Getting Started

### Prerequisites

1. Rust toolchain (1.70.0 or later)
2. Git
3. Familiarity with Criterion.rs benchmarking
4. Understanding of Hydro, Timely, or Differential Dataflow

### Setup

```bash
git clone <repository-url>
cd bigweaver-agent-canary-zeta-hydro-deps
cargo build --release -p benches
cargo bench -p benches --bench identity  # Verify setup
```

## Adding New Benchmarks

### 1. Choose a Benchmark Purpose

Good benchmarks measure:
- **Specific patterns**: Fan-in, fan-out, diamond, etc.
- **Specific operations**: Joins, aggregations, filters
- **Algorithms**: Graph algorithms, string processing, numerical computation
- **Framework comparisons**: Hydro vs. Timely vs. Differential

### 2. Create Benchmark File

Create a new file in `benches/benches/`:

```bash
cd benches/benches
touch my_new_benchmark.rs
```

### 3. Benchmark Template

Use this template as a starting point:

```rust
use criterion::{Criterion, criterion_group, criterion_main, black_box};
use dfir_rs::dfir_syntax;
use dfir_rs::scheduled::graph_ext::GraphExt;

// Constants for benchmark configuration
const NUM_ELEMENTS: usize = 1_000_000;

/// Hydro/DFIR variant
fn benchmark_hydro(c: &mut Criterion) {
    c.bench_function("my_benchmark/hydro", |b| {
        b.iter(|| {
            let mut df = dfir_syntax! {
                source_iter(0..NUM_ELEMENTS)
                    -> map(|x| black_box(x * 2))
                    -> for_each(|x| { black_box(x); });
            };
            df.run_available();
        });
    });
}

/// Timely Dataflow variant (if applicable)
fn benchmark_timely(c: &mut Criterion) {
    use timely::dataflow::operators::{ToStream, Map, Inspect};
    
    c.bench_function("my_benchmark/timely", |b| {
        b.iter(|| {
            timely::execute_directly(move |worker| {
                worker.dataflow::<(), _, _>(|scope| {
                    (0..NUM_ELEMENTS)
                        .to_stream(scope)
                        .map(|x| black_box(x * 2))
                        .inspect(|x| { black_box(x); });
                });
            });
        });
    });
}

/// Baseline Rust variant (if applicable)
fn benchmark_baseline(c: &mut Criterion) {
    c.bench_function("my_benchmark/baseline", |b| {
        b.iter(|| {
            for x in 0..NUM_ELEMENTS {
                let result = black_box(x * 2);
                black_box(result);
            }
        });
    });
}

// Register benchmark group
criterion_group!(
    benches,
    benchmark_hydro,
    benchmark_timely,
    benchmark_baseline
);
criterion_main!(benches);
```

### 4. Update Cargo.toml

Add your benchmark to `benches/Cargo.toml`:

```toml
[[bench]]
name = "my_new_benchmark"
harness = false
```

### 5. Test Your Benchmark

```bash
# Compile check
cargo check -p benches --bench my_new_benchmark

# Run in test mode (fast)
cargo bench -p benches --bench my_new_benchmark -- --test

# Run full benchmark
cargo bench -p benches --bench my_new_benchmark
```

### 6. Document Your Benchmark

Add a section to `README.md` describing:
- Purpose of the benchmark
- What it measures
- Which frameworks it compares
- Expected performance characteristics
- Any special data requirements

## Improving Existing Benchmarks

### Types of Improvements

1. **Performance improvements**: Optimize benchmark code (not framework code)
2. **Additional variants**: Add more framework comparisons
3. **Better measurements**: Improve what is being measured
4. **Code clarity**: Make benchmark intent clearer
5. **Parameter tuning**: Adjust sizes for better measurement

### Guidelines for Changes

1. **Preserve comparability**: Changes should not break historical comparisons
2. **Document changes**: Explain why changes improve the benchmark
3. **Maintain variants**: Keep all existing framework variants working
4. **Test thoroughly**: Verify all variants still produce valid results

### Example Improvement

Before:
```rust
c.bench_function("identity/hydro", |b| {
    b.iter(|| {
        // Implementation
    });
});
```

After:
```rust
c.bench_function("identity/hydro", |b| {
    b.iter_batched(
        || setup_data(),  // Setup runs outside timing
        |data| {
            // Only this is timed
        },
        BatchSize::SmallInput,
    );
});
```

## Documentation

### Required Documentation

When adding or modifying benchmarks:

1. **Inline comments**: Explain complex logic
2. **Function docs**: Document benchmark functions
3. **README updates**: Update benchmark descriptions
4. **PERFORMANCE_COMPARISON.md**: Update if comparison methodology changes

### Documentation Template

```rust
/// Benchmarks [specific operation/pattern].
///
/// This benchmark measures [what is being measured] by [how it measures it].
///
/// # Variants
/// - `hydro`: [Description of Hydro variant]
/// - `timely`: [Description of Timely variant]
/// - `baseline`: [Description of baseline variant]
///
/// # Expected Results
/// [What performance characteristics to expect]
///
/// # Data
/// Uses [description of test data]
fn benchmark_my_operation(c: &mut Criterion) {
    // Implementation
}
```

## Testing

### Verification Steps

Before submitting:

1. **Compilation**: `cargo check -p benches`
2. **Test mode**: `cargo bench -p benches --bench my_benchmark -- --test`
3. **Full run**: `cargo bench -p benches --bench my_benchmark`
4. **All benchmarks**: `cargo bench -p benches`

### Validation

Ensure benchmarks:
- Produce deterministic results (given same input)
- Complete without panics
- Generate HTML reports
- Show reasonable performance characteristics

### Correctness Testing

For complex benchmarks, add validation:

```rust
fn validate_results() {
    let result = run_benchmark_algorithm();
    let expected = load_expected_results();
    assert_eq!(result, expected, "Algorithm produced incorrect results");
}

#[test]
fn test_benchmark_correctness() {
    validate_results();
}
```

## Code Style

### Rust Style

Follow standard Rust conventions:
- Use `rustfmt`: `cargo fmt`
- Check with `clippy`: `cargo clippy`
- Follow workspace lints

### Benchmark-Specific Style

1. **Naming**: Use descriptive names that indicate what is measured
   ```rust
   // Good
   fn benchmark_symmetric_hash_join_hydro(c: &mut Criterion)
   
   // Less clear
   fn bench1(c: &mut Criterion)
   ```

2. **Constants**: Define sizes and parameters as constants
   ```rust
   const NUM_ELEMENTS: usize = 1_000_000;
   const NUM_ITERATIONS: usize = 100;
   ```

3. **Grouping**: Use `BenchmarkGroup` for related variants
   ```rust
   let mut group = c.benchmark_group("my_benchmark");
   group.bench_function("hydro", |b| { /* ... */ });
   group.bench_function("timely", |b| { /* ... */ });
   group.finish();
   ```

4. **Black box**: Always use `black_box` to prevent optimization
   ```rust
   use criterion::black_box;
   
   let result = black_box(compute_value());
   black_box(result);
   ```

## Submitting Changes

### Workflow

1. **Fork the repository**
2. **Create a branch**: `git checkout -b feature/my-new-benchmark`
3. **Make changes**: Follow guidelines above
4. **Test thoroughly**: Run verification checklist
5. **Commit**: Use clear, descriptive commit messages
6. **Push**: `git push origin feature/my-new-benchmark`
7. **Create Pull Request**: Include description of changes

### Commit Messages

Follow conventional commit format:

```
feat(benches): add benchmark for [operation]

- Implements Hydro, Timely, and baseline variants
- Measures [what it measures]
- Includes test data and validation

Related to: #123
```

Types:
- `feat`: New benchmark or feature
- `fix`: Bug fix in existing benchmark
- `docs`: Documentation changes
- `perf`: Performance improvements
- `refactor`: Code restructuring
- `test`: Test improvements

### Pull Request Template

```markdown
## Description
[Brief description of changes]

## Motivation
[Why this change is needed]

## Changes Made
- [Change 1]
- [Change 2]

## Benchmarks Added/Modified
- [Benchmark name]: [What it measures]

## Testing Performed
- [ ] Compilation successful
- [ ] Test mode passed
- [ ] Full benchmark run completed
- [ ] HTML reports generated
- [ ] All variants functional

## Documentation Updated
- [ ] README.md
- [ ] PERFORMANCE_COMPARISON.md (if applicable)
- [ ] Inline documentation
- [ ] MIGRATION.md (if applicable)

## Performance Results
[Optional: Include benchmark results showing impact]
```

## Best Practices

### Benchmark Design

1. **Measure one thing**: Each benchmark should focus on one aspect
2. **Isolate timing**: Only time the operation of interest
3. **Realistic workloads**: Use realistic data sizes and patterns
4. **Multiple variants**: Compare multiple approaches when possible
5. **Reproducibility**: Ensure results are reproducible

### Performance

1. **Warm-up**: Let Criterion handle warm-up
2. **Iterations**: Use sufficient iterations for statistical significance
3. **Throughput**: Report throughput when applicable
   ```rust
   group.throughput(Throughput::Elements(NUM_ELEMENTS as u64));
   ```

### Data Management

1. **Embed small data**: Use `include_bytes!` for test data
2. **Generate large data**: Generate large datasets programmatically
3. **Validate data**: Ensure test data is correct and representative

## Review Process

Contributions will be reviewed for:

1. **Correctness**: Benchmarks measure what they claim
2. **Performance**: Benchmarks run in reasonable time
3. **Code quality**: Clean, well-documented code
4. **Consistency**: Follows existing patterns and style
5. **Documentation**: Adequate documentation provided

## Getting Help

- **Questions**: Open an issue with `question` label
- **Discussion**: Use pull request comments for specific changes
- **Documentation**: Check QUICKSTART.md and PERFORMANCE_COMPARISON.md
- **Examples**: Look at existing benchmarks for patterns

## Resources

- [Criterion.rs Book](https://bheisler.github.io/criterion.rs/book/)
- [Hydro Documentation](https://github.com/hydro-project/hydro)
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)
- [Rust Performance Book](https://nnethercote.github.io/perf-book/)

## License

By contributing, you agree that your contributions will be licensed under the Apache-2.0 license.

Thank you for contributing to Hydro benchmarks! 🚀
