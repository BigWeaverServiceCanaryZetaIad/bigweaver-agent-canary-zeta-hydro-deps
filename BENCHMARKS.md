# Benchmarks Documentation

## Overview

This document describes the benchmark infrastructure for performance testing code that requires external dataflow dependencies such as `timely` and `differential-dataflow`.

## Purpose of Benchmark Separation

The benchmarks in this repository are separated from the main `bigweaver-agent-canary-hydro-zeta` repository for the following reasons:

### 1. Dependency Management
- **Reduced Build Time**: The main repository doesn't need to compile heavy dataflow dependencies during regular development
- **Cleaner Dependency Graph**: Separates production dependencies from benchmark-only dependencies
- **Version Isolation**: Benchmark dependencies can be updated independently

### 2. Code Organization
- **Separation of Concerns**: Keeps core functionality separate from performance testing infrastructure
- **Maintainability**: Easier to maintain and update benchmark code without affecting production code
- **Technical Debt Management**: Benchmark-specific code doesn't accumulate in the main codebase

### 3. Performance Testing Capability
- **Comprehensive Testing**: Ability to use specialized dataflow libraries for performance analysis
- **Cross-Repository Comparisons**: Can measure performance across different implementations
- **Specialized Tooling**: Freedom to use benchmark-specific tools and libraries

## Benchmark Categories

### Dataflow Benchmarks
Located in `benchmarks/dataflow_benchmarks/` (when created), these benchmarks test dataflow processing performance:

- **Fan-out operations**: Measure data distribution performance
- **Fan-in operations**: Test data aggregation efficiency
- **Join operations**: Evaluate multi-stream join performance
- **Arithmetic operations**: Benchmark computational throughput

### Integration Benchmarks
Located in `benchmarks/integration_benchmarks/` (when created), these test cross-system performance:

- **Reachability tests**: Graph traversal performance
- **Identity operations**: Baseline performance measurements
- **Fork-join patterns**: Concurrent operation efficiency

## Creating New Benchmarks

### Step 1: Create Benchmark Crate

```bash
# Create a new benchmark crate
cargo new benchmarks/my_benchmark --lib

# Or create the directory structure manually
mkdir -p benchmarks/my_benchmark/src
```

### Step 2: Configure Cargo.toml

```toml
# benchmarks/my_benchmark/Cargo.toml
[package]
name = "my_benchmark"
version = "0.1.0"
edition = "2024"
publish = false

[dependencies]
# Core dependencies from main repository
hydro_lang = { path = "../../path/to/hydro_lang" }
hydro_std = { path = "../../path/to/hydro_std" }

# Dataflow dependencies
timely = "0.12"
differential-dataflow = "0.12"

# Benchmark infrastructure
criterion = { version = "0.5", features = ["html_reports"] }

[[bench]]
name = "my_benchmark"
harness = false
```

### Step 3: Add to Workspace

```toml
# Root Cargo.toml
[workspace]
members = [
    "benchmarks/my_benchmark",
    # other benchmark crates...
]
```

### Step 4: Implement Benchmark

```rust
// benchmarks/my_benchmark/benches/my_benchmark.rs
use criterion::{black_box, criterion_group, criterion_main, Criterion};

fn benchmark_function(c: &mut Criterion) {
    c.bench_function("my_operation", |b| {
        b.iter(|| {
            // Your benchmark code here
            black_box(perform_operation())
        })
    });
}

criterion_group!(benches, benchmark_function);
criterion_main!(benches);
```

## Running Benchmarks

### Running All Benchmarks

```bash
# From repository root
cargo bench --all
```

### Running Specific Benchmark Crate

```bash
# Run benchmarks for a specific crate
cargo bench --package my_benchmark

# Run with verbose output
cargo bench --package my_benchmark -- --verbose
```

### Saving Baseline for Comparison

```bash
# Save current results as baseline
cargo bench --all -- --save-baseline before_optimization

# Make your changes, then compare
cargo bench --all -- --baseline before_optimization
```

## Performance Comparison Workflow

### Comparing Across Repositories

To measure performance differences between main repository implementations and deps repository benchmarks:

#### 1. Establish Baseline (Main Repository)

```bash
cd ../bigweaver-agent-canary-hydro-zeta

# Run relevant benchmarks
cargo bench --package dfir_rs > ../bench_results/main_baseline.txt
cargo bench --package hydro_test > ../bench_results/main_tests.txt
```

#### 2. Run Specialized Benchmarks (Deps Repository)

```bash
cd ../bigweaver-agent-canary-zeta-hydro-deps

# Run dataflow benchmarks
cargo bench --package dataflow_benchmarks > ../bench_results/deps_dataflow.txt

# Run integration benchmarks
cargo bench --package integration_benchmarks > ../bench_results/deps_integration.txt
```

#### 3. Analyze Results

Use criterion's built-in HTML reports or process the text output:

```bash
# View HTML reports
open target/criterion/report/index.html

# Compare text output
diff ../bench_results/main_baseline.txt ../bench_results/deps_dataflow.txt
```

### Automated Comparison Script

Create a script for consistent comparisons:

```bash
#!/bin/bash
# compare_performance.sh

# Run main repo benchmarks
cd ../bigweaver-agent-canary-hydro-zeta
cargo bench --package dfir_rs -- --save-baseline main_repo

# Run deps repo benchmarks
cd ../bigweaver-agent-canary-zeta-hydro-deps
cargo bench --all -- --save-baseline deps_repo

# Generate comparison report
criterion-table main_repo deps_repo > comparison_report.md
```

## Benchmark Best Practices

### 1. Isolation
- Each benchmark should test one specific operation
- Minimize setup/teardown overhead
- Use `black_box()` to prevent compiler optimizations

### 2. Consistency
- Run benchmarks multiple times for statistical significance
- Use consistent hardware and system state
- Document system specifications in benchmark code

### 3. Documentation
- Document what each benchmark measures
- Include expected performance characteristics
- Note any special requirements or setup

### 4. Maintenance
- Keep benchmarks up to date with API changes
- Remove obsolete benchmarks
- Update documentation when behavior changes

## Example Benchmark Template

```rust
// benchmarks/example/benches/operations.rs
use criterion::{black_box, criterion_group, criterion_main, Criterion, BenchmarkId};

/// Benchmark for measuring fan-out operation performance
/// 
/// Tests how efficiently data can be distributed from one source
/// to multiple destinations.
fn bench_fan_out(c: &mut Criterion) {
    let mut group = c.benchmark_group("fan_out");
    
    for size in [100, 1000, 10000].iter() {
        group.bench_with_input(BenchmarkId::from_parameter(size), size, |b, &size| {
            let data = prepare_test_data(size);
            b.iter(|| {
                black_box(perform_fan_out(black_box(&data)))
            });
        });
    }
    
    group.finish();
}

criterion_group!(benches, bench_fan_out);
criterion_main!(benches);
```

## Continuous Integration

### GitHub Actions Example

```yaml
# .github/workflows/benchmarks.yml
name: Benchmarks

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  benchmark:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3
    - uses: actions-rs/toolchain@v1
      with:
        profile: minimal
        toolchain: stable
    - name: Run benchmarks
      run: cargo bench --all
    - name: Upload results
      uses: actions/upload-artifact@v3
      with:
        name: benchmark-results
        path: target/criterion/
```

## Troubleshooting

### Common Issues

#### Issue: Benchmarks are unstable/inconsistent
**Solution**: 
- Ensure system is idle during benchmarking
- Increase sample size or measurement time
- Check for background processes affecting performance

#### Issue: Dependencies conflict with main repository
**Solution**:
- Use different versions in benchmark Cargo.toml
- Leverage Cargo's dependency resolution
- Document version requirements clearly

#### Issue: Benchmarks take too long to run
**Solution**:
- Reduce iteration count for quick checks
- Use `--bench specific_bench` to run individual benchmarks
- Configure shorter measurement times for development

## Migration Notes

### When to Move Benchmarks Here

Move benchmarks to this repository when:

1. They require `timely` or `differential-dataflow` dependencies
2. They significantly increase build times in the main repository
3. They test cross-system integration with external dataflow tools
4. They require specialized benchmark dependencies

### How to Migrate

1. Copy benchmark files to appropriate directory in this repository
2. Update import paths and dependencies
3. Test that benchmarks still run correctly
4. Update both repositories' documentation
5. Remove benchmark code from main repository (keep references to this repo)

### Preserving Functionality

After migration, ensure:

- Benchmarks can still be executed from this repository
- Performance comparison workflows are documented
- CI/CD pipelines are updated
- Documentation reflects the new structure

## Additional Resources

- [Criterion.rs Documentation](https://bheisler.github.io/criterion.rs/book/)
- [Rust Performance Book](https://nnethercote.github.io/perf-book/)
- Main Repository: [bigweaver-agent-canary-hydro-zeta](../bigweaver-agent-canary-hydro-zeta)

## Questions and Support

For questions about benchmarks or performance testing:

1. Check this documentation
2. Review existing benchmark implementations
3. Refer to the main repository's CONTRIBUTING.md
4. Contact the Performance Engineering team