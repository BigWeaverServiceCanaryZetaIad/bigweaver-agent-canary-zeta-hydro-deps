# Contributing to Hydro Dependencies Benchmarks

Thank you for your interest in contributing to the Hydro benchmarks repository!

## Getting Started

1. **Clone the repository**:
   ```bash
   git clone https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
   cd bigweaver-agent-canary-zeta-hydro-deps
   ```

2. **Verify setup**:
   ```bash
   cargo build -p benches
   ```

3. **Run existing benchmarks**:
   ```bash
   cargo bench -p benches --bench identity
   ```

## Development Workflow

### Adding a New Benchmark

1. **Create benchmark file**:
   - Add a new `.rs` file in `benches/benches/`
   - Follow the naming convention: `<operation>_<pattern>.rs`
   - Example: `benches/benches/my_new_benchmark.rs`

2. **Implement benchmark**:
   ```rust
   use criterion::{Criterion, black_box, criterion_group, criterion_main};
   use dfir_rs::dfir_syntax;
   use timely::dataflow::operators::{ToStream, Inspect};
   
   fn benchmark_my_operation(c: &mut Criterion) {
       c.bench_function("my_operation/dfir", |b| {
           b.iter(|| {
               // Your DFIR implementation
           });
       });
       
       c.bench_function("my_operation/timely", |b| {
           b.iter(|| {
               // Your timely implementation
           });
       });
   }
   
   criterion_group!(benches, benchmark_my_operation);
   criterion_main!(benches);
   ```

3. **Register benchmark in Cargo.toml**:
   ```toml
   [[bench]]
   name = "my_new_benchmark"
   harness = false
   ```

4. **Add documentation**:
   - Document what the benchmark measures
   - Explain expected performance characteristics
   - Note any special considerations

### Running Your Benchmark

```bash
# Run your new benchmark
cargo bench -p benches --bench my_new_benchmark

# Run with fewer samples for faster iteration
cargo bench -p benches --bench my_new_benchmark -- --quick

# Generate flamegraphs (if profiling tools available)
cargo bench -p benches --bench my_new_benchmark -- --profile-time=5
```

## Benchmark Guidelines

### Structure

Each benchmark should:
- Compare multiple implementations (DFIR, Timely, Differential, Raw Rust)
- Use consistent data sizes and parameters
- Include meaningful names for sub-benchmarks
- Use `black_box()` to prevent over-optimization

### Performance

- Use realistic data sizes
- Avoid artificial optimizations
- Test multiple scenarios (small, medium, large)
- Consider both throughput and latency

### Documentation

Each benchmark file should include:
- A header comment explaining what it tests
- Comments on implementation choices
- Notes on expected performance patterns

Example:
```rust
//! Benchmark for identity/pass-through operations.
//!
//! Tests the overhead of various dataflow frameworks when performing
//! no-op transformations. This represents the baseline performance
//! for each framework.

// Implementation...
```

## Code Style

### Formatting

We use `rustfmt` for code formatting:
```bash
cargo fmt --all
```

Configuration is in `rustfmt.toml`.

### Linting

We use `clippy` for linting:
```bash
cargo clippy --all-targets -- -D warnings
```

Configuration is in `clippy.toml`.

### Conventions

- Use descriptive variable names
- Keep functions focused and concise
- Comment non-obvious performance optimizations
- Follow Rust naming conventions

## Testing

Before submitting:

1. **Verify compilation**:
   ```bash
   cargo build --release -p benches
   ```

2. **Run benchmarks**:
   ```bash
   cargo bench -p benches
   ```

3. **Check for warnings**:
   ```bash
   cargo clippy -p benches
   ```

4. **Format code**:
   ```bash
   cargo fmt -p benches
   ```

## Dependencies

### Adding Dependencies

When adding dependencies to `benches/Cargo.toml`:

1. Justify the addition (why is it needed?)
2. Prefer stable, well-maintained crates
3. Document the purpose in comments
4. Keep dependencies minimal

### Git Dependencies

For Hydro-related dependencies:
```toml
dfir_rs = { 
    git = "https://...bigweaver-agent-canary-hydro-zeta.git",
    features = [ "debugging" ]
}
```

This ensures benchmarks test against the current Hydro version.

## Pull Request Process

1. **Create a branch**:
   ```bash
   git checkout -b add-my-benchmark-YYYYMMDD-HHMMSS
   ```
   
   Follow the naming convention: `<action>-<description>-<date>-<time>`

2. **Make your changes**:
   - Add/modify benchmarks
   - Update documentation
   - Format and lint

3. **Commit your changes**:
   ```bash
   git commit -m "feat(benches): add benchmark for XYZ operation"
   ```
   
   Use conventional commit format:
   - `feat`: New feature/benchmark
   - `fix`: Bug fix
   - `docs`: Documentation only
   - `perf`: Performance improvement
   - `refactor`: Code refactoring
   - `test`: Test changes
   - `chore`: Build/tooling changes

4. **Push and create PR**:
   ```bash
   git push origin add-my-benchmark-YYYYMMDD-HHMMSS
   ```

### PR Description Template

```markdown
## Overview
Brief description of the benchmark added or changed.

## Task Details
- [ ] Added new benchmark: `benchmark_name`
- [ ] Updated documentation
- [ ] Verified compilation
- [ ] Ran benchmarks successfully

## Changes Made
- Detailed list of changes
- Files added/modified

## Testing
- [ ] `cargo build --release -p benches` passes
- [ ] `cargo bench -p benches --bench benchmark_name` runs successfully
- [ ] `cargo clippy -p benches` has no warnings
- [ ] `cargo fmt -p benches --check` passes

## Performance Results
Include sample benchmark results (if applicable).

## Notes
Any special considerations or context.
```

## Review Process

Reviewers will check:
- ✅ Benchmark correctness
- ✅ Code quality and style
- ✅ Documentation completeness
- ✅ Performance methodology
- ✅ Comparison fairness

## Questions?

- Review the [README.md](README.md) for general information
- Check [QUICKSTART.md](QUICKSTART.md) for common commands
- Read [MIGRATION.md](MIGRATION.md) for context on this repository
- Consult the main Hydro repository documentation

## License

By contributing, you agree that your contributions will be licensed under the Apache-2.0 license.
