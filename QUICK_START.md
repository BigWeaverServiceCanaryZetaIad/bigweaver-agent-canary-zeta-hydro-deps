# Quick Start Guide

Get up and running with the Hydro benchmarks in minutes.

## Prerequisites

- **Rust 1.91.1** (automatically managed via `rust-toolchain.toml`)
- **Git**
- Approximately **10 minutes** for initial compilation

## Installation

### 1. Clone the Repository

```bash
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps
cd bigweaver-agent-canary-zeta-hydro-deps
```

### 2. Verify Rust Installation

The repository will automatically use Rust 1.91.1 via `rust-toolchain.toml`:

```bash
rustc --version
# Should output: rustc 1.91.1 (c4c1663c1 2024-07-31)
```

If Rust is not installed, install it via [rustup](https://rustup.rs/):

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env
```

### 3. Run Your First Benchmark

```bash
# Run a quick benchmark (completes in ~30 seconds)
cargo bench --bench identity

# View the results
open target/criterion/report/index.html  # macOS
xdg-open target/criterion/report/index.html  # Linux
```

## Common Commands

### Run All Benchmarks

```bash
cargo bench
```

**Note:** First run will take several minutes to compile. Subsequent runs are faster.

### Run Specific Benchmark

```bash
# Arithmetic operations
cargo bench --bench arithmetic

# Graph reachability
cargo bench --bench reachability

# Multiple benchmarks
cargo bench --bench arithmetic --bench join
```

### Control Benchmark Duration

```bash
# Faster (less accurate)
cargo bench -- --sample-size 10

# More accurate (slower)
cargo bench -- --sample-size 100
```

### View Results

Benchmark reports are automatically generated in `target/criterion/`:

```bash
# Open main report
open target/criterion/report/index.html

# View specific benchmark
open target/criterion/arithmetic/report/index.html
```

## Understanding the Output

### Command Line Output

```
arithmetic/dfir_rs/compiled
                        time:   [1.2345 ms 1.2456 ms 1.2567 ms]
```

- **time:** `[lower bound, estimate, upper bound]` (95% confidence interval)
- Lower values are better (faster execution)

### HTML Reports

Reports include:
- **Mean time** - Average execution time
- **Standard deviation** - Measurement consistency
- **Plots** - Visual representation over time
- **Comparison** - Against previous runs (if available)

## Next Steps

### Explore Available Benchmarks

```bash
# List all benchmarks
cargo bench -- --list
```

See [README.md](README.md#available-benchmarks) for detailed descriptions of each benchmark.

### Compare Implementations

Each benchmark typically includes multiple variants:
- `dfir_rs/compiled` - Hydro's compiled implementation
- `dfir_rs/interpreted` - Hydro's interpreted implementation
- `timely` - Timely Dataflow implementation
- `baseline` - Reference implementation

Compare them in the HTML reports to see performance differences.

### Run Performance Comparison

To compare with the main Hydro repository:

```bash
# Save current results as baseline
cargo bench -- --save-baseline current

# After updating dependencies or code
cargo bench -- --baseline current
```

See [BENCHMARK_GUIDE.md](BENCHMARK_GUIDE.md#performance-comparison) for detailed instructions.

## Troubleshooting

### Compilation Takes Too Long

First compilation downloads and builds all dependencies (~5-10 minutes). Subsequent builds are much faster.

```bash
# Monitor progress
cargo bench --verbose
```

### Benchmarks Are Slow

```bash
# Reduce sample size for faster runs
cargo bench -- --sample-size 10 --measurement-time 5
```

### "command not found: cargo"

Install Rust:
```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env
```

### Git Dependency Fetch Fails

Check your network connection and GitHub access:
```bash
# Test GitHub connectivity
ssh -T git@github.com

# Or use HTTPS
git config --global url."https://github.com/".insteadOf "git@github.com:"
```

### High Variance in Results

System load affects benchmarks. For consistent results:

```bash
# Close unnecessary applications
# Ensure laptop is plugged in (not on battery)
# Run multiple times to verify consistency
cargo bench --bench arithmetic
cargo bench --bench arithmetic
```

## Getting Help

- **Documentation:** See [README.md](README.md) and [BENCHMARK_GUIDE.md](BENCHMARK_GUIDE.md)
- **Examples:** Review existing benchmark files in `benches/benches/`
- **Issues:** Open an issue in this repository
- **Hydro Docs:** Visit [hydro.run](https://hydro.run/)

## Example Workflow

Here's a typical workflow for benchmarking:

```bash
# 1. Clone and enter directory
git clone <repository-url>
cd bigweaver-agent-canary-zeta-hydro-deps

# 2. Run a quick benchmark to verify setup
cargo bench --bench identity

# 3. Run comprehensive benchmarks (go grab coffee ☕)
cargo bench

# 4. View results
open target/criterion/report/index.html

# 5. Save as baseline for future comparisons
cargo bench -- --save-baseline initial

# 6. After making changes, compare performance
# (make changes to dependencies or benchmark code)
cargo bench -- --baseline initial

# 7. View comparison
open target/criterion/report/index.html
```

## Tips for Best Results

1. **Minimize System Load**
   - Close browsers, IDEs, and other heavy applications
   - Stop background services if possible

2. **Consistent Environment**
   - Use performance power settings (not power saver)
   - Keep laptop plugged in
   - Ensure good cooling (avoid thermal throttling)

3. **Multiple Runs**
   - Run benchmarks 2-3 times to verify consistency
   - Look for outliers or anomalies

4. **Document Everything**
   - Note your hardware specs
   - Record commit SHAs
   - Save benchmark output files

## Resources

- **Main Repository:** [hydro-project/hydro](https://github.com/hydro-project/hydro)
- **Timely Dataflow:** [TimelyDataflow/timely-dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- **Differential Dataflow:** [TimelyDataflow/differential-dataflow](https://github.com/TimelyDataflow/differential-dataflow)
- **Criterion.rs:** [bheisler.github.io/criterion.rs](https://bheisler.github.io/criterion.rs/book/)

---

Happy benchmarking! 🚀
