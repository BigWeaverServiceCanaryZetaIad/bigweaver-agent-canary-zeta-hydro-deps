# Contributing to bigweaver-agent-canary-zeta-hydro-deps

Thank you for your interest in contributing to this benchmarking repository!

## Getting Started

This repository contains benchmarks for timely and differential-dataflow that were separated 
from the main `bigweaver-agent-canary-hydro-zeta` repository.

### Prerequisites

- Rust toolchain (stable or nightly as specified in rust-toolchain.toml if present)
- Git access to the main repository (for git dependencies)

### Building

```bash
cargo build -p benches
```

### Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run a specific benchmark:
```bash
cargo bench -p benches --bench reachability
```

## Adding New Benchmarks

To add a new benchmark:

1. Create a new `.rs` file in `benches/benches/` directory
2. Add the benchmark configuration to `benches/Cargo.toml`:
   ```toml
   [[bench]]
   name = "my_benchmark"
   harness = false
   ```
3. Implement your benchmark using the Criterion framework
4. Update the README.md to document the new benchmark
5. Run the benchmark locally to ensure it works

### Benchmark Structure

Benchmarks should follow this pattern:

```rust
use criterion::{Criterion, criterion_group, criterion_main};

fn my_benchmark_function(c: &mut Criterion) {
    c.bench_function("my_benchmark/description", |b| {
        b.iter(|| {
            // benchmark code here
        });
    });
}

criterion_group!(benches, my_benchmark_function);
criterion_main!(benches);
```

## Updating Dependencies

### From Main Repository

To update dfir_rs or sinktools dependencies:

1. Update the git revision in `benches/Cargo.toml`:
   ```toml
   dfir_rs = { git = "...", rev = "new_commit_hash", features = [ "debugging" ] }
   ```
2. Run `cargo update` to refresh the lock file
3. Test all benchmarks to ensure compatibility
4. Document any breaking changes

### External Dependencies

To update timely, differential-dataflow, or other crates:

1. Update version in `benches/Cargo.toml`
2. Run `cargo update -p <package-name>`
3. Test all affected benchmarks
4. Update documentation if API changes affect usage

## Testing Changes

Before submitting changes:

1. Ensure all benchmarks compile: `cargo build -p benches --all-targets`
2. Run affected benchmarks to verify they work
3. Check for performance regressions using `--save-baseline` and `--baseline` options
4. Update documentation to reflect any changes

## Pull Request Guidelines

1. **Clear Description**: Explain what the change does and why
2. **Benchmark Results**: Include before/after performance data when relevant
3. **Documentation**: Update README.md and other docs as needed
4. **Atomic Changes**: Keep PRs focused on a single change or feature
5. **Test Locally**: Ensure benchmarks run successfully before submitting

### PR Title Format

Follow the conventional commits format:
- `feat(benches): add new graph algorithm benchmark`
- `fix(benches): correct reachability data loading`
- `docs(benches): update README with new instructions`
- `perf(benches): optimize identity benchmark setup`

## Code Style

- Follow Rust standard formatting (use `rustfmt`)
- Use meaningful variable names
- Add comments for complex algorithms
- Keep benchmarks focused and isolated

## Performance Considerations

When writing benchmarks:

1. **Warm-up**: Criterion handles warm-up automatically
2. **Sample Size**: Let Criterion determine sample size unless you have specific needs
3. **Black Box**: Use `criterion::black_box()` to prevent compiler optimizations
4. **Realistic Data**: Use representative datasets
5. **Isolation**: Avoid shared state between benchmark iterations

## Questions or Problems?

- Open an issue for bugs or feature requests
- Reference the main repository for core functionality questions
- See BENCHMARK_MIGRATION.md for migration-related guidance

## License

By contributing, you agree that your contributions will be licensed under the Apache-2.0 License.
