# Contributing to Hydro Benchmark Dependencies

Thank you for your interest in contributing to the Hydro benchmark repository!

## Repository Purpose

This repository exists to maintain benchmark code comparing DFIR (Hydro) with timely-dataflow and differential-dataflow frameworks. It was separated from the main Hydro repository to:

1. Reduce dependency bloat in the main codebase
2. Preserve performance comparison capabilities
3. Allow independent evolution of benchmark code
4. Maintain CI/CD infrastructure for automated benchmarking

## Getting Started

### Prerequisites

- Rust toolchain (version specified in `rust-toolchain.toml`)
- Git
- Familiarity with dataflow programming concepts

### Building the Project

```bash
# Clone the repository
git clone <repository-url>
cd bigweaver-agent-canary-zeta-hydro-deps

# Build all packages
cargo build --workspace

# Run tests
cargo test --workspace

# Run benchmarks
cargo bench -p benches
```

## Repository Structure

```
.
├── benches/              # Benchmark implementations
│   ├── benches/         # Individual benchmark files
│   ├── Cargo.toml       # Benchmark package configuration
│   ├── build.rs         # Build-time code generation
│   └── README.md        # Benchmark-specific docs
├── dfir_rs/             # Core DFIR runtime
├── dfir_lang/           # DFIR language support
├── dfir_macro/          # DFIR proc macros
├── lattices/            # Lattice types library
├── sinktools/           # Sink utilities
├── variadics/           # Variadic type support
├── .github/             # CI/CD workflows
│   ├── workflows/       # GitHub Actions
│   └── gh-pages/        # GitHub Pages assets
├── Cargo.toml           # Workspace configuration
├── README.md            # Main documentation
├── BENCHMARKS.md        # Detailed benchmark docs
└── CONTRIBUTING.md      # This file
```

## Types of Contributions

### 1. Adding New Benchmarks

When adding a new benchmark:

1. **Create the benchmark file**: Place it in `benches/benches/`
2. **Register in Cargo.toml**: Add a `[[bench]]` entry
3. **Follow the pattern**: Include DFIR, Timely, and/or Differential variants
4. **Document thoroughly**: Add comments explaining what's being tested

Example structure:
```rust
use criterion::{criterion_group, criterion_main, Criterion};

fn benchmark_dfir(c: &mut Criterion) {
    c.bench_function("my_test/dfir", |b| {
        b.iter(|| {
            // DFIR implementation
        });
    });
}

fn benchmark_timely(c: &mut Criterion) {
    c.bench_function("my_test/timely", |b| {
        b.iter(|| {
            // Timely implementation
        });
    });
}

criterion_group!(benches, benchmark_dfir, benchmark_timely);
criterion_main!(benches);
```

### 2. Updating Dependencies

**Core Dependencies (dfir_rs, etc.)**:
- These should generally track the main Hydro repository
- Update via copying from main repo or using git dependencies
- Test thoroughly after updates

**External Dependencies (timely, differential)**:
- Keep versions synchronized with what's benchmarked
- Document version changes in commit messages
- Update benchmarks if APIs change

**Criterion and Test Dependencies**:
- Keep reasonably up to date
- Ensure compatibility with CI environment

### 3. Improving Benchmark Quality

Good benchmarks should:
- **Measure meaningful work**: Avoid benchmarking trivial operations
- **Be representative**: Reflect real-world usage patterns
- **Be stable**: Produce consistent results across runs
- **Be fair**: Compare equivalent operations across frameworks
- **Be documented**: Explain what's being measured and why

### 4. CI/CD Improvements

The GitHub Actions workflow can be improved:
- Optimize benchmark execution time
- Enhance result visualization
- Add performance regression detection
- Improve artifact organization

### 5. Documentation

Documentation improvements are always welcome:
- Clarify existing benchmarks
- Add usage examples
- Explain performance characteristics
- Document expected results

## Coding Standards

### Rust Style
- Follow standard Rust formatting (use `rustfmt`)
- Run `clippy` and address warnings
- Write idiomatic Rust code

### Benchmark Conventions
- Use descriptive benchmark names: `pattern/framework/variant`
- Group related benchmarks with `criterion_group!`
- Use consistent measurement units
- Include warm-up iterations

### Comments
- Explain non-obvious implementations
- Document performance characteristics
- Note framework-specific idioms
- Reference relevant papers/documentation

## Testing

### Before Submitting

1. **Build successfully**:
   ```bash
   cargo build --workspace
   ```

2. **Run tests**:
   ```bash
   cargo test --workspace
   ```

3. **Run benchmarks**:
   ```bash
   cargo bench -p benches -- --quick
   ```

4. **Check formatting**:
   ```bash
   cargo fmt --all -- --check
   ```

5. **Check lints**:
   ```bash
   cargo clippy --workspace --all-targets
   ```

### Benchmark Validation

- Ensure benchmarks complete in reasonable time (< 5 min each)
- Verify results are consistent across runs
- Check that all framework variants produce equivalent results
- Test with different data sizes if applicable

## Submitting Changes

### Pull Request Process

1. **Create a feature branch**:
   ```bash
   git checkout -b feature/my-improvement
   ```

2. **Make your changes** with clear, focused commits

3. **Test thoroughly** (see Testing section)

4. **Push and create PR**:
   ```bash
   git push origin feature/my-improvement
   ```

5. **Describe your changes**:
   - What does this change do?
   - Why is it needed?
   - How does it work?
   - Are there performance implications?

### Commit Message Guidelines

- Use present tense: "Add benchmark" not "Added benchmark"
- Be descriptive but concise
- Reference issues: "Fixes #123"
- Include `[ci-bench]` to trigger benchmark runs

Examples:
```
Add symmetric hash join benchmark

Implements benchmark comparing DFIR and Differential
symmetric hash join performance on streaming data.

[ci-bench]
```

### PR Review

PRs will be reviewed for:
- **Correctness**: Does it work as intended?
- **Performance**: Does it introduce regressions?
- **Code quality**: Is it well-written and maintainable?
- **Documentation**: Is it adequately documented?
- **Testing**: Are there appropriate tests?

## Benchmark Execution in CI

### Automatic Triggers
- **Daily**: Scheduled run at 8:35 PM PDT
- **On demand**: Manual workflow dispatch
- **Commits**: Include `[ci-bench]` in message
- **PRs**: Include `[ci-bench]` in title or body

### Interpreting CI Results

1. **Check workflow status**: Green = passed, Red = failed
2. **Review artifacts**: Download benchmark results
3. **Compare with baseline**: Look for regressions
4. **Check GitHub Pages**: View historical trends

## Performance Expectations

### Typical Benchmark Times
- **Simple operations** (identity, arithmetic): < 10s
- **Medium complexity** (joins, fan-in/out): 10-60s
- **Complex operations** (reachability, diamond): 1-5min
- **Full suite**: ~20-30min

### Resource Usage
- **Memory**: 2-8 GB typical, up to 16GB for large datasets
- **CPU**: Benefits from multi-core (timely especially)
- **Disk**: ~100MB for data files

## Getting Help

- **Questions**: Open a discussion or issue
- **Bugs**: Open an issue with reproduction steps
- **Ideas**: Open an issue for discussion before implementing

## Relationship with Main Repository

This repository is a companion to the main Hydro repository:
- **Main repo**: Core Hydro/DFIR development
- **This repo**: Benchmarks with external dependencies

When updating core dependencies:
1. Sync with main repository versions
2. Test all benchmarks still work
3. Update documentation if APIs changed

## Code of Conduct

Be respectful, constructive, and collaborative. We're all here to improve dataflow computing!

## License

By contributing, you agree that your contributions will be licensed under the Apache-2.0 license.
