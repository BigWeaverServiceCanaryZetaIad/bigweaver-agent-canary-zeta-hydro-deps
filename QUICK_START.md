# Quick Start Guide

## Repository Purpose
This repository contains performance benchmarks for comparing Hydro with timely-dataflow and differential-dataflow implementations.

## Prerequisites
- Rust 1.91.1 (specified in rust-toolchain.toml)
- Cargo

## Quick Commands

### Build Benchmarks
```bash
cargo build --release -p benches
```

### Run All Benchmarks
```bash
cargo bench -p benches
```

### Run Specific Benchmark
```bash
# Run only the identity benchmark
cargo bench -p benches --bench identity

# Run only the reachability benchmark
cargo bench -p benches --bench reachability

# Run only the join benchmark
cargo bench -p benches --bench join
```

### Quick Test (No Benchmarking)
```bash
# Quick test to ensure benchmarks compile and run
cargo bench -p benches --bench identity -- --test
```

### Check Code Quality
```bash
# Format check
cargo fmt --all -- --check

# Linting
cargo clippy --all-targets -- -D warnings
```

## Available Benchmarks

| Benchmark | Description |
|-----------|-------------|
| `arithmetic` | Arithmetic operation benchmarks |
| `fan_in` | Fan-in dataflow pattern |
| `fan_out` | Fan-out dataflow pattern |
| `fork_join` | Fork-join pattern with generated code |
| `futures` | Async futures-based benchmarks |
| `identity` | Identity operation (baseline) |
| `join` | Join operation benchmarks |
| `micro_ops` | Various micro-operation benchmarks |
| `reachability` | Graph reachability algorithm |
| `symmetric_hash_join` | Symmetric hash join implementation |
| `upcase` | String transformation benchmarks |
| `words_diamond` | Text processing benchmarks |

## Benchmark Output

Results are saved to `target/criterion/` with:
- HTML reports
- Comparison charts
- Statistical analysis

Open `target/criterion/report/index.html` in a browser to view detailed results.

## Troubleshooting

### Build Failures
If benchmarks fail to build, ensure:
1. You have the correct Rust version: `rustup show`
2. All dependencies can be fetched (requires network access)
3. The main hydro repository is accessible via git

### Slow Benchmarks
Some benchmarks process large datasets:
- `words_diamond` - processes 3.7 MB word list
- `reachability` - processes 521 KB graph data

These may take several minutes to complete.

## More Information

- Full documentation: [README.md](README.md)
- Changes summary: [CHANGES_SUMMARY.md](CHANGES_SUMMARY.md)
- Benchmark details: [benches/README.md](benches/README.md)
- Verify setup: `bash verify_setup.sh`
