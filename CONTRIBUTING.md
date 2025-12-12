# Contributing to Hydro External Framework Benchmarks

Thank you for your interest in contributing to the Hydro external framework benchmarks! This document provides guidelines for adding new benchmarks and improving existing ones.

## Getting Started

1. **Fork and clone** this repository
2. **Set up your development environment**:
   ```bash
   rustup update
   cd bigweaver-agent-canary-zeta-hydro-deps
   cargo build --release -p hydro-timely-benchmarks
   ```
3. **Verify existing benchmarks run**:
   ```bash
   cargo bench -p hydro-timely-benchmarks --bench identity
   ```

## Adding New Benchmarks

### Step 1: Create Benchmark File

Create a new file in `benches/benches/`:

```bash
touch benches/benches/my_new_benchmark.rs
```

### Step 2: Implement Benchmark

Use this template:

```rust
use criterion::{black_box, criterion_group, criterion_main, Criterion, BenchmarkId};
use dfir_rs::builder::prelude::*;
use differential_dataflow::input::Input;
use differential_dataflow::operators::*;
use timely::dataflow::operators::*;

// DFIR implementation
fn my_operation_dfir(input_size: usize) {
    let mut df = dfir_rs::dfir_syntax! {
        // Your DFIR implementation
    };
    df.run_available();
}

// Timely implementation
fn my_operation_timely(input_size: usize) {
    timely::execute_directly(move |worker| {
        // Your Timely implementation
    });
}

// Differential implementation
fn my_operation_differential(input_size: usize) {
    timely::execute_directly(move |worker| {
        worker.dataflow::<(),_,_>(|scope| {
            // Your Differential implementation
        });
    });
}

// Benchmark group
fn benchmark_my_operation(c: &mut Criterion) {
    let mut group = c.benchmark_group("my_operation");
    
    for size in [100, 1_000, 10_000] {
        group.bench_with_input(BenchmarkId::new("dfir", size), &size, |b, &s| {
            b.iter(|| my_operation_dfir(black_box(s)));
        });
        
        group.bench_with_input(BenchmarkId::new("timely", size), &size, |b, &s| {
            b.iter(|| my_operation_timely(black_box(s)));
        });
        
        group.bench_with_input(BenchmarkId::new("differential", size), &size, |b, &s| {
            b.iter(|| my_operation_differential(black_box(s)));
        });
    }
    
    group.finish();
}

criterion_group!(benches, benchmark_my_operation);
criterion_main!(benches);
```

### Step 3: Register Benchmark

Add to `benches/Cargo.toml`:

```toml
[[bench]]
name = "my_new_benchmark"
harness = false
```

### Step 4: Test Benchmark

```bash
cargo bench -p hydro-timely-benchmarks --bench my_new_benchmark
```

### Step 5: Document Benchmark

Add documentation to `benches/README.md`:

```markdown
#### my_new_benchmark.rs
Description of what this benchmark measures.

**Frameworks tested**: DFIR, Timely, Differential

**Key metrics**: What metrics are important

**Use case**: When to use this benchmark
```

## Benchmark Best Practices

### 1. Correctness First

Ensure all framework implementations produce **identical results**:

```rust
#[test]
fn test_correctness() {
    let dfir_result = my_operation_dfir(100);
    let timely_result = my_operation_timely(100);
    let diff_result = my_operation_differential(100);
    
    assert_eq!(dfir_result, timely_result);
    assert_eq!(timely_result, diff_result);
}
```

### 2. Use black_box

Prevent compiler optimizations from eliminating benchmarked code:

```rust
use criterion::black_box;

b.iter(|| my_operation(black_box(input)));
```

### 3. Appropriate Input Sizes

Choose input sizes that:
- **Reflect real workloads** (not too small or too large)
- **Show scaling behavior** (use multiple sizes)
- **Complete in reasonable time** (< 10 seconds per iteration)

### 4. Minimize Setup Cost

Separate setup from measured code:

```rust
// GOOD: Setup outside iter()
let data = generate_test_data(size);
b.iter(|| process_data(black_box(&data)));

// BAD: Setup inside iter()
b.iter(|| {
    let data = generate_test_data(size);  // Measured!
    process_data(black_box(&data))
});
```

### 5. Statistical Rigor

Use sufficient samples for reliable results:

```rust
let mut group = c.benchmark_group("my_benchmark");
group.sample_size(100);              // More samples = better statistics
group.measurement_time(Duration::from_secs(10));  // Longer = more accurate
```

### 6. Consistent Naming

Follow naming conventions:
- **File names**: `snake_case.rs`
- **Benchmark functions**: `benchmark_<operation>`
- **Benchmark IDs**: Framework name (e.g., "dfir", "timely", "differential")

## Code Style

### Formatting

Use `rustfmt` for consistent formatting:

```bash
cargo fmt --all
```

Configuration is in `rustfmt.toml`.

### Linting

Run `clippy` to catch common issues:

```bash
cargo clippy --all-targets
```

Configuration is in `clippy.toml`.

### Comments

Add comments for:
- **Complex algorithms**: Explain the approach
- **Performance considerations**: Why certain choices were made
- **Framework-specific patterns**: Differences between implementations

Example:

```rust
// Timely requires explicit progress tracking for iterative algorithms.
// We use a loop with probe() to detect completion.
while probe.less_than(input.time()) {
    worker.step();
}
```

## Testing

### Unit Tests

Add tests for helper functions:

```rust
#[cfg(test)]
mod tests {
    use super::*;
    
    #[test]
    fn test_data_generation() {
        let data = generate_test_data(100);
        assert_eq!(data.len(), 100);
    }
}
```

### Integration Tests

Verify benchmarks run successfully:

```bash
cargo test -p hydro-timely-benchmarks
```

### Correctness Tests

Validate results match across frameworks:

```rust
#[test]
fn test_dfir_timely_equivalence() {
    let dfir_output = run_dfir_version();
    let timely_output = run_timely_version();
    assert_eq!(dfir_output, timely_output);
}
```

## Pull Request Guidelines

### Before Submitting

1. **Run all benchmarks**: `cargo bench -p hydro-timely-benchmarks`
2. **Check formatting**: `cargo fmt --all --check`
3. **Run linter**: `cargo clippy --all-targets`
4. **Update documentation**: Add benchmark to README.md
5. **Test on clean checkout**: Verify it works from scratch

### PR Description Template

```markdown
## Summary
Brief description of the new benchmark or changes.

## Benchmark Details
- **Name**: `my_new_benchmark`
- **Measures**: What aspect of performance
- **Frameworks**: DFIR, Timely, Differential
- **Input sizes**: 100, 1K, 10K, 100K

## Results Preview
Brief summary of performance characteristics observed.

## Checklist
- [ ] Benchmark runs successfully
- [ ] All frameworks produce identical results
- [ ] Documentation updated (README.md)
- [ ] Code formatted (cargo fmt)
- [ ] Lints pass (cargo clippy)
- [ ] Tests pass (cargo test)
```

### Review Process

PRs will be reviewed for:
1. **Correctness**: Do implementations match specifications?
2. **Performance validity**: Are measurements meaningful?
3. **Code quality**: Is code clear and maintainable?
4. **Documentation**: Is purpose and usage clear?

## Improving Existing Benchmarks

### Common Improvements

1. **Add input size variations**
2. **Optimize implementations** (ensure fair comparison)
3. **Add result validation**
4. **Improve documentation**
5. **Fix benchmark methodology issues**

### Example: Adding Input Sizes

```rust
// Before: Single input size
fn benchmark_operation(c: &mut Criterion) {
    c.bench_function("operation", |b| {
        b.iter(|| run_operation(1000));
    });
}

// After: Multiple input sizes
fn benchmark_operation(c: &mut Criterion) {
    let mut group = c.benchmark_group("operation");
    
    for size in [100, 1_000, 10_000, 100_000] {
        group.bench_with_input(BenchmarkId::from_parameter(size), &size, |b, &s| {
            b.iter(|| run_operation(black_box(s)));
        });
    }
    
    group.finish();
}
```

## Data Files

### Adding Test Data

When benchmarks need data files:

1. **Place in** `benches/benches/`
2. **Use relative paths**: `include_str!("words_alpha.txt")`
3. **Document source**: Add comment with origin URL
4. **Consider size**: Large files should be generated, not committed

Example:

```rust
// words_alpha.txt from https://github.com/dwyl/english-words
const WORDS: &str = include_str!("words_alpha.txt");

fn benchmark_with_words(c: &mut Criterion) {
    let words: Vec<&str> = WORDS.lines().collect();
    // Use words in benchmark
}
```

## Performance Considerations

### Framework-Specific Optimizations

When implementing benchmarks:

- **DFIR**: Leverage Hydro's compilation model
- **Timely**: Use appropriate progress tracking
- **Differential**: Batch updates when possible

### Fair Comparisons

Ensure equivalence:
- **Same algorithm**: Don't compare bubble sort vs quicksort
- **Same data structures**: Use comparable structures
- **Same computational work**: Avoid unnecessary work in any implementation

### Avoiding Pitfalls

Common mistakes:

❌ **Dead code elimination**:
```rust
b.iter(|| expensive_computation());  // Result unused!
```

✅ **Proper measurement**:
```rust
b.iter(|| black_box(expensive_computation()));
```

---

❌ **Including setup in measurement**:
```rust
b.iter(|| {
    let data = setup();  // Measured!
    process(data)
});
```

✅ **Setup outside measurement**:
```rust
let data = setup();
b.iter(|| process(black_box(&data)));
```

---

❌ **Incorrect framework usage**:
```rust
// Missing progress tracking in Timely
while !done {
    // Infinite loop!
}
```

✅ **Proper framework usage**:
```rust
while probe.less_than(input.time()) {
    worker.step();
}
```

## Getting Help

### Resources

- **Criterion.rs Guide**: https://bheisler.github.io/criterion.rs/book/
- **Rust Performance Book**: https://nnethercote.github.io/perf-book/
- **Timely Docs**: https://github.com/TimelyDataflow/timely-dataflow
- **Differential Docs**: https://github.com/TimelyDataflow/differential-dataflow

### Questions

For questions about:
- **DFIR/Hydro**: Open issue in main Hydro repository
- **Benchmarks**: Open issue in this repository
- **Timely/Differential**: Refer to respective repositories

## Code of Conduct

Please be respectful and constructive in all interactions. We're all here to improve Hydro and advance dataflow systems research.

## License

By contributing, you agree that your contributions will be licensed under the Apache-2.0 license.

---

Thank you for contributing to Hydro benchmarks! 🚀
