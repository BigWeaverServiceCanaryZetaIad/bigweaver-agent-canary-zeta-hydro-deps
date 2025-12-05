# Benchmark Migration Guide

## Overview

This document describes the migration of timely and differential-dataflow benchmarks from the `bigweaver-agent-canary-hydro-zeta` repository to this dedicated `bigweaver-agent-canary-zeta-hydro-deps` repository.

## Background

The benchmarks were moved to:
1. **Maintain a cleaner repository structure** in the main hydro repository
2. **Reduce dependency bloat** by isolating timely and differential-dataflow dependencies
3. **Improve build times** for developers working on the core hydro codebase
4. **Preserve benchmark functionality** while improving maintainability

## Migration Summary

### What Was Moved

The entire `benches/` directory containing:
- **Benchmark Code**: All benchmark implementations (`.rs` files)
- **Configuration**: `Cargo.toml` and `build.rs` files
- **Test Data**: Data files required by benchmarks (`*.txt` files)
- **Documentation**: README describing benchmark usage

### Benchmarks Included

The following benchmarks were migrated:
1. `arithmetic` - Arithmetic operations on streams
2. `fan_in` - Multiple streams merging into one
3. `fan_out` - One stream splitting to multiple outputs
4. `fork_join` - Fork-join parallel patterns
5. `futures` - Async futures-based operations
6. `identity` - Identity transformation operations
7. `join` - Stream join operations
8. `micro_ops` - Low-level micro-operations
9. `reachability` - Graph reachability algorithms
10. `symmetric_hash_join` - Symmetric hash join operations
11. `upcase` - String manipulation (uppercase conversion)
12. `words_diamond` - Diamond-pattern word processing

### Dependencies Removed from Main Repository

The following dependencies were removed from `bigweaver-agent-canary-hydro-zeta`:
- `timely` (package: timely-master, v0.13.0-dev.1)
- `differential-dataflow` (package: differential-dataflow-master, v0.13.0-dev.1)

These dependencies now only exist in this repository.

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── Cargo.toml                    # Workspace configuration
├── README.md                      # Repository overview
├── BENCHMARK_MIGRATION.md         # This file
└── benches/
    ├── Cargo.toml                 # Benchmark package configuration
    ├── README.md                  # Benchmark documentation
    ├── build.rs                   # Build script for code generation
    └── benches/
        ├── arithmetic.rs
        ├── fan_in.rs
        ├── fan_out.rs
        ├── fork_join.rs
        ├── futures.rs
        ├── identity.rs
        ├── join.rs
        ├── micro_ops.rs
        ├── reachability.rs
        ├── reachability_edges.txt
        ├── reachability_reachable.txt
        ├── symmetric_hash_join.rs
        ├── upcase.rs
        ├── words_alpha.txt
        └── words_diamond.rs
```

## Running Benchmarks

### Prerequisites

Ensure you have the Rust toolchain installed with the appropriate version specified in the main repository.

### Running All Benchmarks

```bash
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench -p benches
```

### Running Specific Benchmarks

```bash
# Run the reachability benchmark
cargo bench -p benches --bench reachability

# Run the arithmetic benchmark
cargo bench -p benches --bench arithmetic

# Run with specific configurations
cargo bench -p benches --bench identity -- --verbose
```

### Benchmark Output

Benchmarks use Criterion which generates:
- **Console output**: Real-time progress and results
- **HTML reports**: Detailed analysis in `target/criterion/`
- **Comparison data**: Historical performance tracking

## Performance Comparison

### Maintaining Performance Baselines

Even though the benchmarks have been moved to a separate repository, performance comparison functionality is maintained through:

1. **Criterion's Historical Data**: Criterion automatically maintains historical benchmark data
2. **Separate Git History**: This repository maintains its own benchmark history
3. **Cross-Repository Comparisons**: Can be performed by running benchmarks in both locations

### Comparing Against Main Repository

To compare performance with the main repository:

```bash
# In this repository (new location)
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench -p benches --bench <benchmark_name>

# Results are stored in target/criterion/<benchmark_name>/
```

## Integration with CI/CD

### Continuous Benchmarking

The benchmarks can be integrated into CI/CD pipelines:

```yaml
# Example GitHub Actions workflow
- name: Run benchmarks
  run: |
    cd bigweaver-agent-canary-zeta-hydro-deps
    cargo bench -p benches --no-fail-fast
```

### Performance Regression Detection

Configure Criterion to fail on performance regressions:

```bash
cargo bench -p benches -- --save-baseline main
# After changes:
cargo bench -p benches -- --baseline main
```

## Dependency Management

### Git Dependencies

The benchmarks reference `dfir_rs` and `sinktools` from the main repository via git dependencies:

```toml
dfir_rs = { git = "https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta", features = [ "debugging" ] }
sinktools = { git = "https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta" }
```

### Updating Dependencies

To update to the latest main repository code:

```bash
cargo update
```

To use a specific commit or branch:

```toml
dfir_rs = { git = "https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta", rev = "<commit_hash>", features = [ "debugging" ] }
```

## Development Workflow

### Making Changes to Benchmarks

1. Clone this repository:
   ```bash
   git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
   cd bigweaver-agent-canary-zeta-hydro-deps
   ```

2. Make changes to benchmarks in `benches/benches/`

3. Test your changes:
   ```bash
   cargo bench -p benches --bench <modified_benchmark>
   ```

4. Commit and push:
   ```bash
   git add .
   git commit -m "feat(benches): improve <benchmark_name> performance"
   git push
   ```

### Adding New Benchmarks

1. Create a new benchmark file in `benches/benches/`:
   ```rust
   // benches/benches/my_benchmark.rs
   use criterion::{Criterion, criterion_group, criterion_main};
   // ... benchmark code ...
   ```

2. Add benchmark entry to `benches/Cargo.toml`:
   ```toml
   [[bench]]
   name = "my_benchmark"
   harness = false
   ```

3. Run the new benchmark:
   ```bash
   cargo bench -p benches --bench my_benchmark
   ```

## Troubleshooting

### Build Errors

If you encounter build errors:

1. **Update dependencies**: `cargo update`
2. **Clean build artifacts**: `cargo clean`
3. **Check Rust version**: Ensure you're using the correct toolchain
4. **Verify git dependencies**: Ensure the main repository is accessible

### Benchmark Failures

If benchmarks fail:

1. **Check data files**: Ensure all `.txt` data files are present
2. **Review error messages**: Criterion provides detailed error output
3. **Run in verbose mode**: `cargo bench -p benches -- --verbose`
4. **Check resource limits**: Some benchmarks require sufficient memory

### Performance Degradation

If you notice performance degradation:

1. **Compare with baseline**: Use Criterion's baseline comparison
2. **Check for changes in dependencies**: Review git dependency updates
3. **Profile the benchmark**: Use profiling tools to identify bottlenecks
4. **Review recent changes**: Check git history for relevant changes

## Migration History

- **Date**: December 2025
- **Reason**: Separate timely/differential-dataflow benchmarks to maintain cleaner dependency structure
- **Previous Location**: `bigweaver-agent-canary-hydro-zeta/benches/`
- **New Location**: `bigweaver-agent-canary-zeta-hydro-deps/benches/`
- **Commit Reference**: See git history for detailed migration commits

## Contact and Support

For questions or issues related to these benchmarks:
- Open an issue in this repository
- Reference the Performance Engineering team
- Check the main repository documentation for related information

## References

- [Main Hydro Repository](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)
- [Criterion Documentation](https://bheisler.github.io/criterion.rs/book/)
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)
