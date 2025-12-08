# Contributing to Hydro Deps

This repository contains benchmarks that depend on `timely` and `differential-dataflow`. These were separated from the main Hydro repository to reduce its dependency footprint.

## Running Benchmarks

### Prerequisites

- Rust toolchain (see [rust-lang.org](https://rust-lang.org))
- Git

### Running All Benchmarks

```bash
cargo bench -p benches
```

### Running Specific Benchmarks

```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench join
```

### Benchmark Results

Benchmark results are stored in `target/criterion/` and can be viewed by opening the generated HTML reports in a browser.

## CI/CD Integration

Benchmarks can be triggered in CI by:

1. **Scheduled runs**: Automatically run daily
2. **Manual dispatch**: Trigger via GitHub Actions with `should_bench: true`
3. **Commit message**: Include `[ci-bench]` in commit messages
4. **PR title/body**: Include `[ci-bench]` in pull request title or description

## Adding New Benchmarks

1. Create a new `.rs` file in `benches/benches/`
2. Add a `[[bench]]` entry in `benches/Cargo.toml`
3. Write your benchmark using the `criterion` framework
4. Test locally with `cargo bench -p benches --bench <your_bench_name>`

## Dependencies

This repository depends on:
- `dfir_rs` - From the main Hydro repository (via git)
- `sinktools` - From the main Hydro repository (via git)
- `timely` - Timely dataflow library
- `differential-dataflow` - Differential dataflow library
- `criterion` - Benchmarking framework

## Performance Comparisons

To compare performance across changes:

```bash
# Baseline
git checkout main
cargo bench -p benches -- --save-baseline main

# After changes
git checkout your-branch
cargo bench -p benches -- --baseline main
```

This will show you performance differences compared to the main branch.
