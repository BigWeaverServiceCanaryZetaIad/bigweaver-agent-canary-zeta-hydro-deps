# Contributing to bigweaver-agent-canary-zeta-hydro-deps

Thank you for your interest in contributing to the Hydro benchmark repository!

## 📋 Overview

This repository contains performance benchmarks for Hydro, Timely, and Differential Dataflow. The benchmarks were separated from the main repository to maintain clean dependency management while preserving the ability to run performance comparisons.

## 🚀 Getting Started

### Prerequisites

1. **Rust toolchain**: Install Rust 1.91.1 or later (as specified in `rust-toolchain.toml`)
2. **Main repository**: Clone the main bigweaver-agent-canary-hydro-zeta repository alongside this one:
   ```bash
   parent-directory/
   ├── bigweaver-agent-canary-hydro-zeta/
   └── bigweaver-agent-canary-zeta-hydro-deps/
   ```

### Repository Setup

```bash
# Clone this repository
git clone <repo-url> bigweaver-agent-canary-zeta-hydro-deps
cd bigweaver-agent-canary-zeta-hydro-deps

# Verify the main repository is in the correct location
ls ../bigweaver-agent-canary-hydro-zeta

# Run benchmarks to verify setup
cargo bench -p benches
```

## 🧪 Running Benchmarks

### All Benchmarks
```bash
cargo bench -p benches
```

### Specific Benchmark
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
```

### Quick Benchmarks (reduced samples)
```bash
cargo bench -p benches -- --quick
```

### Baseline Comparison
```bash
# Save current results as baseline
cargo bench -p benches -- --save-baseline my-baseline

# Compare against baseline
cargo bench -p benches -- --baseline my-baseline
```

## 🔧 Code Style

This repository follows the same coding standards as the main Hydro repository:

### Formatting
```bash
cargo fmt --all
```

### Linting
```bash
cargo clippy --all-targets --all-features
```

Configuration files:
- `rustfmt.toml` - Code formatting rules
- `clippy.toml` - Linting configuration
- `rust-toolchain.toml` - Rust version and components

## 📝 Adding New Benchmarks

### 1. Create Benchmark File

Add a new file in `benches/benches/your_benchmark.rs`:

```rust
use criterion::{Criterion, criterion_group, criterion_main};
use dfir_rs::dfir_syntax;

fn benchmark_hydro(c: &mut Criterion) {
    c.bench_function("your_benchmark/hydro", |b| {
        b.iter(|| {
            // Your Hydro implementation
        });
    });
}

fn benchmark_timely(c: &mut Criterion) {
    c.bench_function("your_benchmark/timely", |b| {
        b.iter(|| {
            // Your Timely implementation
        });
    });
}

criterion_group!(benches, benchmark_hydro, benchmark_timely);
criterion_main!(benches);
```

### 2. Register in Cargo.toml

Add to `benches/Cargo.toml`:

```toml
[[bench]]
name = "your_benchmark"
harness = false
```

### 3. Add Documentation

Update `benches/README.md` with:
- Benchmark name and purpose
- What it measures
- Expected performance characteristics
- Any special data requirements

### 4. Test the Benchmark

```bash
cargo bench -p benches --bench your_benchmark
```

## 📊 Benchmark Best Practices

### Structure
- Include multiple implementations (Hydro, Timely, Differential when applicable)
- Use consistent naming: `benchmark_name/implementation_type`
- Group related benchmarks using criterion groups

### Performance
- Use `black_box()` to prevent optimization of benchmark code
- Ensure benchmarks run long enough for accurate measurements
- Use appropriate sample sizes

### Data
- Include test data files in `benches/benches/`
- Use `include_bytes!()` for loading data at compile time
- Document data sources and licenses

### Documentation
- Add comments explaining what's being measured
- Document any non-obvious setup or teardown
- Include example outputs or expected results

## 🧹 Code Quality

### Before Submitting
1. Format code: `cargo fmt --all`
2. Fix linting issues: `cargo clippy --all-targets --all-features`
3. Run all benchmarks: `cargo bench -p benches`
4. Update documentation as needed

### Common Issues
- **Path dependencies**: Ensure paths to `dfir_rs` and `sinktools` are correct
- **Missing data files**: Include all required test data files
- **Build script errors**: Check `build.rs` if generating code at build time

## 🤝 Pull Request Guidelines

### PR Structure
- Clear, descriptive title
- Summary of changes
- Benchmark results showing improvements/changes
- Documentation updates

### PR Checklist
- [ ] Code is formatted (`cargo fmt`)
- [ ] No clippy warnings (`cargo clippy`)
- [ ] Benchmarks run successfully
- [ ] Documentation updated
- [ ] Test data files included (if applicable)
- [ ] Commit messages follow conventional commits format

### Commit Message Format
Follow the [Conventional Commits](https://www.conventionalcommits.org/) specification:

```
feat(benches): add new dataflow pattern benchmark
fix(reachability): correct edge data loading
docs(readme): update benchmark descriptions
chore(deps): update criterion to 0.5.1
```

## 📦 Dependencies

### Core Dependencies
- **criterion**: Benchmarking framework
- **timely**: Timely dataflow
- **differential-dataflow**: Differential dataflow
- **dfir_rs**: Hydro DFIR (from main repo)
- **sinktools**: Output utilities (from main repo)

### Updating Dependencies
1. Update version in `benches/Cargo.toml`
2. Test all benchmarks: `cargo bench -p benches`
3. Document any breaking changes
4. Update `README.md` if dependency changes affect usage

## 🔗 Related Documentation

- [Main Repository Contributing Guide](../bigweaver-agent-canary-hydro-zeta/CONTRIBUTING.md)
- [Benchmark README](benches/README.md)
- [Criterion Documentation](https://bheisler.github.io/criterion.rs/book/)

## 📬 Questions?

For questions about:
- **Benchmarks**: Open an issue in this repository
- **Hydro implementation**: See the main repository
- **Performance issues**: Include benchmark results and system information

## 🙏 Thank You

Your contributions help improve Hydro's performance and ensure we maintain high-quality benchmarks for comparing dataflow systems!
