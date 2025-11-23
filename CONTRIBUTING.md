# Contributing to Hydro-Deps Benchmarks

Thank you for your interest in contributing to the Hydro benchmarking suite! This guide will help you understand how to add new benchmarks, improve existing ones, and maintain the repository.

## Getting Started

1. **Clone both repositories**:
   ```bash
   git clone <main-hydro-repo> bigweaver-agent-canary-hydro-zeta
   git clone <hydro-deps-repo> bigweaver-agent-canary-zeta-hydro-deps
   ```

2. **Verify the setup**:
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps
   cargo check --workspace
   ```

3. **Run existing benchmarks**:
   ```bash
   ./run_benchmarks.sh quick
   ```

## Adding a New Benchmark

### 1. Create the Benchmark File

Create a new file in `benches/benches/<benchmark_name>.rs`:

```rust
use criterion::{black_box, criterion_group, criterion_main, Criterion};

// Hydro implementation
fn hydro_implementation(c: &mut Criterion) {
    c.bench_function("hydro/<benchmark_name>", |b| {
        b.iter(|| {
            // Your Hydro implementation using dfir_rs
            // Use black_box() for values that shouldn't be optimized away
        });
    });
}

// Timely implementation (if applicable)
fn timely_implementation(c: &mut Criterion) {
    c.bench_function("timely/<benchmark_name>", |b| {
        b.iter(|| {
            // Your timely-dataflow implementation
        });
    });
}

// Differential implementation (if applicable)
fn differential_implementation(c: &mut Criterion) {
    c.bench_function("differential/<benchmark_name>", |b| {
        b.iter(|| {
            // Your differential-dataflow implementation
        });
    });
}

criterion_group!(
    benches,
    hydro_implementation,
    timely_implementation,
    // differential_implementation  // Uncomment if applicable
);
criterion_main!(benches);
```

### 2. Register the Benchmark

Add the benchmark to `benches/Cargo.toml`:

```toml
[[bench]]
name = "your_benchmark_name"
harness = false
```

### 3. Update Documentation

Add your benchmark to the following files:

**README.md**:
```markdown
- **your_benchmark_name** - Description of what it benchmarks
```

**QUICKSTART.md**:
Add to the appropriate category (timely, differential, or other)

### 4. Test Your Benchmark

```bash
# Run your benchmark
cargo bench -p benches --bench your_benchmark_name

# Verify it runs without errors
./run_benchmarks.sh your_benchmark_name
```

## Benchmark Best Practices

### Structure

1. **Separate Implementations**: Keep Hydro, timely, and differential implementations in separate functions
2. **Use black_box()**: Wrap values that shouldn't be optimized away
3. **Consistent Inputs**: Use the same input data across all implementations
4. **Meaningful Names**: Use descriptive names for benchmark functions

### Performance Considerations

1. **Warm-up**: Let Criterion handle warm-up automatically
2. **Sample Size**: Use default sample sizes unless you have specific needs
3. **Iteration Count**: Adjust if your benchmark is very fast or very slow
4. **Resource Cleanup**: Ensure resources are properly cleaned up between iterations

### Code Style

Follow the repository's code style:

```bash
# Format your code
cargo fmt --all

# Check for linting issues
cargo clippy --all-targets -- -D warnings
```

## Benchmark Categories

### Timely-Dataflow Benchmarks
Benchmarks that compare Hydro with timely-dataflow implementations:
- Data flow patterns
- Stream processing operations
- Basic transformations

### Differential-Dataflow Benchmarks
Benchmarks that compare Hydro with differential-dataflow:
- Incremental computations
- Join operations with updates
- Graph algorithms

### Standalone Benchmarks
Benchmarks that measure Hydro-specific features:
- Async operations
- Hydro-specific patterns
- Internal optimizations

## Adding Test Data

If your benchmark requires data files:

1. **Add the file** to `benches/benches/`:
   ```bash
   cp your_data.txt benches/benches/
   ```

2. **Document the source**:
   Add a comment in your benchmark file and in `benches/README.md`

3. **Keep files reasonable**:
   - Compress large files if possible
   - Use representative samples for large datasets
   - Document how to generate larger datasets

## Testing Your Changes

### Run Full Test Suite

```bash
# Check compilation
cargo check --workspace

# Run all benchmarks (takes time!)
cargo bench -p benches

# Or run quick validation
./run_benchmarks.sh quick
```

### Verify Documentation

```bash
# Check that docs are up to date
grep -r "your_benchmark_name" README.md QUICKSTART.md benches/README.md
```

### Compare Results

```bash
# Save baseline before changes
cargo bench -p benches -- --save-baseline before

# Make your changes

# Compare after changes
cargo bench -p benches -- --baseline before
```

## Code Review Checklist

Before submitting your contribution:

- [ ] Benchmark compiles without warnings
- [ ] Benchmark runs successfully
- [ ] Code follows formatting guidelines (`cargo fmt`)
- [ ] No linting issues (`cargo clippy`)
- [ ] Documentation updated (README.md, QUICKSTART.md, benches/README.md)
- [ ] Benchmark registered in Cargo.toml
- [ ] Meaningful commit message following convention
- [ ] Results make sense (no surprising outliers)

## Commit Message Format

Follow the Conventional Commits specification:

```
type(scope): description

[optional body]

[optional footer]
```

**Types**:
- `feat`: New benchmark or feature
- `fix`: Bug fix in existing benchmark
- `docs`: Documentation changes
- `refactor`: Code refactoring without behavior change
- `perf`: Performance improvements
- `test`: Adding or updating tests
- `chore`: Maintenance tasks

**Examples**:
```
feat(benches): add hash_aggregate benchmark

Add new benchmark comparing hash aggregation performance
between Hydro and timely-dataflow.

The benchmark measures aggregation of 1M records with various
group cardinalities.
```

```
fix(reachability): correct edge loading logic

The previous implementation was loading edges incorrectly,
leading to inaccurate comparisons.
```

## Pull Request Process

1. **Create a branch**:
   ```bash
   git checkout -b feat/your-benchmark-name
   ```

2. **Make your changes** following the guidelines above

3. **Test thoroughly**:
   ```bash
   ./run_benchmarks.sh your_benchmark_name
   ```

4. **Commit with proper message**:
   ```bash
   git add .
   git commit -m "feat(benches): add your_benchmark_name"
   ```

5. **Push and create PR**:
   ```bash
   git push origin feat/your-benchmark-name
   ```

6. **PR Description** should include:
   - Overview of what the benchmark measures
   - Why this benchmark is valuable
   - Sample results or findings
   - Any special considerations

## Common Issues and Solutions

### Issue: Benchmark times out

**Solution**: Reduce the input size or adjust Criterion configuration:
```rust
c.bench_function("name", |b| {
    b.iter_batched(
        || setup_data(),
        |data| run_benchmark(data),
        criterion::BatchSize::LargeInput
    );
});
```

### Issue: Results are inconsistent

**Solution**: 
- Ensure deterministic inputs (fixed seeds for random data)
- Increase sample size
- Check for external factors (CPU throttling, background processes)

### Issue: Dependency conflicts

**Solution**:
```bash
cargo clean
cargo update
cargo check --workspace
```

### Issue: Path dependency not found

**Solution**: Verify relative path to main repository:
```bash
ls -la ../../bigweaver-agent-canary-hydro-zeta/dfir_rs
```

## Performance Optimization Tips

1. **Profile before optimizing**: Use profiling tools to identify bottlenecks
2. **Compare fairly**: Ensure all implementations do the same work
3. **Document assumptions**: Note any simplifications or limitations
4. **Test edge cases**: Include small and large inputs
5. **Measure consistently**: Run benchmarks on the same hardware

## Questions or Help

If you have questions or need help:

1. Check existing benchmarks for examples
2. Review QUICKSTART.md for setup issues
3. Read README.md for architectural context
4. Review the main repository documentation

## Code of Conduct

- Be respectful and constructive
- Focus on improving the benchmarks
- Share knowledge and help others
- Follow established patterns and conventions

## License

By contributing, you agree that your contributions will be licensed under the Apache-2.0 license, matching the project's license.

---

Thank you for contributing to making Hydro better! 🚀
