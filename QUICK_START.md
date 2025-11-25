# Quick Start Guide

Get up and running with Hydro benchmarks in 5 minutes!

## Prerequisites

- Rust toolchain (1.91.1 or later)
- Git
- 4GB RAM minimum

## Setup

### 1. Clone Both Repositories

The benchmarks reference the main Hydro repository, so both need to be cloned side-by-side:

```bash
# Create a workspace directory
mkdir hydro-workspace
cd hydro-workspace

# Clone main Hydro repository
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git

# Clone benchmarks repository
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git

# Your directory structure should look like this:
# hydro-workspace/
# ├── bigweaver-agent-canary-hydro-zeta/
# └── bigweaver-agent-canary-zeta-hydro-deps/
```

### 2. Build the Benchmarks

```bash
cd bigweaver-agent-canary-zeta-hydro-deps
cargo build -p hydro-deps-benches --release
```

**Note**: First build will take 5-10 minutes as it compiles timely and differential-dataflow.

### 3. Verify Everything Works

```bash
./verify_benchmarks.sh
```

This checks that:
- ✅ Repository structure is correct
- ✅ Dependencies are available
- ✅ Benchmarks compile
- ✅ Quick test runs successfully

## Running Benchmarks

### Run All Benchmarks (takes ~30-60 minutes)

```bash
cargo bench -p hydro-deps-benches
```

### Run a Single Benchmark (fast)

```bash
# Run arithmetic benchmark only
cargo bench -p hydro-deps-benches --bench arithmetic

# Other available benchmarks:
cargo bench -p hydro-deps-benches --bench fan_in
cargo bench -p hydro-deps-benches --bench fan_out
cargo bench -p hydro-deps-benches --bench fork_join
cargo bench -p hydro-deps-benches --bench identity
cargo bench -p hydro-deps-benches --bench join
cargo bench -p hydro-deps-benches --bench reachability
cargo bench -p hydro-deps-benches --bench upcase
```

### Run Specific Implementation

```bash
# Run only Hydro (DFIR) variants
cargo bench -p hydro-deps-benches -- dfir

# Run only Timely variants
cargo bench -p hydro-deps-benches -- timely

# Run only Differential variants (reachability only)
cargo bench -p hydro-deps-benches -- differential
```

### Quick Test Run (reduced accuracy, faster)

```bash
cargo bench -p hydro-deps-benches -- --measurement-time 5 --sample-size 20
```

## View Results

Results are saved as HTML reports in `target/criterion/`:

```bash
# macOS
open target/criterion/arithmetic/report/index.html

# Linux
xdg-open target/criterion/arithmetic/report/index.html

# Windows
start target/criterion/arithmetic/report/index.html
```

## Understanding Results

### Terminal Output

```
arithmetic/dfir         time:   [45.123 ms 45.456 ms 45.789 ms]
                        change: [-2.3% -1.5% -0.7%] (p = 0.00 < 0.05)
                        Performance has improved.
```

- **time**: `[lower estimate upper]` - 95% confidence interval
- **change**: Compared to previous run
  - Negative = faster (improvement)
  - Positive = slower (regression)
- **p-value**: `p < 0.05` means statistically significant

### Compare Implementations

To see which is faster:
1. Look at the "estimate" (middle value)
2. Compare Hydro vs. Timely:
   - `arithmetic/dfir`: 45.456 ms
   - `arithmetic/timely`: 52.123 ms
   - **Result**: Hydro is ~14.7% faster

## Common Commands

```bash
# Clean build artifacts
cargo clean

# Rebuild everything
cargo build -p hydro-deps-benches --release

# Run with more samples (more accurate)
cargo bench -p hydro-deps-benches -- --sample-size 200

# Run with less time (faster)
cargo bench -p hydro-deps-benches -- --measurement-time 5

# Skip HTML report generation
cargo bench -p hydro-deps-benches -- --noplot

# Run benchmarks matching pattern
cargo bench -p hydro-deps-benches -- fan_
```

## Troubleshooting

### "Cannot find dfir_rs"

**Problem**: Benchmarks can't find the main repository.

**Solution**: Ensure repositories are side-by-side:
```bash
cd ..
ls -d bigweaver-agent-canary-hydro-zeta bigweaver-agent-canary-zeta-hydro-deps
```

### Build Errors

**Problem**: Compilation fails.

**Solution**:
```bash
# Update Rust
rustup update

# Clean and rebuild
cargo clean
cargo build -p hydro-deps-benches --release
```

### Slow Benchmarks

**Problem**: Benchmarks take too long.

**Solution**: Use reduced parameters:
```bash
cargo bench -p hydro-deps-benches -- --measurement-time 5 --sample-size 20
```

### Inconsistent Results

**Problem**: Results vary widely between runs.

**Solution**:
- Close other applications
- Increase sample size: `--sample-size 200`
- Increase measurement time: `--measurement-time 20`
- Ensure laptop is plugged in (not on battery)

## Next Steps

- **Detailed Guide**: See [BENCHMARK_GUIDE.md](BENCHMARK_GUIDE.md) for comprehensive documentation
- **Contributing**: See [CONTRIBUTING.md](CONTRIBUTING.md) to add new benchmarks
- **Main Repository**: Check out [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)

## Need Help?

1. Check [README.md](README.md) for overview
2. Read [BENCHMARK_GUIDE.md](BENCHMARK_GUIDE.md) for details
3. Search existing issues
4. Open a new issue with your question

## Benchmark Comparison Matrix

| Benchmark | Hydro | Timely | Differential | Baseline |
|-----------|-------|--------|--------------|----------|
| arithmetic | ✅ | ✅ | - | ✅ |
| fan_in | ✅ | ✅ | - | - |
| fan_out | ✅ | ✅ | - | - |
| fork_join | ✅ | ✅ | - | - |
| identity | ✅ | ✅ | - | - |
| join | ✅ | ✅ | - | - |
| reachability | ✅ | ✅ | ✅ | - |
| upcase | ✅ | ✅ | - | - |

## Tips for Best Results

1. **Always use release builds**: `--release` flag is essential
2. **Run on idle system**: Close other apps for consistent results
3. **Multiple runs**: Run 3-5 times and compare
4. **Check confidence intervals**: Narrow intervals = more reliable
5. **Statistical significance**: Look for p < 0.05

Happy benchmarking! 🚀
