# Contributing to Hydro Dependencies

This repository contains benchmarks and dependencies that have been separated from the main hydro repository to keep it lean and focused.

## Running Benchmarks

To run all benchmarks:

```bash
cd benches
cargo bench
```

To run a specific benchmark:

```bash
cd benches
cargo bench --bench <benchmark_name>
```

Available benchmarks:
- `arithmetic` - Pipeline arithmetic operations
- `fan_in` - Fan-in pattern benchmarks
- `fan_out` - Fan-out pattern benchmarks
- `fork_join` - Fork-join pattern benchmarks
- `identity` - Identity transformation benchmarks
- `join` - Join operation benchmarks
- `reachability` - Graph reachability benchmarks (uses differential-dataflow)
- `upcase` - String uppercase transformation benchmarks

## Comparing Performance

Criterion generates HTML reports for benchmark results. After running benchmarks, you can find the reports in:

```
benches/target/criterion/
```

Open `index.html` in your browser to view detailed performance comparisons.

## Rust Toolchain

This repository uses the same Rust toolchain as the main hydro repository. The version is specified in `rust-toolchain.toml` and will be automatically used by `cargo`.

## Code Style

The repository follows the same code style conventions as the main hydro project:
- Use `cargo fmt` to format code
- Use `cargo clippy` to lint code

Configuration files (`rustfmt.toml` and `clippy.toml`) are included in the repository.
