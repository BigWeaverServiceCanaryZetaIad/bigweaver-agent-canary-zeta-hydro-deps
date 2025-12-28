# Contributing to Hydro Dependencies Repository

Thanks for your interest in contributing to the Hydro benchmarks! This repository contains benchmarks that compare Hydro/DFIR with Timely Dataflow and Differential Dataflow.

## Repository Purpose

This repository maintains benchmarks that:
- Compare Hydro/DFIR performance with Timely and Differential Dataflow
- Require external dataflow framework dependencies
- Enable performance tracking across different implementations

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── benches/           # Benchmark package
│   ├── benches/       # Benchmark source files
│   ├── Cargo.toml     # Dependencies including timely/differential
│   ├── build.rs       # Build script
│   └── README.md      # Benchmark documentation
├── .github/           # CI/CD workflows
│   └── workflows/
│       ├── ci.yml     # Continuous integration
│       └── benchmark.yml  # Benchmark execution
├── Cargo.toml         # Workspace configuration
├── rustfmt.toml       # Code formatting rules
├── clippy.toml        # Linting configuration
└── README.md          # This file
```

## Development Setup

### Prerequisites

1. **Rust**: Install the version specified in `rust-toolchain.toml`
2. **Repository Structure**: Both repositories must be checked out as siblings:

```
/projects/sandbox/
├── bigweaver-agent-canary-hydro-zeta/         # Main Hydro repository
└── bigweaver-agent-canary-zeta-hydro-deps/    # This repository
```

The benchmarks reference `dfir_rs` and `sinktools` from the main repository via relative paths.

### Building

```bash
cd bigweaver-agent-canary-zeta-hydro-deps
cargo check --all-targets
```

### Running Tests

```bash
cargo test --all-targets
```

### Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmark:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench join
```

## Adding New Benchmarks

### When to Add Benchmarks Here

Add benchmarks to this repository if they:
- ✅ Compare Hydro with Timely Dataflow
- ✅ Compare Hydro with Differential Dataflow
- ✅ Require timely or differential-dataflow dependencies

Add benchmarks to the main repository if they:
- ❌ Only test Hydro functionality
- ❌ Don't require external framework dependencies

### Creating a New Benchmark

1. **Create benchmark file** in `benches/benches/your_benchmark.rs`
2. **Add benchmark target** in `benches/Cargo.toml`:
   ```toml
   [[bench]]
   name = "your_benchmark"
   harness = false
   ```
3. **Follow existing patterns**:
   - Use `criterion` for benchmarking infrastructure
   - Include Hydro, Timely, and Differential implementations when relevant
   - Use descriptive benchmark names (e.g., `benchmark_name/framework`)
4. **Document the benchmark** in `benches/README.md`

### Benchmark Structure Template

```rust
use criterion::{Criterion, criterion_group, criterion_main};
use dfir_rs::dfir_syntax;
use timely::dataflow::operators::*;
use differential_dataflow::operators::*;

fn benchmark_hydro(c: &mut Criterion) {
    c.bench_function("your_benchmark/dfir", |b| {
        b.iter(|| {
            // Hydro implementation
        });
    });
}

fn benchmark_timely(c: &mut Criterion) {
    c.bench_function("your_benchmark/timely", |b| {
        b.iter(|| {
            // Timely implementation
        });
    });
}

fn benchmark_differential(c: &mut Criterion) {
    c.bench_function("your_benchmark/differential", |b| {
        b.iter(|| {
            // Differential implementation
        });
    });
}

criterion_group!(
    your_benchmark,
    benchmark_hydro,
    benchmark_timely,
    benchmark_differential,
);
criterion_main!(your_benchmark);
```

## Code Style

### Formatting

This repository uses the same formatting rules as the main Hydro repository:

```bash
cargo fmt --all
```

### Linting

Run clippy with the same settings as the main repository:

```bash
cargo clippy --all-targets --all-features -- -D warnings
```

## Submitting Changes

### Feature Branches

Create feature branches for new work:

```bash
git fetch origin
git checkout -b feature/$FEATURE_NAME origin/main
git push origin HEAD
```

### Commit Messages

Follow [Conventional Commits specification](https://www.conventionalcommits.org/):

- `feat: Add new join benchmark`
- `fix: Correct reachability benchmark setup`
- `docs: Update benchmark documentation`
- `perf: Optimize benchmark data generation`

### Pull Requests

1. Ensure all benchmarks compile and run
2. Update documentation if adding/modifying benchmarks
3. Run formatting and linting checks
4. Include benchmark results in PR description if relevant

## CI/CD

### Continuous Integration

The CI workflow (`ci.yml`) runs on every push and PR:
- Checks that code compiles
- Runs tests
- Verifies formatting
- Runs clippy lints

### Benchmark Workflow

The benchmark workflow (`benchmark.yml`) runs:
- On schedule (daily)
- When manually triggered
- When commits contain `[ci-bench]`
- When PRs contain `[ci-bench]` in title/body

## Troubleshooting

### Build Errors

If you encounter build errors:

1. **Check repository structure**: Ensure both repos are siblings
2. **Verify paths**: Path dependencies in `Cargo.toml` must be correct
3. **Update dependencies**: Run `cargo update` if needed
4. **Check Rust version**: Ensure you're using the version in `rust-toolchain.toml`

### Benchmark Failures

If benchmarks fail or produce unexpected results:

1. **Check data files**: Ensure `.txt` data files are present
2. **Verify implementations**: Compare with working benchmarks
3. **Review criterion output**: Look for specific error messages
4. **Test incrementally**: Run individual benchmarks to isolate issues

## Getting Help

If you need assistance:

1. Check the [BENCHMARK_MIGRATION.md](../bigweaver-agent-canary-hydro-zeta/BENCHMARK_MIGRATION.md) in the main repository
2. Review existing benchmarks for examples
3. Consult the main Hydro [CONTRIBUTING.md](../bigweaver-agent-canary-hydro-zeta/CONTRIBUTING.md)
4. Reach out to the development team

## Related Documentation

- [Main Hydro Repository](../bigweaver-agent-canary-hydro-zeta/)
- [Benchmark Migration Guide](../bigweaver-agent-canary-hydro-zeta/BENCHMARK_MIGRATION.md)
- [Benchmark Documentation](benches/README.md)
- [Hydro Documentation](https://hydro.run/docs)

## License

Apache-2.0 (same as the main Hydro repository)
