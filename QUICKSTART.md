# Quick Start Guide

Get up and running with the benchmarks in 5 minutes.

## Prerequisites

1. **Rust Toolchain**: Install from [rustup.rs](https://rustup.rs/)
   ```bash
   curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
   ```

2. **Clone Repository**:
   ```bash
   git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
   cd bigweaver-agent-canary-zeta-hydro-deps
   ```

## Quick Commands

### Check Everything Compiles
```bash
cargo check --workspace
```

### Run All Benchmarks
```bash
cargo bench -p benches
```

### Run a Single Benchmark
```bash
cargo bench -p benches --bench identity
```

### Quick Test (Small Sample)
```bash
cargo bench -p benches --bench arithmetic -- --sample-size 10
```

## View Results

After running benchmarks, view HTML reports:
```bash
# Open the main report
open target/criterion/report/index.html

# Or for a specific benchmark
open target/criterion/arithmetic/report/index.html
```

## Common Use Cases

### 1. Compare Hydro vs Timely Performance
```bash
cargo bench -p benches --bench arithmetic
# Check results in target/criterion/arithmetic/report/index.html
```

### 2. Test Graph Algorithms
```bash
cargo bench -p benches --bench reachability
```

### 3. Quick Performance Check
```bash
cargo bench -p benches --bench micro_ops -- --sample-size 20
```

### 4. Baseline and Compare
```bash
# Save current performance
cargo bench -p benches -- --save-baseline main

# Make changes...

# Compare against baseline
cargo bench -p benches -- --baseline main
```

## What to Expect

Each benchmark tests multiple implementations:
- **Hydro (dfir_rs)**: Our implementation
- **Timely**: Comparison against timely-dataflow
- **Differential**: Comparison against differential-dataflow

Results include:
- Throughput (operations/second)
- Latency (time per operation)
- Statistical analysis and confidence intervals
- Automatic regression detection

## Troubleshooting

### Build Fails
```bash
# Clean and rebuild
cargo clean
cargo build --workspace
```

### Slow Benchmarks
```bash
# Use smaller sample size
cargo bench -p benches -- --sample-size 10 --quick
```

### Out of Memory
```bash
# Run benchmarks one at a time
cargo bench -p benches --bench identity
cargo bench -p benches --bench arithmetic
# etc.
```

## Next Steps

- Read [BENCHMARK_GUIDE.md](BENCHMARK_GUIDE.md) for detailed documentation
- See [README.md](README.md) for comprehensive information
- Check [MIGRATION_SUMMARY.md](MIGRATION_SUMMARY.md) for background
- Run [SETUP_VERIFICATION.md](SETUP_VERIFICATION.md) checks to verify setup

## Getting Help

- **Documentation Issues**: Check the guides in this repository
- **Benchmark Questions**: See BENCHMARK_GUIDE.md
- **Performance Issues**: Review Criterion reports in target/criterion/
- **Build Problems**: Ensure Rust version matches rust-toolchain.toml

## Typical First Run

```bash
# 1. Verify setup
cargo check --workspace

# 2. Run one benchmark as a test
cargo bench -p benches --bench identity -- --sample-size 10

# 3. If successful, run all benchmarks
cargo bench -p benches

# 4. View results
open target/criterion/report/index.html
```

That's it! You're ready to benchmark. 🚀
