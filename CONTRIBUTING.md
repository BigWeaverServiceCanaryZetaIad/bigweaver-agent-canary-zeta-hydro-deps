# Contributing to bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks that compare DFIR performance with timely-dataflow and differential-dataflow frameworks.

## Repository Structure

The repository is set up as a Cargo workspace with the following structure:

* `benches/` - Contains comparison benchmarks between DFIR and timely/differential-dataflow
  * `benches/benches/*.rs` - Individual benchmark files
  * `benches/build.rs` - Build script for generating benchmark code
  * `benches/Cargo.toml` - Dependencies including timely-master and differential-dataflow-master

## Dependencies

This repository depends on packages from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository:
- `dfir_rs` - The DFIR runtime
- `sinktools` - Utilities used by benchmarks

These are automatically fetched via git dependencies during the build.

## Adding New Benchmarks

To add a new benchmark:

1. Create a new benchmark file in `benches/benches/`, e.g., `my_benchmark.rs`
2. Follow the existing pattern of implementing benchmarks for:
   - DFIR implementation
   - Timely-dataflow implementation  
   - Differential-dataflow implementation (if applicable)
3. Register the benchmark in `benches/Cargo.toml`:
   ```toml
   [[bench]]
   name = "my_benchmark"
   harness = false
   ```
4. Update `benches/README.md` to document the new benchmark

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run a specific benchmark:
```bash
cargo bench -p benches --bench arithmetic
```

Run a specific benchmark function:
```bash
cargo bench -p benches --bench arithmetic -- "arithmetic/dfir"
```

## Benchmark Structure

Each benchmark should follow this pattern:

```rust
use criterion::{criterion_group, criterion_main, Criterion};
use dfir_rs::dfir_syntax;
use timely::dataflow::operators::*;
use differential_dataflow::operators::*;

fn benchmark_dfir(c: &mut Criterion) {
    c.bench_function("my_benchmark/dfir", |b| {
        // DFIR implementation
    });
}

fn benchmark_timely(c: &mut Criterion) {
    c.bench_function("my_benchmark/timely", |b| {
        // Timely implementation
    });
}

fn benchmark_differential(c: &mut Criterion) {
    c.bench_function("my_benchmark/differential", |b| {
        // Differential implementation
    });
}

criterion_group!(benches, benchmark_dfir, benchmark_timely, benchmark_differential);
criterion_main!(benches);
```

## Code Style

This repository follows the same code style as the main Hydro project:
- Use `rustfmt` for formatting: `cargo fmt`
- Use `clippy` for linting: `cargo clippy`
- Configuration files (`rustfmt.toml`, `clippy.toml`) are synchronized with the main repository

## Rust Toolchain

The project uses a pinned Rust nightly version specified in `rust-toolchain.toml`. The toolchain is automatically detected by `cargo`.

## Submitting Changes

Follow the same contribution guidelines as the main Hydro project:

1. Create a feature branch
2. Make your changes
3. Ensure benchmarks compile and run
4. Submit a pull request with a clear description

### Commit Messages

Follow [Conventional Commits specification](https://www.conventionalcommits.org/):
- `feat(benches): add new xyz benchmark`
- `fix(benches): correct arithmetic benchmark implementation`
- `docs(benches): update README with new benchmark info`

## Testing

While these are benchmarks, ensure they compile and run correctly:

```bash
# Check compilation
cargo check -p benches

# Run benchmarks to verify they work
cargo bench -p benches
```

## Performance Regression Testing

When modifying existing benchmarks:
1. Run benchmarks before changes: `cargo bench -p benches > before.txt`
2. Make your changes
3. Run benchmarks after changes: `cargo bench -p benches > after.txt`
4. Compare results to ensure no unintended performance regressions

## License

Apache-2.0 (same as the main Hydro project)
