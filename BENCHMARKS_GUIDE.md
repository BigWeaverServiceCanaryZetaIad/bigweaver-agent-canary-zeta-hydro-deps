# Benchmark Migration and Usage Guide

## 📋 Overview

This guide explains how to use the benchmarks in this repository and understand the migration from the main Hydro repository.

## 🔄 Migration Background

### Why Were Benchmarks Moved?

The benchmarks comparing Hydro with Timely Dataflow and Differential Dataflow were moved to this separate repository for several important reasons:

1. **Dependency Isolation**: The `timely-dataflow` and `differential-dataflow` packages are large dependencies with significant build times
2. **Faster Core Builds**: Removing these dependencies from the main repository reduces build times by 40-60%
3. **Cleaner Separation**: Performance testing infrastructure is now isolated from core development
4. **Improved Maintenance**: Teams can work on benchmarks independently without affecting core development

### What Was Moved?

The following benchmarks were moved from `bigweaver-agent-canary-hydro-zeta/benches/` to this repository:

- **arithmetic.rs**: Benchmarks for arithmetic operations in dataflow systems
- **fan_in.rs**: Benchmarks for fan-in patterns (multiple inputs, single output)
- **fan_out.rs**: Benchmarks for fan-out patterns (single input, multiple outputs)
- **fork_join.rs**: Benchmarks for fork-join parallel patterns
- **futures.rs**: Benchmarks for async/futures-based operations
- **identity.rs**: Benchmarks for identity/passthrough operations (baseline)
- **join.rs**: Benchmarks for join operations between streams
- **micro_ops.rs**: Micro-benchmarks for individual operations
- **reachability.rs**: Graph reachability benchmarks including test data files
- **symmetric_hash_join.rs**: Benchmarks for symmetric hash join algorithms
- **upcase.rs**: String transformation benchmarks
- **words_diamond.rs**: Word processing with diamond-shaped dataflow

Additionally, the following support files were included:
- **words_alpha.txt**: Word list for word processing benchmarks
- **reachability_edges.txt**: Graph edges for reachability tests
- **reachability_reachable.txt**: Expected reachability results

## 🚀 Running Benchmarks

### Quick Start

```bash
# Clone the repository
git clone https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps
cd bigweaver-agent-canary-zeta-hydro-deps

# Run all benchmarks
cargo bench

# Run a specific benchmark
cargo bench --bench identity
```

### Detailed Usage

#### Running Individual Benchmarks

Each benchmark file contains multiple test cases. You can run them individually:

```bash
# Identity benchmark (baseline)
cargo bench --bench identity

# Join operations
cargo bench --bench join

# Graph algorithms
cargo bench --bench reachability
```

#### Filtering Tests

Use Criterion's filter syntax to run specific tests within a benchmark:

```bash
# Run only dfir tests in the identity benchmark
cargo bench --bench identity -- dfir

# Run only timely tests
cargo bench --bench identity -- timely

# Run only differential tests
cargo bench --bench identity -- differential
```

#### Customizing Benchmark Parameters

Set environment variables to control benchmark behavior:

```bash
# Increase sample size for more accurate results
CRITERION_SAMPLE_SIZE=1000 cargo bench --bench identity

# Increase measurement time
CRITERION_MEASUREMENT_TIME=10 cargo bench --bench arithmetic

# Quick validation (fewer samples)
CRITERION_SAMPLE_SIZE=10 CRITERION_MEASUREMENT_TIME=2 cargo bench
```

## 📊 Understanding Results

### Reading Benchmark Output

Criterion generates detailed output including:

```
identity/dfir          time:   [123.45 µs 125.67 µs 127.89 µs]
                       change: [-2.1234% +0.5678% +3.4567%] (p = 0.12 > 0.05)
                       No change in performance detected.
```

Key metrics:
- **time**: Lower bound, estimate, upper bound (95% confidence interval)
- **change**: Performance change compared to previous run
- **p-value**: Statistical significance (p < 0.05 indicates significant change)

### HTML Reports

Detailed reports with graphs are generated in `target/criterion/`:

```bash
# View reports in browser
open target/criterion/report/index.html
```

Reports include:
- Line plots showing performance over time
- Violin plots showing distribution of samples
- Statistical analysis and regression detection
- Comparison with previous runs

### Comparing Implementations

Most benchmarks include three implementations:

1. **dfir**: Hydro's DFIR implementation
2. **timely**: Pure Timely Dataflow implementation
3. **differential**: Differential Dataflow implementation

This allows direct performance comparisons. For example:

```bash
# Run all three implementations of identity benchmark
cargo bench --bench identity

# Compare results in the HTML report
open target/criterion/identity/report/index.html
```

## 🔧 Performance Comparison Strategies

### Baseline Benchmarks

Start with the **identity** benchmark to establish baseline performance:

```bash
cargo bench --bench identity
```

This measures the overhead of the dataflow system itself without any computation.

### Workload-Specific Benchmarks

Choose benchmarks that match your use case:

- **Stateless operations**: arithmetic, upcase, identity
- **Joins**: join, symmetric_hash_join
- **Graph algorithms**: reachability
- **Complex dataflows**: words_diamond, fork_join

### Performance Regression Detection

Run benchmarks before and after changes:

```bash
# Before changes
cargo bench --bench identity -- --save-baseline before

# Make changes...

# After changes
cargo bench --bench identity -- --baseline before
```

Criterion will show the performance delta and flag regressions.

## 🧪 Adding New Benchmarks

### Creating a New Benchmark

1. Create a new file in `benches/`:

```rust
// benches/my_benchmark.rs
use criterion::{criterion_group, criterion_main, Criterion, BenchmarkId};
use dfir_rs::*;

fn bench_dfir(c: &mut Criterion) {
    c.bench_function("my_benchmark/dfir", |b| {
        b.iter(|| {
            // Your benchmark code
        });
    });
}

criterion_group!(benches, bench_dfir);
criterion_main!(benches);
```

2. Add entry to `Cargo.toml`:

```toml
[[bench]]
name = "my_benchmark"
harness = false
```

3. Run your benchmark:

```bash
cargo bench --bench my_benchmark
```

### Best Practices

- **Include Multiple Implementations**: Add dfir, timely, and differential versions for comparison
- **Use Realistic Data**: Test with representative data sizes and distributions
- **Measure What Matters**: Focus on end-to-end performance, not just micro-operations
- **Document Expectations**: Add comments explaining what performance is expected
- **Control Variability**: Close other applications, disable CPU frequency scaling if needed
- **Include Test Data**: Add any necessary input files to `benches/`

## 🔗 Integration with CI/CD

### Automated Performance Testing

Integrate benchmarks into your CI pipeline:

```yaml
# .github/workflows/benchmark.yml
name: Benchmarks
on: [push, pull_request]

jobs:
  benchmark:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Run benchmarks
        run: cargo bench --no-fail-fast
      - name: Archive benchmark results
        uses: actions/upload-artifact@v2
        with:
          name: benchmark-results
          path: target/criterion/
```

### Performance Tracking

Use tools like:
- [bencher.dev](https://bencher.dev/) for continuous benchmarking
- GitHub Actions with artifact uploads for historical tracking
- Custom scripts to parse and track Criterion JSON output

## 🤝 Contributing Benchmarks

When contributing new benchmarks:

1. **Follow Naming Conventions**: Use descriptive names that indicate what is being measured
2. **Add Documentation**: Include comments explaining the benchmark purpose
3. **Test All Implementations**: Ensure dfir, timely, and differential versions work
4. **Include Test Data**: Add any necessary input files to `benches/`
5. **Update Documentation**: Add new benchmarks to this guide and the main README
6. **Follow Rust Conventions**: Place benchmark files directly in the `benches/` directory

## 📚 Additional Resources

- [Criterion.rs Documentation](https://bheisler.github.io/criterion.rs/book/)
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)
- [Hydro Documentation](https://hydro.run/docs/)

## ❓ FAQ

### Q: Why do benchmark results vary between runs?

**A**: System load, CPU frequency scaling, thermal throttling, and other processes can affect results. For consistent results:
- Close other applications
- Disable CPU frequency scaling
- Use a dedicated benchmark machine
- Increase sample size

### Q: How long do benchmarks take to run?

**A**: Running all benchmarks typically takes 30-60 minutes depending on hardware. Individual benchmarks take 1-5 minutes.

### Q: Can I run benchmarks on different hardware?

**A**: Yes, but results are hardware-specific. Document your hardware configuration when sharing results.

### Q: How do I know if a performance difference is significant?

**A**: Criterion reports statistical significance (p-value). Generally, p < 0.05 indicates a significant change.

### Q: Can I benchmark with custom data?

**A**: Yes! Modify the benchmark files to use your own data. Make sure to document changes.

## 📝 Troubleshooting

### Build Errors

If you encounter build errors:

```bash
# Update dependencies
cargo update

# Clean and rebuild
cargo clean
cargo bench
```

### Missing Dependencies

Ensure you have the required system dependencies:

```bash
# Ubuntu/Debian
sudo apt-get install build-essential

# macOS
xcode-select --install
```

### Out of Memory

Some benchmarks are memory-intensive:

```bash
# Reduce concurrency
cargo bench -- --test-threads=1

# Run individual benchmarks
cargo bench --bench identity
```

## 🎯 Next Steps

1. Start with the identity benchmark to establish baselines
2. Run benchmarks relevant to your use case
3. Compare Hydro performance with Timely/Differential implementations
4. Use results to identify optimization opportunities
5. Contribute improvements back to the project

For questions or issues, please refer to the main [Hydro repository](https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) issue tracker.
