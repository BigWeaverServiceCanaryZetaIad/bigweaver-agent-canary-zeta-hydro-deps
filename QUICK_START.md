# Quick Start Guide

Get up and running with the benchmarks in 5 minutes.

## Prerequisites

- Rust 1.89.0 (automatically installed via rust-toolchain.toml)
- Git
- ~5GB disk space for dependencies

## Installation

```bash
# Clone the repository
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps

# Verify installation
cargo --version
```

## Running Benchmarks

### Run All Benchmarks

```bash
cargo bench -p benches
```

**Expected time**: 10-20 minutes depending on your hardware.

### Run Specific Benchmarks

```bash
# Run arithmetic benchmarks only
cargo bench -p benches --bench arithmetic

# Run reachability benchmarks only
cargo bench -p benches --bench reachability

# Run join benchmarks only
cargo bench -p benches --bench join
```

### Run Framework-Specific Benchmarks

```bash
# Run only DFIR benchmarks
cargo bench -p benches -- dfir

# Run only Timely benchmarks
cargo bench -p benches -- timely

# Run only Differential benchmarks
cargo bench -p benches -- differential
```

### Run Micro Operations

```bash
# Run micro operations benchmarks
cargo bench -p benches -- micro/ops/
```

## Viewing Results

### Local HTML Reports

After running benchmarks, open the Criterion HTML reports:

```bash
# Open in browser (Linux)
xdg-open target/criterion/report/index.html

# Open in browser (macOS)
open target/criterion/report/index.html

# Open in browser (Windows)
start target/criterion/report/index.html
```

### GitHub Pages (After Setup)

Once the repository is pushed and GitHub Pages is enabled:

```
https://BigWeaverServiceCanaryZetaIad.github.io/bigweaver-agent-canary-zeta-hydro-deps/bench/
```

## CI/CD Integration

### Trigger Benchmarks on Commit

Include `[ci-bench]` in your commit message:

```bash
git commit -m "Update benchmark parameters [ci-bench]"
git push
```

### Trigger Benchmarks on PR

Include `[ci-bench]` in the PR title or description:

```
Title: Performance improvements [ci-bench]
```

### Manual Trigger

1. Go to repository on GitHub
2. Click "Actions" tab
3. Select "benchmark" workflow
4. Click "Run workflow"
5. Set "Should Benchmark?" to `true`
6. Click "Run workflow" button

## Common Commands

```bash
# Check dependencies
cargo fetch

# Build without running
cargo bench -p benches --no-run

# Run with verbose output
cargo bench -p benches --verbose

# Run single test iteration (for debugging)
cargo bench -p benches --bench arithmetic -- --sample-size 10

# Save baseline for comparison
cargo bench -p benches -- --save-baseline my-baseline

# Compare against baseline
cargo bench -p benches -- --baseline my-baseline
```

## Benchmark List

| Name | Description | Run Time |
|------|-------------|----------|
| `arithmetic` | Pipeline arithmetic operations | ~1 min |
| `fan_in` | Fan-in pattern | ~1 min |
| `fan_out` | Fan-out pattern | ~1 min |
| `fork_join` | Fork-join pattern | ~2 min |
| `futures` | Futures handling | ~1 min |
| `identity` | Identity/passthrough | ~1 min |
| `join` | Join operations | ~2 min |
| `micro_ops` | Micro operations | ~2 min |
| `reachability` | Graph reachability | ~3 min |
| `symmetric_hash_join` | Symmetric hash join | ~2 min |
| `upcase` | String transformation | ~1 min |
| `words_diamond` | Word processing diamond | ~2 min |

## Troubleshooting

### Build Fails

**Error**: `failed to fetch ...`

**Solution**:
```bash
cargo clean
cargo fetch
cargo bench -p benches --no-run
```

### Slow Compilation

**Issue**: First build takes a long time

**Expected**: Yes, dependencies are large (~5GB). Subsequent builds are cached.

**Speed up**:
```bash
# Use parallel compilation (if not already set)
export CARGO_BUILD_JOBS=8
```

### Out of Memory

**Issue**: Build runs out of memory

**Solution**: Reduce parallel jobs
```bash
export CARGO_BUILD_JOBS=2
cargo bench -p benches
```

### Git Dependencies Fail

**Error**: `failed to clone git repository`

**Solution**:
```bash
# Clear git cache
rm -rf ~/.cargo/git
cargo fetch
```

### Permission Denied

**Issue**: Cannot write benchmark results

**Solution**:
```bash
# Fix permissions
chmod -R u+w target/
```

## Quick Tips

1. **First run takes longest** - Dependencies need to compile (~30-60 minutes)
2. **Use filters** - Run specific benchmarks to save time
3. **Check CPU usage** - Benchmarks use all available cores
4. **Close other apps** - For accurate results, minimize background processes
5. **Save baselines** - Compare performance before/after changes

## Next Steps

- Read [README.md](README.md) for complete overview
- Check [CONFIGURATION.md](CONFIGURATION.md) for detailed configuration
- Review [MIGRATION.md](MIGRATION.md) to understand the migration
- See [benches/README.md](benches/README.md) for benchmark details

## Support

For issues or questions:

1. Check [CONFIGURATION.md](CONFIGURATION.md) troubleshooting section
2. Review GitHub Actions logs for CI/CD issues
3. Compare with baseline results in gh-pages
4. Check main repository for upstream changes

## Benchmark Output Example

```
arithmetic/pipeline     time:   [152.34 ms 153.21 ms 154.15 ms]
                        thrpt:  [6.4899 Melem/s 6.5293 Melem/s 6.5664 Melem/s]

arithmetic/dfir         time:   [168.92 ms 170.13 ms 171.42 ms]
                        thrpt:  [5.8342 Melem/s 5.8785 Melem/s 5.9208 Melem/s]

arithmetic/timely       time:   [145.67 ms 146.89 ms 148.19 ms]
                        thrpt:  [6.7490 Melem/s 6.8084 Melem/s 6.8654 Melem/s]
```

- **time**: Execution time (lower is better)
- **thrpt**: Throughput (higher is better)
- Numbers show [lower_bound best_estimate upper_bound]

## Performance Metrics

Criterion provides:

- **Mean**: Average execution time
- **Median**: Middle value of execution times
- **Std Dev**: Standard deviation (variance)
- **Outliers**: Samples outside expected range
- **R²**: Goodness of fit (closer to 1.0 is better)

## Configuration Tips

### Adjust Sample Size

In benchmark file:
```rust
c.bench_function("my_benchmark", |b| {
    b.iter(|| {
        // benchmark code
    })
})
.sample_size(100) // Adjust for faster/more accurate results
```

### Adjust Measurement Time

```rust
use criterion::Criterion;

let mut criterion = Criterion::default()
    .measurement_time(std::time::Duration::from_secs(10));
```

### Warm-up Time

```rust
.warm_up_time(std::time::Duration::from_secs(3))
```

## Resources

- **Criterion Book**: https://bheisler.github.io/criterion.rs/book/
- **Cargo Bench**: https://doc.rust-lang.org/cargo/commands/cargo-bench.html
- **Benchmarking Best Practices**: https://easyperf.net/blog/

---

**Ready to start?** Run: `cargo bench -p benches --bench arithmetic`
