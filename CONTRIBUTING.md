# Contributing to bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependency-heavy components for the Hydro project. Contributions to improve benchmark coverage and performance analysis are welcome.

## Development Setup

### Prerequisites

- Rust toolchain (automatically installed via `rust-toolchain.toml`)
- Git

### Building

```bash
# Clone the repository
git clone <repository-url>
cd bigweaver-agent-canary-zeta-hydro-deps

# Build all benchmarks
cargo build --release -p benches
```

## Running Benchmarks

### All Benchmarks

```bash
cargo bench -p benches
```

### Individual Benchmarks

```bash
# Micro-operations benchmarks
cargo bench -p benches --bench micro_ops

# Symmetric hash join benchmarks
cargo bench -p benches --bench symmetric_hash_join

# Words diamond benchmarks
cargo bench -p benches --bench words_diamond

# Futures benchmarks
cargo bench -p benches --bench futures
```

### Viewing Results

Benchmark results are saved as HTML reports in `target/criterion/`. Open the `index.html` file in a browser to view detailed results and historical comparisons.

## Code Quality Standards

### Formatting

All code must be formatted with `rustfmt`:

```bash
cargo fmt --all --check
```

To automatically format code:

```bash
cargo fmt --all
```

### Linting

All code must pass `clippy` checks with no warnings:

```bash
cargo clippy --workspace -- -D warnings
```

## Adding New Benchmarks

1. Create a new `.rs` file in `benches/benches/`
2. Use the Criterion framework for benchmarking
3. Add a `[[bench]]` section to `benches/Cargo.toml`
4. Update the README with benchmark description
5. Ensure benchmarks follow existing patterns
6. Test that benchmarks run successfully

Example benchmark structure:

```rust
use criterion::{criterion_group, criterion_main, Criterion};

fn my_benchmark(c: &mut Criterion) {
    c.bench_function("my_test", |b| {
        b.iter(|| {
            // Benchmark code here
        })
    });
}

criterion_group!(benches, my_benchmark);
criterion_main!(benches);
```

## Dependencies

### Adding Dependencies

When adding new dependencies:

1. Add to appropriate section in `benches/Cargo.toml`
2. Use specific versions (avoid `*` or overly broad ranges)
3. Document why the dependency is needed
4. Consider impact on build times and binary size

### Core Dependencies

- **timely**: For Timely Dataflow comparisons
- **differential-dataflow**: For Differential Dataflow comparisons  
- **dfir_rs**: Core Hydro/DFIR implementation
- **criterion**: Benchmarking framework

## Pull Request Process

1. Ensure all benchmarks build and run successfully
2. Run formatting and linting checks
3. Update documentation if adding new benchmarks
4. Provide clear description of changes
5. Include benchmark results if relevant

## Benchmark Best Practices

1. **Warmup**: Ensure proper warmup before measurements
2. **Sample Size**: Use appropriate sample sizes for statistical significance
3. **Black Box**: Use `black_box()` to prevent compiler optimization of benchmark code
4. **Consistency**: Maintain consistent naming and structure with existing benchmarks
5. **Documentation**: Comment complex benchmark setups

## Questions or Issues?

If you have questions or encounter issues, please open an issue on the repository.
