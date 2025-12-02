# Quick Start Guide

Get up and running with the bigweaver-agent-canary-zeta-hydro-deps benchmarks in 5 minutes.

## Prerequisites

1. **Clone both repositories as siblings:**
   ```bash
   git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git
   git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
   ```

2. **Ensure Rust is installed:**
   ```bash
   rustc --version  # Should show Rust 1.75+ or later
   ```

## Run Your First Benchmark

```bash
cd bigweaver-agent-canary-zeta-hydro-deps

# Run a quick benchmark (takes ~30 seconds)
cargo bench -p benches --bench identity
```

## View Results

Open the HTML report:
```bash
open target/criterion/identity/report/index.html
# or on Linux:
xdg-open target/criterion/identity/report/index.html
```

## Run All Benchmarks

```bash
# Full benchmark suite (takes 10-30 minutes)
cargo bench -p benches

# Save baseline for future comparisons
cargo bench -p benches -- --save-baseline my-baseline
```

## Run Specific Benchmarks

```bash
# Arithmetic operations
cargo bench -p benches --bench arithmetic

# Graph reachability
cargo bench -p benches --bench reachability

# Join operations
cargo bench -p benches --bench join

# All pattern benchmarks
cargo bench -p benches --bench fan_in
cargo bench -p benches --bench fan_out
cargo bench -p benches --bench fork_join
```

## Run Examples

```bash
# Build examples
cargo build -p hydro_test_examples --examples

# Run Paxos example
cargo run -p hydro_test_examples --example paxos

# Run Two-Phase Commit example
cargo run -p hydro_test_examples --example two_pc
```

## Compare Performance

### 1. Run Timely/Differential Benchmarks (this repo)

```bash
cargo bench -p benches --bench arithmetic -- --save-baseline timely
```

### 2. Run Hydro Benchmarks (main repo)

```bash
cd ../bigweaver-agent-canary-hydro-zeta
cargo bench -p dfir_rs --bench arithmetic_hydro -- --save-baseline hydro
```

### 3. Compare Results

Open both reports and compare:
- `bigweaver-agent-canary-zeta-hydro-deps/target/criterion/`
- `bigweaver-agent-canary-hydro-zeta/target/criterion/`

## Troubleshooting

### Build Errors

If you see "could not find dfir_rs":
```bash
# Verify repository structure
ls ../bigweaver-agent-canary-hydro-zeta/dfir_rs

# If missing, clone main repository
cd ..
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git
```

### Slow Builds

First build takes 5-15 minutes (compiling timely/differential):
```bash
# Check progress
cargo build -p benches --verbose
```

### Inconsistent Benchmark Results

Reduce system noise:
```bash
# Close other applications
# Run again with more samples
cargo bench -p benches --bench identity -- --sample-size 200
```

## Next Steps

- **Comprehensive Guide**: See `BENCHMARK_GUIDE.md` for detailed benchmark documentation
- **Setup Verification**: See `SETUP_VERIFICATION.md` to verify your environment
- **Full Documentation**: See `README.md` for complete repository overview
- **Comparison Methodology**: See the "Performance Comparison" section in `README.md`

## Common Commands Reference

```bash
# Run all benchmarks
cargo bench -p benches

# Run specific benchmark
cargo bench -p benches --bench <name>

# Save baseline
cargo bench -p benches -- --save-baseline <name>

# Compare to baseline
cargo bench -p benches -- --baseline <name>

# Filter specific tests
cargo bench -p benches --bench arithmetic -- multiply

# Increase sample size
cargo bench -p benches -- --sample-size 200

# Check workspace
cargo check --workspace

# Build everything
cargo build --workspace

# Clean build artifacts
cargo clean
```

## Available Benchmarks

| Benchmark | Category | Description |
|-----------|----------|-------------|
| arithmetic | Micro | Basic arithmetic operations |
| identity | Micro | Pass-through (baseline) |
| upcase | Micro | String transformations |
| fan_in | Pattern | Multiple sources merge |
| fan_out | Pattern | Single source split |
| fork_join | Pattern | Parallel with sync |
| join | Pattern | Relational joins |
| symmetric_hash_join | Pattern | Hash-based joins |
| reachability | Application | Graph reachability |
| words_diamond | Application | Diamond dataflow |
| futures | Application | Async patterns |
| micro_ops | Micro | Individual operations |

## Get Help

- **Documentation Issues**: Check `SETUP_VERIFICATION.md`
- **Performance Questions**: See `BENCHMARK_GUIDE.md`
- **Main Repository**: See `../bigweaver-agent-canary-hydro-zeta/CONTRIBUTING.md`
- **Bug Reports**: File an issue with your error output and system info

## Quick Tips

💡 **Pro Tips:**
- Use `--save-baseline` before making changes
- Run benchmarks on a quiet system for consistency
- Compare HTML reports for visual analysis
- Increase `--sample-size` for more stable results
- Use `--warm-up-time` for consistent startup
