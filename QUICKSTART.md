# Quick Start Guide

Get up and running with the Hydro comparison benchmarks in 5 minutes!

## Prerequisites

- ✅ Rust toolchain installed ([rustup.rs](https://rustup.rs))
- ✅ Git (for cloning repository)

## Step 1: Get the Code

```bash
git clone <repository-url> bigweaver-agent-canary-zeta-hydro-deps
cd bigweaver-agent-canary-zeta-hydro-deps
```

## Step 2: (Optional) Configure Dependencies

**Note**: Some benchmarks may require `dfir_rs` and `sinktools` from the main Hydro repository.

### Option A: Use Path Dependencies

If you have the main Hydro repository locally:

```toml
# Edit Cargo.toml and uncomment:
[dev-dependencies]
dfir_rs = { path = "../bigweaver-agent-canary-hydro-zeta/dfir_rs", features = [ "debugging" ] }
sinktools = { path = "../bigweaver-agent-canary-hydro-zeta/sinktools", version = "^0.0.1" }
```

### Option B: Use Git Dependencies

```toml
# Edit Cargo.toml and uncomment:
[dev-dependencies]
dfir_rs = { git = "https://github.com/hydro-project/hydro.git", features = [ "debugging" ] }
sinktools = { git = "https://github.com/hydro-project/hydro.git", version = "^0.0.1" }
```

### Option C: Skip for Now

Many benchmarks work without these dependencies. Try running first!

## Step 3: Verify Setup

Run the verification script:

```bash
./verify_benchmarks.sh
```

Expected output:
```
✓ Cargo.toml exists
✓ benches directory exists
✓ Benchmark file: arithmetic.rs
...
✓ All critical checks passed!
```

## Step 4: Run Your First Benchmark

Try a quick benchmark run:

```bash
# Quick mode - runs faster with fewer samples
cargo bench --bench arithmetic -- --quick
```

This will:
- Compile the benchmark (first time may take a few minutes)
- Run the arithmetic benchmark in quick mode
- Display results in terminal
- Generate HTML report

## Step 5: View Results

Open the HTML report:

```bash
# On macOS:
open target/criterion/report/index.html

# On Linux:
xdg-open target/criterion/report/index.html

# On Windows:
start target/criterion/report/index.html
```

## Common Commands

### Run All Benchmarks

```bash
# Full run (may take 10-30 minutes)
cargo bench

# Quick run (faster, less accurate)
cargo bench -- --quick
```

### Run Specific Benchmark

```bash
# Just the arithmetic benchmark
cargo bench --bench arithmetic

# Just the reachability benchmark
cargo bench --bench reachability
```

### Use Helper Script

```bash
# Quick mode with helper script
./run_comparison.sh --quick

# Run specific benchmark
./run_comparison.sh --bench arithmetic

# Save as baseline for future comparisons
./run_comparison.sh --save-baseline --baseline-name my-baseline
```

## Available Benchmarks

| Benchmark | Description | Time (approx) |
|-----------|-------------|---------------|
| arithmetic | Arithmetic operations | ~2 min |
| fan_in | Multiple streams merging | ~2 min |
| fan_out | Stream splitting | ~2 min |
| fork_join | Split and merge pattern | ~2 min |
| identity | Framework overhead test | ~2 min |
| join | Stream join operations | ~2 min |
| reachability | Graph reachability | ~5 min |
| upcase | String transformation | ~2 min |

**Total for all benchmarks**: ~15-20 minutes (full run)

## Understanding Results

### Terminal Output

```
arithmetic/hydroflow  time:   [45.234 ms 45.678 ms 46.123 ms]
                      change: [-2.12% -1.57% -0.99%] (p = 0.00 < 0.05)
                      Performance has improved.
```

- **time**: [lower bound, estimate, upper bound] for 95% confidence interval
- **change**: Percentage change from previous run (if available)
- **p-value**: Statistical significance (< 0.05 = significant change)

### HTML Report

Interactive visualizations showing:
- Performance distributions (violin plots)
- Time series trends
- Comparison between implementations
- Statistical analysis

## Troubleshooting

### "Cannot compile" errors

```bash
# Clean and rebuild
cargo clean
cargo build --benches
```

### Missing dependencies

If you see errors about `dfir_rs` or `sinktools`:
- Follow Step 2 above to configure dependencies
- Or comment out benchmarks that require them

### Build takes too long

First compilation can take 5-10 minutes. Subsequent builds are much faster.

```bash
# Speed up by using fewer cores (if system is slow)
CARGO_BUILD_JOBS=2 cargo build --benches
```

### Benchmarks take too long

Use quick mode:

```bash
cargo bench -- --quick
# or
./run_comparison.sh --quick
```

## Next Steps

### Learn More

- 📖 [Full Documentation](README.md) - Complete overview
- 📊 [Benchmark Details](BENCHMARKS.md) - In-depth benchmark explanations
- 🔧 [Contributing](CONTRIBUTING.md) - Add your own benchmarks
- 📝 [Migration Notes](MIGRATION_NOTES.md) - Background on this repository

### Run Full Suite

When ready, run the complete benchmark suite:

```bash
./run_comparison.sh --save-baseline --baseline-name initial
```

This creates a baseline for tracking performance over time.

### Compare Performance

After making changes, compare against baseline:

```bash
cargo bench --baseline initial
```

### Explore Examples

Look at benchmark source files to understand implementation:

```bash
# View arithmetic benchmark
less benches/arithmetic.rs

# View reachability benchmark
less benches/reachability.rs
```

## Tips for Best Results

1. **Close Other Applications**: For consistent results, minimize background processes
2. **Run Multiple Times**: Run benchmarks 2-3 times to ensure consistency
3. **Use Same Hardware**: Compare results on the same machine
4. **Check CPU Governor**: Disable CPU frequency scaling for consistent results:
   ```bash
   # Linux - check current governor
   cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
   ```

## Getting Help

- 📖 Check [README.md](README.md) for detailed information
- 🔍 Review [BENCHMARKS.md](BENCHMARKS.md) for benchmark-specific questions
- 🐛 Run `./verify_benchmarks.sh` to diagnose issues
- 💬 Open an issue in the repository

## Quick Reference Card

```bash
# Verify setup
./verify_benchmarks.sh

# Quick test
cargo bench --bench arithmetic -- --quick

# Run all (quick mode)
./run_comparison.sh --quick

# Run specific benchmark
./run_comparison.sh --bench <name>

# Full run with baseline
./run_comparison.sh --save-baseline

# View results
open target/criterion/report/index.html
```

---

**You're ready to go!** 🚀

Start with `cargo bench --bench arithmetic -- --quick` and explore from there.
