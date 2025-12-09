# Contributing to Hydro-Deps

Thank you for your interest in contributing to the Hydro dependencies repository! This repository contains performance benchmarks and other components that depend on external frameworks.

## Getting Started

1. **Clone the repository**
   ```bash
   git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
   cd bigweaver-agent-canary-zeta-hydro-deps
   ```

2. **Set up for local development** (optional)
   
   If you want to test benchmarks against a local checkout of the main Hydro repository:
   ```bash
   cd benches
   cp Cargo.toml.local Cargo.toml
   # Edit Cargo.toml to adjust the path to your local Hydro repository
   ```

3. **Build and test**
   ```bash
   cargo build -p benches
   cargo bench -p benches
   ```

## Adding New Benchmarks

When adding a new benchmark:

1. **Create the benchmark file** in `benches/benches/your_benchmark.rs`

2. **Implement multiple versions**:
   - Hydro (DFIR) implementation using dfir_rs
   - Timely Dataflow implementation (if applicable)
   - Differential Dataflow implementation (if applicable)

3. **Follow the existing pattern**:
   ```rust
   use criterion::{Criterion, criterion_group, criterion_main};
   use dfir_rs::dfir_syntax;
   use differential_dataflow::operators::*;
   use timely::dataflow::operators::*;
   
   fn benchmark_dfir(c: &mut Criterion) {
       c.bench_function("your_benchmark/dfir", |b| {
           // Your DFIR implementation
       });
   }
   
   fn benchmark_timely(c: &mut Criterion) {
       c.bench_function("your_benchmark/timely", |b| {
           // Your Timely implementation
       });
   }
   
   fn benchmark_differential(c: &mut Criterion) {
       c.bench_function("your_benchmark/differential", |b| {
           // Your Differential implementation
       });
   }
   
   criterion_group!(
       your_benchmark,
       benchmark_dfir,
       benchmark_timely,
       benchmark_differential
   );
   criterion_main!(your_benchmark);
   ```

4. **Add benchmark entry to Cargo.toml**:
   ```toml
   [[bench]]
   name = "your_benchmark"
   harness = false
   ```

5. **Update documentation**:
   - Add benchmark description to README.md
   - Document any special setup or data files needed

## Code Quality

### Formatting

Run rustfmt before committing:
```bash
cargo fmt --all
```

### Linting

Run clippy to catch common mistakes:
```bash
cargo clippy --all-targets --all-features
```

## Testing Benchmarks

Before submitting a PR:

1. **Verify all benchmarks compile**:
   ```bash
   cargo build -p benches --all-targets
   ```

2. **Run your new benchmark**:
   ```bash
   cargo bench -p benches --bench your_benchmark
   ```

3. **Verify correctness**: Ensure all implementations produce the same results

4. **Check performance**: Compare results across frameworks

## Pull Request Guidelines

1. **One benchmark per PR**: Keep PRs focused on a single benchmark or related change

2. **Clear description**: Explain:
   - What the benchmark measures
   - Why it's useful for comparing frameworks
   - Any interesting findings from initial runs

3. **Include results**: Paste sample benchmark output in the PR description

4. **Update documentation**: Ensure README.md and other docs are updated

5. **Follow commit conventions**: Use conventional commit format
   ```
   feat(benches): add graph traversal benchmark
   fix(benches): correct join benchmark correctness check
   docs(benches): improve reachability benchmark documentation
   ```

## Benchmark Best Practices

1. **Fair comparisons**: Ensure all implementations solve the same problem
2. **Realistic workloads**: Use data sizes that reflect real-world usage
3. **Warm-up**: Criterion handles this automatically, but be aware
4. **Determinism**: Use fixed seeds for random data when possible
5. **Document assumptions**: Explain any framework-specific optimizations

## Dependencies

### Updating Hydro Reference

The benchmarks reference the main Hydro repository via git dependencies. To update to a specific commit:

```toml
dfir_rs = { git = "https://github.com/hydro-project/hydro", rev = "abc123", features = [ "debugging" ] }
```

### Updating External Frameworks

When updating timely or differential-dataflow versions:

1. Update version in `benches/Cargo.toml`
2. Check all benchmarks still compile
3. Document any API changes in commit message
4. Update benchmarks if APIs changed

## Getting Help

- **Main Hydro repository**: [hydro-project/hydro](https://github.com/hydro-project/hydro)
- **Timely Dataflow**: [TimelyDataflow/timely-dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- **Differential Dataflow**: [TimelyDataflow/differential-dataflow](https://github.com/TimelyDataflow/differential-dataflow)

## License

By contributing to this repository, you agree that your contributions will be licensed under the Apache-2.0 license.
