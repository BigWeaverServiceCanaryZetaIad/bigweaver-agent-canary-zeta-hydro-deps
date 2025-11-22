# Quick Start Guide

Get up and running with the Hydro benchmarks in minutes.

## Prerequisites

- **Rust**: Version 1.91.1 or later (automatically managed by `rust-toolchain.toml`)
- **Cargo**: Comes with Rust
- **Git**: For cloning the repository
- **Disk Space**: ~500MB for dependencies and build artifacts

## Installation

### 1. Clone the Repository

```bash
git clone <repository-url>
cd bigweaver-agent-canary-zeta-hydro-deps
```

### 2. Verify Rust Installation

The repository will automatically use the correct Rust version:

```bash
rustc --version  # Should show 1.91.1
```

## Running Your First Benchmark

### Run All Benchmarks

```bash
cargo bench -p benches
```

This will:
- Compile all benchmark code
- Run each benchmark multiple times
- Generate statistical reports
- Create HTML visualizations in `target/criterion/`

**Note**: First run takes longer as dependencies are compiled.

### Run a Single Benchmark

For quicker feedback, run one benchmark:

```bash
cargo bench -p benches --bench identity
```

### Quick Test Run

For a faster test with fewer samples:

```bash
cargo bench -p benches --bench identity -- --quick
```

## Understanding Results

### Console Output

Benchmark results appear in your terminal:

```
identity/dfir_rs        time:   [1.2345 µs 1.2456 µs 1.2567 µs]
identity/timely         time:   [2.3456 µs 2.3567 µs 2.3678 µs]
```

- First value: Lower bound of confidence interval
- Second value: Mean (average) time
- Third value: Upper bound of confidence interval

### HTML Reports

Detailed reports with graphs are in `target/criterion/`:

```bash
# View in browser (example paths)
firefox target/criterion/identity/report/index.html
# or
open target/criterion/identity/report/index.html
```

## Available Benchmarks

Quick reference of available benchmarks:

| Benchmark | Description | Typical Runtime |
|-----------|-------------|-----------------|
| `identity` | Pass-through operations | ~30 seconds |
| `arithmetic` | Basic math operations | ~1 minute |
| `fan_in` | Multiple inputs to one output | ~1 minute |
| `fan_out` | One input to multiple outputs | ~1 minute |
| `fork_join` | Parallel fork-join patterns | ~1 minute |
| `join` | Join operations | ~1 minute |
| `upcase` | String transformations | ~1 minute |
| `micro_ops` | Micro-level operations | ~2 minutes |
| `symmetric_hash_join` | Hash join operations | ~2 minutes |
| `futures` | Async operations | ~2 minutes |
| `words_diamond` | Word processing patterns | ~3 minutes |
| `reachability` | Graph algorithms | ~5 minutes |

## Common Commands

### Building Without Running

```bash
# Check that everything compiles
cargo check --workspace

# Build benchmarks (but don't run)
cargo build --release -p benches
```

### Testing Benchmarks

```bash
# Compile benchmark tests
cargo test -p benches --benches --no-run

# Run benchmark tests (not the actual benchmarks)
cargo test -p benches
```

### Cleaning Build Artifacts

```bash
# Remove all build artifacts
cargo clean

# Remove just benchmark results
rm -rf target/criterion/
```

## Local Development Setup

If you're developing alongside the main Hydro repository:

### 1. Clone Both Repositories

```bash
mkdir hydro-workspace
cd hydro-workspace

# Clone main repository
git clone <main-repo-url> bigweaver-agent-canary-hydro-zeta

# Clone benchmark repository
git clone <bench-repo-url> bigweaver-agent-canary-zeta-hydro-deps
```

### 2. Configure Local Paths

Edit `bigweaver-agent-canary-zeta-hydro-deps/benches/Cargo.toml`:

```toml
[dev-dependencies]
# Comment out git dependencies:
# dfir_rs = { git = "https://github.com/hydro-project/hydro.git", features = [ "debugging" ] }
# sinktools = { git = "https://github.com/hydro-project/hydro.git", version = "^0.0.1" }

# Use local paths:
dfir_rs = { path = "../../bigweaver-agent-canary-hydro-zeta/dfir_rs", features = [ "debugging" ] }
sinktools = { path = "../../bigweaver-agent-canary-hydro-zeta/sinktools", version = "^0.0.1" }
```

### 3. Test Local Setup

```bash
cd bigweaver-agent-canary-zeta-hydro-deps
cargo check -p benches
```

## Troubleshooting

### "Cannot find crate dfir_rs"

**Solution**: You're using git dependencies but they're not accessible. Either:
- Ensure you have internet access for git dependencies
- Switch to local path dependencies (see Local Development Setup)

### Benchmarks Take Too Long

**Solution**: Run with `--quick` flag or run individual benchmarks:

```bash
# Quick mode (fewer samples)
cargo bench -p benches --bench identity -- --quick

# Run just one test within a benchmark
cargo bench -p benches --bench identity -- "identity/dfir_rs"
```

### Build Fails with "permission denied"

**Solution**: Build script needs write access:

```bash
# Check permissions
ls -la benches/benches/

# If needed, fix permissions
chmod u+w benches/benches/
```

### "error: package collision" or Similar

**Solution**: Clean and rebuild:

```bash
cargo clean
cargo bench -p benches --bench identity
```

## Next Steps

### Explore More

- **[BENCHMARKING.md](BENCHMARKING.md)**: Detailed benchmarking guide
- **[MIGRATION_NOTES.md](MIGRATION_NOTES.md)**: Background and migration details
- **[benches/README.md](benches/README.md)**: Benchmark-specific documentation

### Contribute

- Add new benchmarks for different patterns
- Improve existing benchmark coverage
- Optimize benchmark implementations
- Enhance documentation

### Performance Analysis

- Compare DFIR vs timely implementations
- Track performance over time
- Identify optimization opportunities
- Validate performance improvements

## Getting Help

If you're stuck:

1. **Check Documentation**: Review BENCHMARKING.md and MIGRATION_NOTES.md
2. **Review Examples**: Look at existing benchmark implementations
3. **Check Issues**: See if others encountered similar problems
4. **Ask Team**: Contact the Hydro development team

## Summary

You should now be able to:
- ✅ Clone and set up the repository
- ✅ Run benchmarks
- ✅ Understand benchmark results
- ✅ Configure local development
- ✅ Troubleshoot common issues

Happy benchmarking! 🚀
