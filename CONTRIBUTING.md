# Contributing to bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies moved from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository.

## Structure

* `benches/` - Microbenchmarks comparing Hydro/DFIR with timely-dataflow and differential-dataflow implementations

## Rust

This repository follows the same Rust toolchain version as the main repository. The pinned version is specified in `rust-toolchain.toml` which is automatically detected by `cargo`.

## Running Benchmarks

To run all benchmarks:
```bash
cargo bench -p hydro-timely-differential-benches
```

To run a specific benchmark:
```bash
cargo bench -p hydro-timely-differential-benches --bench arithmetic
```

## Code Quality

This repository uses the same code quality tools as the main repository:

### Formatting
```bash
cargo fmt --check
```

### Linting
```bash
cargo clippy -- -D warnings
```

Configuration files (`rustfmt.toml`, `clippy.toml`) are maintained to match the main repository for consistency.

## Performance Comparison

These benchmarks are designed to work in conjunction with the DFIR-only benchmarks in the main repository. Criterion saves results in `target/criterion/`, allowing performance comparisons across implementations:

1. Run DFIR benchmarks from main repository
2. Run these benchmarks (timely/differential implementations)
3. Compare results in criterion output

## Adding New Benchmarks

When adding new benchmarks:
1. Create the benchmark file in `benches/benches/`
2. Add a `[[bench]]` section to `benches/Cargo.toml`
3. Follow the existing pattern of comparing multiple implementations (raw, timely, differential, DFIR)
4. Update `benches/README.md` to document the new benchmark
