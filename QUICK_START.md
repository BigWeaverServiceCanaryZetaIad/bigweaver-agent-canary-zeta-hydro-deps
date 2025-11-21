# Quick Start Guide

Get up and running with Hydroflow benchmarks in 5 minutes!

## 1. Setup (1 minute)

```bash
# Clone the repository
git clone https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps

# Verify it builds
cargo check -p hydro-timely-differential-benchmarks
```

## 2. Run Your First Benchmark (2 minutes)

```bash
# Quick test with small sample
cargo bench -p hydro-timely-differential-benchmarks --bench identity -- --sample-size 10

# Expected output:
# identity/hydroflow     time:   [XXX.XX µs XXX.XX µs XXX.XX µs]
# identity/timely        time:   [XXX.XX µs XXX.XX µs XXX.XX µs]
```

## 3. View Results (1 minute)

```bash
# Open the HTML report in your browser
# Location: target/criterion/identity/report/index.html

# Or on macOS:
open target/criterion/identity/report/index.html

# Or on Linux:
xdg-open target/criterion/identity/report/index.html
```

## 4. Run More Benchmarks (1 minute)

```bash
# Run all benchmarks (takes longer)
cargo bench -p hydro-timely-differential-benchmarks

# Run specific benchmark
cargo bench -p hydro-timely-differential-benchmarks --bench reachability
cargo bench -p hydro-timely-differential-benchmarks --bench arithmetic
cargo bench -p hydro-timely-differential-benchmarks --bench join

# Run specific framework
cargo bench -p hydro-timely-differential-benchmarks -- hydroflow
cargo bench -p hydro-timely-differential-benchmarks -- timely
cargo bench -p hydro-timely-differential-benchmarks -- differential
```

## Available Benchmarks

| Command | What It Tests | Time |
|---------|---------------|------|
| `--bench identity` | Passthrough operations | ~30s |
| `--bench arithmetic` | Basic math operations | ~1m |
| `--bench join` | Join operations | ~2m |
| `--bench reachability` | Graph algorithms | ~3m |
| `--bench fan_in` | Multiple inputs → one output | ~1m |
| `--bench fan_out` | One input → multiple outputs | ~1m |
| `--bench fork_join` | Parallel patterns | ~2m |
| `--bench symmetric_hash_join` | Hash joins | ~2m |
| `--bench upcase` | String operations | ~1m |
| `--bench words_diamond` | Diamond patterns | ~2m |
| `--bench micro_ops` | Micro-operations | ~1m |
| `--bench futures` | Async operations | ~2m |

## Common Commands

### Development
```bash
# Quick validation (10 samples instead of 100)
cargo bench -p hydro-timely-differential-benchmarks --bench identity -- --sample-size 10

# Check compilation without running
cargo check -p hydro-timely-differential-benchmarks

# Format code
cargo fmt -p hydro-timely-differential-benchmarks
```

### Performance Analysis
```bash
# Save baseline
cargo bench -p hydro-timely-differential-benchmarks -- --save-baseline before

# Make changes...

# Compare with baseline
cargo bench -p hydro-timely-differential-benchmarks -- --baseline before

# Results show: "Performance has improved/regressed by X%"
```

### Specific Tests
```bash
# Only Hydroflow implementations
cargo bench -p hydro-timely-differential-benchmarks -- hydroflow

# Only Timely implementations  
cargo bench -p hydro-timely-differential-benchmarks -- timely

# Only Differential implementations
cargo bench -p hydro-timely-differential-benchmarks -- differential

# Specific benchmark + specific framework
cargo bench -p hydro-timely-differential-benchmarks --bench reachability -- differential
```

## Understanding Results

### Console Output
```
identity/hydroflow     time:   [142.35 µs 143.67 µs 145.12 µs]
                       ↑         ↑         ↑         ↑
                       name    lower     mean      upper
                              bound    estimate    bound
```

### HTML Reports
- **Location**: `target/criterion/<benchmark>/report/index.html`
- **Contents**: 
  - Line charts of performance over time
  - Probability density plots
  - Mean, median, and standard deviation
  - Comparison with previous runs

## Troubleshooting

### Build Fails
```bash
# Clean and rebuild
cargo clean
cargo build -p hydro-timely-differential-benchmarks
```

### Slow Benchmarks
```bash
# Reduce sample size
cargo bench -p hydro-timely-differential-benchmarks -- --sample-size 10

# Run single benchmark
cargo bench -p hydro-timely-differential-benchmarks --bench identity
```

### Git Authentication Issues
```bash
# Check git credentials
git config --global credential.helper store
```

## Next Steps

1. **Read full documentation**: `README.md`
2. **Learn to contribute**: `CONTRIBUTING.md`
3. **Understand migration**: `MIGRATION.md`
4. **View changelog**: `CHANGELOG.md`

## Need Help?

- 📖 Full documentation in `README.md`
- 🔧 Benchmark details in `benches/README.md`
- 💬 Contribution guide in `CONTRIBUTING.md`
- 📝 Migration details in `MIGRATION.md`

## Cheat Sheet

```bash
# One command to rule them all (run everything)
cargo bench -p hydro-timely-differential-benchmarks

# One command to test quickly
cargo bench -p hydro-timely-differential-benchmarks --bench identity -- --sample-size 10

# One command to compare
cargo bench -p hydro-timely-differential-benchmarks -- --baseline before

# One command to view results
open target/criterion/*/report/index.html
```

---

**Total Time**: ~5 minutes to get started, ~20 minutes for full benchmark suite

**Enjoy benchmarking!** 🚀
