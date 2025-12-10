# Contributing to bigweaver-agent-canary-zeta-hydro-deps

Thank you for considering contributing to this repository! This guide will help you understand how to add or modify benchmarks.

## Purpose of This Repository

This repository contains benchmarks that depend on `timely` and `differential-dataflow`. These benchmarks were separated from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to avoid unnecessary dependencies.

## When to Add Benchmarks Here

Add benchmarks to this repository if they:
- Use the `timely` dataflow library
- Use the `differential-dataflow` library
- Compare dfir_rs performance against timely/differential implementations

Add benchmarks to the main repository if they:
- Only use dfir_rs and standard Rust dependencies
- Don't require timely or differential-dataflow

## Adding a New Benchmark

1. **Create the benchmark file:**
   ```bash
   cd benches/benches
   touch your_benchmark.rs
   ```

2. **Add the benchmark entry to `benches/Cargo.toml`:**
   ```toml
   [[bench]]
   name = "your_benchmark"
   harness = false
   ```

3. **Write your benchmark:**
   ```rust
   use criterion::{Criterion, criterion_group, criterion_main};
   
   fn your_benchmark(c: &mut Criterion) {
       c.bench_function("your_benchmark/name", |b| {
           b.iter(|| {
               // Your benchmark code
           });
       });
   }
   
   criterion_group!(benches, your_benchmark);
   criterion_main!(benches);
   ```

4. **Test your benchmark:**
   ```bash
   cargo bench --bench your_benchmark
   ```

5. **Update documentation:**
   - Add the benchmark to the list in `README.md`
   - Update `MIGRATION.md` if relevant

## Benchmark Structure

Follow these conventions:
- Use `criterion` for benchmarking
- Group related benchmarks in the same file
- Include descriptive names for benchmark functions
- Add comments explaining what is being tested
- Include any necessary data files in the `benches/benches/` directory

## Dependencies

Available dependencies (see `benches/Cargo.toml`):
- `criterion` - Benchmarking framework
- `timely` - Timely dataflow
- `differential-dataflow` - Differential dataflow
- `dfir_rs` - From main repository (git dependency)
- `sinktools` - From main repository (git dependency)
- Standard Rust libraries (futures, tokio, etc.)

## Running Tests

Before submitting:
1. Run all benchmarks to ensure they work:
   ```bash
   cargo bench
   ```

2. Check that your code compiles:
   ```bash
   cargo check
   ```

## Code Style

- Follow Rust standard formatting (`rustfmt`)
- Use meaningful variable and function names
- Add comments for complex logic

## Submitting Changes

1. Create a descriptive commit message following conventional commits format
2. Create a pull request with:
   - Clear description of what the benchmark tests
   - Why the benchmark is useful
   - Any special setup or data files required
   - Results or comparisons if relevant

## Questions?

If you're unsure whether a benchmark belongs in this repository or the main repository, ask in your pull request or open an issue.
