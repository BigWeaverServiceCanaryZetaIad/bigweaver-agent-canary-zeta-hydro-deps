# Quick Start Guide

Get up and running with the timely and differential-dataflow benchmarks in minutes.

## Prerequisites

Before you begin, ensure you have:

- **Rust**: Stable toolchain (1.70.0 or later recommended)
  ```bash
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  rustup update
  ```
- **Git**: For cloning the repository
- **~500MB disk space**: For dependencies and build artifacts

## Installation

### Step 1: Clone the Repository

```bash
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps
```

### Step 2: Verify Setup

```bash
# Check Rust version
rustc --version

# Verify repository structure
ls -la benches/
```

## Running Benchmarks

### Run All Benchmarks

```bash
# This runs all 8 benchmarks with full statistical analysis
cargo bench
```

**Expected output**: Progress bars for each benchmark, followed by summary statistics. This takes 5-15 minutes depending on your system.

### Run a Single Benchmark (Quick Test)

```bash
# Run just one benchmark to verify everything works
cargo bench --bench identity
```

**Expected duration**: ~1 minute

### View Results

After running benchmarks, HTML reports are automatically generated:

```bash
# Open the main report index
open target/criterion/report/index.html   # macOS
xdg-open target/criterion/report/index.html   # Linux
start target/criterion/report/index.html  # Windows
```

## Common Tasks

### 1. Quick Sanity Check

Run the fastest benchmark to verify everything works:

```bash
cargo bench --bench identity -- --quick
```

### 2. Run Specific Benchmarks

```bash
# Pattern matching benchmarks
cargo bench --bench fan_in
cargo bench --bench fan_out
cargo bench --bench fork_join

# Complex benchmarks
cargo bench --bench reachability
```

### 3. Compare Performance Over Time

```bash
# Run benchmarks and save baseline
cargo bench -- --save-baseline initial

# Make changes, then compare
cargo bench -- --baseline initial
```

### 4. Run with Custom Parameters

```bash
# Longer measurement time for more accurate results
cargo bench --bench reachability -- --measurement-time 20

# Shorter warm-up time for faster execution
cargo bench --bench identity -- --warm-up-time 1
```

## Performance Comparison with DFIR

To compare these benchmarks with DFIR implementations:

### Step 1: Run Timely/Differential Benchmarks (This Repo)

```bash
# In this repository
cargo bench | tee timely_results.txt
```

### Step 2: Run DFIR Benchmarks (Main Repo)

```bash
# Clone and run main Hydro repository
cd ..
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git
cd bigweaver-agent-canary-hydro-zeta

# Run DFIR benchmarks
cargo bench -p benches | tee dfir_results.txt
```

### Step 3: Compare Results

Use criterion's HTML reports or compare the text output manually:

```bash
# Compare key metrics from both files
grep "time:" timely_results.txt
grep "time:" dfir_results.txt
```

## Troubleshooting

### Build Fails

```bash
# Clean and rebuild
cargo clean
cargo build

# Update dependencies
cargo update
```

### Benchmarks Run Slowly

- Close other applications to reduce system noise
- Run on AC power (laptops may throttle on battery)
- Use longer measurement times: `cargo bench -- --measurement-time 30`

### Permission Errors

```bash
# On Linux, you may need to adjust file permissions
chmod +x target/release/deps/benchmark_name
```

### Missing Data Files

```bash
# Verify data files exist
ls -lh benches/benches/*.txt

# Should show:
# reachability_edges.txt (533KB)
# reachability_reachable.txt (38KB)

# If missing, restore from git
git checkout benches/benches/*.txt
```

### Out of Memory

The reachability benchmark uses significant memory. If you encounter OOM errors:

```bash
# Run lighter benchmarks only
cargo bench --bench arithmetic
cargo bench --bench identity
cargo bench --bench upcase
```

## Benchmark Overview

Quick reference for each benchmark:

| Benchmark | Runtime | Complexity | Purpose |
|-----------|---------|------------|---------|
| identity | ~30s | Low | Baseline overhead |
| arithmetic | ~1m | Low | Computation performance |
| upcase | ~1m | Low | String operations |
| fan_in | ~2m | Medium | Data convergence |
| fan_out | ~2m | Medium | Data distribution |
| fork_join | ~3m | Medium | Parallel patterns |
| join | ~3m | Medium | Join operations |
| reachability | ~5m | High | Graph algorithms |

## Next Steps

Now that you have the benchmarks running:

1. **Explore the code**: Check out `benches/benches/*.rs` to see implementations
2. **Read detailed docs**: See [benches/README.md](benches/README.md) for comprehensive information
3. **Add your own benchmarks**: Follow the patterns in existing benchmarks
4. **Compare with DFIR**: Use the performance comparison workflow above

## Quick Reference Commands

```bash
# Build everything
cargo build --release

# Run all benchmarks
cargo bench

# Run specific benchmark
cargo bench --bench <name>

# Run quick version
cargo bench -- --quick

# View results
open target/criterion/report/index.html

# Clean build artifacts
cargo clean
```

## Getting Help

If you run into issues:

1. Check [benches/README.md](benches/README.md) for detailed documentation
2. Review [MIGRATION_NOTES.md](MIGRATION_NOTES.md) for migration context
3. Verify your Rust version: `rustc --version` (1.70.0+ recommended)
4. Check system resources: `free -h` (Linux) or Activity Monitor (macOS)
5. Open an issue with:
   - Error message
   - Rust version
   - OS and system specs
   - Steps to reproduce

## Additional Resources

- **Main README**: [README.md](README.md) - Complete project overview
- **Benchmark Details**: [benches/README.md](benches/README.md) - Comprehensive benchmark docs
- **Migration Info**: [MIGRATION_NOTES.md](MIGRATION_NOTES.md) - Why and how these were separated
- **Criterion Docs**: https://bheisler.github.io/criterion.rs/book/ - Benchmarking framework docs
- **Timely Docs**: https://github.com/TimelyDataflow/timely-dataflow - Timely dataflow framework
- **Differential Docs**: https://github.com/TimelyDataflow/differential-dataflow - Differential dataflow framework

Happy benchmarking! 🚀
