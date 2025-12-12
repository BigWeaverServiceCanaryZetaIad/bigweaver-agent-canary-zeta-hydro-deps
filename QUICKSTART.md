# Quick Start Guide

## For Developers Adding Benchmarks

### Prerequisites
```bash
# Ensure Rust is installed
rustc --version
cargo --version
```

### Adding Your First Benchmark

#### 1. Create Benchmark Crate
```bash
cargo new --lib benchmarks/my_benchmark
cd benchmarks/my_benchmark
```

#### 2. Edit Cargo.toml
```toml
[package]
name = "my_benchmark"
version = "0.1.0"
edition = "2024"
publish = false

[dependencies]
# Add timely/differential-dataflow as needed
timely = "0.12"
differential-dataflow = "0.12"

# Benchmark framework
criterion = { version = "0.5", features = ["html_reports"] }

[[bench]]
name = "my_benchmark"
harness = false
```

#### 3. Create Benchmark
```bash
mkdir benches
cat > benches/my_benchmark.rs << 'EOF'
use criterion::{black_box, criterion_group, criterion_main, Criterion};

fn my_operation() {
    // Your code here
}

fn bench_my_operation(c: &mut Criterion) {
    c.bench_function("my_operation", |b| {
        b.iter(|| black_box(my_operation()))
    });
}

criterion_group!(benches, bench_my_operation);
criterion_main!(benches);
EOF
```

#### 4. Add to Workspace
Edit root `Cargo.toml`:
```toml
[workspace]
members = [
    "benchmarks/my_benchmark",
]
```

#### 5. Run Benchmark
```bash
cd ../..
cargo bench --package my_benchmark
```

## For Developers Running Benchmarks

### Run All Benchmarks
```bash
./run_benchmarks.sh --all
```

### Run Specific Benchmark
```bash
./run_benchmarks.sh --package my_benchmark
```

### Compare Performance
```bash
# Save baseline
./run_benchmarks.sh --all --baseline before

# Make changes...

# Compare
./run_benchmarks.sh --all --compare before
```

### Cross-Repository Comparison
```bash
./compare_with_main_repo.sh
```

## For Reviewers

### Review Checklist
- [ ] Benchmark builds: `cargo build --package my_benchmark`
- [ ] Benchmark runs: `cargo bench --package my_benchmark`
- [ ] Code formatted: `cargo fmt --check`
- [ ] Lints pass: `cargo clippy`
- [ ] Documentation updated in BENCHMARKS.md
- [ ] PR description is complete

## Quick Reference

| Task | Command |
|------|---------|
| Build all | `cargo build --all` |
| Test all | `cargo test --all` |
| Bench all | `cargo bench --all` |
| Format | `cargo fmt --all` |
| Lint | `cargo clippy --all` |
| View results | `open target/criterion/report/index.html` |

## Common Issues

**Q: Cargo says no benchmarks found**
A: The workspace has no benchmark members yet. Add one following the steps above.

**Q: How do I add timely/differential-dataflow?**
A: Add to your benchmark crate's Cargo.toml dependencies section.

**Q: Where do I document my benchmark?**
A: Update BENCHMARKS.md with details about your benchmark.

## More Information

- Full documentation: [README.md](README.md)
- Detailed benchmarks guide: [BENCHMARKS.md](BENCHMARKS.md)
- Contributing guidelines: [CONTRIBUTING.md](CONTRIBUTING.md)
- Migration guide: [../bigweaver-agent-canary-hydro-zeta/BENCHMARK_MIGRATION.md](../bigweaver-agent-canary-hydro-zeta/BENCHMARK_MIGRATION.md)
