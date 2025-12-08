# Quick Start Guide

## 📋 TL;DR

```bash
# Run all benchmarks
cargo bench -p benches

# Run specific benchmark
cargo bench -p benches --bench reachability

# Create baseline
cargo bench -p benches -- --save-baseline before

# Compare against baseline
cargo bench -p benches -- --baseline before
```

## 📚 Documentation

- **[README.md](README.md)** - Repository overview and structure
- **[USAGE.md](USAGE.md)** - Detailed usage instructions
- **[BENCHMARK_MIGRATION.md](BENCHMARK_MIGRATION.md)** - Migration context and rationale
- **[CONTRIBUTING.md](CONTRIBUTING.md)** - How to contribute
- **[benches/README.md](benches/README.md)** - Benchmark descriptions

## 🎯 Available Benchmarks

### Timely Dataflow
- `arithmetic` - Arithmetic operations
- `fan_in` - Fan-in patterns
- `fan_out` - Fan-out patterns
- `fork_join` - Fork-join patterns
- `identity` - Identity transformations
- `join` - Join operations
- `upcase` - String transformations

### Differential Dataflow
- `reachability` - Graph reachability

### Hydro Comparisons
- `futures` - Async futures
- `micro_ops` - Micro-operations
- `symmetric_hash_join` - Hash joins
- `words_diamond` - Word processing

## 🚀 Common Commands

### Running Benchmarks

```bash
# All benchmarks
cargo bench -p benches

# Specific benchmark
cargo bench -p benches --bench micro_ops

# With longer measurement time (more stable results)
cargo bench -p benches --bench reachability -- --measurement-time 20
```

### Performance Tracking

```bash
# Save baseline
cargo bench -p benches -- --save-baseline 2025-12-04

# Compare against baseline
cargo bench -p benches -- --baseline 2025-12-04

# See difference
cargo bench -p benches -- --baseline 2025-12-04 --verbose
```

### Viewing Results

```bash
# HTML reports are in: target/criterion/<benchmark-name>/report/index.html
open target/criterion/arithmetic/report/index.html
```

## 🔧 Maintenance

### Update Dependencies

```bash
# Update all
cargo update

# Update from main repo
cargo update -p dfir_rs -p sinktools
```

### Test Local Changes

Edit `benches/Cargo.toml`:
```toml
dfir_rs = { path = "../bigweaver-agent-canary-hydro-zeta/dfir_rs", features = [ "debugging" ] }
```

Run benchmarks, then **revert** the change.

## 🆘 Troubleshooting

### Build Errors
```bash
cargo clean
cargo update
cargo build -p benches --release
```

### High Variance
- Close other applications
- Use longer measurement time: `--measurement-time 20`
- Run multiple times

### Missing Dependencies
```bash
cargo update
# or
cargo fetch
```

## 📞 Get Help

- **Usage Questions**: See [USAGE.md](USAGE.md)
- **Migration Info**: See [BENCHMARK_MIGRATION.md](BENCHMARK_MIGRATION.md)
- **Contributing**: See [CONTRIBUTING.md](CONTRIBUTING.md)
- **Issues**: Open an issue in this repository
- **Main Repo**: [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)
