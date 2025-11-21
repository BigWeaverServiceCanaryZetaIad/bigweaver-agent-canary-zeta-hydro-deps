# Contributing to Hydro Performance Comparison Benchmarks

Thank you for your interest in contributing to the Hydro performance comparison benchmarks!

## Overview

This repository contains benchmarks that compare Hydro/dfir_rs performance with Timely Dataflow 
and Differential Dataflow implementations. These benchmarks have been separated from the main 
Hydro repository to isolate the timely/differential dependencies.

## Prerequisites

To work with and run these benchmarks, you need:

1. Rust toolchain (same version as specified in the main Hydro repository)
2. Access to the main Hydro repository for `dfir_rs` and `sinktools` dependencies
3. Familiarity with the Criterion benchmarking framework

## Adding New Benchmarks

When adding a new benchmark that compares Hydro with Timely/Differential:

1. Create a new `.rs` file in `benches/benches/`
2. Follow the existing benchmark structure (see examples like `arithmetic.rs`)
3. Include multiple implementations:
   - Hydro/dfir_rs implementation
   - Timely Dataflow implementation (if applicable)
   - Differential Dataflow implementation (if applicable)
   - Optional: baseline implementations (raw iterators, channels, etc.)
4. Add the benchmark entry to `benches/Cargo.toml`
5. Update the `benches/README.md` with the new benchmark description

## Benchmark Structure

A typical benchmark should:

```rust
use criterion::{Criterion, criterion_group, criterion_main};
use dfir_rs::dfir_syntax;
use timely::dataflow::operators::*;

fn benchmark_hydroflow(c: &mut Criterion) {
    c.bench_function("my_benchmark/dfir_rs", |b| {
        // Hydro implementation
    });
}

fn benchmark_timely(c: &mut Criterion) {
    c.bench_function("my_benchmark/timely", |b| {
        // Timely implementation
    });
}

criterion_group!(
    my_benchmark,
    benchmark_hydroflow,
    benchmark_timely,
);
criterion_main!(my_benchmark);
```

## Running Benchmarks

```bash
# Run all benchmarks
cargo bench -p benches

# Run specific benchmark
cargo bench -p benches --bench my_benchmark

# Run with specific filter
cargo bench -p benches --bench my_benchmark -- pattern
```

## Performance Guidelines

1. **Fair Comparisons**: Ensure all implementations solve the same problem with similar semantics
2. **Realistic Workloads**: Use workloads that represent real-world scenarios
3. **Multiple Scales**: Test with different input sizes when appropriate
4. **Proper Warmup**: Let Criterion handle warmup automatically
5. **Black Box**: Use `criterion::black_box()` to prevent compiler optimizations from eliminating work

## Data Files

If your benchmark requires data files:

1. Place them in `benches/benches/` directory
2. Use `include_bytes!()` or `include_str!()` for embedding
3. Document the source/generation of the data in comments
4. Update the benchmark README with data file information

## Dependencies

### Adding Dependencies

Only add dependencies that are necessary for:
- Timely Dataflow benchmarks
- Differential Dataflow benchmarks  
- Hydro benchmarks (via git dependencies)
- Benchmark infrastructure (Criterion, etc.)

Do not add unrelated dependencies.

### Git Dependencies

The `dfir_rs` and `sinktools` dependencies point to the main Hydro repository via git:

```toml
[dev-dependencies.dfir_rs]
git = "https://github.com/hydro-project/hydro"
features = [ "debugging" ]
```

## Testing Changes

Before submitting a pull request:

1. Run all benchmarks to ensure they compile and execute:
   ```bash
   cargo bench -p benches
   ```

2. Verify benchmark results are sensible (no crashes, reasonable performance)

3. Check that documentation is updated

## Code Style

Follow the same coding style as the main Hydro repository:

- Use `rustfmt` for formatting
- Use `clippy` for linting
- Follow Rust naming conventions
- Add comments for complex logic

## Pull Request Process

1. Fork the repository
2. Create a feature branch
3. Add your benchmark(s)
4. Update documentation
5. Test thoroughly
6. Submit a pull request with:
   - Clear description of what the benchmark measures
   - Rationale for the comparison
   - Sample results (if informative)
   - Any special setup or data requirements

## Questions?

If you have questions about contributing:

1. Check the main Hydro repository documentation
2. Review existing benchmarks as examples
3. Open an issue for discussion

## License

By contributing to this repository, you agree that your contributions will be licensed under 
the Apache-2.0 license, consistent with the main Hydro project.
