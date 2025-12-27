# Benchmark Quick Reference

Quick reference for common benchmarking tasks.

## Common Commands

### Basic Usage

```bash
# Run all benchmarks
cargo bench -p benches

# Run specific benchmark
cargo bench -p benches --bench reachability

# Run with filter
cargo bench -p benches -- dfir_rs
cargo bench -p benches -- timely
cargo bench -p benches -- /raw/
```

### Quick Iteration

```bash
# Fast run for development (10 samples, 1s warmup)
cargo bench -p benches -- --sample-size 10 --warm-up-time 1

# Run specific test within benchmark
cargo bench -p benches --bench micro_ops -- identity
```

### Baseline Management

```bash
# Save current results as baseline
cargo bench -p benches -- --save-baseline main

# Compare against baseline
cargo bench -p benches -- --baseline main

# Compare specific benchmark
cargo bench -p benches --bench reachability -- --baseline main
```

### Helper Script (Recommended)

```bash
# Run all benchmarks
./run_benchmarks.sh

# Run specific benchmark
./run_benchmarks.sh reachability

# Quick mode for fast iteration
./run_benchmarks.sh --quick micro_ops

# Save baseline
./run_benchmarks.sh --save main

# Compare against baseline
./run_benchmarks.sh --compare main

# Quick comparison workflow
./run_benchmarks.sh --quick --save before-changes
# ... make changes ...
./run_benchmarks.sh --quick --compare before-changes
```

## Benchmark Matrix

| Benchmark | Purpose | Scale | Duration | Frameworks |
|-----------|---------|-------|----------|------------|
| `arithmetic` | Pipeline overhead | 1M ops × 20 stages | ~30s | Raw, Iter, Timely, Hydro |
| `fan_in` | Merge streams | 10 streams × 100K | ~20s | Timely, Hydro |
| `fan_out` | Split stream | 100K → 10 outputs | ~20s | Timely, Hydro |
| `fork_join` | Fork-join pattern | 20 iterations | ~25s | Timely, Hydro |
| `futures` | Async operations | Small workload | ~10s | Hydro |
| `identity` | Baseline overhead | 100K elements | ~15s | All |
| `join` | Hash join | 100K × 100K | ~30s | Timely, Raw |
| `micro_ops` | Individual ops | 10K per op | ~60s | Hydro |
| `reachability` | Graph algorithm | Graph iteration | ~40s | All |
| `symmetric_hash_join` | Join selectivity | Varied | ~20s | Hydro |
| `upcase` | String ops | 370K words | ~35s | All |
| `words_diamond` | Diamond pattern | 370K words | ~40s | Raw, Timely, Hydro |

**Total runtime**: ~5-6 minutes for all benchmarks

## Filter Patterns

### By Framework

```bash
# Hydro only
cargo bench -p benches -- dfir_rs

# Timely only
cargo bench -p benches -- timely

# Differential only
cargo bench -p benches -- differential

# Raw implementations only
cargo bench -p benches -- /raw/
```

### By Operation Type

```bash
# Join operations
cargo bench -p benches -- join

# String operations
cargo bench -p benches --bench upcase
cargo bench -p benches --bench words_diamond

# Graph algorithms
cargo bench -p benches --bench reachability

# Micro operations
cargo bench -p benches --bench micro_ops -- map
cargo bench -p benches --bench micro_ops -- filter
```

### By Complexity

```bash
# Simple/fast benchmarks
cargo bench -p benches --bench identity
cargo bench -p benches --bench fan_in

# Medium benchmarks
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench join

# Complex/slow benchmarks
cargo bench -p benches --bench reachability
cargo bench -p benches --bench words_diamond
```

## Viewing Results

### Command Line

Results are printed to stdout with statistical summary.

### HTML Reports

```bash
# Open main report (all benchmarks)
open target/criterion/report/index.html           # macOS
xdg-open target/criterion/report/index.html       # Linux
start target/criterion/report/index.html          # Windows

# Open specific benchmark report
open target/criterion/reachability/report/index.html
```

### Directory Structure

```
target/criterion/
├── report/
│   └── index.html                    # Main report (all benchmarks)
├── <benchmark_name>/
│   ├── report/
│   │   └── index.html                # Benchmark-specific report
│   ├── <test_case>/
│   │   ├── report/
│   │   │   └── index.html            # Test case report
│   │   ├── new/
│   │   │   ├── estimates.json        # Statistical estimates
│   │   │   └── sample.json           # Raw measurements
│   │   └── base/                     # Previous run (for comparison)
│   └── ...
└── ...
```

## Performance Targets

### Framework Overhead (vs Raw)

| Operation Type | Target Overhead | Acceptable Range |
|----------------|-----------------|-------------------|
| Simple (map, filter) | <20% | 10-30% |
| Medium (join, group) | <40% | 30-50% |
| Complex (iteration) | <30% | 20-40% |

### Relative Performance (Hydro vs Timely)

| Scenario | Target | Acceptable Range |
|----------|--------|-------------------|
| Simple pipelines | Faster | 0.8-1.2x |
| Complex graphs | Comparable | 0.9-1.1x |
| String operations | Comparable | 0.9-1.1x |

### Compiled vs Surface Syntax

| Metric | Target | Acceptable Range |
|--------|--------|-------------------|
| Overhead | <5% | 0-10% |
| Variance | Same | ±2% |

## Quick Troubleshooting

### Problem: Build fails

```bash
# Verify path to main repo
ls ../bigweaver-agent-canary-hydro-zeta/dfir_rs

# Clean and rebuild
cargo clean -p benches
cargo build -p benches
```

### Problem: High variance in results

```bash
# Close background apps
# Run with more samples
cargo bench -p benches -- --sample-size 200

# Use dedicated benchmark environment
```

### Problem: Benchmarks too slow

```bash
# Run subset
cargo bench -p benches --bench micro_ops

# Use quick mode
cargo bench -p benches -- --sample-size 10 --warm-up-time 1

# Skip slow benchmarks
cargo bench -p benches --skip reachability --skip words_diamond
```

### Problem: Results don't match expectations

```bash
# Verify release mode (cargo bench should use release automatically)
cargo bench -p benches --verbose

# Check for debug builds
ls target/release/deps/

# Verify data files are embedded
cargo clean -p benches && cargo bench -p benches --bench reachability
```

## Workflow Examples

### 1. Initial Benchmarking

```bash
# First run - establish baseline
cargo bench -p benches -- --save-baseline initial

# View results
open target/criterion/report/index.html
```

### 2. Development Iteration

```bash
# Quick baseline
cargo bench -p benches --bench micro_ops -- --sample-size 10 --save-baseline before

# Make changes to Hydro...

# Quick comparison
cargo bench -p benches --bench micro_ops -- --sample-size 10 --baseline before

# If looking good, full benchmark
cargo bench -p benches --bench micro_ops -- --baseline before
```

### 3. Performance Investigation

```bash
# Run specific operation
cargo bench -p benches --bench micro_ops -- join

# Try different implementations
cargo bench -p benches --bench join -- timely
cargo bench -p benches --bench join -- /sol/
cargo bench -p benches --bench join -- dfir_rs

# Profile if needed
cargo bench -p benches --bench join -- --profile-time=10
```

### 4. Regression Testing

```bash
# On main branch
git checkout main
cargo bench -p benches -- --save-baseline main

# On feature branch
git checkout feature/my-optimization
cargo bench -p benches -- --baseline main

# Check for regressions in output
grep "regressed" benchmark_output.txt
```

### 5. Release Validation

```bash
# Run all benchmarks
cargo bench -p benches -- --save-baseline release-v1.0

# Compare against previous release
cargo bench -p benches -- --baseline release-v0.9

# Document any significant changes
```

## CI/CD Integration

### GitHub Actions Example

```yaml
name: Benchmark

on:
  pull_request:
    branches: [ main ]

jobs:
  benchmark:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: actions-rs/toolchain@v1
        with:
          toolchain: stable
      
      # Get baseline from main branch
      - name: Checkout main
        run: git fetch origin main
      - name: Run main benchmarks
        run: |
          git checkout origin/main
          cargo bench -p benches -- --save-baseline main
      
      # Compare PR against main
      - name: Checkout PR
        run: git checkout ${{ github.sha }}
      - name: Run PR benchmarks
        run: cargo bench -p benches -- --baseline main
```

## Tips and Tricks

1. **Fast Feedback Loop**: Use `--sample-size 10` for quick iteration
2. **Focus Testing**: Use filters to run only relevant benchmarks
3. **Baseline Everything**: Always save baselines before making changes
4. **Multiple Runs**: Run 3-5 times to verify consistency
5. **Document Results**: Keep notes on what changes affected performance
6. **Use Helper Script**: The `run_benchmarks.sh` script simplifies common tasks
7. **Check HTML Reports**: Visual plots often reveal patterns not obvious in CLI output
8. **Profile Slowdowns**: Use flamegraphs to identify bottlenecks
9. **Version Control Baselines**: Commit baseline results for team sharing
10. **Automate Regression Checks**: Integrate into CI/CD pipeline

## Additional Resources

- Full documentation: `README.md`
- Performance guide: `PERFORMANCE_COMPARISON.md`
- Benchmark sources: `benches/benches/`
- [Criterion.rs Book](https://bheisler.github.io/criterion.rs/book/)
