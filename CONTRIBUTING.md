# Contributing to Hydro Comparison Benchmarks

Thank you for your interest in contributing to the Hydro comparison benchmarks! This document provides guidelines for contributing new benchmarks, improvements, and fixes.

## Getting Started

### Prerequisites

- Rust toolchain (stable or nightly)
- Git
- Familiarity with Criterion benchmarking framework
- Understanding of Hydro, Timely, and/or Differential Dataflow

### Setting Up Development Environment

```bash
# Clone the repository
git clone <repo-url> bigweaver-agent-canary-zeta-hydro-deps
cd bigweaver-agent-canary-zeta-hydro-deps

# Build benchmarks
cargo build --benches

# Run tests
cargo test

# Run benchmarks
cargo bench
```

## Types of Contributions

We welcome the following types of contributions:

1. **New Benchmarks**: Add benchmarks for new patterns or operations
2. **Performance Improvements**: Optimize existing benchmark implementations
3. **Bug Fixes**: Fix issues in benchmark code or configuration
4. **Documentation**: Improve documentation, add examples, clarify instructions
5. **Test Data**: Add new test datasets or improve existing ones

## Adding New Benchmarks

### Benchmark Structure

Each benchmark should follow this structure:

```rust
use criterion::{Criterion, black_box, criterion_group, criterion_main};

// Configuration constants
const NUM_ELEMENTS: usize = 1_000_000;

// Individual benchmark functions
fn benchmark_hydroflow(c: &mut Criterion) {
    c.bench_function("pattern/hydroflow", |b| {
        b.iter(|| {
            // Hydroflow implementation
        });
    });
}

fn benchmark_timely(c: &mut Criterion) {
    c.bench_function("pattern/timely", |b| {
        b.iter(|| {
            // Timely implementation
        });
    });
}

// Criterion group and main
criterion_group!(benches, benchmark_hydroflow, benchmark_timely);
criterion_main!(benches);
```

### Benchmark Naming Conventions

- **File names**: Use snake_case (e.g., `fan_in.rs`, `symmetric_join.rs`)
- **Function names**: `benchmark_<framework>` (e.g., `benchmark_hydroflow`, `benchmark_timely`)
- **Criterion test names**: `<pattern>/<framework>` (e.g., `fan_in/hydroflow`, `fan_in/timely`)

### Adding a New Benchmark - Step by Step

1. **Create benchmark file**:
   ```bash
   touch benches/my_new_benchmark.rs
   ```

2. **Implement benchmark**:
   - Add necessary imports
   - Define configuration constants
   - Implement different framework versions
   - Ensure fair comparison (same algorithm, data structures)

3. **Update Cargo.toml**:
   ```toml
   [[bench]]
   name = "my_new_benchmark"
   harness = false
   ```

4. **Test benchmark**:
   ```bash
   cargo bench --bench my_new_benchmark
   ```

5. **Document benchmark**:
   - Add section to BENCHMARKS.md
   - Describe purpose, implementations, configuration
   - Include usage examples

6. **Submit pull request** (see "Submitting Changes" section)

### Fair Comparison Guidelines

When implementing multiple framework versions:

1. **Use Same Algorithm**: Implement identical logic across frameworks
2. **Equivalent Data Structures**: Use comparable data types and structures
3. **Same Input Data**: Use identical test data for all implementations
4. **Consistent Configuration**: Match parameters across implementations
5. **Proper Warm-up**: Allow frameworks to warm up appropriately
6. **Measure What Matters**: Focus on meaningful metrics, not framework quirks

### Example: Adding a Filter Benchmark

```rust
use criterion::{Criterion, black_box, criterion_group, criterion_main};
use dfir_rs::dfir_syntax;
use timely::dataflow::operators::{ToStream, Filter as TimelyFilter, Inspect};

const NUM_ELEMENTS: usize = 1_000_000;

fn benchmark_hydroflow(c: &mut Criterion) {
    c.bench_function("filter/hydroflow", |b| {
        b.iter(|| {
            let mut df = dfir_syntax! {
                source_iter(0..NUM_ELEMENTS)
                    -> filter(|x| x % 2 == 0)
                    -> for_each(|x| { black_box(x); });
            };
            df.run_available();
        });
    });
}

fn benchmark_timely(c: &mut Criterion) {
    c.bench_function("filter/timely", |b| {
        b.iter(|| {
            timely::execute_directly(move |worker| {
                (0..NUM_ELEMENTS)
                    .to_stream(worker)
                    .filter(|x| x % 2 == 0)
                    .inspect(|x| { black_box(x); });
            });
        });
    });
}

criterion_group!(benches, benchmark_hydroflow, benchmark_timely);
criterion_main!(benches);
```

## Code Style and Quality

### Rust Style Guidelines

Follow standard Rust conventions:

- Use `rustfmt` for formatting
- Use `clippy` for linting
- Follow Rust API guidelines

```bash
# Format code
cargo fmt

# Run clippy
cargo clippy --benches
```

### Benchmark-Specific Guidelines

1. **Constants**: Use `const` for configuration values
2. **black_box**: Use `black_box` to prevent compiler optimization of measured code
3. **Resource Cleanup**: Ensure proper cleanup of resources
4. **Comments**: Add comments explaining non-obvious benchmark logic
5. **Error Handling**: Handle errors appropriately (panic if necessary for benchmarks)

### Documentation Requirements

Every benchmark must include:

1. **File-level documentation**:
   ```rust
   //! Benchmark for [pattern/operation name]
   //!
   //! Compares [framework1] and [framework2] implementations of [pattern].
   //!
   //! Configuration:
   //! - NUM_ELEMENTS: [value]
   //! - [other config]
   ```

2. **Function documentation**:
   ```rust
   /// Benchmark [operation] using Hydroflow
   fn benchmark_hydroflow(c: &mut Criterion) {
       // ...
   }
   ```

3. **BENCHMARKS.md entry**: Add detailed documentation to BENCHMARKS.md

## Testing

### Building Benchmarks

Ensure benchmarks compile:

```bash
# Build all benchmarks
cargo build --benches

# Build specific benchmark
cargo build --bench my_benchmark
```

### Running Benchmarks

Test benchmarks before submitting:

```bash
# Quick run to verify functionality
cargo bench --bench my_benchmark -- --quick

# Full run
cargo bench --bench my_benchmark

# Check for consistent results
cargo bench --bench my_benchmark
cargo bench --bench my_benchmark
# Results should be similar across runs
```

### Validation

Verify benchmark correctness:

1. **Correctness**: Ensure benchmark produces correct results
2. **Consistency**: Run multiple times, check for consistent performance
3. **Comparison**: If possible, verify results match across implementations
4. **Edge Cases**: Test with different input sizes and configurations

## Test Data

### Adding Test Data

If your benchmark requires test data:

1. **Small Data**: Include directly in repository (< 1MB)
2. **Large Data**: Document how to generate or obtain data
3. **Format**: Use simple text formats when possible
4. **Documentation**: Document data format and source

Example:

```rust
// Load test data
let edges: Vec<(u32, u32)> = include_str!("graph_edges.txt")
    .lines()
    .map(|line| {
        let parts: Vec<&str> = line.split_whitespace().collect();
        (parts[0].parse().unwrap(), parts[1].parse().unwrap())
    })
    .collect();
```

### Test Data Guidelines

- Keep data files in `benches/` directory
- Use descriptive names (e.g., `graph_edges.txt`, not `data.txt`)
- Include data source/generation method in comments
- Document expected results if applicable

## Submitting Changes

### Before Submitting

1. **Test thoroughly**: Run all affected benchmarks
2. **Format code**: Run `cargo fmt`
3. **Lint code**: Run `cargo clippy`
4. **Update documentation**: Update BENCHMARKS.md and other docs
5. **Write clear commit messages**: Follow conventional commits format

### Commit Message Format

Use conventional commits format:

```
type(scope): description

Detailed explanation of changes (if needed)
```

**Types**:
- `feat`: New benchmark or feature
- `fix`: Bug fix in benchmark
- `docs`: Documentation changes
- `perf`: Performance improvement
- `test`: Test-related changes
- `chore`: Maintenance tasks

**Examples**:
```
feat(benches): add aggregation benchmark

Implements count, sum, and average aggregation benchmarks comparing
Hydroflow and Timely implementations.
```

```
fix(reachability): correct edge loading logic

Fixed off-by-one error in edge parsing that caused incorrect results.
```

```
docs(benchmarks): add detailed description for join benchmark

Added explanation of join algorithm, test data, and expected results.
```

### Pull Request Process

1. **Create feature branch**:
   ```bash
   git checkout -b feat/my-new-benchmark
   ```

2. **Make changes and commit**:
   ```bash
   git add .
   git commit -m "feat(benches): add my new benchmark"
   ```

3. **Push to repository**:
   ```bash
   git push origin feat/my-new-benchmark
   ```

4. **Create pull request** with description including:
   - Purpose of changes
   - Benchmarks added/modified
   - Performance characteristics observed
   - Any dependencies or requirements

### Pull Request Template

```markdown
## Overview

Brief description of changes.

## Benchmarks Added/Modified

- [ ] benchmark_name1
- [ ] benchmark_name2

## Changes Made

- Added/Modified files
- Updated documentation
- Added test data

## Performance Characteristics

Brief description of performance observed during testing.

## Testing

- [ ] Benchmarks compile successfully
- [ ] Benchmarks run without errors
- [ ] Results are consistent across runs
- [ ] Documentation updated

## Related Issues

Closes #123 (if applicable)
```

## Review Process

### What Reviewers Look For

- **Correctness**: Benchmark implements intended functionality
- **Fairness**: Comparisons are fair and meaningful
- **Documentation**: Clear documentation of benchmark purpose and usage
- **Code Quality**: Clean, readable, well-structured code
- **Performance**: Reasonable performance characteristics

### Addressing Review Comments

- Respond to all comments
- Make requested changes
- Update PR description if scope changes
- Request re-review when ready

## Performance Considerations

### Writing Efficient Benchmarks

1. **Minimize Setup Overhead**: Move setup outside timed section when possible
2. **Avoid Unnecessary Allocations**: Reuse allocations when appropriate
3. **Use Appropriate Data Structures**: Choose efficient data structures
4. **Consider Memory Locality**: Optimize for cache performance
5. **Avoid I/O in Tight Loops**: Minimize I/O during measurement

### Example: Efficient Benchmark Setup

```rust
fn benchmark_with_setup(c: &mut Criterion) {
    // Setup outside benchmark timing
    let data: Vec<_> = (0..NUM_ELEMENTS).collect();
    
    c.bench_function("pattern/impl", |b| {
        b.iter(|| {
            // Only measure the actual operation
            for &x in &data {
                black_box(x);
            }
        });
    });
}
```

## Getting Help

If you need help:

1. **Check Documentation**: Review README.md, BENCHMARKS.md, and this file
2. **Look at Examples**: Study existing benchmarks
3. **Ask Questions**: Open an issue with `question` label
4. **Join Discussion**: Participate in team communication channels

## Code of Conduct

- Be respectful and constructive
- Focus on improving benchmarks and documentation
- Help others learn and contribute
- Follow project guidelines and conventions

## License

By contributing, you agree that your contributions will be licensed under the Apache-2.0 license.

## Additional Resources

- [Criterion Documentation](https://bheisler.github.io/criterion.rs/book/)
- [Rust Performance Book](https://nnethercote.github.io/perf-book/)
- [Hydroflow Documentation](https://hydro-project.github.io/hydro/)
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)

## Thank You!

Thank you for contributing to the Hydro comparison benchmarks! Your contributions help improve performance understanding and drive framework improvements.
