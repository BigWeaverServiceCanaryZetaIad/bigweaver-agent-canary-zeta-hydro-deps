# Quick Reference

Fast access to common commands and information.

## Common Commands

### Running Benchmarks

```bash
# Run all benchmarks
cargo bench -p timely-differential-benchmarks

# Run specific benchmark
cargo bench -p timely-differential-benchmarks --bench arithmetic
cargo bench -p timely-differential-benchmarks --bench reachability

# Run with custom options
cargo bench -p timely-differential-benchmarks -- --warm-up-time 5 --measurement-time 10

# Save baseline for comparison
cargo bench -p timely-differential-benchmarks -- --save-baseline main

# Compare against baseline
cargo bench -p timely-differential-benchmarks -- --baseline main
```

### Building

```bash
# Build everything
cargo build --all-targets

# Build release
cargo build --release

# Clean build
cargo clean && cargo build
```

### Code Quality

```bash
# Format code
cargo fmt

# Check formatting
cargo fmt --check

# Run linter
cargo clippy --all-targets

# Fix clippy warnings
cargo clippy --fix
```

### Verification

```bash
# Run verification script
./verify_benchmarks.sh

# Check without building
cargo check
```

## Benchmark List

| Name | Type | Command |
|------|------|---------|
| arithmetic | Timely | `cargo bench --bench arithmetic` |
| fan_in | Timely | `cargo bench --bench fan_in` |
| fan_out | Timely | `cargo bench --bench fan_out` |
| fork_join | Timely | `cargo bench --bench fork_join` |
| identity | Timely | `cargo bench --bench identity` |
| join | Timely | `cargo bench --bench join` |
| upcase | Timely | `cargo bench --bench upcase` |
| reachability | Differential | `cargo bench --bench reachability` |

## File Locations

### Source Files
- Benchmarks: `benches/benches/*.rs`
- Build script: `benches/build.rs`
- Data files: `benches/benches/*.txt`

### Configuration
- Workspace: `Cargo.toml`
- Package: `benches/Cargo.toml`
- Toolchain: `rust-toolchain.toml`
- Formatting: `rustfmt.toml`
- Linting: `clippy.toml`

### Documentation
- Overview: `README.md`
- Quick start: `QUICKSTART.md`
- Details: `BENCHMARK_DETAILS.md`
- Migration: `MIGRATION.md`
- Changelog: `CHANGELOG.md`
- Index: `INDEX.md`

### Results
- Criterion output: `target/criterion/`
- HTML reports: `target/criterion/report/index.html`

## Key Dependencies

```toml
criterion = "0.5.0"
timely = { package = "timely-master", version = "0.13.0-dev.1" }
differential-dataflow = { package = "differential-dataflow-master", version = "0.13.0-dev.1" }
dfir_rs = { git = "https://github.com/hydro-project/hydro" }
sinktools = { git = "https://github.com/hydro-project/hydro" }
```

## Troubleshooting

### Build fails
```bash
cargo clean
cargo update
cargo build
```

### Slow build
```bash
# First build is slow (downloads dependencies)
# Subsequent builds are cached
```

### Permission errors
```bash
sudo chmod -R 755 .
```

### Missing Rust
```bash
# Install rustup
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

## Quick Links

- [Full README](README.md)
- [Quick Start](QUICKSTART.md)
- [Benchmark Details](BENCHMARK_DETAILS.md)
- [Migration Guide](MIGRATION.md)

## Repository Info

- **Name**: bigweaver-agent-canary-zeta-hydro-deps
- **Purpose**: Timely and differential-dataflow benchmarks
- **Version**: 0.1.0
- **License**: Apache-2.0

## Support

1. Check documentation in [INDEX.md](INDEX.md)
2. Run `./verify_benchmarks.sh` for diagnostics
3. Review error messages carefully
4. Consult team documentation
