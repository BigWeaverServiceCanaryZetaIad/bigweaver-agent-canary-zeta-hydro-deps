# Contributing to Hydro Benchmarks

Thank you for your interest in contributing to the Hydro benchmark suite! This repository contains performance benchmarks comparing Hydro with timely-dataflow and differential-dataflow.

## Adding New Benchmarks

To add a new benchmark to this repository:

### 1. Create the Benchmark File

Create a new `.rs` file in the `benches/benches/` directory:

```bash
touch benches/benches/my_new_benchmark.rs
```

### 2. Implement the Benchmark

Use the `criterion` framework for your benchmark. Here's a basic template:

```rust
use criterion::{criterion_group, criterion_main, Criterion};

fn my_benchmark(c: &mut Criterion) {
    c.bench_function("benchmark_name", |b| {
        b.iter(|| {
            // Your benchmark code here
        });
    });
}

criterion_group!(benches, my_benchmark);
criterion_main!(benches);
```

### 3. Register the Benchmark

Add your benchmark to `benches/Cargo.toml`:

```toml
[[bench]]
name = "my_new_benchmark"
harness = false
```

### 4. Test Locally

Run your benchmark locally to ensure it works:

```bash
cargo bench -p benches --bench my_new_benchmark
```

### 5. Update Documentation

Add your benchmark to the list in the main `README.md` file with a brief description of what it tests.

## Running Benchmarks

### Run All Benchmarks

```bash
cargo bench -p benches
```

### Run Specific Benchmark

```bash
cargo bench -p benches --bench <benchmark_name>
```

### Run with Specific Filter

```bash
cargo bench -p benches -- <filter_pattern>
```

## Benchmark Guidelines

### Performance Considerations

- Keep benchmarks focused on specific operations
- Use realistic data sizes when possible
- Avoid I/O operations unless testing I/O performance
- Use `criterion::black_box()` to prevent compiler optimizations from eliminating code

### Code Quality

- Follow the same coding standards as the main Hydro repository
- Run `cargo fmt` and `cargo clippy` before submitting
- Add comments explaining complex benchmark logic
- Include data files in the repository when needed (see existing examples)

### Naming Conventions

- Use descriptive names that indicate what is being benchmarked
- Use snake_case for file and function names
- Group related benchmarks together when possible

## CI/CD Integration

Benchmarks are automatically run via GitHub Actions:

- **Scheduled Runs**: Daily at 8:35 PM PDT / 7:35 PM PST
- **Manual Trigger**: Via GitHub Actions workflow dispatch
- **Commit Trigger**: Include `[ci-bench]` in commit messages
- **Pull Request Trigger**: Include `[ci-bench]` in PR title or description

## Updating Dependencies

When updating the Hydro dependency version:

1. Update the `rev` field in `benches/Cargo.toml` to point to the desired commit
2. Run all benchmarks to ensure they still compile and work correctly
3. Update `MIGRATION.md` with the new commit reference
4. Create a pull request with your changes

## Benchmark Results

- Local results are stored in `target/criterion/`
- HTML reports can be viewed by opening `target/criterion/report/index.html` in a browser
- CI results are published to GitHub Pages (if enabled)

## Questions or Issues?

For general contribution guidelines, see the main [Hydro repository](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta/blob/main/CONTRIBUTING.md).

For questions specific to benchmarks, please open an issue in this repository.
