# Quick Start Guide

Get started with the Hydro Dependencies Benchmarks in 5 minutes.

## Prerequisites

- Rust (2024 edition or later)
- Git
- ~10 minutes for initial compilation

## Installation

```bash
# Clone the repository
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps

# Build benchmarks (takes 5-10 minutes first time)
cargo build --benches --release
```

## Run Your First Benchmark

### Quick Test

Run a fast benchmark to verify everything works:

```bash
cargo bench --bench identity -- --quick
```

You should see output like:
```
identity/timely         time:   [XXX ns XXX ns XXX ns]
identity/dfir_rs       time:   [XXX ns XXX ns XXX ns]
```

### View Results

Open the HTML report in your browser:

```bash
# macOS
open target/criterion/report/index.html

# Linux
xdg-open target/criterion/report/index.html

# Windows
start target/criterion/report/index.html
```

## Common Benchmark Commands

```bash
# Run all benchmarks (takes ~30 minutes)
cargo bench

# Run specific benchmark suite
cargo bench --bench arithmetic
cargo bench --bench reachability
cargo bench --bench join

# Quick mode (faster, less accurate)
cargo bench -- --quick

# Filter by name
cargo bench -- timely          # Only timely benchmarks
cargo bench -- differential    # Only differential benchmarks
```

## Understanding Output

### Console Output

```
arithmetic/timely       time:   [245.67 ns 246.89 ns 248.23 ns]
                        change: [-2.3456% -1.2345% +0.1234%] (p = 0.12 > 0.05)
                        No change in performance detected.
```

- **time**: Mean execution time with confidence interval
- **change**: Performance change vs. last run
- **p-value**: Statistical significance (< 0.05 = significant)

### HTML Report

The HTML report (`target/criterion/report/index.html`) provides:
- 📊 Graphs of performance over time
- 📈 Detailed statistics
- 🔍 Comparison across runs
- 📁 Individual benchmark pages

## Next Steps

### Learn More

- Read [README.md](./README.md) for full documentation
- Read [PERFORMANCE_COMPARISON.md](./PERFORMANCE_COMPARISON.md) for methodology
- Check [benches/](./benches/) for benchmark implementations

### Add Your Own Benchmark

1. Create `benches/my_benchmark.rs`
2. Follow the pattern from existing benchmarks
3. Add to `Cargo.toml`:
   ```toml
   [[bench]]
   name = "my_benchmark"
   harness = false
   ```
4. Run: `cargo bench --bench my_benchmark`

### Integrate with CI

Example GitHub Actions workflow:

```yaml
name: Benchmarks

on:
  push:
    branches: [main]

jobs:
  benchmark:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions-rs/toolchain@v1
        with:
          profile: minimal
          toolchain: stable
      - run: cargo bench --benches
      - uses: actions/upload-artifact@v3
        with:
          name: benchmark-results
          path: target/criterion/
```

## Troubleshooting

### Build Errors

**Problem**: Dependency resolution fails

**Solution**: Update dependencies
```bash
cargo update
cargo build --benches --release
```

### Slow Builds

**Problem**: Initial build takes forever

**Solution**: This is normal for first build. Subsequent builds are faster:
- Timely/Differential have many dependencies
- Consider using [`sccache`](https://github.com/mozilla/sccache)

### Git Dependencies Not Found

**Problem**: `dfir_rs` cannot be fetched from git

**Solution**: Ensure you have access to the main repository:
```bash
git ls-remote https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta
```

### Inconsistent Results

**Problem**: Benchmark results vary wildly

**Solution**: 
1. Close other applications
2. Disable CPU frequency scaling:
   ```bash
   # Linux
   sudo cpupower frequency-set --governor performance
   ```
3. Run multiple times: `cargo bench` (Criterion averages automatically)

### Permission Denied Errors

**Problem**: Cannot write to `target/criterion/`

**Solution**: Check file permissions:
```bash
chmod -R u+w target/
```

## Getting Help

- **Bug reports**: Open an issue in this repository
- **Performance questions**: See [PERFORMANCE_COMPARISON.md](./PERFORMANCE_COMPARISON.md)
- **DFIR/Hydro questions**: Open an issue in the [main repository](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)

## Quick Reference Card

| Task | Command |
|------|---------|
| Run all benchmarks | `cargo bench` |
| Run one benchmark | `cargo bench --bench NAME` |
| Quick mode | `cargo bench -- --quick` |
| Filter benchmarks | `cargo bench -- PATTERN` |
| Build only | `cargo build --benches --release` |
| Clean build | `cargo clean` |
| Update deps | `cargo update` |
| View report | `open target/criterion/report/index.html` |

---

**Ready to dive deeper?** Check out [README.md](./README.md) for comprehensive documentation.
