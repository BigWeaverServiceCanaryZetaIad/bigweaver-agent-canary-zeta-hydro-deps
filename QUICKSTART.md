# Quick Start Guide

Get up and running with Hydro benchmarks in minutes.

## Prerequisites

1. **Rust** - Install from [rustup.rs](https://rustup.rs/)
   ```bash
   curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
   ```

2. **Git** - For cloning the repository

## Installation

```bash
# Clone the benchmarks repository
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps
```

## Running Your First Benchmark

### Option 1: Using the Convenience Script (Recommended)

```bash
# List all available benchmarks
./run_benchmarks.sh --list

# Run a single benchmark
./run_benchmarks.sh --bench identity

# Run all benchmarks
./run_benchmarks.sh --all
```

### Option 2: Using Cargo Directly

```bash
# Run a single benchmark
cargo bench -p benches --bench identity

# Run all benchmarks
cargo bench -p benches
```

## Viewing Results

After running benchmarks, open the HTML reports in your browser:

```bash
# Open the identity benchmark report (adjust path based on your OS)
open target/criterion/identity/report/index.html  # macOS
xdg-open target/criterion/identity/report/index.html  # Linux
```

The reports show:
- **Throughput** measurements
- **Latency** distributions
- **Performance trends** over time
- **Statistical analysis** of results

## Performance Comparison Workflow

### 1. Establish a Baseline

Before making changes to the Hydro codebase:

```bash
./run_benchmarks.sh --all --baseline before-optimization
```

### 2. Make Your Changes

Edit code in the main Hydro repository:
```bash
cd ../bigweaver-agent-canary-hydro-zeta
# Make your optimizations or changes
```

### 3. Run Comparison

Return to benchmarks and compare:

```bash
cd ../bigweaver-agent-canary-zeta-hydro-deps
./run_benchmarks.sh --all --compare before-optimization
```

Criterion will show:
- Performance improvements/regressions
- Statistical significance of changes
- Detailed comparisons in HTML reports

## Available Benchmarks

| Benchmark | What It Measures | Typical Runtime |
|-----------|------------------|-----------------|
| `arithmetic` | Arithmetic operation throughput | ~2 min |
| `identity` | Passthrough/identity operations | ~1 min |
| `fan_in` | Fan-in communication patterns | ~2 min |
| `fan_out` | Fan-out communication patterns | ~2 min |
| `fork_join` | Fork-join parallelism | ~2 min |
| `join` | Join operations | ~3 min |
| `reachability` | Graph reachability algorithms | ~5 min |
| `micro_ops` | Micro-level operations | ~3 min |
| `futures` | Async futures-based operations | ~2 min |
| `symmetric_hash_join` | Hash join operations | ~3 min |
| `upcase` | String transformations | ~2 min |
| `words_diamond` | Diamond patterns | ~4 min |

## Common Commands

```bash
# Quick single benchmark
./run_benchmarks.sh --bench arithmetic

# Run all with baseline
./run_benchmarks.sh --all --baseline my-baseline

# Compare against baseline
./run_benchmarks.sh --all --compare my-baseline

# Get help
./run_benchmarks.sh --help
```

## Troubleshooting

### Build Errors

If you encounter build errors:

1. **Update Rust**: `rustup update`
2. **Clean build**: `cargo clean`
3. **Check network**: Benchmarks fetch dependencies from GitHub

### Long Build Times

First build may take 5-10 minutes due to:
- Downloading dependencies (timely, differential-dataflow)
- Compiling all benchmark code
- Optimized release builds

Subsequent builds are much faster (incremental compilation).

### Missing HTML Reports

If reports aren't generated:
- Check `target/criterion/` exists
- Ensure benchmark completed successfully
- Look for error messages in benchmark output

## Next Steps

1. **Read the full README**: [README.md](README.md)
2. **Understand the migration**: [MIGRATION_SUMMARY.md](MIGRATION_SUMMARY.md)
3. **Explore benchmarks**: Check files in `benches/benches/`
4. **Main repository**: [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)

## Getting Help

- **Issues**: Open an issue in this repository
- **Main Hydro docs**: https://hydro.run
- **Contributing**: See main repository CONTRIBUTING.md

---

**Happy benchmarking! 🚀**
