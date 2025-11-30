# Benchmark Migration Guide

## Overview

The timely-dataflow and differential-dataflow benchmarks have been moved from the main `bigweaver-agent-canary-hydro-zeta` repository to this separate `bigweaver-agent-canary-zeta-hydro-deps` repository.

## Rationale

This migration was performed to:
1. Separate benchmarking dependencies from the main codebase
2. Avoid unnecessary timely and differential-dataflow dependencies in the main repository
3. Allow independent development and performance testing without affecting the main project's dependency tree
4. Maintain the ability to run performance comparisons between Hydro and timely/differential implementations

## What Was Moved

### Benchmark Files
All benchmark files from `benches/benches/`:
- `arithmetic.rs` - Arithmetic operation benchmarks
- `fan_in.rs` - Fan-in pattern benchmarks
- `fan_out.rs` - Fan-out pattern benchmarks
- `fork_join.rs` - Fork-join pattern benchmarks
- `futures.rs` - Futures-based operation benchmarks
- `identity.rs` - Identity transformation benchmarks
- `join.rs` - Join operation benchmarks
- `micro_ops.rs` - Micro-operation benchmarks
- `reachability.rs` - Graph reachability benchmarks
- `symmetric_hash_join.rs` - Symmetric hash join benchmarks
- `upcase.rs` - String uppercase operation benchmarks
- `words_diamond.rs` - Word processing diamond pattern benchmarks

### Data Files
- `reachability_edges.txt` - Edge data for reachability benchmarks
- `reachability_reachable.txt` - Reachable nodes data
- `words_alpha.txt` - English word list for word processing benchmarks

### Configuration Files
- `benches/Cargo.toml` - Benchmark crate configuration
- `benches/build.rs` - Build script
- `benches/README.md` - Benchmark documentation
- `.github/workflows/benchmark.yml` - CI/CD benchmark workflow

## Dependencies

The benchmarks now use git dependencies to reference the main repository:
- `dfir_rs` - References the main repository via git
- `sinktools` - References the main repository via git

External dependencies maintained:
- `timely-master` (version 0.13.0-dev.1)
- `differential-dataflow-master` (version 0.13.0-dev.1)
- `criterion` (version 0.5.0) - For benchmarking framework

## Running Benchmarks

### All Benchmarks
```bash
cargo bench -p benches
```

### Specific Benchmark
```bash
cargo bench -p benches --bench reachability
```

### With Specific Configuration
```bash
cargo bench -p benches --bench reachability -- --sample-size 10
```

## Performance Comparison Workflow

The benchmarks maintain their ability to compare Hydro implementations against timely/differential-dataflow implementations. Each benchmark typically includes:

1. **Hydro Implementation** - Using dfir_rs operators
2. **Timely/Differential Implementation** - Using native timely/differential operators
3. **Criterion Comparison** - Automatic performance comparison between implementations

## CI/CD Integration

The benchmark workflow (`.github/workflows/benchmark.yml`) has been migrated to run in this repository. It will:
- Run benchmarks on pull requests
- Compare performance against baseline
- Generate performance reports

## Future Development

To add new benchmarks:
1. Create a new `.rs` file in `benches/benches/`
2. Add a `[[bench]]` section in `benches/Cargo.toml`
3. Follow the existing pattern of comparing Hydro vs timely/differential implementations
4. Update this guide with the new benchmark description

## Troubleshooting

### Git Dependency Issues
If you encounter issues with git dependencies:
```bash
cargo update
```

### Build Issues
Ensure you have the latest Rust toolchain:
```bash
rustup update
```

### Performance Regression
If benchmarks show unexpected performance regression:
1. Check if the main repository has breaking changes
2. Review the git dependency versions
3. Run benchmarks locally with `--verbose` flag for detailed output
