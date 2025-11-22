# Quick Start Guide

Get up and running with Hydro benchmarks in minutes.

## 🚀 Basic Usage

```bash
# Clone the repository
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps

# Run all benchmarks
cargo bench -p benches

# Run a specific benchmark
cargo bench -p benches --bench identity

# Quick run (for development)
cargo bench -p benches -- --quick

# View results
open target/criterion/report/index.html  # macOS
xdg-open target/criterion/report/index.html  # Linux
```

## 🔧 Local Development

Set up for working with local Hydro changes:

```bash
# Clone both repositories
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git

# Setup local development
cd bigweaver-agent-canary-zeta-hydro-deps
./setup_local_dev.sh ../bigweaver-agent-canary-hydro-zeta

# Now benchmarks use your local Hydro code
cargo bench -p benches
```

## 📊 Performance Comparison

Track performance changes:

```bash
# Save baseline before changes
cargo bench -p benches -- --save-baseline before

# Make your changes to Hydro...

# Compare against baseline
cargo bench -p benches -- --baseline before
```

## 📚 Available Benchmarks

### Core Benchmarks
- `arithmetic` - Arithmetic operations
- `fork_join` - Fork-join pattern
- `futures` - Async operations
- `join` - Join operations
- `micro_ops` - Micro-level operations
- `symmetric_hash_join` - Symmetric hash join
- `upcase` - String transformations
- `words_diamond` - Diamond pattern

### vs Timely Dataflow
- `fan_in` - Fan-in pattern
- `fan_out` - Fan-out pattern
- `identity` - Identity transformation

### vs Differential-Dataflow
- `reachability` - Graph reachability

## 🎯 Common Commands

```bash
# Run specific benchmark
cargo bench -p benches --bench reachability

# Quick run during development
cargo bench -p benches --bench identity -- --quick

# Filter benchmarks by pattern
cargo bench -p benches -- join

# Save baseline
cargo bench -p benches -- --save-baseline my-baseline

# Compare with baseline
cargo bench -p benches -- --baseline my-baseline

# Build benchmarks only
cargo build --release -p benches

# Check for errors
cargo check -p benches

# Format code
cargo fmt --all

# Run linter
cargo clippy -p benches
```

## 📖 Documentation

- **README.md** - Full repository documentation
- **PERFORMANCE_COMPARISON.md** - Detailed performance testing guide
- **CONTRIBUTING.md** - How to contribute
- **benches/README.md** - Benchmark-specific details
- **SETUP_VERIFICATION.md** - Verify your setup
- **IMPLEMENTATION_SUMMARY.md** - Complete implementation details

## 🆘 Troubleshooting

### Can't compile?
```bash
# Clean and rebuild
cargo clean
cargo build -p benches
```

### Need local Hydro?
```bash
# Run setup script
./setup_local_dev.sh /path/to/bigweaver-agent-canary-hydro-zeta
```

### Unstable results?
```bash
# Use more samples
cargo bench -p benches -- --sample-size 100

# Longer measurement time
cargo bench -p benches -- --measurement-time 10
```

## 🔗 Links

- Main Hydro Repository: https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta
- Criterion.rs Documentation: https://bheisler.github.io/criterion.rs/book/

## 💡 Tips

1. **Development**: Use `--quick` flag for faster iterations
2. **Comparison**: Always save baselines before major changes
3. **Results**: HTML reports in `target/criterion/` are very detailed
4. **Focus**: Run specific benchmarks instead of all for faster feedback
5. **Local Dev**: Use `setup_local_dev.sh` for seamless local Hydro testing

## ✅ Verification

Verify everything works:

```bash
# Check compilation
cargo check -p benches

# Run quick test
cargo bench -p benches --bench identity -- --quick

# Should see output like:
# identity/hydro/100     time:   [1.23 µs 1.25 µs 1.27 µs]
```

## 🎉 Next Steps

1. Run your first benchmark: `cargo bench -p benches --bench identity`
2. View the results in your browser
3. Explore the documentation
4. Try comparing with baselines
5. Set up local development if needed

Happy benchmarking! 🚀
