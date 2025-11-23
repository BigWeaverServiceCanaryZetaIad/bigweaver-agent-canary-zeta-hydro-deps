# Quick Start Guide

Get up and running with the Hydro benchmarks in minutes.

## Prerequisites

1. **Rust Toolchain** (automatically configured to 1.91.1 via `rust-toolchain.toml`)
   ```bash
   # Install Rust if not already installed
   curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
   
   # Verify installation
   cargo --version
   ```

2. **Git** (to clone the repository)

## Installation

```bash
# Clone the repository
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps

# Verify setup
./verify_benchmarks.sh
```

## Running Your First Benchmark

### 1. Run a Quick Test

Start with the identity benchmark (fastest):

```bash
cargo bench --bench identity -- --quick
```

**Expected output**:
```
identity/pipeline       time:   [X.XX ms X.XX ms X.XX ms]
identity/raw            time:   [X.XX ms X.XX ms X.XX ms]
identity/timely         time:   [X.XX ms X.XX ms X.XX ms]
identity/dfir           time:   [X.XX ms X.XX ms X.XX ms]
```

### 2. Run a Specific Benchmark

Try the arithmetic operations benchmark:

```bash
cargo bench --bench arithmetic
```

### 3. Run All Benchmarks

**Warning**: This will take several minutes!

```bash
cargo bench
```

## Understanding the Output

### Terminal Output

```
arithmetic/dfir        time:   [49.234 ms 49.891 ms 50.621 ms]
                       ─────────────────┬──────────────────────
                                        └─ [min, mean, max] with 95% confidence
```

### HTML Reports

Detailed reports with charts are available at:
```bash
# Open in your browser
open target/criterion/report/index.html
```

## Common Commands

```bash
# Run all benchmarks
cargo bench

# Run a specific benchmark
cargo bench --bench arithmetic

# Run specific test within benchmark
cargo bench --bench arithmetic -- arithmetic/dfir

# Quick mode (faster, less accurate)
cargo bench -- --quick

# Compare implementations
cargo bench --bench arithmetic -- arithmetic/dfir arithmetic/timely

# Save baseline for comparison
cargo bench -- --save-baseline main

# Compare against baseline
cargo bench -- --baseline main
```

## Available Benchmarks

| Benchmark | Description | Run Time |
|-----------|-------------|----------|
| `identity` | Minimal overhead test | ~30s |
| `arithmetic` | Computational operations | ~2m |
| `upcase` | String transformations | ~1m |
| `fan_in` | Multiple inputs → one output | ~1m |
| `fan_out` | One input → multiple outputs | ~1m |
| `fork_join` | Split → process → merge | ~2m |
| `join` | Stream join operations | ~2m |
| `reachability` | Graph computation (differential) | ~3m |

**Total time for all benchmarks**: ~15-20 minutes

## Troubleshooting

### Compilation Errors

If benchmarks don't compile:

```bash
# Clean and rebuild
cargo clean
cargo check --benches

# Update dependencies
cargo update
```

### Slow Benchmarks

If benchmarks are taking too long:

```bash
# Use quick mode
cargo bench -- --quick

# Run only specific benchmarks
cargo bench --bench identity --bench arithmetic
```

### Git Dependency Issues

If you get errors about `dfir_rs` or `sinktools`:

```bash
# Force update git dependencies
cargo update -p dfir_rs -p sinktools
```

## Next Steps

### Compare Performance

Run benchmarks and compare results:

```bash
# Save current performance as baseline
cargo bench -- --save-baseline current

# Make changes to Hydro...

# Compare new performance
cargo bench -- --baseline current
```

### Deep Dive

- Read [BENCHMARKS.md](BENCHMARKS.md) for detailed information
- Explore benchmark source code in `benches/`
- Check HTML reports in `target/criterion/`

### Add Your Own Benchmark

1. Create new file: `benches/my_benchmark.rs`
2. Add to `Cargo.toml`:
   ```toml
   [[bench]]
   name = "my_benchmark"
   harness = false
   ```
3. Run: `cargo bench --bench my_benchmark`

## Performance Tips

### Get Accurate Results

```bash
# Disable CPU frequency scaling (Linux)
sudo cpupower frequency-set --governor performance

# Close other applications to reduce noise

# Run multiple times for consistency
cargo bench
cargo bench
cargo bench
```

### Interpret Results

- **Lower is better**: Shorter execution time = better performance
- **Look at confidence intervals**: Narrow ranges indicate consistent performance
- **Compare implementations**: Which framework is fastest for your workload?
- **Check overhead**: Compare against baseline (raw/pipeline) implementations

## Example Workflow

```bash
# 1. Clone and verify
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps
./verify_benchmarks.sh

# 2. Quick sanity check
cargo bench --bench identity -- --quick

# 3. Run full benchmark suite
cargo bench

# 4. View results
open target/criterion/report/index.html

# 5. Compare specific implementations
cargo bench --bench arithmetic -- arithmetic/dfir arithmetic/timely
```

## Key Files

- **`README.md`** - Overview and general information
- **`BENCHMARKS.md`** - Detailed benchmark documentation
- **`QUICKSTART.md`** - This file
- **`Cargo.toml`** - Dependencies and benchmark configuration
- **`benches/`** - Benchmark source code
- **`verify_benchmarks.sh`** - Setup verification script

## Getting Help

1. **Check documentation**: Start with [README.md](README.md)
2. **Run verification**: `./verify_benchmarks.sh`
3. **Read detailed guide**: [BENCHMARKS.md](BENCHMARKS.md)
4. **Check Criterion docs**: https://bheisler.github.io/criterion.rs/book/
5. **Main repository**: https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta

## Summary

```bash
# Everything you need to get started:
git clone <repo>
cd bigweaver-agent-canary-zeta-hydro-deps
./verify_benchmarks.sh
cargo bench --bench identity -- --quick
cargo bench --bench arithmetic
open target/criterion/report/index.html
```

Happy benchmarking! 🚀
