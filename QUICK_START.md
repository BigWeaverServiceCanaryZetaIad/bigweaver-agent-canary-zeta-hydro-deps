# Quick Start Guide

Get up and running with Hydro benchmark comparisons in 5 minutes.

## Prerequisites

- Rust toolchain (installed automatically via `rust-toolchain.toml`)
- Git
- 8GB+ RAM recommended

## Installation

```bash
# Clone repository
git clone <repository-url>/bigweaver-agent-canary-zeta-hydro-deps
cd bigweaver-agent-canary-zeta-hydro-deps

# Build benchmarks
cargo build --release -p hydro-timely-benchmarks
```

## Run Your First Benchmark

```bash
# Run a simple benchmark
cargo bench -p hydro-timely-benchmarks --bench identity

# View results
open target/criterion/report/index.html
```

## Common Commands

### Run all benchmarks
```bash
cargo bench -p hydro-timely-benchmarks
```

### Run specific category
```bash
# Computational benchmarks
cargo bench -p hydro-timely-benchmarks --bench arithmetic

# Join operations
cargo bench -p hydro-timely-benchmarks --bench join

# Graph algorithms
cargo bench -p hydro-timely-benchmarks --bench reachability
```

### Quick benchmark (less time)
```bash
cargo bench -p hydro-timely-benchmarks -- --sample-size 10
```

### Save baseline for comparison
```bash
cargo bench -p hydro-timely-benchmarks -- --save-baseline my-baseline
```

### Compare against baseline
```bash
# Make changes...
cargo bench -p hydro-timely-benchmarks -- --baseline my-baseline
```

## Understanding Output

```
identity/dfir           time:   [5.234 µs 5.291 µs 5.351 µs]
                        ^^^^^^  ^^^^^^^  ^^^^^^^  ^^^^^^^
                        metric  lower    mean     upper
                                (95% confidence interval)
```

**Interpreting**:
- **Lower is better** for time measurements
- **Confidence interval** shows measurement reliability
- **Compare "mean" values** between frameworks

## View Detailed Results

HTML reports with plots and statistics:

```bash
open target/criterion/report/index.html
```

Or browse to specific benchmark:

```bash
open target/criterion/arithmetic/report/index.html
```

## Benchmark List

| Benchmark | Description | Time |
|-----------|-------------|------|
| `identity` | Framework overhead | 1 min |
| `arithmetic` | Numerical operations | 2 min |
| `upcase` | String operations | 2 min |
| `fan_in` | Multiple inputs → one output | 2 min |
| `fan_out` | One input → multiple outputs | 2 min |
| `fork_join` | Parallel processing | 2 min |
| `join` | Join operations | 3 min |
| `symmetric_hash_join` | Hash-based joins | 3 min |
| `reachability` | Graph algorithms | 5 min |
| `words_diamond` | Complex workflows | 3 min |
| `futures` | Async operations | 2 min |
| `micro_ops` | Micro-benchmarks | 3 min |

**Total time (all benchmarks)**: ~30 minutes

## Troubleshooting

### Build fails

```bash
cargo clean
rustup update
cargo build --release -p hydro-timely-benchmarks
```

### Benchmarks too slow

```bash
# Reduce sample size
cargo bench -p hydro-timely-benchmarks -- --sample-size 10 --measurement-time 5
```

### Can't find data files

Ensure you're in the repository root and data files exist in `benches/benches/`.

## Next Steps

- **Read detailed documentation**: [README.md](README.md)
- **Learn comparison techniques**: [PERFORMANCE_COMPARISON.md](PERFORMANCE_COMPARISON.md)
- **Add your own benchmarks**: [CONTRIBUTING.md](CONTRIBUTING.md)

## Need Help?

Open an issue or check documentation:
- Main README: [README.md](README.md)
- Benchmark details: [benches/README.md](benches/README.md)
- Performance guide: [PERFORMANCE_COMPARISON.md](PERFORMANCE_COMPARISON.md)

---

**Happy benchmarking!** 🚀
