# Contributing to bigweaver-agent-canary-zeta-hydro-deps

Thank you for your interest in contributing to the bigweaver-agent-canary-zeta-hydro-deps repository! This document provides guidelines for contributing benchmarks, documentation, and improvements.

## Table of Contents

1. [Getting Started](#getting-started)
2. [Repository Structure](#repository-structure)
3. [Adding New Benchmarks](#adding-new-benchmarks)
4. [Modifying Existing Benchmarks](#modifying-existing-benchmarks)
5. [Documentation Guidelines](#documentation-guidelines)
6. [Testing Your Changes](#testing-your-changes)
7. [Pull Request Process](#pull-request-process)
8. [Code Style](#code-style)
9. [Performance Considerations](#performance-considerations)

## Getting Started

### Prerequisites

- Rust 1.91.1 (managed via rust-toolchain.toml)
- Basic understanding of benchmarking with Criterion.rs
- Familiarity with Timely or Differential Dataflow (for relevant benchmarks)

### Initial Setup

1. Clone the repository:
   ```bash
   cd /projects/sandbox
   git clone <repository-url> bigweaver-agent-canary-zeta-hydro-deps
   cd bigweaver-agent-canary-zeta-hydro-deps
   ```

2. Verify setup:
   ```bash
   bash verify_setup.sh
   ```

3. Run a smoke test:
   ```bash
   cargo bench -- --test
   ```

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── Cargo.toml                    # Workspace configuration
├── rust-toolchain.toml           # Rust toolchain version
├── README.md                     # Main documentation
├── BENCHMARK_GUIDE.md            # Performance comparison guide
├── CHANGELOG.md                  # Version history
├── CONTRIBUTING.md               # This file
├── verify_setup.sh               # Setup verification script
└── benches/                      # Benchmark package
    ├── Cargo.toml                # Benchmark dependencies
    ├── README.md                 # Benchmark documentation
    ├── build.rs                  # Build-time code generation
    └── benches/                  # Benchmark implementations
        ├── *.rs                  # Benchmark source files
        └── *.txt                 # Data files
```

## Adding New Benchmarks

### Step 1: Create the Benchmark File

Create a new file in `benches/benches/`:

```rust
// benches/benches/my_new_benchmark.rs

use criterion::{Criterion, black_box, criterion_group, criterion_main};
use timely::dataflow::operators::{ToStream, Inspect};

const WORKLOAD_SIZE: usize = 1_000_000;

fn benchmark_timely_implementation(c: &mut Criterion) {
    c.bench_function("my_new_benchmark/timely", |b| {
        b.iter(|| {
            timely::example(|scope| {
                (0..WORKLOAD_SIZE)
                    .to_stream(scope)
                    .inspect(|x| {
                        black_box(x);
                    });
            });
        })
    });
}

// Add more benchmark variations (raw, hydro, etc.)

criterion_group!(
    my_benchmark_group,
    benchmark_timely_implementation,
);
criterion_main!(my_benchmark_group);
```

### Step 2: Register in Cargo.toml

Add the benchmark entry in `benches/Cargo.toml`:

```toml
[[bench]]
name = "my_new_benchmark"
harness = false
```

### Step 3: Document the Benchmark

Update `benches/README.md`:

1. Add to the benchmark list
2. Describe what it tests
3. Note any special requirements or data files
4. Document expected performance characteristics

### Step 4: Update CHANGELOG.md

Add an entry under "Added" in the unreleased section:

```markdown
### Added
- `my_new_benchmark.rs` - Description of what this benchmark tests
```

### Step 5: Test Your Benchmark

```bash
# Quick smoke test
cargo bench --bench my_new_benchmark -- --test

# Full benchmark run
cargo bench --bench my_new_benchmark

# Verify results
open target/criterion/my_new_benchmark/report/index.html
```

## Modifying Existing Benchmarks

### Making Changes

1. **Preserve existing benchmarks**: If adding new variants, keep old ones for comparison
2. **Document changes**: Update comments explaining what changed and why
3. **Update constants**: If changing workload size, use constants at the top of the file
4. **Test thoroughly**: Run benchmarks before and after to detect regressions

### Example Modification

```rust
// Before
const NUM_INTS: usize = 1_000_000;

// After - with documentation
const NUM_INTS: usize = 10_000_000;  // Increased for better signal-to-noise ratio
```

### Documenting Changes

Update `CHANGELOG.md`:

```markdown
### Changed
- Increased workload size in `arithmetic.rs` from 1M to 10M for better precision
```

## Documentation Guidelines

### Code Comments

- **Purpose**: Explain what the benchmark tests, not how it works
- **Assumptions**: Document any assumptions about data or environment
- **Performance notes**: Note expected relative performance

Example:
```rust
// Tests the overhead of fork-join patterns with filtering.
// Splits data stream based on even/odd predicate, processes separately,
// then merges results. Expected to be ~2x slower than identity due to
// branching overhead.
fn benchmark_fork_join(c: &mut Criterion) {
    // ...
}
```

### README Updates

When adding benchmarks, update the appropriate README:

1. **benches/README.md**: Technical details, running instructions
2. **Main README.md**: High-level overview if significant
3. **BENCHMARK_GUIDE.md**: If adding new comparison patterns

### Documentation Style

- Use clear, concise language
- Include code examples
- Provide expected output examples
- Link to relevant external documentation

## Testing Your Changes

### Verification Checklist

Before submitting a pull request:

- [ ] Run `bash verify_setup.sh` successfully
- [ ] Run `cargo check` without errors
- [ ] Run `cargo bench -- --test` for quick validation
- [ ] Run full benchmarks: `cargo bench --bench <name>`
- [ ] Review HTML reports for sanity
- [ ] Update documentation
- [ ] Update CHANGELOG.md
- [ ] Add or update code comments

### Running Tests

```bash
# Quick verification
cargo check
cargo bench -- --test

# Full benchmark suite (can take 10+ minutes)
cargo bench

# Specific benchmark
cargo bench --bench arithmetic

# Compare against baseline
cargo bench -- --save-baseline before
# Make changes
cargo bench -- --baseline before
```

## Pull Request Process

### 1. Prepare Your Changes

- Create a feature branch: `git checkout -b add-new-benchmark`
- Make your changes
- Test thoroughly
- Update documentation
- Commit with clear messages

### 2. Commit Message Format

Follow conventional commits:

```
type(scope): description

[optional body]

[optional footer]
```

Types:
- `feat`: New benchmark or feature
- `fix`: Bug fix
- `docs`: Documentation only
- `perf`: Performance improvement
- `refactor`: Code restructuring without behavior change
- `test`: Adding or updating tests

Examples:
```
feat(benches): add graph traversal benchmark

Adds new benchmark for graph traversal patterns using timely dataflow.
Compares BFS and DFS implementations.

docs(readme): update benchmark list with new graph benchmarks

fix(reachability): correct data file path handling
```

### 3. Create Pull Request

Structure your PR description:

```markdown
## Overview
Brief description of what this PR does

## Changes
- Added/Modified/Fixed X
- Updated documentation in Y
- Added tests for Z

## Testing
- [ ] Ran verify_setup.sh
- [ ] Ran cargo bench -- --test
- [ ] Ran full benchmarks
- [ ] Reviewed HTML reports

## Performance Impact
- Benchmark X: ~100ms (baseline)
- New benchmark Y: ~150ms
- No regressions detected

## Documentation
- Updated benches/README.md
- Updated CHANGELOG.md
- Added inline comments

## Related Issues
Closes #123 (if applicable)
```

## Code Style

### Rust Style

Follow standard Rust conventions:

- Use `rustfmt` for formatting
- Use `clippy` for linting
- Follow naming conventions in existing code

```bash
# Format code
cargo fmt

# Check with clippy
cargo clippy -- -D warnings
```

### Benchmark Structure

Follow the existing pattern:

```rust
// 1. Imports
use criterion::{Criterion, black_box, criterion_group, criterion_main};
use timely::dataflow::operators::{ToStream, Inspect};

// 2. Constants
const WORKLOAD_SIZE: usize = 1_000_000;

// 3. Benchmark functions
fn benchmark_variant_1(c: &mut Criterion) {
    c.bench_function("name/variant1", |b| {
        b.iter(|| {
            // benchmark code
        })
    });
}

// 4. Criterion group
criterion_group!(
    benchmark_group_name,
    benchmark_variant_1,
    benchmark_variant_2,
);

// 5. Main
criterion_main!(benchmark_group_name);
```

### Naming Conventions

- **Files**: `snake_case.rs` (e.g., `fork_join.rs`)
- **Functions**: `snake_case` (e.g., `benchmark_timely_implementation`)
- **Constants**: `UPPER_SNAKE_CASE` (e.g., `NUM_INTS`)
- **Criterion test names**: `category/variant` (e.g., `arithmetic/timely`)

## Performance Considerations

### Benchmark Design

1. **Representative workloads**: Use realistic data sizes
2. **Black-box critical values**: Prevent compiler optimization: `black_box(x)`
3. **Minimize setup**: Put setup in `iter_batched` if needed
4. **Statistical significance**: Ensure sufficient iterations
5. **Consistent environment**: Document system requirements

### Example: Good Benchmark

```rust
fn benchmark_good(c: &mut Criterion) {
    c.bench_function("example/good", |b| {
        b.iter_batched(
            || {
                // Setup (run once per batch)
                vec![0; 1000]
            },
            |mut data| {
                // Benchmark code (timed)
                for x in data.iter_mut() {
                    *x = black_box(*x + 1);
                }
                black_box(data);
            },
            criterion::BatchSize::SmallInput,
        )
    });
}
```

### Performance Gotchas

❌ **Avoid**:
```rust
// Compiler can optimize this away!
b.iter(|| {
    let x = 42;
    x + 1
});
```

✅ **Do**:
```rust
// Forces compiler to actually compute
b.iter(|| {
    let x = black_box(42);
    black_box(x + 1)
});
```

### Data Files

If your benchmark needs data files:

1. Keep files small (< 1MB if possible)
2. Place in `benches/benches/`
3. Document source and generation method
4. Add to `.gitignore` if very large (provide generation script)

## Questions?

If you have questions:

1. Check existing benchmarks for examples
2. Review documentation in README files
3. Open an issue for discussion
4. Refer to [Criterion.rs documentation](https://bheisler.github.io/criterion.rs/book/)

## License

By contributing, you agree that your contributions will be licensed under the same license as this project (Apache-2.0).
