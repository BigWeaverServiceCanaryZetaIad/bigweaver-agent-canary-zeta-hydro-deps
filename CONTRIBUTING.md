# Contributing to Hydro Benchmarks

This repository contains benchmarks for timely and differential-dataflow that have been separated from the main Hydro repository.

## Running Benchmarks

To run benchmarks locally:

```bash
cargo bench -p benches
```

To run a specific benchmark:

```bash
cargo bench -p benches --bench reachability
```

## Adding New Benchmarks

1. Add your benchmark file to the `benches/benches/` directory
2. Register the benchmark in `benches/Cargo.toml` by adding a `[[bench]]` section
3. Follow the existing benchmark structure using the `criterion` framework
4. Ensure your benchmark includes appropriate documentation

## CI/CD

Benchmarks are automatically run via GitHub Actions:
- On schedule (daily)
- When commit messages or PR titles/bodies include `[ci-bench]`
- On manual workflow dispatch

## Development Guidelines

For general Hydro development guidelines, please refer to the [main repository's CONTRIBUTING.md](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta/blob/main/CONTRIBUTING.md).

## Code Style

This repository follows the same code style as the main Hydro repository:
- Use `rustfmt` for formatting
- Follow `clippy` recommendations
- Write clear, documented code

## Questions?

For questions about the Hydro project in general, please refer to the [main repository](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta).
