# Contributing to Hydro-Deps

Thank you for your interest in contributing to the Hydro dependencies repository!

## Repository Purpose

This repository contains benchmarks and code that depend on external packages like `timely-dataflow` and `differential-dataflow`. These have been separated from the main Hydro repository to maintain a clean dependency structure.

## Prerequisites

1. Clone both repositories in the same parent directory:
   ```bash
   git clone https://github.com/hydro-project/hydro.git bigweaver-agent-canary-hydro-zeta
   git clone https://github.com/hydro-project/hydro-deps.git bigweaver-agent-canary-zeta-hydro-deps
   ```

2. Ensure you have Rust installed (see [rust-lang.org](https://www.rust-lang.org/tools/install))

## Development Workflow

### Running Benchmarks

```bash
# Run all benchmarks
cargo bench -p benches

# Run specific benchmark
cargo bench -p benches --bench micro_ops

# Run benchmark with specific test
cargo bench -p benches --bench micro_ops -- specific_test_name
```

### Code Style

This repository follows the same code style guidelines as the main Hydro repository:

- Format code with `cargo fmt`
- Check lints with `cargo clippy`
- Warnings are treated as errors

### Making Changes

1. Create a feature branch from `main`
2. Make your changes
3. Test the benchmarks to ensure they still work
4. Format your code: `cargo fmt`
5. Check for issues: `cargo clippy`
6. Commit your changes with a descriptive message
7. Submit a pull request

### Commit Message Format

Follow the [Conventional Commits](https://www.conventionalcommits.org/) specification:

```
type(scope): description

[optional body]

[optional footer]
```

Examples:
- `feat(benches): add new benchmark for hash join operations`
- `fix(benches): correct data generation in reachability benchmark`
- `docs: update README with new benchmark instructions`

### Coordinating with Main Repository

When changes in the main Hydro repository affect code in this repository (or vice versa):

1. Create PRs in both repositories
2. Link the PRs in their descriptions
3. Specify the merge order in PR descriptions
4. Test that benchmarks work with the updated main repository code

## Getting Help

- For general Hydro questions, see the [main repository](https://github.com/hydro-project/hydro)
- For benchmark-specific issues, open an issue in this repository
- Join the [Hydro Discord](https://hydro.run/discord) for community support

## Code of Conduct

This project follows the same Code of Conduct as the main Hydro project. Be respectful and constructive in all interactions.

## License

By contributing to this repository, you agree that your contributions will be licensed under the Apache License 2.0.
