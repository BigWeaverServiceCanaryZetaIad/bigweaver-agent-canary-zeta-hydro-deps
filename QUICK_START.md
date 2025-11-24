# Quick Start Guide

Get started with the benchmark repository in minutes!

## Prerequisites

```bash
# Install Rust (if not already installed)
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Verify installation
rustc --version
cargo --version
```

## Clone and Build

```bash
# Clone the repository
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps

# Build the project
cargo build
```

## Run Your First Benchmark

```bash
# Run a quick identity benchmark (baseline performance)
cargo bench -p benches --bench identity

# Results will be in: target/criterion/report/index.html
```

## View Results

```bash
# Open the HTML report (macOS)
open target/criterion/report/index.html

# Open the HTML report (Linux)
xdg-open target/criterion/report/index.html

# Open the HTML report (Windows)
start target/criterion/report/index.html
```

## Try More Benchmarks

```bash
# Run all benchmarks (takes longer)
cargo bench -p benches

# Run specific benchmark patterns
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench join
cargo bench -p benches --bench reachability

# Compare just Hydroflow implementations
cargo bench -p benches -- dfir

# Compare just Timely implementations
cargo bench -p benches -- timely
```

## Quick Mode

For faster iteration during development:

```bash
# Run shorter benchmarks
cargo bench -p benches --bench identity -- --quick
```

## Understanding Output

Criterion will show you:
- **Time**: How long operations take
- **Change**: Performance compared to previous runs
- **Outliers**: Statistical anomalies in measurements

Example output:
```
identity/timely         time:   [45.234 ms 45.678 ms 46.123 ms]
                        change: [-2.3% -1.5% -0.8%] (p = 0.00 < 0.05)
                        Performance has improved.
```

## Next Steps

- Read [benches/README.md](benches/README.md) for detailed benchmark documentation
- Check [BENCHMARK_MIGRATION.md](BENCHMARK_MIGRATION.md) for background information
- See [CONTRIBUTING.md](CONTRIBUTING.md) to add your own benchmarks

## Troubleshooting

### Build Fails

```bash
# Update Rust toolchain
rustup update

# Clean and rebuild
cargo clean
cargo build
```

### Benchmarks Take Too Long

```bash
# Use quick mode
cargo bench -p benches -- --quick

# Or run fewer benchmarks
cargo bench -p benches --bench identity
```

### Git Dependencies Fail

```bash
# Check network connection
# Verify repository URLs in benches/Cargo.toml
# Try updating dependencies
cargo update
```

## Resources

- **Documentation**: [README.md](README.md)
- **Detailed Benchmarks**: [benches/README.md](benches/README.md)
- **Contributing**: [CONTRIBUTING.md](CONTRIBUTING.md)
- **Criterion Docs**: https://bheisler.github.io/criterion.rs/book/

## Get Help

- Check existing [Issues](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps/issues)
- Open a new issue with your question
- Include error messages and system info

Happy Benchmarking! 🚀
