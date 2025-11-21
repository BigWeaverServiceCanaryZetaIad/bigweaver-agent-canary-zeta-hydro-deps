# Contributing to Timely and Differential Dataflow Benchmarks

Thank you for your interest in contributing! This document provides guidelines for contributing benchmarks and improvements.

## Getting Started

1. Fork the repository
2. Clone your fork
3. Create a feature branch
4. Make your changes
5. Submit a pull request

## Development Setup

### Prerequisites

- Rust 1.70 or later
- Cargo
- Git

### Installation

```bash
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps
cargo build --all
cargo test --all
```

### Running Benchmarks Locally

```bash
# Quick check during development
make bench-quick

# Full benchmark run
make bench

# Specific package
make bench-timely
```

## Adding New Benchmarks

### Benchmark Structure

Each benchmark should:

1. **Measure one specific operation**
2. **Use appropriate data sizes**
3. **Include documentation**
4. **Follow naming conventions**

### Example: Adding a New Timely Benchmark

1. Create the benchmark file:

```rust
// timely-benchmarks/benches/my_new_benchmark.rs

use criterion::{BenchmarkId, Criterion, criterion_group, criterion_main};
use timely::dataflow::operators::{ToStream, Inspect};

fn my_benchmark(c: &mut Criterion) {
    let mut group = c.benchmark_group("timely/my_operation");
    
    for size in [1000, 10000, 100000].iter() {
        group.bench_with_input(
            BenchmarkId::from_parameter(size),
            size,
            |b, &size| {
                b.iter(|| {
                    timely::example(|scope| {
                        (0..size).to_stream(scope)
                            .inspect(|_| {});
                    });
                });
            },
        );
    }
    
    group.finish();
}

criterion_group!(benches, my_benchmark);
criterion_main!(benches);
```

2. Register in `Cargo.toml`:

```toml
[[bench]]
name = "my_new_benchmark"
harness = false
```

3. Document in README:

Add description to `timely-benchmarks/README.md`

4. Test the benchmark:

```bash
cargo bench --package timely-benchmarks --bench my_new_benchmark
```

### Example: Adding a New Differential Benchmark

Follow the same structure, but use differential-dataflow operators:

```rust
// differential-benchmarks/benches/my_new_benchmark.rs

use criterion::{BenchmarkId, Criterion, criterion_group, criterion_main};
use differential_dataflow::input::InputSession;

fn my_benchmark(c: &mut Criterion) {
    let mut group = c.benchmark_group("differential/my_operation");
    
    for size in [1000, 10000, 100000].iter() {
        group.bench_with_input(
            BenchmarkId::from_parameter(size),
            size,
            |b, &size| {
                b.iter(|| {
                    timely::execute_directly(move |worker| {
                        let mut input = InputSession::new();
                        
                        worker.dataflow::<usize, _, _>(|scope| {
                            input.to_collection(scope);
                        });
                        
                        for i in 0..size {
                            input.insert(i);
                        }
                        input.advance_to(1);
                        input.flush();
                        
                        worker.step_while(|| worker.pending_work());
                    });
                });
            },
        );
    }
    
    group.finish();
}

criterion_group!(benches, my_benchmark);
criterion_main!(benches);
```

## Code Style

### Formatting

Use `rustfmt` for consistent formatting:

```bash
cargo fmt --all
```

### Linting

Run clippy to catch common issues:

```bash
cargo clippy --all-targets --all-features -- -D warnings
```

### Documentation

- Add doc comments to public functions
- Include examples where appropriate
- Update README files when adding new benchmarks

## Benchmark Guidelines

### DO ✅

- **Use appropriate sample sizes**: 1K-100K for most operations
- **Test multiple scenarios**: Vary parameters to understand behavior
- **Document what you're measuring**: Clear comments explaining the benchmark
- **Use `black_box`**: Prevent compiler optimizations that skew results
- **Include warm-up**: Let JIT compilation settle
- **Test incrementally**: For differential benchmarks, test both initial and update scenarios

### DON'T ❌

- **Mix concerns**: Don't measure data generation with operation performance
- **Use huge datasets**: Keep benchmarks runnable in CI (< 1 minute each)
- **Ignore variance**: Check for consistent results across runs
- **Optimize for benchmarks**: Write realistic scenarios, not artificial best-cases
- **Skip documentation**: Always explain what's being measured

### Example: Good Benchmark

```rust
fn good_benchmark(c: &mut Criterion) {
    let mut group = c.benchmark_group("timely/filter");
    
    // Test varying sizes
    for size in [1000, 10000, 100000].iter() {
        group.bench_with_input(
            BenchmarkId::new("selective", size),
            size,
            |b, &size| {
                b.iter(|| {
                    timely::example(|scope| {
                        (0..size).to_stream(scope)
                            // Use black_box to prevent optimization
                            .filter(|x| black_box(*x % 2 == 0))
                            .inspect(|_| {});
                    });
                });
            },
        );
    }
    
    group.finish();
}
```

### Example: Bad Benchmark

```rust
// ❌ Bad: Mixing data generation with measurement
fn bad_benchmark(c: &mut Criterion) {
    c.bench_function("bad_filter", |b| {
        b.iter(|| {
            // Data generation shouldn't be measured!
            let data = generate_large_dataset();
            
            timely::example(|scope| {
                data.to_stream(scope)
                    .filter(|x| x % 2 == 0)  // No black_box!
                    .inspect(|_| {});
            });
        });
    });
}
```

## Testing

### Unit Tests

Add unit tests for utility functions:

```rust
#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_my_utility() {
        let result = my_utility_function();
        assert_eq!(result, expected_value);
    }
}
```

### Integration Tests

Ensure benchmarks actually run:

```bash
# Test that benchmarks compile and run
cargo bench --all -- --quick
```

## Pull Request Process

1. **Create a feature branch**
   ```bash
   git checkout -b feature/my-new-benchmark
   ```

2. **Make your changes**
   - Add benchmark code
   - Add tests
   - Update documentation

3. **Verify your changes**
   ```bash
   make check          # Format and lint
   make test           # Run tests
   make bench-quick    # Verify benchmarks work
   ```

4. **Commit with clear messages**
   ```bash
   git commit -m "Add benchmark for XYZ operation
   
   - Adds new benchmark measuring XYZ
   - Tests scenarios A, B, and C
   - Updates documentation"
   ```

5. **Push and create PR**
   ```bash
   git push origin feature/my-new-benchmark
   ```

6. **PR Description Template**
   ```markdown
   ## Description
   Brief description of what this PR does.
   
   ## Type of Change
   - [ ] New benchmark
   - [ ] Bug fix
   - [ ] Performance improvement
   - [ ] Documentation update
   
   ## Testing
   - [ ] Ran `make test`
   - [ ] Ran `make check`
   - [ ] Ran benchmarks locally
   
   ## Benchmark Results
   Include sample results if applicable.
   
   ## Checklist
   - [ ] Code follows style guidelines
   - [ ] Documentation updated
   - [ ] Tests added/updated
   - [ ] Benchmarks run successfully
   ```

## Review Process

- PRs require one approval
- CI must pass (tests, lints, benchmarks)
- Maintainers may request changes
- Be responsive to feedback

## Performance Considerations

### Memory Usage

Monitor memory usage for large benchmarks:

```bash
/usr/bin/time -v cargo bench --package differential-benchmarks --bench arrange
```

### Execution Time

Keep individual benchmarks under 30 seconds:

```rust
// Configure for faster execution in CI
fn custom_criterion() -> Criterion {
    Criterion::default()
        .sample_size(10)  // Reduced for CI
        .measurement_time(Duration::from_secs(5))
}
```

## Documentation Standards

### Code Comments

```rust
/// Benchmarks the performance of join operations.
///
/// Tests various scenarios:
/// - Different input sizes
/// - Various key selectivities
/// - Different worker counts
///
/// # Parameters
/// - `size`: Number of elements in each input collection
/// - `num_keys`: Number of unique keys (affects join size)
fn join_benchmark(c: &mut Criterion) {
    // Implementation
}
```

### README Updates

When adding benchmarks, update:

1. Main README.md (if new category)
2. Package README.md (benchmark description)
3. COMPARISON.md (if relevant for comparisons)

## Community

- Be respectful and constructive
- Ask questions if unsure
- Share benchmark results and insights
- Help review others' contributions

## Resources

- [Criterion.rs Documentation](https://bheisler.github.io/criterion.rs/book/)
- [Timely Dataflow Docs](https://docs.rs/timely/)
- [Differential Dataflow Docs](https://docs.rs/differential-dataflow/)
- [Rust Performance Book](https://nnethercote.github.io/perf-book/)

## License

By contributing, you agree that your contributions will be licensed under the Apache-2.0 License.

## Questions?

- Open an issue for questions
- Tag maintainers if urgent
- Check existing issues/PRs for similar topics

Thank you for contributing! 🎉
