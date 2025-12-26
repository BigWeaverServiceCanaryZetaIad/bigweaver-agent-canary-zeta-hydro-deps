# Contributing to bigweaver-agent-canary-zeta-hydro-deps

Thank you for your interest in contributing! This repository contains benchmarks that compare Hydro performance against Timely Dataflow and Differential Dataflow.

## Development Setup

1. Install Rust (see [rustup.rs](https://rustup.rs))
2. Clone this repository
3. Run tests: `cargo test`
4. Run benchmarks: `cargo bench`

## Running Benchmarks

To run all benchmarks:
```bash
cargo bench
```

To run a specific benchmark:
```bash
cargo bench --bench reachability
cargo bench --bench join
```

## Code Quality

Before submitting a PR, ensure your code passes:
- Formatting: `cargo fmt --check`
- Linting: `cargo clippy --all-targets -- -D warnings`
- Build: `cargo build --all-targets`

## Adding New Benchmarks

When adding new benchmarks that compare against Timely/Differential:

1. Add the benchmark file to `benches/benches/`
2. Register it in `benches/Cargo.toml` with a `[[bench]]` section
3. Update `benches/README.md` with documentation
4. Ensure the benchmark compares Hydro against Timely/Differential implementations

## Pull Requests

- Use descriptive commit messages following [Conventional Commits](https://www.conventionalcommits.org/)
- Keep PRs focused on a single change
- Include performance results if modifying benchmarks
- Reference any related issues

## Questions?

For questions about Hydro itself, see the [main repository](https://github.com/hydro-project/hydro).
