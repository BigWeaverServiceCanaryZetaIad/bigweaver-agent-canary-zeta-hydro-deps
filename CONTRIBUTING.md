# Contributing to Hydro Benchmarks

Thank you for your interest in contributing to the Hydro benchmarking repository!

## Repository Purpose

This repository contains benchmarks comparing Hydro (dfir_rs) with timely-dataflow and differential-dataflow. The benchmarks help track performance characteristics and ensure competitive performance.

## Getting Started

### Prerequisites

- Rust 1.91.1 (automatically managed via `rust-toolchain.toml`)
- Git
- Familiarity with Rust and criterion benchmarking framework

### Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
   cd bigweaver-agent-canary-zeta-hydro-deps
   ```

2. Verify setup:
   ```bash
   bash verify_setup.sh
   ```

3. Build the workspace:
   ```bash
   cargo build --workspace
   ```

4. Run benchmarks:
   ```bash
   cargo bench -p benches
   ```

## Code Quality Standards

This repository follows strict code quality standards:

### Formatting

All code must be formatted using `rustfmt`:
```bash
cargo fmt --all
```

Configuration is in `rustfmt.toml`.

### Linting

All code must pass clippy checks:
```bash
cargo clippy --all -- -D warnings
```

Configuration is in `clippy.toml`.

### Before Committing

Always run these checks before committing:
```bash
cargo fmt --all -- --check
cargo clippy --all
cargo build --workspace
cargo test --workspace  # If tests exist
```

## Adding New Benchmarks

To add a new benchmark:

1. **Create the benchmark file** in `benches/benches/<name>.rs`
   - Follow the existing pattern (see `identity.rs` for a simple example)
   - Include comparisons for timely, differential, and dfir_rs implementations
   - Use criterion's benchmarking framework
   - Document the benchmark purpose

2. **Register the benchmark** in `benches/Cargo.toml`:
   ```toml
   [[bench]]
   name = "your_benchmark_name"
   harness = false
   ```

3. **Document the benchmark** in `benches/README.md` and main `README.md`

4. **Test the benchmark**:
   ```bash
   cargo bench -p benches --bench your_benchmark_name
   ```

5. **Add any required test data** to `benches/benches/` directory

### Benchmark Structure Example

```rust
use criterion::{Criterion, black_box, criterion_group, criterion_main};
use dfir_rs::dfir_syntax;
use timely::dataflow::operators::{Map, ToStream};

fn benchmark_dfir(c: &mut Criterion) {
    c.bench_function("benchmark_name/dfir", |b| {
        b.iter(|| {
            // Your dfir_rs benchmark implementation
        });
    });
}

fn benchmark_timely(c: &mut Criterion) {
    c.bench_function("benchmark_name/timely", |b| {
        b.iter(|| {
            // Your timely benchmark implementation
        });
    });
}

criterion_group!(benches, benchmark_dfir, benchmark_timely);
criterion_main!(benches);
```

## Pull Request Process

1. **Create a branch** for your changes:
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Make your changes** following the code quality standards

3. **Test thoroughly**:
   ```bash
   cargo fmt --all -- --check
   cargo clippy --all
   cargo build --workspace
   cargo bench -p benches --bench <your-benchmark>
   ```

4. **Commit with a descriptive message** following Conventional Commits:
   ```bash
   git commit -m "feat(benches): add new benchmark for <feature>"
   ```
   
   Commit message format: `type(scope): description`
   - Types: `feat`, `fix`, `docs`, `chore`, `test`, `refactor`, `ci`
   - Scope: usually `benches`, `docs`, or `ci`
   - Breaking changes: Add `!` after type, e.g., `feat!:`

5. **Push your branch**:
   ```bash
   git push origin feature/your-feature-name
   ```

6. **Create a Pull Request** with:
   - Clear title describing the change
   - Detailed description of what and why
   - Results of running the new/modified benchmarks
   - Any relevant performance comparisons

### Pull Request Template

Your PR description should include:

```markdown
## Overview
Brief description of changes

## Task Details
- ✅ Item 1 completed
- ✅ Item 2 completed

## Changes Made
### Added Files
- List new files

### Modified Files
- List modified files

### Removed Files (if any)
- List removed files

## Benefits
- Benefit 1
- Benefit 2

## Testing
- Description of how you tested
- Benchmark results (if applicable)

## Related Changes
- Link to related PRs or issues
```

## Dependency Management

### Git Dependencies

This repository uses Git dependencies to remain independent:

```toml
dfir_rs = { git = "https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git", features = [ "debugging" ] }
timely = { git = "https://github.com/TimelyDataflow/timely-dataflow.git" }
differential-dataflow = { git = "https://github.com/TimelyDataflow/differential-dataflow.git" }
```

### Updating Dependencies

To update dependencies:
```bash
cargo update
```

To pin a specific revision:
```toml
dfir_rs = { git = "https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git", rev = "abc123", features = [ "debugging" ] }
```

## Documentation

### Documentation Standards

- All benchmarks should have clear comments explaining their purpose
- Update README.md when adding new benchmarks
- Keep BENCHMARK_MIGRATION.md updated with significant changes
- Use clear, concise language
- Include code examples where helpful

### Updating Documentation

When making changes:
1. Update relevant README files
2. Update BENCHMARK_MIGRATION.md if architecture changes
3. Update comments in code
4. Update this CONTRIBUTING.md if process changes

## Issue Reporting

When reporting issues:

1. **Search existing issues** first
2. **Use a clear title** describing the problem
3. **Include details**:
   - Rust version: `rustc --version`
   - OS and version
   - Steps to reproduce
   - Expected vs actual behavior
   - Error messages (full output)
   - Relevant benchmark results

### Issue Template

```markdown
**Description**
Clear description of the issue

**Steps to Reproduce**
1. Step 1
2. Step 2
3. ...

**Expected Behavior**
What you expected to happen

**Actual Behavior**
What actually happened

**Environment**
- OS: 
- Rust version: 
- Relevant dependency versions:

**Additional Context**
Any other relevant information
```

## Performance Considerations

When adding or modifying benchmarks:

- **Ensure meaningful comparisons** - Benchmark equivalent operations
- **Use appropriate sample sizes** - Balance accuracy and runtime
- **Document performance characteristics** - Note any surprising results
- **Consider warmup time** - Some operations need warmup
- **Test on representative data** - Use realistic data sizes

## Questions or Help

- Review existing benchmarks in `benches/benches/`
- Check the main README.md
- Review BENCHMARK_MIGRATION.md for architecture context
- Open an issue for questions
- Reference the main Hydro repository for core library questions

## Code of Conduct

- Be respectful and inclusive
- Focus on constructive feedback
- Help others learn and grow
- Follow the team's established patterns

## License

By contributing, you agree that your contributions will be licensed under the Apache-2.0 license.

## Thank You!

Thank you for contributing to Hydro benchmarks. Your efforts help improve performance visibility and guide optimization efforts.
