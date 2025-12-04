# Contributing to bigweaver-agent-canary-zeta-hydro-deps

Thank you for contributing to the Hydro benchmarks repository! This guide will help you understand how to add and maintain benchmarks.

## 📋 Overview

This repository contains performance benchmarks that depend on `timely` and `differential-dataflow` packages. These benchmarks were separated from the main repository to:

- Reduce build times for the main repository
- Isolate heavy dependencies
- Maintain ability to run performance comparisons
- Allow independent versioning of benchmark code

## 🎯 When to Add Benchmarks Here

Add benchmarks to this repository when they:

- Use `timely` or `differential-dataflow` directly
- Measure performance of Hydro features that interact with these frameworks
- Require the heavy dependencies that would slow down main repository builds

For benchmarks that don't use these dependencies, add them to the main repository instead.

## 🔧 Adding a New Benchmark

### Step 1: Create the Benchmark File

Create a new file in `benches/benches/<benchmark_name>.rs`:

```rust
use criterion::{Criterion, criterion_group, criterion_main, black_box};
use dfir_rs::dfir_syntax;
// Add timely or differential-dataflow imports as needed

fn my_benchmark(c: &mut Criterion) {
    c.bench_function("my_benchmark_name", |b| {
        b.iter(|| {
            // Your benchmark code here
            black_box(/* your code */);
        });
    });
}

criterion_group!(benches, my_benchmark);
criterion_main!(benches);
```

### Step 2: Update Cargo.toml

Add your benchmark to `benches/Cargo.toml`:

```toml
[[bench]]
name = "my_benchmark"
harness = false
```

### Step 3: Test Your Benchmark

Run your benchmark to ensure it works:

```bash
cd benches
cargo bench --bench my_benchmark
```

### Step 4: Update Documentation

Update the following files:

1. **benches/README.md**: Add your benchmark to the appropriate category
2. **README.md** (root): Add your benchmark to the list with a brief description

## 📊 Benchmark Best Practices

### Performance Testing

- Use `black_box()` to prevent compiler optimizations from eliminating your code
- Ensure benchmarks are deterministic when possible
- Use appropriate sample sizes for statistical significance
- Consider warm-up iterations for JIT compilation

### Code Quality

- Follow the existing code style and conventions
- Add comments for complex benchmark logic
- Use meaningful variable and function names
- Keep benchmarks focused on a single operation or pattern

### Data Files

If your benchmark requires data files:

1. Place them in `benches/benches/` directory
2. Use `include_bytes!()` or `include_str!()` to embed them
3. Document the source and format in comments
4. Update the README to mention the data file

## 🔄 Maintaining Performance Comparisons

### Comparing Across Versions

To ensure benchmarks remain comparable across main repository versions:

1. **Document Breaking Changes**: If a benchmark changes significantly, note it in commit messages
2. **Versioning**: Use git tags to mark benchmark versions that correspond to main repository releases
3. **Baseline Maintenance**: Keep baseline results for major versions

### Running Comparisons

```bash
# Save baseline for current main version
cargo bench -- --save-baseline main-v1.0

# After making changes to main repository
cargo bench -- --baseline main-v1.0
```

## 📝 Pull Request Guidelines

When submitting a PR:

1. **Title Format**: `feat(benches): add <benchmark_name> benchmark`
2. **Description**: Include:
   - What the benchmark measures
   - Why it's important
   - Sample output or results
   - Any special setup requirements
3. **Testing**: Show that the benchmark runs successfully
4. **Documentation**: Ensure README files are updated

## 🔍 Code Review Checklist

Before submitting your PR, verify:

- [ ] Benchmark compiles without errors
- [ ] Benchmark runs and produces reasonable results
- [ ] Cargo.toml is updated with benchmark entry
- [ ] README files are updated
- [ ] Code follows existing style conventions
- [ ] No hardcoded paths (use relative paths to parent repository)
- [ ] Data files are documented if added
- [ ] Benchmark is in the appropriate category (timely/differential/other)

## 🚀 Advanced Topics

### Build Scripts

If your benchmark requires code generation, update `benches/build.rs`:

```rust
pub fn main() {
    if let Err(err) = my_generator() {
        eprintln!("benches/build.rs error: {:?}", err);
    }
}

pub fn my_generator() -> std::io::Result<()> {
    // Your code generation logic
    Ok(())
}
```

### Criterion Configuration

For advanced criterion features:

```rust
use criterion::{Criterion, BenchmarkId, PlotConfiguration, AxisScale};

fn my_parameterized_benchmark(c: &mut Criterion) {
    let mut group = c.benchmark_group("my_group");
    
    for size in [10, 100, 1000] {
        group.bench_with_input(BenchmarkId::from_parameter(size), &size, |b, &size| {
            b.iter(|| {
                // Benchmark with parameter
            });
        });
    }
    
    group.finish();
}
```

## 📚 Resources

- [Criterion.rs Documentation](https://bheisler.github.io/criterion.rs/book/)
- [Timely Dataflow Documentation](https://timelydataflow.github.io/timely-dataflow/)
- [Differential Dataflow Documentation](https://timelydataflow.github.io/differential-dataflow/)
- [Main Repository](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)

## 🐛 Troubleshooting

### Common Issues

**Benchmark doesn't compile:**
- Check that the main repository is cloned as a sibling directory
- Verify relative paths in `benches/Cargo.toml`
- Ensure you're using compatible versions of dependencies

**Inconsistent results:**
- Run multiple times to account for variance
- Check for background processes affecting performance
- Consider using `--sample-size` to increase samples

**Build script fails:**
- Check `benches/build.rs` for errors
- Verify generated files are in the correct location
- Look for file permission issues

## 💬 Getting Help

If you encounter issues or have questions:

1. Check existing benchmarks for examples
2. Review the main repository documentation
3. Open an issue with details about your problem
4. Include error messages and relevant code snippets

## 📄 License

By contributing, you agree that your contributions will be licensed under the Apache-2.0 license.
