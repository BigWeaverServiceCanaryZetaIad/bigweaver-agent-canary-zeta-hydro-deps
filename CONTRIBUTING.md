# Contributing to bigweaver-agent-canary-zeta-hydro-deps

Thank you for your interest in contributing to the Hydro benchmarks repository! This document provides guidelines for contributing new benchmarks, improving existing ones, and maintaining the repository.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Development Setup](#development-setup)
- [Contributing Benchmarks](#contributing-benchmarks)
- [Code Style Guidelines](#code-style-guidelines)
- [Testing and Verification](#testing-and-verification)
- [Documentation](#documentation)
- [Pull Request Process](#pull-request-process)
- [Coordinating with Main Repository](#coordinating-with-main-repository)

## Code of Conduct

Please be respectful and constructive in all interactions. We aim to maintain a welcoming and inclusive community.

## Getting Started

### Prerequisites

- Rust toolchain (2024 edition or later)
- Git
- Familiarity with at least one of:
  - Timely Dataflow
  - Differential Dataflow
  - Hydroflow/dfir_rs

### Fork and Clone

1. Fork this repository on GitHub
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

### Building the Project

```bash
# Build all benchmarks
cargo build

# Build in release mode
cargo build --release
```

### Running Benchmarks

```bash
# Run all benchmarks
cargo bench -p benches

# Run specific benchmark
cargo bench -p benches --bench identity

# Quick test run (faster, less comprehensive)
cargo bench -p benches --bench identity -- --quick
```

### Checking Code

```bash
# Run clippy
cargo clippy --all-targets --all-features

# Check formatting
cargo fmt -- --check

# Format code
cargo fmt
```

## Contributing Benchmarks

### When to Add a New Benchmark

Consider adding a new benchmark when:
- Testing a distinct dataflow pattern not covered by existing benchmarks
- Evaluating a specific operation or algorithm
- Providing a reproducible test case for performance analysis
- Comparing implementations of a particular feature

### Benchmark Structure

A good benchmark should:

1. **Compare Multiple Implementations**: Include Timely, Differential, and Hydroflow implementations
2. **Be Fair**: Ensure implementations are equivalent and optimized
3. **Be Reproducible**: Use fixed seeds for random data
4. **Be Documented**: Explain what is being measured and why
5. **Be Configurable**: Support both quick and comprehensive modes when appropriate

### Creating a New Benchmark

#### Step 1: Create the Benchmark File

Create a new file in `benches/benches/`:
```bash
touch benches/benches/my_pattern.rs
```

#### Step 2: Implement the Benchmark

```rust
use criterion::{black_box, criterion_group, criterion_main, Criterion, BenchmarkId};
use std::collections::HashMap;

// Helper functions for setup
fn setup_data(size: usize) -> Vec<i32> {
    (0..size as i32).collect()
}

// Timely implementation
fn timely_implementation(data: &[i32]) {
    use timely::dataflow::operators::{ToStream, Operator};
    
    timely::execute_directly(move |worker| {
        let data = data.to_vec();
        worker.dataflow::<(), _, _>(|scope| {
            data.to_stream(scope)
                // Your implementation here
                .container::<Vec<_>>()
                .sink(|_| {});
        });
    });
}

// Differential implementation
fn differential_implementation(data: &[i32]) {
    use timely::dataflow::operators::Probe;
    use differential_dataflow::input::Input;
    use differential_dataflow::operators::Join;
    
    timely::execute_directly(move |worker| {
        let data = data.to_vec();
        let mut probe = worker.dataflow::<(), _, _>(|scope| {
            let (input, collection) = scope.new_collection();
            
            // Your implementation here
            
            collection.probe()
        });
        
        // Insert data and step
    });
}

// Hydroflow implementation
fn dfir_implementation(data: &[i32]) {
    use dfir_rs::dfir_syntax;
    
    let mut flow = dfir_syntax! {
        // Your Hydroflow implementation here
        source_iter(data.iter().copied())
            -> for_each(|x| { black_box(x); });
    };
    
    flow.run_available();
}

// Benchmark function
fn benchmark_my_pattern(c: &mut Criterion) {
    let mut group = c.benchmark_group("my_pattern");
    
    for size in [100, 1000, 10000].iter() {
        let data = setup_data(*size);
        
        group.bench_with_input(
            BenchmarkId::new("timely", size),
            &data,
            |b, data| b.iter(|| timely_implementation(data))
        );
        
        group.bench_with_input(
            BenchmarkId::new("differential", size),
            &data,
            |b, data| b.iter(|| differential_implementation(data))
        );
        
        group.bench_with_input(
            BenchmarkId::new("dfir", size),
            &data,
            |b, data| b.iter(|| dfir_implementation(data))
        );
    }
    
    group.finish();
}

criterion_group!(benches, benchmark_my_pattern);
criterion_main!(benches);
```

#### Step 3: Register the Benchmark

Add to `benches/Cargo.toml`:
```toml
[[bench]]
name = "my_pattern"
harness = false
```

#### Step 4: Test the Benchmark

```bash
# Test compilation
cargo build --bench my_pattern

# Run a quick test
cargo bench -p benches --bench my_pattern -- --quick

# Run full benchmark
cargo bench -p benches --bench my_pattern
```

#### Step 5: Document the Benchmark

Update `benches/README.md` to include:
- Benchmark name and purpose
- What it measures
- How to run it
- Expected results or insights

### Benchmark Best Practices

#### Data Setup

```rust
// ✅ Good: Reproducible with fixed seed
use rand::{SeedableRng, Rng};
let mut rng = rand::rngs::StdRng::seed_from_u64(42);
let data: Vec<i32> = (0..1000).map(|_| rng.gen()).collect();

// ❌ Bad: Non-reproducible
let data: Vec<i32> = (0..1000).map(|_| rand::random()).collect();
```

#### Performance

```rust
// ✅ Good: Use black_box to prevent optimization
use criterion::black_box;
flow.run_available();
black_box(result);

// ❌ Bad: Result may be optimized away
flow.run_available();
// result is dropped
```

#### Fairness

```rust
// ✅ Good: Equivalent implementations
// All implementations produce same results
assert_eq!(timely_result, differential_result);
assert_eq!(differential_result, dfir_result);

// ❌ Bad: Different algorithms or optimizations
// Timely uses algorithm A, Differential uses algorithm B
```

#### Configuration

```rust
// ✅ Good: Support both quick and full modes
let iterations = if cfg!(feature = "quick") { 100 } else { 10000 };

// ✅ Good: Parameterize sizes
for size in [100, 1000, 10000, 100000].iter() { ... }

// ❌ Bad: Hard-coded single configuration
let size = 10000;
```

## Code Style Guidelines

### Rust Formatting

We follow the Rust standard style with workspace-specific lints:

```bash
# Format code
cargo fmt

# Check formatting
cargo fmt -- --check
```

### Linting

```bash
# Run clippy with workspace lints
cargo clippy --all-targets --all-features

# Fix clippy warnings
cargo clippy --fix
```

### Naming Conventions

- **Benchmark files**: `lowercase_with_underscores.rs`
- **Benchmark functions**: `benchmark_descriptive_name`
- **Criterion groups**: `descriptive_group_name`
- **Implementations**: `system_implementation` (e.g., `timely_implementation`)

### Comments and Documentation

```rust
// ✅ Good: Explain non-obvious choices
// Use Vec instead of HashMap because lookup is not the bottleneck
let mut buffer = Vec::new();

// ✅ Good: Document parameters
/// Benchmarks join operations with varying data sizes.
/// 
/// # Parameters
/// - `left_size`: Number of items in left relation
/// - `right_size`: Number of items in right relation

// ❌ Bad: Obvious comments
// Create a vector
let mut buffer = Vec::new();
```

## Testing and Verification

### Verify Correctness

Always verify that implementations produce equivalent results:

```rust
#[cfg(test)]
mod tests {
    use super::*;
    
    #[test]
    fn test_equivalence() {
        let data = vec![1, 2, 3, 4, 5];
        
        let timely_result = run_timely(&data);
        let differential_result = run_differential(&data);
        let dfir_result = run_dfir(&data);
        
        assert_eq!(timely_result, differential_result);
        assert_eq!(differential_result, dfir_result);
    }
}
```

### Performance Sanity Checks

```rust
// Ensure benchmarks complete in reasonable time
// If a benchmark takes > 1 minute, consider adding a "quick" mode
```

### Pre-commit Checks

Before committing:
```bash
# Format code
cargo fmt

# Check clippy
cargo clippy --all-targets --all-features

# Build benchmarks
cargo build --benches

# Run a quick test
cargo bench -p benches --bench your_benchmark -- --quick
```

## Documentation

### Required Documentation

When adding or modifying benchmarks:

1. **Code Comments**: Explain non-obvious implementation choices
2. **Benchmark README**: Update `benches/README.md` with:
   - Benchmark name and description
   - How to run it
   - What it measures
   - Expected insights
3. **Repository README**: Update main `README.md` if adding significant features
4. **Migration Doc**: Update `BENCHMARK_MIGRATION.md` if relevant

### Documentation Style

- **Be Clear**: Write for someone unfamiliar with the code
- **Be Concise**: Avoid unnecessary verbosity
- **Be Accurate**: Keep documentation synchronized with code
- **Use Examples**: Show concrete usage where helpful

## Pull Request Process

### Before Submitting

1. **Test Your Changes**:
   ```bash
   cargo fmt
   cargo clippy --all-targets --all-features
   cargo build --benches
   cargo bench -p benches --bench your_benchmark -- --quick
   ```

2. **Update Documentation**: Ensure all relevant docs are updated

3. **Verify Equivalence**: Ensure implementations produce same results

4. **Check Performance**: Verify benchmarks complete in reasonable time

### PR Title Format

Follow conventional commits format:
```
feat(benches): add graph coloring benchmark
fix(arithmetic): correct overflow handling
docs(readme): update benchmark descriptions
chore(deps): update criterion to 0.5.1
```

Types:
- `feat`: New feature or benchmark
- `fix`: Bug fix
- `docs`: Documentation changes
- `test`: Test additions or modifications
- `chore`: Maintenance tasks
- `refactor`: Code refactoring without behavior change
- `perf`: Performance improvements

### PR Description Structure

Use this template:

```markdown
## Overview
Brief description of the changes

## Task Details
- What benchmark/feature is being added/modified
- Why this change is needed
- Related issues or discussions

## Changes Made
- ✅ Created new benchmark for X pattern
- ✅ Updated documentation
- ✅ Added tests for equivalence
- ✅ Verified performance characteristics

## Benefits
- ✅ Enables comparison of X algorithm across systems
- ✅ Provides baseline for Y performance
- ✅ Improves coverage of Z pattern

## Testing
- [ ] Ran `cargo fmt`
- [ ] Ran `cargo clippy`
- [ ] Verified benchmark equivalence
- [ ] Ran benchmarks successfully
- [ ] Updated documentation
```

### Review Process

1. **Automated Checks**: CI will run formatting, linting, and build checks
2. **Peer Review**: Maintainers will review code and documentation
3. **Performance Review**: Verify benchmarks are fair and meaningful
4. **Documentation Review**: Ensure docs are clear and complete

### After Approval

1. Squash commits if necessary
2. Ensure commit message follows conventions
3. Merge will be handled by maintainers

## Coordinating with Main Repository

### When Changes Affect Both Repositories

If your contribution requires changes in the main `bigweaver-agent-canary-hydro-zeta` repository:

1. **Create Companion PRs**:
   - Submit PR to main repository
   - Submit PR to this repository
   - Reference both PRs in descriptions

2. **Link Issues**:
   - Use "Related to #123" to link issues
   - Use "Depends on org/repo#456" for cross-repo dependencies

3. **Coordinate Merging**:
   - Ensure compatibility between changes
   - Merge in correct order (usually main repo first)
   - Update git dependencies if needed

### Dependency Updates

When updating references to the main repository:

```toml
# In benches/Cargo.toml
dfir_rs = { git = "https://github.com/hydro-project/hydro", rev = "abc123", features = [ "debugging" ] }
```

Update the `rev` to point to a specific commit when stability is needed.

## Getting Help

### Resources

- **Documentation**: Check `README.md` and `benches/README.md`
- **Examples**: Look at existing benchmarks for patterns
- **Issues**: Search existing issues for similar problems
- **Discussions**: Use GitHub Discussions for questions

### Asking Questions

When asking for help:
1. Check existing documentation and issues first
2. Provide minimal reproducible examples
3. Include error messages and relevant logs
4. Describe what you've tried
5. Be specific about what you need help with

## Recognition

Contributors will be:
- Listed in commit history
- Mentioned in release notes for significant contributions
- Credited in documentation where appropriate

Thank you for contributing to the Hydro benchmarks! Your work helps improve understanding of dataflow system performance and guides optimization efforts.
