# Contributing to Hydro Benchmarks

Thank you for your interest in contributing to the Hydro performance benchmarks! This document provides guidelines and best practices for contributing.

## Table of Contents

1. [Code of Conduct](#code-of-conduct)
2. [Getting Started](#getting-started)
3. [Development Setup](#development-setup)
4. [Adding New Benchmarks](#adding-new-benchmarks)
5. [Modifying Existing Benchmarks](#modifying-existing-benchmarks)
6. [Testing Guidelines](#testing-guidelines)
7. [Documentation Standards](#documentation-standards)
8. [Pull Request Process](#pull-request-process)
9. [Coding Standards](#coding-standards)

## Code of Conduct

This project follows the same code of conduct as the main Hydro repository. Please be respectful, constructive, and professional in all interactions.

## Getting Started

### Prerequisites

- Rust stable or nightly toolchain
- Git
- Both repositories cloned side-by-side:
  ```
  workspace/
  ├── bigweaver-agent-canary-hydro-zeta/
  └── bigweaver-agent-canary-zeta-hydro-deps/
  ```

### Fork and Clone

1. Fork the repository on GitHub
2. Clone your fork:
   ```bash
   git clone https://github.com/YOUR_USERNAME/bigweaver-agent-canary-zeta-hydro-deps.git
   cd bigweaver-agent-canary-zeta-hydro-deps
   ```

3. Add upstream remote:
   ```bash
   git remote add upstream https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
   ```

## Development Setup

### Build and Test

```bash
# Build all benchmarks
cargo build -p hydro-deps-benches --release

# Run verification script
./verify_benchmarks.sh

# Run a quick benchmark to ensure everything works
cargo bench -p hydro-deps-benches --bench arithmetic -- --measurement-time 5
```

### Development Workflow

1. Create a feature branch:
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. Make your changes

3. Test your changes:
   ```bash
   cargo build -p hydro-deps-benches
   cargo bench -p hydro-deps-benches --bench your-benchmark
   ./verify_benchmarks.sh
   ```

4. Commit your changes (see commit message guidelines below)

5. Push and create a pull request

## Adding New Benchmarks

### When to Add a Benchmark

Add a new benchmark when:
- Testing a new dataflow pattern
- Comparing a new algorithm or optimization
- Evaluating a specific performance characteristic
- Reproducing a performance issue

### Benchmark Structure

Create a new file in `benches/benches/your_benchmark.rs`:

```rust
use criterion::{Criterion, black_box, criterion_group, criterion_main};
use dfir_rs::dfir_syntax;
use timely::dataflow::operators::*;

// Configuration constants
const BENCHMARK_SIZE: usize = 100_000;

/// Hydro (DFIR) implementation
fn benchmark_dfir(c: &mut Criterion) {
    c.bench_function("your_benchmark/dfir", |b| {
        b.iter(|| {
            let mut df = dfir_syntax! {
                // Your dataflow implementation
                source_iter(0..BENCHMARK_SIZE)
                    -> map(|x| x * 2)
                    -> for_each(|x| { black_box(x); });
            };
            df.run_available();
        });
    });
}

/// Timely Dataflow implementation
fn benchmark_timely(c: &mut Criterion) {
    c.bench_function("your_benchmark/timely", |b| {
        b.iter(|| {
            timely::execute_directly(move |worker| {
                worker.dataflow::<(), _, _>(|scope| {
                    (0..BENCHMARK_SIZE)
                        .to_stream(scope)
                        .map(|x| x * 2)
                        .inspect(|x| { black_box(x); });
                });
            });
        });
    });
}

// Register benchmarks
criterion_group!(
    benches,
    benchmark_dfir,
    benchmark_timely
);
criterion_main!(benches);
```

### Update Configuration

1. Add to `benches/Cargo.toml`:
   ```toml
   [[bench]]
   name = "your_benchmark"
   harness = false
   ```

2. Add test data files if needed:
   - Place in `benches/benches/`
   - Document format and source
   - Keep files reasonably sized (< 1MB if possible)

3. Update documentation:
   - Add entry to README.md benchmark table
   - Document in BENCHMARK_GUIDE.md
   - Include expected performance characteristics

### Benchmark Best Practices

#### 1. Use `black_box` for Results

Prevent compiler optimizations from eliminating work:
```rust
use criterion::black_box;

// Good
for_each(|x| { black_box(x); });

// Bad - might be optimized away
for_each(|x| { let _ = x; });
```

#### 2. Appropriate Data Sizes

Choose sizes that:
- Complete in reasonable time (< 5 seconds per iteration)
- Are large enough to measure meaningful differences
- Represent realistic workloads

#### 3. Multiple Variants

Always include at least:
- Hydro (DFIR) implementation
- Timely implementation
- Baseline/reference implementation (if applicable)

#### 4. Clear Naming

Use descriptive names:
- `benchmark_name/dfir` - Hydro implementation
- `benchmark_name/timely` - Timely implementation
- `benchmark_name/differential` - Differential implementation
- `benchmark_name/baseline` - Reference implementation

#### 5. Documentation

Include in the benchmark file:
```rust
//! Benchmark Name
//!
//! Description of what this benchmark measures.
//!
//! # Variants
//! - `dfir`: Hydro implementation
//! - `timely`: Timely Dataflow implementation
//!
//! # Configuration
//! - `CONST_NAME`: What this controls (default: value)
```

## Modifying Existing Benchmarks

### Guidelines

1. **Preserve Comparability**: Don't change parameters that would invalidate historical comparisons
2. **Document Changes**: Explain why the change is needed
3. **Backward Compatibility**: Consider adding new variants instead of changing existing ones
4. **Test Thoroughly**: Ensure changes don't break existing functionality

### Acceptable Modifications

- Bug fixes that correct invalid measurements
- Performance improvements to the benchmark harness
- Adding new variants or comparisons
- Updating dependencies (with care)

### Changes Requiring Discussion

- Changing benchmark parameters (sizes, iterations)
- Removing variants
- Significant refactoring
- Changing measurement methodology

## Testing Guidelines

### Required Tests

Before submitting a PR:

1. **Compilation**: Benchmark must compile without warnings
   ```bash
   cargo build -p hydro-deps-benches --release
   ```

2. **Execution**: Benchmark must run successfully
   ```bash
   cargo bench -p hydro-deps-benches --bench your-benchmark -- --measurement-time 5
   ```

3. **Verification**: Pass verification script
   ```bash
   ./verify_benchmarks.sh
   ```

### Verification Script

The `verify_benchmarks.sh` script checks:
- ✅ All benchmarks compile
- ✅ All benchmarks can run
- ✅ Dependencies are available
- ✅ No regressions in existing benchmarks

### Testing Checklist

- [ ] Benchmark compiles without warnings
- [ ] Benchmark runs without errors
- [ ] Results are reasonable (not NaN, inf, or suspiciously fast/slow)
- [ ] Documentation is updated
- [ ] Verification script passes
- [ ] Code follows style guidelines (rustfmt)
- [ ] Code passes lints (clippy)

## Documentation Standards

### Code Documentation

Use Rust doc comments:
```rust
/// Brief description of the benchmark.
///
/// # What It Measures
/// Detailed explanation of what performance characteristic this tests.
///
/// # Variants
/// - `variant_name`: Description
///
/// # Parameters
/// - `PARAM_NAME`: What this controls
fn benchmark_function(c: &mut Criterion) {
    // Implementation
}
```

### README Updates

When adding a benchmark, update README.md:

```markdown
| **your_benchmark** | Brief description | Hydro vs. Timely vs. X |
```

### Benchmark Guide Updates

Add a section in BENCHMARK_GUIDE.md:

```markdown
#### N. Your Benchmark (`your_benchmark.rs`)

**Purpose**: What this benchmark measures.

**What it tests**:
- Key characteristic 1
- Key characteristic 2

**Variants**:
- `your_benchmark/dfir` - Hydro implementation
- `your_benchmark/timely` - Timely implementation

**Key parameters**:
- `PARAM_NAME`: Description (default: value)
```

## Pull Request Process

### Before Submitting

1. **Update Documentation**: Ensure all docs are current
2. **Run Tests**: All verification checks pass
3. **Format Code**: Run `cargo fmt`
4. **Lint Code**: Run `cargo clippy` and fix warnings
5. **Commit Messages**: Follow conventional commits format

### PR Template

Use this structure for your PR description:

```markdown
## Description
Brief description of the changes.

## Type of Change
- [ ] New benchmark
- [ ] Bug fix
- [ ] Performance improvement
- [ ] Documentation update
- [ ] Other (please describe)

## Changes
- Bullet point list of changes

## Testing
- [ ] Compiled successfully
- [ ] Ran benchmark successfully
- [ ] Verification script passes
- [ ] Documentation updated

## Performance Impact
Describe any performance implications of the changes.

## Additional Notes
Any additional context or considerations.
```

### Review Process

1. Automated checks run on PR submission
2. Maintainers review code and provide feedback
3. Address feedback and update PR
4. Once approved, maintainers will merge

### Commit Message Format

Follow conventional commits:

```
type(scope): description

[optional body]

[optional footer]
```

**Types**:
- `feat`: New benchmark or feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `perf`: Performance improvement
- `refactor`: Code refactoring
- `test`: Test updates
- `chore`: Maintenance tasks

**Examples**:
```
feat(benches): add graph coloring benchmark

Add new benchmark comparing graph coloring algorithms
across Hydro, Timely, and Differential implementations.

Includes test data and comprehensive documentation.
```

```
fix(reachability): correct edge loading logic

Fix bug in edge loading that caused incorrect results
for graphs with duplicate edges.
```

```
docs(guide): add profiling section

Add section on using perf and flamegraph for
detailed performance analysis.
```

## Coding Standards

### Rust Style

Follow the Rust API Guidelines and use:

```bash
# Format code
cargo fmt

# Check lints
cargo clippy -- -D warnings
```

### Benchmark-Specific Standards

1. **Constants**: Use `const` for configuration values
   ```rust
   const BENCHMARK_SIZE: usize = 100_000;
   ```

2. **Naming**: Use descriptive names
   ```rust
   // Good
   fn benchmark_symmetric_hash_join(c: &mut Criterion)
   
   // Bad
   fn bench_shj(c: &mut Criterion)
   ```

3. **Comments**: Explain non-obvious logic
   ```rust
   // Use timely's synchronous execution for fair comparison
   timely::execute_directly(move |worker| {
       // ...
   });
   ```

4. **Error Handling**: Benchmarks should not panic
   ```rust
   // Handle potential errors gracefully
   let data = load_data().expect("Failed to load benchmark data");
   ```

### Performance Considerations

1. **Avoid Allocation in Hot Paths**: Pre-allocate where possible
2. **Use `black_box`**: Prevent unwanted optimizations
3. **Realistic Workloads**: Use representative data and operations
4. **Consistent Measurement**: Ensure fair comparisons between variants

## Getting Help

If you need help:

1. **Check Documentation**: README.md and BENCHMARK_GUIDE.md
2. **Search Issues**: Look for similar questions or problems
3. **Ask Questions**: Open an issue with the `question` label
4. **Main Repository**: Refer to the main Hydro repository for core functionality questions

## Recognition

Contributors will be:
- Listed in release notes
- Acknowledged in documentation
- Credited in relevant benchmark files

Thank you for contributing to Hydro benchmarks!
