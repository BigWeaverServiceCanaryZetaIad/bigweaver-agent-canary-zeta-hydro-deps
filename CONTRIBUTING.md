# Contributing to Hydro Dependencies Repository

Thanks for your interest in contributing to the Hydro dependencies repository! This repository contains benchmarks and dependencies that have been separated from the main Hydro project.

## Repository Purpose

This repository serves as a companion to the main [Hydro project](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta), containing:

1. **Benchmarks** comparing Hydro with Timely Dataflow and Differential Dataflow
2. **Dependencies** on external frameworks not needed in the core Hydro project

## Development Setup

### Prerequisites

- Rust 1.91.1 or later (specified in `rust-toolchain.toml`)
- Git

### Getting Started

```bash
# Clone the repository
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps

# Build the project
cargo build --workspace

# Run tests
cargo test --workspace

# Run benchmarks
cargo bench -p benches
```

## Project Structure

- `benches/` - Microbenchmarks for Timely/Differential Dataflow
  - `benches/benches/` - Individual benchmark implementations
  - `build.rs` - Build script for generating benchmark code
  - `Cargo.toml` - Benchmark package dependencies

## Code Style

This repository follows the same code style as the main Hydro project:

### Formatting

Code is formatted using `rustfmt` with the configuration in `rustfmt.toml`:

```bash
cargo fmt --all
```

### Linting

Code is linted using `clippy` with the configuration in `clippy.toml`:

```bash
cargo clippy --workspace --all-targets -- -D warnings
```

## Running Benchmarks

### Run All Benchmarks

```bash
cargo bench -p benches
```

### Run Specific Benchmark

```bash
cargo bench -p benches --bench reachability
```

### Save Baseline for Comparison

```bash
cargo bench -p benches -- --save-baseline my-baseline
```

### Compare with Baseline

```bash
cargo bench -p benches -- --baseline my-baseline
```

## Adding New Benchmarks

When adding a new benchmark:

1. Create a new `.rs` file in `benches/benches/`
2. Follow the existing patterns (use Criterion, harness = false)
3. Add a `[[bench]]` entry to `benches/Cargo.toml`
4. Update `benches/README.md` to document the new benchmark
5. Ensure the benchmark uses Timely/Differential Dataflow (that's the purpose of this repo)

Example:

```rust
use criterion::{Criterion, criterion_group, criterion_main};
use timely::dataflow::operators::{ToStream, Inspect};

fn my_benchmark(c: &mut Criterion) {
    c.bench_function("my_benchmark", |b| {
        b.iter(|| {
            // Your benchmark code here
        });
    });
}

criterion_group!(benches, my_benchmark);
criterion_main!(benches);
```

## Testing

### Unit Tests

```bash
cargo test --workspace
```

### Integration Tests

The benchmarks themselves serve as integration tests, ensuring the dependencies work correctly.

## Submitting Changes

### Commit Messages

Follow the [Conventional Commits](https://www.conventionalcommits.org/) specification:

```
type(scope): description

[optional body]

[optional footer]
```

Examples:
- `feat(benches): add new graph traversal benchmark`
- `fix(benches): correct reachability data file path`
- `docs(readme): update performance comparison instructions`
- `chore(deps): update timely-dataflow to 0.13.1`

### Pull Requests

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/my-feature`)
3. Make your changes
4. Run tests and benchmarks to verify
5. Format code: `cargo fmt --all`
6. Run linting: `cargo clippy --workspace --all-targets -- -D warnings`
7. Commit your changes following commit message guidelines
8. Push to your fork
9. Create a Pull Request with a clear description

### PR Description Template

```markdown
## Description
Brief description of what this PR does.

## Changes Made
- List of changes
- Another change

## Why These Changes Are Necessary
Explanation of motivation and context.

## Testing
How the changes were tested.

## Related Issues
Fixes #123
```

## CI/CD

The repository has two GitHub Actions workflows:

1. **CI** (`.github/workflows/ci.yml`) - Runs on every push/PR:
   - Tests on stable and beta Rust
   - Format checks
   - Clippy linting
   - Build verification

2. **Benchmarks** (`.github/workflows/benchmark.yml`) - Runs on:
   - Schedule (daily)
   - Manual trigger
   - When `[ci-bench]` is in commit message or PR title/body

## Relationship with Main Repository

This repository is designed to work alongside the main Hydro repository:

- **Dependencies**: Can reference `dfir_rs` from the main repo via Git dependency
- **Performance Comparison**: Benchmarks can compare Timely/Differential with Hydro
- **Independent Evolution**: Changes here don't require changes in main repo

When making changes that affect both repositories:
1. Coordinate with the main repository maintainers
2. Document the relationship in PR descriptions
3. Consider merge order if dependencies are involved

## Questions or Issues?

- For benchmark-specific questions: Open an issue in this repository
- For Hydro functionality questions: See the [main repository](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)
- For general questions: Check the [Hydro documentation](https://hydro.run)

## License

This project is licensed under the Apache License 2.0 - see the [LICENSE](LICENSE) file for details.
