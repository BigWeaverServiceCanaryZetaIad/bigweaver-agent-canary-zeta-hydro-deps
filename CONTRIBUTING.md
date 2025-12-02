# Contributing to bigweaver-agent-canary-zeta-hydro-deps

Thank you for your interest in contributing to the Hydro dependencies repository!

## Repository Structure

This repository contains components that depend on timely and differential-dataflow packages, separated from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository.

* `benches` contains microbenchmarks for DFIR and other dataflow frameworks that use timely and differential-dataflow for performance comparisons.

## Development Setup

### Prerequisites

You'll need:
- Rust toolchain (see [rust-lang.org](https://www.rust-lang.org/tools/install))
- Git

### Building

To build the benchmarks:

```bash
cargo build -p benches
```

### Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
```

## Dependencies

This repository depends on:
- Components from the main bigweaver-agent-canary-hydro-zeta repository (via git): `dfir_rs`, `sinktools`
- External packages: `timely-master`, `differential-dataflow-master`

When making changes, ensure compatibility with the main repository.

## Workflow

### Making Changes

1. Create a feature branch from `main`
2. Make your changes
3. Test your changes locally
4. Submit a pull request

### Pull Requests

When submitting a pull request:
- Provide a clear description of the changes
- Reference any related issues
- Ensure benchmarks still run successfully
- If changing benchmark behavior, explain the rationale

### Coordinating with Main Repository

Changes to this repository may need to be coordinated with the main bigweaver-agent-canary-hydro-zeta repository if:
- Benchmark code depends on changes to `dfir_rs` or `sinktools`
- New benchmarks are added that test specific features
- Breaking changes affect the benchmark interface

## Benchmarking

Benchmarks are run automatically via GitHub Actions on:
- Pushes to main
- Pull requests with `[ci-bench]` in the title or body
- Daily schedule
- Manual workflow dispatch

Results are published to the gh-pages branch.

## Questions?

For questions about the main Hydro project, please refer to the [main repository](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta).
