# Benchmark Migration Guide

## Overview

This repository contains the Timely Dataflow and Differential Dataflow benchmarks that were previously part of the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository. These benchmarks were moved here to maintain better separation of concerns and cleaner dependency management.

## Rationale for Migration

The migration serves several important purposes:

1. **Dependency Isolation**: Separates external dependencies (timely-master, differential-dataflow-master) from the core Hydro framework, reducing the dependency footprint of the main repository.

2. **Cleaner Architecture**: Maintains a clear distinction between Hydro's internal implementation and external performance comparisons with other dataflow frameworks.

3. **Focused Development**: Allows the main Hydro repository to focus on framework development without carrying comparison benchmarks and their associated dependencies.

4. **Independent Evolution**: Enables benchmarks to evolve independently from the core framework, with their own release cycle and maintenance schedule.

## Migrated Benchmarks

The following benchmarks are now available in this repository:

### Timely Dataflow Benchmarks
- **`arithmetic.rs`** - Performance tests for arithmetic operations in dataflow pipelines
- **`fan_in.rs`** - Tests for fan-in dataflow patterns where multiple streams merge
- **`fan_out.rs`** - Tests for fan-out dataflow patterns where one stream splits into multiple
- **`fork_join.rs`** - Tests for fork-join parallelism patterns
- **`identity.rs`** - Baseline tests using identity transformations
- **`join.rs`** - Performance tests for join operations between streams
- **`upcase.rs`** - String transformation benchmarks (uppercase conversion)

### Differential Dataflow Benchmarks
- **`reachability.rs`** - Graph reachability computations using incremental computation
  - Uses test data files: `reachability_edges.txt`, `reachability_reachable.txt`

### Hydro Comparison Benchmarks
- **`futures.rs`** - Async futures performance comparisons
- **`micro_ops.rs`** - Micro-operation benchmarks comparing basic operations across frameworks
- **`symmetric_hash_join.rs`** - Hash join implementation comparisons
- **`words_diamond.rs`** - Word processing pattern benchmarks (diamond dataflow topology)
  - Uses test data file: `words_alpha.txt`

## Running Benchmarks

### Basic Usage

Run all benchmarks:
```bash
cargo bench -p benches
```

Run a specific benchmark:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench micro_ops
```

Run benchmarks with a filter:
```bash
# Run all benchmarks containing "join" in their name
cargo bench -p benches --bench join

# Run all benchmarks in the arithmetic suite
cargo bench -p benches --bench arithmetic
```

### Benchmark Options

Criterion (the benchmarking framework used) supports various options:

```bash
# Save baseline for later comparison
cargo bench -p benches -- --save-baseline my-baseline

# Compare against a baseline
cargo bench -p benches -- --baseline my-baseline

# Generate detailed reports
cargo bench -p benches -- --verbose

# Set specific measurement time
cargo bench -p benches -- --measurement-time 10
```

### Viewing Results

Benchmark results are generated in multiple formats:

1. **Console Output**: Real-time results displayed during benchmark execution
2. **HTML Reports**: Detailed reports in `target/criterion/<benchmark-name>/report/index.html`
3. **Data Files**: Raw data in `target/criterion/<benchmark-name>/` for further analysis

To view HTML reports:
```bash
# Open a specific benchmark report
open target/criterion/arithmetic/report/index.html

# Or use your preferred browser
firefox target/criterion/reachability/report/index.html
```

## Performance Comparison Workflow

The benchmarks maintain the ability to perform meaningful performance comparisons:

### 1. Framework Comparisons

Each benchmark typically includes implementations for multiple frameworks:
- **Hydro/dfir_rs**: The Hydro dataflow implementation
- **Timely Dataflow**: Direct timely dataflow implementation
- **Differential Dataflow**: Differential dataflow implementation (where applicable)

This allows direct performance comparisons between frameworks running the same workload.

### 2. Establishing Baselines

Before making changes to the main Hydro repository:

```bash
# Run benchmarks and save as baseline
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench -p benches -- --save-baseline before-changes
```

### 3. Comparing After Changes

After making changes to the main Hydro repository:

```bash
# The git dependencies will automatically pull latest changes
# Run benchmarks and compare against baseline
cargo bench -p benches -- --baseline before-changes
```

### 4. Historical Tracking

For long-term performance tracking:

```bash
# Create dated baselines
cargo bench -p benches -- --save-baseline 2025-12-04

# Compare against historical baseline
cargo bench -p benches -- --baseline 2025-12-04
```

## Dependencies and Integration

### Git Dependencies

The benchmarks use git dependencies to reference components from the main Hydro repository:

```toml
[dev-dependencies]
dfir_rs = { git = "https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git", features = [ "debugging" ] }
sinktools = { git = "https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git", version = "^0.0.1" }
```

This means:
- Benchmarks always test against the latest version in the main repository
- No need to manually sync versions
- Automatic integration with main repository development

### Updating Dependencies

To update to the latest version from the main repository:

```bash
# Update all dependencies
cargo update

# Update specific dependency
cargo update -p dfir_rs
cargo update -p sinktools
```

### Testing Against Local Changes

To test against local changes in the main repository:

```toml
# Temporarily modify benches/Cargo.toml
[dev-dependencies]
dfir_rs = { path = "../bigweaver-agent-canary-hydro-zeta/dfir_rs", features = [ "debugging" ] }
sinktools = { path = "../bigweaver-agent-canary-hydro-zeta/sinktools", version = "^0.0.1" }
```

Remember to revert this change before committing.

## Test Data Files

The benchmarks include the following test data files:

- **`words_alpha.txt`**: English word list (370,000+ words) from [dwyl/english-words](https://github.com/dwyl/english-words/blob/master/words_alpha.txt)
  - Used by: `words_diamond.rs`, `upcase.rs`
  
- **`reachability_edges.txt`**: Graph edge data for reachability testing
  - Format: Each line represents an edge: `source_node destination_node`
  - Used by: `reachability.rs`
  
- **`reachability_reachable.txt`**: Expected reachability results
  - Used for verification in: `reachability.rs`

These files are preserved in the repository and automatically included in benchmark builds.

## Troubleshooting

### Build Issues

If you encounter build issues:

```bash
# Clean build artifacts
cargo clean

# Update dependencies
cargo update

# Try building without running
cargo build -p benches --release
```

### Benchmark Failures

If benchmarks fail or produce unexpected results:

1. Check that dependencies are up to date: `cargo update`
2. Verify test data files are present in `benches/benches/`
3. Check available system resources (benchmarks can be memory-intensive)
4. Review criterion output for specific error messages

### Performance Variance

If you see high variance in results:

1. Close unnecessary applications
2. Run benchmarks multiple times
3. Use longer measurement times: `cargo bench -p benches -- --measurement-time 20`
4. Check for system background activity

## CI/CD Integration

To integrate these benchmarks into your CI/CD pipeline:

```yaml
# Example GitHub Actions workflow
name: Benchmarks

on:
  schedule:
    - cron: '0 0 * * 0'  # Weekly
  workflow_dispatch:       # Manual trigger

jobs:
  benchmark:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Install Rust
        uses: actions-rs/toolchain@v1
        with:
          toolchain: stable
      - name: Run benchmarks
        run: cargo bench -p benches
      - name: Upload results
        uses: actions/upload-artifact@v4
        with:
          name: benchmark-results
          path: target/criterion/
```

## Impact on Main Repository

The migration removed the following from the main Hydro repository:

### ✅ Removed Files
- `benches/` directory and all benchmark files
- Benchmark-specific test data files
- `.github/workflows/benchmark.yml` (if present)

### ✅ Removed Dependencies
- `timely-master` package
- `differential-dataflow-master` package
- Benchmark-specific dependencies

### ✅ Updated Documentation
- Main README now references this repository
- Links to benchmark documentation point here
- Migration guide created (this document)

## Contributing

To add new benchmarks:

1. Create a new `.rs` file in `benches/benches/`
2. Follow the pattern of existing benchmarks
3. Add a `[[bench]]` entry in `benches/Cargo.toml`
4. Update `benches/README.md` with benchmark description
5. Include test data files if needed
6. Submit a pull request

## Questions and Support

If you have questions about:
- **Running benchmarks**: See `benches/README.md` or this document
- **Benchmark results**: Check the Criterion documentation and HTML reports
- **Main Hydro framework**: Visit the [main repository](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)
- **Issues or bugs**: Open an issue in the appropriate repository

## Resources

- [Criterion.rs Documentation](https://bheisler.github.io/criterion.rs/book/)
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)
- [Hydro Project Documentation](https://hydro.run)
- [Main Hydro Repository](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)
