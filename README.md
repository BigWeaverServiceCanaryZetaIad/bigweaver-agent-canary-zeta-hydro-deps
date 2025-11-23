# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks for comparing Hydro/Hydroflow with timely and differential-dataflow frameworks. These benchmarks were moved from the main `bigweaver-agent-canary-hydro-zeta` repository to better manage dependencies and maintain cleaner separation of concerns.

## Overview

This repository houses performance comparison benchmarks that require `timely` and `differential-dataflow` dependencies. By keeping these benchmarks separate from the main Hydro repository, we:

- Reduce dependency complexity in the main repository
- Enable focused performance comparisons
- Maintain cleaner code organization
- Provide dedicated benchmark infrastructure

## Benchmarks

The following benchmarks are available:

1. **arithmetic** - Arithmetic pipeline benchmarks comparing timely vs hydroflow
2. **fan_in** - Fan-in pattern benchmarks with timely comparisons
3. **fan_out** - Fan-out pattern benchmarks with timely comparisons
4. **fork_join** - Fork-join pattern benchmarks with timely comparisons
5. **identity** - Identity operation benchmarks with timely comparisons
6. **join** - Join operation benchmarks using timely
7. **reachability** - Graph reachability benchmarks using differential-dataflow
8. **upcase** - String transformation benchmarks with timely comparisons

## Quick Start

### Prerequisites

- Rust toolchain (stable or nightly as required)
- Cargo

### Running All Benchmarks

```bash
cargo bench
```

### Running Specific Benchmarks

```bash
# Run arithmetic benchmarks
cargo bench --bench arithmetic

# Run reachability benchmarks
cargo bench --bench reachability

# Run join benchmarks
cargo bench --bench join
```

### Running Quick Benchmarks

For faster iteration during development:

```bash
# Run with reduced sample size
cargo bench --bench arithmetic -- --quick

# Or set environment variable
CRITERION_QUICK=1 cargo bench
```

## Performance Comparison

These benchmarks enable performance comparison between different dataflow frameworks. Results are saved in `target/criterion/` and include:

- HTML reports with visualizations
- Statistical analysis of performance
- Comparison with previous runs

## Test Data

The repository includes test data files required for benchmarks:

- `benches/reachability_edges.txt` - Graph edges for reachability testing
- `benches/reachability_reachable.txt` - Expected reachable nodes

## Documentation

For more detailed information, see:

- [BENCHMARKS.md](BENCHMARKS.md) - Detailed benchmark descriptions and methodology
- [MIGRATION_NOTES.md](MIGRATION_NOTES.md) - Information about benchmark migration from main repository
- [CONTRIBUTING.md](CONTRIBUTING.md) - Guidelines for contributing new benchmarks

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── benches/              # Benchmark implementations
│   ├── arithmetic.rs
│   ├── fan_in.rs
│   ├── fan_out.rs
│   ├── fork_join.rs
│   ├── identity.rs
│   ├── join.rs
│   ├── reachability.rs
│   ├── upcase.rs
│   ├── reachability_edges.txt
│   └── reachability_reachable.txt
├── build.rs              # Build script for generated code
├── Cargo.toml            # Dependencies and benchmark configuration
└── README.md             # This file
```

## Dependencies

This repository depends on:

- **criterion** - Benchmarking framework
- **timely** - Timely dataflow framework
- **differential-dataflow** - Differential dataflow framework
- **tokio** - Async runtime
- **rand** - Random number generation for test data

Note: Some benchmarks may require additional dependencies from the main Hydro repository (dfir_rs, sinktools). These can be configured via git dependencies or path dependencies as needed.

## Building

```bash
# Build all benchmarks
cargo build --benches

# Check that benchmarks compile without running
cargo bench --no-run
```

## Troubleshooting

### Compilation Errors

If you encounter compilation errors:

```bash
# Clean build artifacts
cargo clean

# Update dependencies
cargo update

# Rebuild
cargo build --benches
```

### Missing Dependencies

If you see errors about missing `dfir_rs` or `sinktools`, you may need to:

1. Clone the main Hydro repository alongside this one
2. Update `Cargo.toml` to use path dependencies
3. Or use git dependencies pointing to the Hydro repository

### Performance Comparison Issues

If benchmark results seem inconsistent:

- Ensure your system is not under heavy load
- Close unnecessary applications
- Run benchmarks multiple times to establish baseline
- Check CPU governor settings for consistent performance

## License

Apache-2.0

## Related Repositories

- [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) - Main Hydro repository