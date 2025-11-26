# Quick Start Guide

Get up and running with the timely/differential-dataflow benchmarks in 5 minutes!

## Prerequisites

Just need Rust installed. If you don't have it:
```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

## 1. Clone and Setup

```bash
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps
```

The project will automatically use the correct Rust version specified in `rust-toolchain.toml`.

## 2. Run Your First Benchmark

```bash
# Run a quick benchmark (arithmetic operations)
cargo bench --bench arithmetic
```

This will:
1. Download and compile dependencies (first time only)
2. Run the arithmetic benchmark
3. Generate results in `target/criterion/`

⏱️ First build may take 5-10 minutes due to dependency compilation.

## 3. View Results

Open the HTML report:
```bash
# Linux/macOS
open target/criterion/report/index.html

# Or just navigate to the file in your browser
```

You'll see:
- Performance graphs
- Statistical analysis
- Comparison with previous runs

## 4. Run More Benchmarks

```bash
# Run all benchmarks (takes longer)
cargo bench

# Or run specific ones
cargo bench --bench fan_in
cargo bench --bench join
cargo bench --bench reachability
```

## 5. Compare with Main Repository

Want to compare with pure DFIR/Hydro implementations?

```bash
# Clone the main repository
cd ..
git clone https://github.com/hydro-project/hydro.git bigweaver-agent-canary-hydro-zeta
cd bigweaver-agent-canary-hydro-zeta

# Run its benchmarks
cargo bench -p benches
```

Then compare the `target/criterion/` reports from both repositories!

## Common Commands

```bash
# Format code
cargo fmt

# Lint code
cargo clippy

# Build without running
cargo build --release

# Run specific benchmark with filter
cargo bench --bench arithmetic -- dfir

# Clean build artifacts
cargo clean
```

## Benchmark Cheat Sheet

| Command | What It Does |
|---------|-------------|
| `cargo bench --bench arithmetic` | Basic arithmetic operations |
| `cargo bench --bench fan_in` | Multiple inputs → one output |
| `cargo bench --bench fan_out` | One input → multiple outputs |
| `cargo bench --bench fork_join` | Parallel processing patterns |
| `cargo bench --bench identity` | Framework overhead test |
| `cargo bench --bench join` | Relational join operations |
| `cargo bench --bench reachability` | Graph algorithms |
| `cargo bench --bench upcase` | String transformations |

## Customizing Benchmarks

Want to adjust benchmark parameters?

1. Edit the benchmark file in `benches/benches/`
2. Look for constants like `NUM_INTS` or `NUM_OPS`
3. Change values (smaller = faster testing)
4. Re-run: `cargo bench --bench <name>`

Example:
```rust
// In benches/benches/arithmetic.rs
const NUM_INTS: usize = 100_000;  // Reduce from 1_000_000 for faster testing
```

## Troubleshooting

### Build Takes Forever
- **First time?** Dependencies need to compile (normal)
- **Still slow?** Use `cargo build --release` first to check for errors

### Out of Memory
- Close other applications
- Reduce `NUM_INTS` in benchmark files
- Use `--sample-size 10` flag: `cargo bench -- --sample-size 10`

### Benchmark Results Vary
- Close CPU-intensive applications
- Run on a quiet system
- Use release mode (cargo bench does this automatically)

## Next Steps

- 📖 Read [README.md](README.md) for comprehensive documentation
- 📊 Read [benches/README.md](benches/README.md) for benchmark details
- 🔧 Modify benchmarks to test your scenarios
- 📈 Track performance over time using Criterion's historical data

## Need Help?

- **Issues**: Open an issue in this repository
- **Questions**: See the [main Hydro project](https://github.com/hydro-project/hydro)
- **Benchmarking**: Check [Criterion.rs documentation](https://bheisler.github.io/criterion.rs/book/)

Happy benchmarking! 🚀
