# Performance Comparison Guide

This guide explains how to maintain performance comparisons between the main `bigweaver-agent-canary-hydro-zeta` repository and the benchmarks in this repository.

## 📋 Overview

The benchmarks in this repository test the performance of code from the main repository. Since the benchmarks depend on the main repository via relative paths, changes to the main repository directly affect benchmark results.

## 🎯 Repository Relationship

```
workspace/
├── bigweaver-agent-canary-hydro-zeta/     # Main repository
│   ├── dfir_rs/                           # Referenced by benchmarks
│   └── sinktools/                         # Referenced by benchmarks
└── bigweaver-agent-canary-zeta-hydro-deps/ # This repository
    └── benches/
        ├── Cargo.toml                     # Points to ../bigweaver-agent-canary-hydro-zeta
        └── benches/*.rs                   # Benchmark files
```

The benchmarks in this repository depend on:
- `dfir_rs` from the main repository
- `sinktools` from the main repository
- `timely` and `differential-dataflow` (managed in this repository)

## 🔧 Setting Up for Performance Testing

### Initial Setup

1. Clone both repositories as siblings:
```bash
cd workspace/
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
```

2. Verify the setup:
```bash
cd bigweaver-agent-canary-zeta-hydro-deps/benches
cargo check
```

### Environment Configuration

For consistent results, configure your environment:

```bash
# Set CPU governor to performance mode (Linux)
echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor

# Disable CPU frequency scaling (if supported)
sudo cpupower frequency-set -g performance

# Clear system caches before benchmarking
sync; echo 3 | sudo tee /proc/sys/vm/drop_caches
```

## 📊 Running Performance Comparisons

### Baseline Comparison

Compare current changes against a baseline:

```bash
cd bigweaver-agent-canary-zeta-hydro-deps/benches

# 1. Save baseline from main branch
cd ../../bigweaver-agent-canary-hydro-zeta
git checkout main
cd ../bigweaver-agent-canary-zeta-hydro-deps/benches
cargo bench -- --save-baseline main

# 2. Switch to your feature branch
cd ../../bigweaver-agent-canary-hydro-zeta
git checkout feature-branch
cd ../bigweaver-agent-canary-zeta-hydro-deps/benches

# 3. Compare against baseline
cargo bench -- --baseline main
```

### Branch Comparison

Compare two different branches:

```bash
# Run baseline on branch A
cd bigweaver-agent-canary-hydro-zeta
git checkout branch-a
cd ../bigweaver-agent-canary-zeta-hydro-deps/benches
cargo bench -- --save-baseline branch-a

# Run comparison on branch B
cd ../../bigweaver-agent-canary-hydro-zeta
git checkout branch-b
cd ../bigweaver-agent-canary-zeta-hydro-deps/benches
cargo bench -- --baseline branch-a
```

### Version Comparison

Compare across different versions:

```bash
# Benchmark version 1.0
cd bigweaver-agent-canary-hydro-zeta
git checkout v1.0
cd ../bigweaver-agent-canary-zeta-hydro-deps/benches
cargo bench -- --save-baseline v1.0

# Benchmark version 2.0
cd ../../bigweaver-agent-canary-hydro-zeta
git checkout v2.0
cd ../bigweaver-agent-canary-zeta-hydro-deps/benches
cargo bench -- --baseline v1.0
```

## 📈 Interpreting Results

### Understanding Criterion Output

Criterion provides detailed statistical analysis:

```
arithmetic/dfir/10000 time:   [1.2345 ms 1.2456 ms 1.2567 ms]
                      change: [-5.23% -3.45% -1.67%] (p = 0.02 < 0.05)
                      Performance has improved.
```

- **Time range**: [lower_bound estimate upper_bound]
- **Change**: Percentage change from baseline
- **p-value**: Statistical significance (< 0.05 is significant)
- **Performance**: Improved (faster) or regressed (slower)

### Performance Thresholds

Consider investigating when:
- **> 5% regression**: May indicate a performance issue
- **> 10% regression**: Likely indicates a problem
- **> 20% regression**: Significant performance issue requiring attention

### Variance and Reliability

- **Low variance (< 5%)**: Results are reliable
- **High variance (> 10%)**: Re-run in a more controlled environment
- Check for background processes if variance is high

## 🔄 Continuous Integration

### CI/CD Integration

Example GitHub Actions workflow:

```yaml
name: Performance Benchmarks

on:
  pull_request:
    branches: [main]

jobs:
  benchmark:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout main repository
        uses: actions/checkout@v3
        with:
          repository: BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta
          path: bigweaver-agent-canary-hydro-zeta
          
      - name: Checkout benchmark repository
        uses: actions/checkout@v3
        with:
          path: bigweaver-agent-canary-zeta-hydro-deps
          
      - name: Setup Rust
        uses: actions-rs/toolchain@v1
        with:
          toolchain: stable
          
      - name: Run benchmarks
        run: |
          cd bigweaver-agent-canary-zeta-hydro-deps/benches
          cargo bench --no-fail-fast
```

### Automated Comparisons

For automated baseline comparisons:

```bash
# Run in CI
cargo bench -- --save-baseline ci-baseline
cargo bench -- --baseline ci-baseline --output-format bencher | tee bench-results.txt
```

## 📚 Best Practices

### Before Benchmarking

1. **Clean build**: `cargo clean` to ensure fresh compilation
2. **Consistent environment**: Close unnecessary applications
3. **Multiple runs**: Run benchmarks at least 3 times to verify consistency
4. **Warm-up**: First run may include compilation time; focus on subsequent runs

### During Development

1. **Incremental testing**: Benchmark after each significant change
2. **Document changes**: Note what changed between benchmark runs
3. **Track trends**: Keep a log of performance over time
4. **Investigate regressions**: Don't ignore small regressions; they can accumulate

### Maintaining Baselines

1. **Version baselines**: Save baselines for each major version
2. **Clean old baselines**: Remove outdated baselines periodically
3. **Document baseline**: Note the commit hash of the main repository

```bash
# Save with metadata
cd bigweaver-agent-canary-hydro-zeta
COMMIT_HASH=$(git rev-parse HEAD)
cd ../bigweaver-agent-canary-zeta-hydro-deps/benches
cargo bench -- --save-baseline "main-${COMMIT_HASH:0:8}"
```

## 🎯 Specific Benchmark Use Cases

### Testing Optimization Impact

```bash
# Baseline before optimization
cargo bench --bench arithmetic -- --save-baseline pre-optimization

# Make optimization changes in main repository

# Test optimization
cargo bench --bench arithmetic -- --baseline pre-optimization
```

### Regression Testing

```bash
# Test that changes don't cause regression
cargo bench -- --save-baseline before-changes

# Make changes in main repository

# Check for regressions
cargo bench -- --baseline before-changes

# If regression detected, investigate
git diff HEAD~1 # Check what changed in main repository
```

### Feature Performance

When adding a new feature:

```bash
# Baseline without feature
cargo bench -- --save-baseline without-feature

# Implement feature in main repository

# Measure feature cost
cargo bench -- --baseline without-feature
```

## 🐛 Troubleshooting

### Inconsistent Results

If results vary significantly between runs:

1. Check CPU frequency scaling
2. Monitor system load during benchmarks
3. Ensure no background tasks are running
4. Consider increasing sample size
5. Run on a dedicated benchmark machine

### Build Failures

If benchmarks fail to build:

1. Verify both repositories are up to date
2. Check that relative paths are correct
3. Ensure compatible versions in Cargo.toml
4. Run `cargo update` to refresh dependencies

### Missing Baselines

If baseline comparison fails:

```bash
# List available baselines
ls -la target/criterion/*/base/

# Recreate baseline if missing
cargo bench -- --save-baseline <baseline-name>
```

## 📊 Reporting Results

### For Pull Requests

Include benchmark results in PR descriptions:

```markdown
## Performance Impact

Benchmarked against main branch:

- `arithmetic`: +2.3% improvement
- `reachability`: No significant change
- `join`: -1.2% regression (within noise threshold)

<details>
<summary>Full benchmark output</summary>

```
[paste benchmark output]
```

</details>
```

### For Documentation

Maintain a PERFORMANCE.md file with historical data:

```markdown
## Performance History

### Version 2.0 (2024-01-15)
- `arithmetic`: 1.2ms (5% improvement from v1.9)
- `reachability`: 45ms (no change)

### Version 1.9 (2024-01-01)
- `arithmetic`: 1.26ms
- `reachability`: 45ms
```

## 📖 Additional Resources

- [Criterion.rs Book](https://bheisler.github.io/criterion.rs/book/)
- [Benchmarking Best Practices](https://easyperf.net/blog/)
- [Statistical Analysis of Benchmarks](https://www.gnu.org/software/gsl/doc/html/statistics.html)

## 🔗 Related Documentation

- [CONTRIBUTING.md](CONTRIBUTING.md) - How to add new benchmarks
- [README.md](README.md) - General repository information
- [benches/README.md](benches/README.md) - Benchmark-specific documentation
