# Quick Start Guide

Get started with timely and differential-dataflow benchmarks in minutes.

## Prerequisites

- Rust toolchain installed
- Git access to main repository (for dfir_rs dependency)
- This repository cloned locally

## Running Your First Benchmark

```bash
# Run a simple benchmark
./run_benchmarks.sh arithmetic

# View results in terminal output
```

That's it! You've run your first benchmark.

## Common Tasks

### Run All Benchmarks

```bash
./run_benchmarks.sh
# or
./run_benchmarks.sh --all
```

### Run Specific Benchmark

```bash
./run_benchmarks.sh <benchmark-name>
```

Available benchmarks: `arithmetic`, `fan_in`, `fan_out`, `fork_join`, `identity`, `join`, `reachability`, `upcase`

### Run Only Hydroflow Implementations

```bash
./run_benchmarks.sh --dfir-only
# or with filter
./run_benchmarks.sh -f dfir
```

### Run Only Timely Implementations

```bash
./run_benchmarks.sh --timely-only
# or with filter
./run_benchmarks.sh -f timely
```

### Quick Mode (Faster, Less Accurate)

```bash
./run_benchmarks.sh -q <benchmark-name>
```

### Save Results for Later Comparison

```bash
# Save current results as "baseline"
./run_benchmarks.sh -s baseline

# Later, compare new results with baseline
./run_benchmarks.sh -c baseline
```

### View HTML Report

```bash
./run_benchmarks.sh -o
# Opens browser with detailed report
```

## Comparing with Main Repository

```bash
# Compare with main repository benchmarks
./compare_with_main.sh

# Run both and compare
./compare_with_main.sh -r

# Save comparison to file
./compare_with_main.sh -o report.txt
```

## Manual Benchmark Execution

If you prefer using cargo directly:

```bash
# Run all benchmarks
cargo bench -p timely-differential-benches

# Run specific benchmark
cargo bench -p timely-differential-benches --bench arithmetic

# Run with filter
cargo bench -p timely-differential-benches -- dfir
```

## Understanding Results

### Terminal Output

```
arithmetic/dfir_rs/compiled
                        time:   [123.45 ms 124.56 ms 125.67 ms]
```

- **First value**: Lower bound of confidence interval
- **Second value**: Best estimate (mean)
- **Third value**: Upper bound of confidence interval

### HTML Reports

Open `target/criterion/report/index.html` for detailed visualizations:
- Performance graphs
- Statistical analysis
- Historical comparisons
- Outlier detection

## Common Options

| Option | Description | Example |
|--------|-------------|---------|
| `-h, --help` | Show help | `./run_benchmarks.sh -h` |
| `-a, --all` | Run all benchmarks | `./run_benchmarks.sh -a` |
| `-l, --list` | List benchmarks | `./run_benchmarks.sh -l` |
| `-f, --filter` | Filter by name | `./run_benchmarks.sh -f dfir` |
| `-q, --quick` | Quick mode | `./run_benchmarks.sh -q arithmetic` |
| `-s, --save` | Save results | `./run_benchmarks.sh -s baseline` |
| `-c, --compare` | Compare results | `./run_benchmarks.sh -c baseline` |
| `-o, --open` | Open report | `./run_benchmarks.sh -o` |
| `--dfir-only` | Only dfir_rs | `./run_benchmarks.sh --dfir-only` |
| `--timely-only` | Only timely | `./run_benchmarks.sh --timely-only` |

## Troubleshooting

### Compilation Errors

```bash
# Clean and rebuild
cargo clean
cargo check -p timely-differential-benches
```

### Git Dependency Issues

Ensure main repository is accessible:
```bash
# Check main repository
cd ../bigweaver-agent-canary-hydro-zeta
git pull

# Retry in this repository
cd ../bigweaver-agent-canary-zeta-hydro-deps
cargo update
```

### Permission Denied on Scripts

```bash
chmod +x run_benchmarks.sh compare_with_main.sh
```

## Next Steps

- Read [benches/README.md](benches/README.md) for detailed benchmark documentation
- Review [README.md](README.md) for architecture and integration details
- Check [MIGRATION_SUMMARY.md](MIGRATION_SUMMARY.md) for migration history

## Tips

1. **Start with quick mode** (`-q`) for rapid iteration
2. **Use filters** to focus on specific implementations
3. **Save baselines** before making changes
4. **Compare regularly** to detect regressions early
5. **Check HTML reports** for detailed analysis

## Examples

### Performance Testing Workflow

```bash
# 1. Save baseline before changes
./run_benchmarks.sh -s before-optimization

# 2. Make changes in main repository
cd ../bigweaver-agent-canary-hydro-zeta
# ... make changes ...

# 3. Compare after changes
cd ../bigweaver-agent-canary-zeta-hydro-deps
./run_benchmarks.sh -c before-optimization -o
```

### Quick Sanity Check

```bash
# Run one quick benchmark
./run_benchmarks.sh -q identity

# Should complete in seconds
```

### Comprehensive Comparison

```bash
# Run all benchmarks and compare with main
./compare_with_main.sh -r -o full_comparison.txt

# Review the report
cat full_comparison.txt
```

## Need Help?

- Run `./run_benchmarks.sh -h` for script help
- Run `./compare_with_main.sh -h` for comparison help
- See [benches/README.md](benches/README.md) for detailed docs
- Check [MIGRATION_SUMMARY.md](MIGRATION_SUMMARY.md) for architecture

---

Happy benchmarking! 🚀
