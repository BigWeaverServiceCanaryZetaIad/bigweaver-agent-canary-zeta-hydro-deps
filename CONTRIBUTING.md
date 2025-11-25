# Contributing to Hydro Dependencies Repository

Thank you for your interest in contributing to the Hydro dependencies repository! This document provides guidelines for contributing benchmarks and improvements.

## Table of Contents

- [Getting Started](#getting-started)
- [Repository Structure](#repository-structure)
- [Adding New Benchmarks](#adding-new-benchmarks)
- [Running Tests](#running-tests)
- [Code Style](#code-style)
- [Submitting Changes](#submitting-changes)

## Getting Started

### Prerequisites

1. **Rust Toolchain**: Install the version specified in `rust-toolchain.toml`
2. **Main Repository**: Clone the main `bigweaver-agent-canary-hydro-zeta` repository as a sibling directory
3. **Git**: For version control

### Development Setup

```bash
# Clone this repository
git clone <this-repo-url>
cd bigweaver-agent-canary-zeta-hydro-deps

# Ensure main repository is in sibling directory
ls ../bigweaver-agent-canary-hydro-zeta

# Build benchmarks
cargo build --release -p benches

# Run benchmarks to verify setup
cargo bench -p benches --bench arithmetic
```

## Repository Structure

```
.
├── benches/              # Benchmark package
│   ├── benches/          # Benchmark source files
│   │   ├── *.rs          # Individual benchmark files
│   │   └── *.txt         # Test data files
│   ├── Cargo.toml        # Benchmark dependencies
│   ├── README.md         # Benchmark documentation
│   └── build.rs          # Build script
├── Cargo.toml            # Workspace configuration
├── rustfmt.toml          # Formatting rules
├── clippy.toml           # Linting rules
├── rust-toolchain.toml   # Rust version
└── *.md                  # Documentation files
```

## Adding New Benchmarks

### 1. Create Benchmark File

Create a new `.rs` file in `benches/benches/`:

```rust
use criterion::{black_box, criterion_group, criterion_main, Criterion};
use dfir_rs::prelude::*;

fn my_benchmark_dfir(c: &mut Criterion) {
    c.bench_function("DFIR my operation", |b| {
        b.iter(|| {
            // Your benchmark code here
            black_box(/* operation to measure */);
        });
    });
}

criterion_group!(benches, my_benchmark_dfir);
criterion_main!(benches);
```

### 2. Register in Cargo.toml

Add to `benches/Cargo.toml`:

```toml
[[bench]]
name = "my_benchmark"
harness = false
```

### 3. Add Documentation

Update relevant documentation:
- Add benchmark description to `README.md`
- Add entry to `BENCHMARK_GUIDE.md`
- Add command to `QUICK_REFERENCE.md`

### 4. Test Your Benchmark

```bash
# Verify it compiles
cargo check -p benches --bench my_benchmark

# Run the benchmark
cargo bench -p benches --bench my_benchmark
```

## Benchmark Best Practices

### Structure

1. **Isolate Setup**: Keep setup code outside the measured section
2. **Use `black_box`**: Prevent compiler optimizations from eliminating code
3. **Multiple Frameworks**: When possible, compare DFIR, Timely, and Differential
4. **Parameterization**: Test with multiple input sizes
5. **Documentation**: Document what is being measured and why

### Example Structure

```rust
fn benchmark_with_comparison(c: &mut Criterion) {
    let mut group = c.benchmark_group("operation_comparison");
    
    // DFIR implementation
    group.bench_function("DFIR", |b| {
        b.iter(|| {
            // DFIR code
        });
    });
    
    // Timely implementation
    group.bench_function("Timely", |b| {
        b.iter(|| {
            // Timely code
        });
    });
    
    // Differential implementation
    group.bench_function("Differential", |b| {
        b.iter(|| {
            // Differential code
        });
    });
    
    group.finish();
}
```

### Data Files

If your benchmark requires data files:

1. Place them in `benches/benches/`
2. Use relative paths: `include_str!("data_file.txt")`
3. Document the source and format in the benchmark file
4. Add to `.gitignore` if files are large and can be regenerated

## Running Tests

### Build Verification

```bash
# Check all packages
cargo check --workspace

# Check specific benchmark
cargo check -p benches --bench my_benchmark
```

### Running Benchmarks

```bash
# Run all benchmarks
cargo bench -p benches

# Run specific benchmark
cargo bench -p benches --bench my_benchmark

# Run with filtering
cargo bench -p benches -- "DFIR"
```

### Lint and Format

```bash
# Format code
cargo fmt --all

# Run clippy
cargo clippy --workspace -- -D warnings

# Run clippy on benchmarks specifically
cargo clippy -p benches --benches -- -D warnings
```

## Code Style

### Formatting

- Follow Rust standard formatting rules (see `rustfmt.toml`)
- Use 4-space indentation
- Maximum line length: 100 characters (where reasonable)

### Naming Conventions

- **Benchmark files**: `snake_case.rs` (e.g., `fan_in.rs`)
- **Benchmark functions**: Descriptive names with framework suffix
  ```rust
  fn operation_name_dfir(c: &mut Criterion) { ... }
  fn operation_name_timely(c: &mut Criterion) { ... }
  ```
- **Benchmark IDs**: Clear, hierarchical names
  ```rust
  c.bench_function("DFIR operation_name", |b| { ... });
  ```

### Documentation

- Add doc comments to complex benchmark functions
- Explain what is being measured
- Document any non-obvious setup or teardown
- Reference related benchmarks or issues

Example:
```rust
/// Benchmarks the performance of join operations in DFIR.
/// 
/// This benchmark measures the time to perform a two-way join
/// on generated data. The input sizes are parameterized.
/// 
/// Related benchmarks: symmetric_hash_join, fork_join
fn join_dfir(c: &mut Criterion) {
    // ...
}
```

## Submitting Changes

### Before Submitting

1. ✅ Format code: `cargo fmt --all`
2. ✅ Run clippy: `cargo clippy --workspace -- -D warnings`
3. ✅ Build benchmarks: `cargo build --release -p benches`
4. ✅ Run affected benchmarks: `cargo bench -p benches --bench <your-benchmark>`
5. ✅ Update documentation (README, guides, etc.)
6. ✅ Write clear commit messages (see below)

### Commit Message Format

Follow the Conventional Commits specification:

```
type(scope): description

[optional body]

[optional footer]
```

**Types:**
- `feat`: New benchmark or feature
- `fix`: Bug fix in benchmark
- `docs`: Documentation changes
- `chore`: Maintenance tasks
- `refactor`: Code restructuring
- `test`: Test-related changes
- `perf`: Performance improvements

**Examples:**
```
feat(benches): add graph traversal benchmark

Add new benchmark for graph traversal algorithms comparing
DFIR, Timely, and Differential implementations.

docs(guide): update benchmark guide with new examples

fix(benches): correct data path in reachability benchmark
```

### Pull Request Process

1. **Create a feature branch**
   ```bash
   git checkout -b feat/my-new-benchmark
   ```

2. **Make your changes**
   - Follow code style guidelines
   - Add tests/benchmarks as appropriate
   - Update documentation

3. **Commit your changes**
   ```bash
   git add .
   git commit -m "feat(benches): add my new benchmark"
   ```

4. **Push to remote**
   ```bash
   git push origin feat/my-new-benchmark
   ```

5. **Create Pull Request**
   - Provide clear description of changes
   - Reference any related issues
   - Include benchmark results if relevant

### Pull Request Template

```markdown
## Description
Brief description of changes

## Type of Change
- [ ] New benchmark
- [ ] Bug fix
- [ ] Documentation update
- [ ] Performance improvement

## Benchmarks Added/Modified
- List of benchmarks affected

## Testing
- [ ] Benchmarks compile
- [ ] Benchmarks run successfully
- [ ] Code formatted with cargo fmt
- [ ] Clippy passes with no warnings

## Documentation
- [ ] Updated README.md
- [ ] Updated BENCHMARK_GUIDE.md
- [ ] Updated QUICK_REFERENCE.md
- [ ] Added inline documentation

## Performance Impact
Describe any performance implications (if applicable)
```

## Questions and Support

- **Documentation**: Check README.md, BENCHMARK_GUIDE.md, and QUICK_REFERENCE.md
- **Issues**: Open an issue for bugs or feature requests
- **Discussion**: For questions about benchmark design or interpretation

## Code of Conduct

Be respectful, professional, and constructive in all interactions.

## License

By contributing, you agree that your contributions will be licensed under the Apache-2.0 license.
