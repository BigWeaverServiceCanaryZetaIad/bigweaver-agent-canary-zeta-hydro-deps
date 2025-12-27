# Contributing to bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks that compare Hydro/DFIR performance against external dataflow frameworks (timely-dataflow and differential-dataflow).

## Repository Setup

This repository must be checked out alongside the main `bigweaver-agent-canary-hydro-zeta` repository, as it references DFIR components via relative paths:

```bash
# Ensure both repositories are in the same parent directory
cd /path/to/parent/
git clone <main-repo-url> bigweaver-agent-canary-hydro-zeta
git clone <deps-repo-url> bigweaver-agent-canary-zeta-hydro-deps
```

## Running Benchmarks

```bash
cd bigweaver-agent-canary-zeta-hydro-deps

# Run all benchmarks
cargo bench

# Run specific benchmarks
cargo bench --bench reachability
cargo bench --bench join
cargo bench --bench arithmetic
```

## Adding New Benchmarks

When adding new benchmarks that compare DFIR against timely or differential-dataflow:

1. Add the benchmark file to `benches/benches/`
2. Add any required data files to the same directory
3. Update `benches/Cargo.toml` to add a `[[bench]]` entry
4. Ensure the benchmark includes:
   - A DFIR implementation
   - Timely and/or Differential Dataflow implementations for comparison
   - Clear performance metrics using criterion

### Example Benchmark Structure

```rust
use criterion::{Criterion, criterion_group, criterion_main};
use dfir_rs::dfir_syntax;
use timely::dataflow::operators::*;
use differential_dataflow::operators::*;

fn benchmark_timely(c: &mut Criterion) {
    c.bench_function("operation/timely", |b| {
        // Timely implementation
    });
}

fn benchmark_differential(c: &mut Criterion) {
    c.bench_function("operation/differential", |b| {
        // Differential implementation
    });
}

fn benchmark_dfir(c: &mut Criterion) {
    c.bench_function("operation/dfir", |b| {
        // DFIR implementation
    });
}

criterion_group!(
    operation,
    benchmark_timely,
    benchmark_differential,
    benchmark_dfir,
);
criterion_main!(operation);
```

## Submitting Changes

Follow the same contribution guidelines as the main Hydro repository:

1. Create a feature branch for prototypes
2. Follow Conventional Commits specification for PR titles and bodies
3. Ensure all benchmarks run successfully before submitting

## CI/CD

The repository includes a GitHub Actions workflow that:
- Checks out both this repository and the main Hydro repository
- Runs all benchmarks
- Publishes results to gh-pages for tracking over time

The workflow is triggered by:
- Push to main or feature branches (with `[ci-bench]` in commit message)
- Pull requests (with `[ci-bench]` in title or body)
- Daily schedule (03:35 UTC)
- Manual workflow dispatch

## Dependencies

- `timely` (timely-master 0.13.0-dev.1)
- `differential-dataflow` (differential-dataflow-master 0.13.0-dev.1)
- `dfir_rs` (from main repository)
- `sinktools` (from main repository)
- `criterion` for benchmarking

## Benchmarks Included

Current benchmarks in this repository:

- **arithmetic.rs** - Arithmetic operations comparison
- **fan_in.rs** - Fan-in pattern performance
- **fan_out.rs** - Fan-out pattern performance
- **fork_join.rs** - Fork-join pattern (dynamically generated via build.rs)
- **identity.rs** - Identity operation overhead
- **join.rs** - Join operations with different data types
- **reachability.rs** - Graph reachability algorithms
- **upcase.rs** - String transformation operations

## Questions?

For questions about the main Hydro/DFIR project, see the [main repository's CONTRIBUTING.md](https://github.com/hydro-project/hydro/blob/main/CONTRIBUTING.md).
