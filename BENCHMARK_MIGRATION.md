# Benchmark Migration Guide

## Overview

This document describes the migration of timely and differential-dataflow benchmarks from the main `bigweaver-agent-canary-hydro-zeta` repository to this dedicated `bigweaver-agent-canary-zeta-hydro-deps` repository.

## Why Were Benchmarks Moved?

The benchmarks were moved to achieve the following goals:

1. **Clean Dependency Management**: Remove heavy dependencies (timely-dataflow and differential-dataflow) from the main repository to reduce build times and simplify the dependency tree
2. **Separation of Concerns**: Keep core functionality separate from performance testing infrastructure
3. **Focused Repository Purpose**: Allow the main repository to focus on core Hydro functionality while this repository manages benchmarks and dependency-heavy code
4. **Improved Build Performance**: Reduce compilation time for developers working on the main repository who don't need benchmark dependencies

## What Was Moved?

### Benchmarks Directory Structure

All content from `benches/` in the main repository was moved here:

```
benches/
├── Cargo.toml              # Benchmark package configuration
├── README.md               # Benchmark documentation
├── build.rs                # Build script
└── benches/
    ├── .gitignore
    ├── arithmetic.rs       # Arithmetic operation benchmarks
    ├── fan_in.rs           # Fan-in pattern benchmarks
    ├── fan_out.rs          # Fan-out pattern benchmarks
    ├── fork_join.rs        # Fork-join pattern benchmarks
    ├── futures.rs          # Async futures benchmarks
    ├── identity.rs         # Identity transformation benchmarks
    ├── join.rs             # Join operation benchmarks
    ├── micro_ops.rs        # Micro-operation benchmarks
    ├── reachability.rs     # Graph reachability benchmarks
    ├── reachability_edges.txt         # Test data for reachability
    ├── reachability_reachable.txt     # Test data for reachability
    ├── symmetric_hash_join.rs         # Symmetric hash join benchmarks
    ├── upcase.rs           # String uppercase transformation benchmarks
    ├── words_alpha.txt     # Word list test data
    └── words_diamond.rs    # Diamond pattern word processing benchmarks
```

### Dependencies Removed from Main Repository

The following dependencies were removed from the main repository's workspace:

- `timely-master` (v0.13.0-dev.1)
- `differential-dataflow-master` (v0.13.0-dev.1)

These dependencies are now only present in this repository's `benches/Cargo.toml`.

## Dependency References

The benchmarks in this repository reference `dfir_rs` and `sinktools` from the main repository via git dependencies:

```toml
dfir_rs = { git = "https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git", features = [ "debugging" ] }
sinktools = { git = "https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git" }
```

This approach:
- Maintains access to core Hydro functionality for benchmarking
- Keeps the repositories loosely coupled
- Allows independent versioning and development cycles

## Running Benchmarks After Migration

### Basic Usage

The benchmark interface remains the same as before:

```bash
# Run all benchmarks
cargo bench -p benches

# Run a specific benchmark
cargo bench -p benches --bench reachability

# Run benchmarks with verbose output
cargo bench -p benches -- --verbose
```

### Performance Comparison Workflow

To compare performance across different implementations:

1. **Clone Both Repositories**:
   ```bash
   git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git
   git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
   ```

2. **Establish Baseline**:
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps
   cargo bench -p benches --bench <benchmark_name> -- --save-baseline before
   ```

3. **Make Changes** in the main repository or benchmark repository

4. **Compare Results**:
   ```bash
   cargo bench -p benches --bench <benchmark_name> -- --baseline before
   ```

5. **Review Reports**: Criterion generates HTML reports in `target/criterion/`

## CI/CD Integration

### GitHub Actions Workflow

The benchmark workflow (`.github/workflows/benchmark.yml`) has been preserved from the main repository and adapted for this repository. It:

- Runs on schedule or manual trigger
- Executes all benchmark suites
- Generates performance reports
- Can be configured to compare against baselines

### Setting Up Benchmark Automation

To set up automated benchmarking:

1. Ensure the workflow file is present in `.github/workflows/`
2. Configure secrets if needed for result publishing
3. Set up branch protection rules if benchmark gates are desired
4. Configure notification channels for performance regressions

## Migration Impact

### For Main Repository Developers

- **Faster Builds**: The main repository builds faster without timely/differential-dataflow dependencies
- **Simpler Testing**: `cargo test` in main repository no longer builds benchmark dependencies
- **Focused Development**: Core Hydro development is decoupled from benchmark infrastructure

### For Performance Engineers

- **Dedicated Repository**: All performance benchmarks are in one place
- **Independent Versioning**: Benchmark suite can evolve independently
- **Clear Ownership**: Performance engineering team has clear ownership of this repository

## Updating Benchmarks

### Adding New Benchmarks

1. Create a new benchmark file in `benches/benches/`:
   ```rust
   // benches/benches/my_new_bench.rs
   use criterion::{criterion_group, criterion_main, Criterion};
   
   fn my_benchmark(c: &mut Criterion) {
       // Your benchmark code
   }
   
   criterion_group!(benches, my_benchmark);
   criterion_main!(benches);
   ```

2. Register it in `benches/Cargo.toml`:
   ```toml
   [[bench]]
   name = "my_new_bench"
   harness = false
   ```

3. Run the new benchmark:
   ```bash
   cargo bench -p benches --bench my_new_bench
   ```

### Modifying Existing Benchmarks

1. Edit the benchmark file in `benches/benches/`
2. Test your changes:
   ```bash
   cargo bench -p benches --bench <benchmark_name>
   ```
3. Commit and push your changes
4. Monitor CI for performance regressions

## Troubleshooting

### Build Errors

**Issue**: `dfir_rs` or `sinktools` not found
**Solution**: Ensure you have network access to fetch git dependencies, or update the dependency references if repository URLs have changed

**Issue**: Timely or differential-dataflow version conflicts
**Solution**: Check `Cargo.toml` for version specifications and update as needed

### Performance Discrepancies

**Issue**: Benchmark results differ significantly from previous runs
**Solution**: 
- Ensure consistent hardware and system load
- Use `--save-baseline` and `--baseline` flags for accurate comparisons
- Check for changes in the underlying `dfir_rs` implementation

## Historical Context

The benchmarks were originally part of the main Hydro repository to facilitate rapid development and testing. As the project matured, the team identified that:

1. Build times for the main repository were increasing due to heavy dependencies
2. Not all developers needed the benchmark suite for their daily work
3. Performance testing deserved dedicated infrastructure and workflows

The migration maintains all functionality while improving the development experience for both core developers and performance engineers.

## References

- Main Repository: https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta
- Criterion.rs Documentation: https://bheisler.github.io/criterion.rs/book/
- Timely Dataflow: https://github.com/TimelyDataflow/timely-dataflow
- Differential Dataflow: https://github.com/TimelyDataflow/differential-dataflow

## Questions and Support

For questions about:
- **Benchmark functionality**: Open an issue in this repository
- **Core Hydro implementation**: Open an issue in the main repository
- **Performance analysis**: Contact the Performance Engineering team

---

Last Updated: December 2025
