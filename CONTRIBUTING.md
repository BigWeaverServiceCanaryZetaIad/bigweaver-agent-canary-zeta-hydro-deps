# Contributing to bigweaver-agent-canary-zeta-hydro-deps

Thanks for your interest in contributing! This repository contains benchmarks and code that depend on timely and differential-dataflow, separated from the main Hydro repository to reduce dependency overhead.

## Repository Structure

- `benches/` - Performance benchmarks using timely and differential-dataflow
  - `benches/benches/` - Benchmark source files
  - `benches/build.rs` - Build script
  - `benches/Cargo.toml` - Benchmark dependencies

## Prerequisites

This repository has path dependencies on the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository. Ensure both are cloned at the same level:

```
parent-directory/
├── bigweaver-agent-canary-hydro-zeta/
└── bigweaver-agent-canary-zeta-hydro-deps/  (this repository)
```

## Development

### Running Benchmarks

```bash
cd benches
cargo bench
```

Run a specific benchmark:
```bash
cargo bench --bench arithmetic
```

### Code Style

This repository follows the same code style as the main Hydro repository:

- Use `rustfmt` for formatting (configuration in `rustfmt.toml`)
- Use `clippy` for linting (configuration in `clippy.toml`)
- Rust toolchain version is specified in `rust-toolchain.toml`

Run format checks:
```bash
cargo fmt --check
```

Run clippy:
```bash
cargo clippy --all-targets
```

### Commit Messages

Follow the [Conventional Commits specification](https://www.conventionalcommits.org/):
- `feat:` for new features
- `fix:` for bug fixes
- `refactor:` for code refactoring
- `test:` for test changes
- `docs:` for documentation changes
- `chore:` for maintenance tasks

Examples:
```
feat(benches): add new timely benchmark for aggregation
fix(benches): correct reachability benchmark edge loading
docs(benches): update README with new benchmark instructions
```

## Pull Requests

1. Create a feature branch from `main`
2. Make your changes
3. Ensure all benchmarks compile and run: `cd benches && cargo bench`
4. Run format and lint checks: `cargo fmt && cargo clippy`
5. Submit a pull request with a clear description

## Questions?

For questions about the benchmarks or this repository, please open an issue or refer to the main [Hydro repository](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) for general Hydro questions.
