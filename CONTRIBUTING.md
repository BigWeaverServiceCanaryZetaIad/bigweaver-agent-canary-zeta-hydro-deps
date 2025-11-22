# Contributing to Hydro Benchmarks

Thank you for your interest in contributing to the Hydro benchmarks repository! This document provides guidelines and information for contributors.

## Table of Contents

- [Getting Started](#getting-started)
- [Repository Structure](#repository-structure)
- [Adding New Benchmarks](#adding-new-benchmarks)
- [Modifying Existing Benchmarks](#modifying-existing-benchmarks)
- [Testing Your Changes](#testing-your-changes)
- [Submitting Pull Requests](#submitting-pull-requests)
- [Code Style](#code-style)
- [Documentation](#documentation)
- [Performance Considerations](#performance-considerations)

## Getting Started

### Prerequisites

- Rust toolchain (latest stable)
- Git
- Familiarity with Criterion.rs benchmarking framework
- Understanding of Hydro, Timely, or Differential-Dataflow (depending on benchmark type)

### Initial Setup

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

4. Set up local Hydro development (optional):
```bash
cd ..
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git
```

5. Configure local paths in `benches/Cargo.toml`:
```toml
[dev-dependencies]
dfir_rs = { path = "../../bigweaver-agent-canary-hydro-zeta/dfir_rs", features = [ "debugging" ] }
sinktools = { path = "../../bigweaver-agent-canary-hydro-zeta/sinktools" }
```

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── Cargo.toml                  # Workspace configuration
├── README.md                   # Main documentation
├── CONTRIBUTING.md             # This file
├── PERFORMANCE_COMPARISON.md   # Performance testing guide
└── benches/                    # Benchmark package
    ├── Cargo.toml              # Dependencies and bench configuration
    ├── README.md               # Benchmark documentation
    ├── build.rs                # Build script
    └── benches/                # Benchmark implementations
        ├── arithmetic.rs       # Example benchmark
        ├── *.rs                # Other benchmarks
        └── *.txt               # Test data files
```

## Adding New Benchmarks

### Step 1: Create Benchmark File

Create a new file in `benches/benches/`:

```bash
touch benches/benches/my_new_benchmark.rs
```

### Step 2: Implement Benchmark

Use Criterion.rs framework:

```rust
use criterion::{criterion_group, criterion_main, Criterion, BenchmarkId};
use dfir_rs::dfir_syntax;

fn benchmark_my_feature(c: &mut Criterion) {
    let mut group = c.benchmark_group("my_feature");
    
    for size in [10, 100, 1000] {
        group.bench_with_input(
            BenchmarkId::new("hydro", size),
            &size,
            |b, &size| {
                b.iter(|| {
                    // Your Hydro implementation
                    let df = dfir_syntax! {
                        // ... your dataflow code
                    };
                    df.run_available();
                });
            },
        );
    }
    
    group.finish();
}

criterion_group!(benches, benchmark_my_feature);
criterion_main!(benches);
```

### Step 3: Register Benchmark

Add to `benches/Cargo.toml`:

```toml
[[bench]]
name = "my_new_benchmark"
harness = false
```

### Step 4: Add Test Data (if needed)

If your benchmark requires test data:

```bash
# Add data file
echo "data" > benches/benches/my_data.txt

# Load in benchmark
let data = include_str!("my_data.txt");
```

### Step 5: Document Benchmark

Add documentation to `benches/README.md`:

```markdown
- **my_new_benchmark** - Description of what this benchmark measures
```

### Step 6: Test

Run your new benchmark:

```bash
cargo bench -p benches --bench my_new_benchmark
```

## Modifying Existing Benchmarks

### Making Changes

1. Create a feature branch:
```bash
git checkout -b improve-reachability-benchmark
```

2. Save baseline before changes:
```bash
cargo bench -p benches --bench reachability -- --save-baseline before
```

3. Make your changes

4. Test and compare:
```bash
cargo bench -p benches --bench reachability -- --baseline before
```

### What to Modify

Acceptable modifications:
- **Bug fixes**: Correcting benchmark implementation errors
- **Performance improvements**: Optimizing benchmark code (not the code being tested)
- **Additional test cases**: Adding new input sizes or scenarios
- **Better comparisons**: Adding or improving comparative benchmarks
- **Documentation**: Clarifying what benchmarks measure

### What to Avoid

- **Changing methodology**: Don't change what's being measured without discussion
- **Removing comparisons**: Keep existing baseline comparisons intact
- **Unfair optimizations**: Don't optimize in ways that wouldn't apply to real usage

## Testing Your Changes

### Local Testing

1. Run specific benchmark:
```bash
cargo bench -p benches --bench YOUR_BENCHMARK
```

2. Run all benchmarks:
```bash
cargo bench -p benches
```

3. Quick test during development:
```bash
cargo bench -p benches -- --quick
```

### Validation Checklist

Before submitting:

- [ ] Benchmark compiles without warnings
- [ ] Benchmark runs successfully
- [ ] Results are stable (small confidence intervals)
- [ ] Baseline comparisons work (if applicable)
- [ ] Documentation is updated
- [ ] Code follows style guidelines
- [ ] Commit messages are clear

## Submitting Pull Requests

### PR Preparation

1. Update your fork:
```bash
git fetch upstream
git rebase upstream/main
```

2. Run full benchmark suite:
```bash
cargo bench -p benches
```

3. Check formatting:
```bash
cargo fmt --all --check
```

4. Run clippy:
```bash
cargo clippy --all-targets --all-features -- -D warnings
```

### PR Structure

**Title Format:**
```
Add [benchmark name] benchmark for [feature/comparison]
```

**PR Description:**
```markdown
## Overview
Brief description of what this PR adds or changes.

## Benchmark Details
- **Name**: my_new_benchmark
- **Purpose**: Measures X performance
- **Comparisons**: Hydro vs Timely (if applicable)
- **Input sizes**: [10, 100, 1000, 10000]

## Changes Made
- Added `benches/benches/my_new_benchmark.rs`
- Updated `benches/Cargo.toml` with new benchmark entry
- Added test data `my_data.txt`
- Updated `benches/README.md` with benchmark description

## Testing
- Ran benchmark locally: `cargo bench -p benches --bench my_new_benchmark`
- Results: [brief summary or link to results]

## Related
- Related to issue #123
- Companion to hydro PR #456
```

### Review Process

1. Submit PR to main repository
2. Automated CI will run benchmarks
3. Maintainers will review:
   - Code quality
   - Benchmark methodology
   - Documentation
   - Test results
4. Address review feedback
5. PR will be merged when approved

## Code Style

### Rust Style

Follow standard Rust conventions:

```rust
// Use descriptive names
fn benchmark_graph_reachability(c: &mut Criterion) { ... }

// Group related benchmarks
let mut group = c.benchmark_group("reachability");

// Comment complex logic
// This benchmark measures incremental reachability updates
// by adding edges one at a time and measuring update latency
```

### Benchmark Organization

```rust
// 1. Imports
use criterion::{...};
use dfir_rs::{...};

// 2. Helper functions (if needed)
fn generate_test_data(size: usize) -> Vec<(u32, u32)> { ... }

// 3. Benchmark functions
fn benchmark_feature_hydro(c: &mut Criterion) { ... }
fn benchmark_feature_timely(c: &mut Criterion) { ... }

// 4. Criterion setup
criterion_group!(benches, benchmark_feature_hydro, benchmark_feature_timely);
criterion_main!(benches);
```

### Comments

Add comments for:
- Non-obvious setup code
- Benchmark methodology
- Why certain parameters were chosen
- Known limitations

```rust
// Test with exponentially increasing sizes to identify
// algorithmic complexity characteristics
for size in [10, 100, 1000, 10000] {
    // ...
}
```

## Documentation

### Benchmark Documentation

Each benchmark should be documented:

**In code:**
```rust
/// Benchmark for graph reachability computation.
/// 
/// This benchmark measures the performance of computing
/// reachable nodes in a graph, comparing Hydro's implementation
/// with differential-dataflow.
/// 
/// Input sizes: 100, 1000, 10000 edges
/// Measures: Initial computation time and update latency
```

**In README.md:**
```markdown
- **reachability** - Graph reachability benchmark (includes differential-dataflow comparison)
```

**In PERFORMANCE_COMPARISON.md:**
Update if adding new comparison methodologies or significant benchmarks.

### Commit Messages

Follow Conventional Commits format:

```
feat(benches): add graph reachability benchmark

Adds a new benchmark comparing Hydro and differential-dataflow
performance for graph reachability computation.

- Tests multiple graph sizes
- Measures both initial computation and updates
- Includes test data with realistic graph structure
```

Types:
- `feat`: New benchmark or feature
- `fix`: Bug fix in benchmark
- `docs`: Documentation only
- `refactor`: Code restructuring
- `test`: Adding or updating tests
- `chore`: Maintenance tasks

## Performance Considerations

### Benchmark Performance

Write efficient benchmarks:

```rust
// ✅ Good: Setup outside measurement
let data = generate_test_data(size);
b.iter(|| {
    // Only measure the actual operation
    compute_reachability(&data)
});

// ❌ Bad: Setup inside measurement
b.iter(|| {
    let data = generate_test_data(size); // This will be measured!
    compute_reachability(&data)
});
```

### Avoiding Optimization Issues

```rust
// ✅ Good: Use black_box to prevent over-optimization
use criterion::black_box;
b.iter(|| {
    black_box(compute_result(black_box(&input)))
});

// ❌ Bad: Compiler might optimize away
b.iter(|| {
    compute_result(&input) // Result might be eliminated
});
```

### Iteration Count

Let Criterion determine iteration count automatically:

```rust
// ✅ Good: Criterion manages iterations
b.iter(|| operation());

// ❌ Avoid: Manual iteration (unless necessary)
b.iter(|| {
    for _ in 0..1000 {
        operation();
    }
});
```

## Questions and Support

### Getting Help

- **Questions**: Open a GitHub Discussion
- **Bugs**: Open an issue with "bug" label
- **Ideas**: Open an issue with "enhancement" label
- **Urgent**: Tag maintainers in issue/PR

### Resources

- [Criterion.rs Book](https://bheisler.github.io/criterion.rs/book/)
- [Hydro Documentation](https://hydro.run)
- [Main Repository](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)

## Recognition

Contributors will be:
- Listed in release notes
- Credited in relevant documentation
- Mentioned in related issues/PRs

Thank you for contributing to Hydro benchmarks! Your work helps ensure Hydro maintains excellent performance.
