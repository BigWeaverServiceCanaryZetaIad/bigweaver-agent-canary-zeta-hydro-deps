# Contributing to bigweaver-agent-canary-zeta-hydro-deps

Thank you for your interest in contributing to the benchmark repository! This document provides guidelines for contributing benchmarks, improvements, and fixes.

## Table of Contents

1. [Getting Started](#getting-started)
2. [Types of Contributions](#types-of-contributions)
3. [Development Workflow](#development-workflow)
4. [Adding New Benchmarks](#adding-new-benchmarks)
5. [Modifying Existing Benchmarks](#modifying-existing-benchmarks)
6. [Documentation](#documentation)
7. [Testing](#testing)
8. [Code Style](#code-style)
9. [Pull Request Process](#pull-request-process)

## Getting Started

### Prerequisites

1. Rust toolchain installed
2. Access to the main `bigweaver-agent-canary-hydro-zeta` repository
3. Familiarity with Criterion benchmarking framework

### Setup

```bash
# Clone or ensure you have the correct repository structure
cd /projects/sandbox
ls bigweaver-agent-canary-hydro-zeta  # Main repository
ls bigweaver-agent-canary-zeta-hydro-deps  # This repository

# Verify setup
cd bigweaver-agent-canary-zeta-hydro-deps
./verify_setup.sh
```

## Types of Contributions

We welcome the following types of contributions:

### New Benchmarks

- Benchmarks for new dataflow patterns
- Comparisons with additional baseline implementations
- Performance tests for specific use cases

### Improvements to Existing Benchmarks

- Performance optimizations
- Better coverage of edge cases
- Improved accuracy or measurement methodology
- Bug fixes

### Documentation

- Improvements to guides and documentation
- Additional examples
- Clarifications and corrections
- Translation of documentation

### Tooling

- Scripts for automated analysis
- CI/CD integration
- Visualization tools
- Performance regression detection

## Development Workflow

### 1. Create a Feature Branch

```bash
git checkout -b feature/add-map-reduce-benchmark
```

### 2. Make Your Changes

Follow the guidelines in this document for your specific contribution type.

### 3. Test Your Changes

```bash
# Verify compilation
cargo check --benches

# Run the specific benchmark
cargo bench --bench your_benchmark

# Run quick test
cargo bench --bench your_benchmark -- --sample-size 10
```

### 4. Document Your Changes

- Update relevant documentation
- Add comments to your code
- Update CHANGELOG.md

### 5. Commit Your Changes

Follow conventional commit format:

```bash
git commit -m "feat(benches): add map-reduce benchmark

Add comprehensive benchmark comparing map-reduce implementations
across Hydro, Timely, and baseline Rust."
```

### 6. Submit Pull Request

Create a pull request with a clear description of your changes.

## Adding New Benchmarks

### Step-by-Step Process

#### 1. Create Benchmark File

Create a new file in `benches/` directory:

```rust
// benches/my_benchmark.rs
use criterion::{Criterion, black_box, criterion_group, criterion_main};
use dfir_rs::dfir_syntax;
use timely::dataflow::operators::{ToStream, Map, Inspect};

// Constants for the benchmark
const INPUT_SIZE: usize = 1_000_000;

/// Benchmark using Hydro (dfir_rs)
fn benchmark_hydro(c: &mut Criterion) {
    c.bench_function("my_benchmark/dfir_rs", |b| {
        b.iter_batched(
            || {
                dfir_syntax! {
                    source_iter(0..INPUT_SIZE)
                        -> map(|x| black_box(x * 2))
                        -> for_each(|x| { black_box(x); });
                }
            },
            |mut df| {
                df.run_available_sync();
            },
            criterion::BatchSize::SmallInput,
        )
    });
}

/// Benchmark using Timely dataflow
fn benchmark_timely(c: &mut Criterion) {
    c.bench_function("my_benchmark/timely", |b| {
        b.iter(|| {
            timely::example(|scope| {
                (0..INPUT_SIZE)
                    .to_stream(scope)
                    .map(|x| x * 2)
                    .inspect(|x| { black_box(x); });
            });
        })
    });
}

/// Baseline using raw Rust iterators
fn benchmark_baseline(c: &mut Criterion) {
    c.bench_function("my_benchmark/baseline", |b| {
        b.iter(|| {
            for x in 0..INPUT_SIZE {
                black_box(x * 2);
            }
        });
    });
}

criterion_group!(
    my_benchmark_group,
    benchmark_hydro,
    benchmark_timely,
    benchmark_baseline,
);
criterion_main!(my_benchmark_group);
```

#### 2. Add to Cargo.toml

Add your benchmark to the `[[bench]]` sections:

```toml
[[bench]]
name = "my_benchmark"
harness = false
```

#### 3. Document the Benchmark

Add documentation at the top of your file:

```rust
//! My Benchmark
//!
//! This benchmark measures the performance of [operation] across different
//! dataflow implementations.
//!
//! ## Pattern
//! [Describe the dataflow pattern]
//!
//! ## Input
//! [Describe the input data]
//!
//! ## What It Measures
//! - [Aspect 1]
//! - [Aspect 2]
//! - [Aspect 3]
//!
//! ## Implementations
//! - `dfir_rs` - Hydro dataflow implementation
//! - `timely` - Timely dataflow implementation
//! - `baseline` - Raw Rust baseline
```

#### 4. Update Documentation

Add your benchmark to `BENCHMARK_GUIDE.md`:

```markdown
### my_benchmark.rs

**Purpose**: [Brief description]

**Pattern**: [Dataflow pattern]

**Input**: [Input description]

**What It Measures**:
- [Measurement 1]
- [Measurement 2]
- [Measurement 3]
```

#### 5. Test the Benchmark

```bash
# Verify it compiles
cargo check --benches

# Run quick test
cargo bench --bench my_benchmark -- --sample-size 10

# Run full benchmark
cargo bench --bench my_benchmark
```

#### 6. Update CHANGELOG.md

```markdown
### Added
- Added `my_benchmark.rs` - [Brief description]
```

## Modifying Existing Benchmarks

When modifying existing benchmarks:

### 1. Understand Current Behavior

```bash
# Run benchmark to establish baseline
cargo bench --bench existing_benchmark -- --save-baseline before_change
```

### 2. Make Changes

Ensure changes don't alter what the benchmark measures unless that's the intent.

### 3. Compare Results

```bash
# Run after changes
cargo bench --bench existing_benchmark -- --baseline before_change
```

### 4. Document Changes

If the change affects measurement:
- Update benchmark documentation
- Note the change in CHANGELOG.md
- Explain the reasoning in your PR

## Documentation

### Documentation Standards

All documentation should:
- Be clear and concise
- Include examples where appropriate
- Use proper markdown formatting
- Be kept up to date with code changes

### Documentation Files

- **README.md** - Repository overview and quick reference
- **BENCHMARK_GUIDE.md** - Detailed benchmark documentation
- **PERFORMANCE_COMPARISON.md** - Performance analysis guides
- **QUICK_START.md** - Getting started guide
- **CHANGELOG.md** - Change history

### Code Comments

Benchmarks should include:
- File-level documentation (module doc comments)
- Function documentation for non-obvious code
- Explanation of constants and magic numbers
- Citations for algorithms or external sources

Example:
```rust
/// Benchmark for graph reachability using transitive closure.
///
/// This implements the standard graph reachability algorithm where we
/// iteratively propagate reachability information until a fixed point.
///
/// Reference: [Graph algorithms paper/book]
fn benchmark_reachability(c: &mut Criterion) {
    // ...
}
```

## Testing

### Before Submitting

Run these checks:

```bash
# 1. Verify compilation
cargo check --benches

# 2. Run your specific benchmark
cargo bench --bench your_benchmark

# 3. Verify all benchmarks still work
cargo bench --no-run

# 4. Quick test of all benchmarks (optional)
cargo bench -- --sample-size 10 --measurement-time 1
```

### Benchmark Quality

Ensure your benchmark:
- **Measures the right thing**: Use `black_box` to prevent over-optimization
- **Is reproducible**: Results should be consistent across runs
- **Has appropriate scale**: Not too fast (< 1µs) or too slow (> 10s)
- **Includes baselines**: Compare against raw Rust or iterators
- **Is documented**: Clear explanation of what it measures

### Common Issues

**Over-optimization**:
```rust
// Bad - compiler may optimize away
let result = (0..N).map(|x| x + 1).collect();

// Good - prevents optimization
let result = (0..N).map(|x| black_box(x + 1)).collect();
```

**Too fast**:
```rust
// If benchmark is < 1µs, increase workload
const INPUT_SIZE: usize = 1_000;  // Too small
const INPUT_SIZE: usize = 1_000_000;  // Better
```

**Non-deterministic**:
```rust
// Bad - random without fixed seed
let data: Vec<_> = (0..N).map(|_| rand::random()).collect();

// Good - fixed seed for reproducibility
let mut rng = rand::rngs::StdRng::seed_from_u64(42);
let data: Vec<_> = (0..N).map(|_| rng.gen()).collect();
```

## Code Style

### Rust Code

Follow the Rust style guide and use rustfmt:

```bash
# Format your code
cargo fmt

# Check formatting
cargo fmt -- --check
```

### Benchmark Organization

Organize benchmarks consistently:

```rust
// 1. Imports
use criterion::{...};

// 2. Constants
const INPUT_SIZE: usize = 1_000_000;

// 3. Helper functions (if any)
fn setup_data() -> Vec<usize> { ... }

// 4. Benchmark functions (grouped by implementation)
fn benchmark_hydro(c: &mut Criterion) { ... }
fn benchmark_timely(c: &mut Criterion) { ... }
fn benchmark_baseline(c: &mut Criterion) { ... }

// 5. Criterion group and main
criterion_group!(...);
criterion_main!(...);
```

### Naming Conventions

- Benchmark files: `snake_case.rs` (e.g., `map_reduce.rs`)
- Benchmark functions: `benchmark_<impl>` (e.g., `benchmark_hydro`)
- Constants: `UPPER_SNAKE_CASE` (e.g., `INPUT_SIZE`)

## Pull Request Process

### PR Title

Use conventional commit format:

```
feat(benches): add map-reduce benchmark
fix(benches): correct identity benchmark timing
docs: update BENCHMARK_GUIDE with new examples
chore: update dependencies to latest versions
```

### PR Description

Include:

1. **Overview**: Brief description of changes
2. **Motivation**: Why this change is needed
3. **Changes**: Detailed list of what changed
4. **Testing**: How you tested the changes
5. **Results**: Benchmark results (if applicable)
6. **Related Issues**: Link to related issues or PRs

Example:

```markdown
## Overview
Add comprehensive map-reduce pattern benchmark comparing Hydro, Timely, and baseline implementations.

## Motivation
Map-reduce is a common pattern in data processing, and we need benchmarks to understand Hydro's performance characteristics for this pattern.

## Changes
- Added `benches/map_reduce.rs` with three implementations
- Updated `BENCHMARK_GUIDE.md` with benchmark description
- Updated `CHANGELOG.md` with addition
- Added `map_reduce` to Cargo.toml

## Testing
- Verified compilation: `cargo check --benches`
- Ran benchmark: `cargo bench --bench map_reduce`
- Verified results are consistent across multiple runs

## Results
- Hydro (compiled): 234.56 µs
- Timely: 456.78 µs
- Baseline: 123.45 µs

Hydro is ~2x faster than Timely but ~1.9x slower than raw Rust baseline.

## Related
Related to issue #123 regarding map-reduce performance analysis.
```

### Review Process

1. **Automated checks**: Ensure CI passes
2. **Code review**: Address reviewer feedback
3. **Testing**: Verify benchmarks work as expected
4. **Documentation**: Ensure docs are complete
5. **Approval**: Get approval from maintainers

### After Merge

- Update your local copy
- Delete your feature branch
- Celebrate! 🎉

## Questions or Help

If you need help:

1. Check existing documentation (README.md, BENCHMARK_GUIDE.md, etc.)
2. Review existing benchmarks for examples
3. Open an issue for discussion
4. Contact the maintainers

## Recognition

All contributors will be recognized in the project. Thank you for helping improve the benchmarks!

---

**Last Updated**: November 24, 2024  
**Maintained By**: BigWeaverServiceCanaryZetaIad Team
