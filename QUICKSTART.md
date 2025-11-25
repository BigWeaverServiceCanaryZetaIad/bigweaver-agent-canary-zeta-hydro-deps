# Quick Start Guide

This guide will help you get started with running benchmarks in the hydro-deps repository.

## Prerequisites

Before you begin, ensure you have:

1. **Rust Toolchain**: The repository will automatically use Rust 1.91.1 via `rust-toolchain.toml`
2. **Git**: For cloning the repository
3. **Cargo**: Comes with Rust installation

## Installation

### 1. Clone the Repository

```bash
git clone https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps
```

### 2. Verify Setup

Check that the workspace builds correctly:

```bash
cargo check --workspace
```

This will download all dependencies and verify the code compiles.

## Running Benchmarks

### Run All Benchmarks

To run the complete benchmark suite:

```bash
cargo bench -p benches
```

This will:
- Compile all benchmark code
- Execute each benchmark multiple times for statistical accuracy
- Generate HTML reports with detailed results
- Store results in `target/criterion/`

**Expected runtime**: 10-30 minutes depending on your hardware

### Run a Specific Benchmark

To run just one benchmark:

```bash
# Run only the arithmetic benchmarks
cargo bench -p benches --bench arithmetic

# Run only the reachability benchmarks
cargo bench -p benches --bench reachability

# Run only the join benchmarks
cargo bench -p benches --bench join
```

### Run Specific Test Cases

To run specific test cases within a benchmark:

```bash
# Run only the pipeline test in arithmetic
cargo bench -p benches --bench arithmetic -- pipeline

# Run only DFIR tests
cargo bench -p benches -- dfir

# Run only timely tests
cargo bench -p benches -- timely
```

## Viewing Results

### HTML Reports

After running benchmarks, open the HTML report in your browser:

```bash
# On Linux
xdg-open target/criterion/report/index.html

# On macOS
open target/criterion/report/index.html

# On Windows
start target/criterion/report/index.html
```

The HTML reports include:
- Performance graphs
- Statistical analysis
- Comparison with previous runs
- Detailed timing breakdowns

### Command Line Output

Benchmark results are also displayed in the terminal:

```
arithmetic/pipeline     time:   [45.123 ms 45.456 ms 45.789 ms]
                        change: [-2.5% -1.2% +0.5%] (p = 0.15 > 0.05)
                        No change in performance detected.
```

## Available Benchmarks

| Benchmark | Description | Typical Runtime |
|-----------|-------------|-----------------|
| `arithmetic` | Arithmetic operations in pipelines | ~2 minutes |
| `fan_in` | Multiple inputs merging to one output | ~1 minute |
| `fan_out` | One input splitting to multiple outputs | ~1 minute |
| `fork_join` | Parallel processing and rejoining | ~2 minutes |
| `identity` | Pass-through operations | ~1 minute |
| `join` | Join operations between streams | ~3 minutes |
| `reachability` | Graph reachability algorithms | ~5 minutes |
| `symmetric_hash_join` | Symmetric hash join operations | ~3 minutes |
| `upcase` | String transformation operations | ~2 minutes |
| `words_diamond` | Diamond pattern with word processing | ~3 minutes |
| `micro_ops` | Various micro-operations | ~4 minutes |
| `futures` | Async futures-based operations | ~2 minutes |

## Common Tasks

### Compare Performance

To compare DFIR vs Timely implementations:

```bash
# Run benchmarks and save baseline
cargo bench -p benches --bench arithmetic -- --save-baseline before

# After making changes, compare
cargo bench -p benches --bench arithmetic -- --baseline before
```

### Quick Smoke Test

For a quick verification that everything works:

```bash
# Run a fast benchmark with fewer iterations
cargo bench -p benches --bench identity -- --quick
```

### Clean Build

If you encounter issues:

```bash
# Clean all build artifacts
cargo clean

# Rebuild and run
cargo bench -p benches
```

## Troubleshooting

### Build Errors

**Problem**: Compilation fails with dependency errors

**Solution**: Ensure you have a stable internet connection for downloading dependencies:
```bash
cargo clean
cargo update
cargo check --workspace
```

### Slow Benchmarks

**Problem**: Benchmarks take too long to run

**Solution**: Run specific benchmarks instead of the full suite:
```bash
cargo bench -p benches --bench identity
```

Or use the `--quick` flag for faster (but less accurate) results:
```bash
cargo bench -p benches -- --quick
```

### Out of Memory

**Problem**: System runs out of memory during benchmarks

**Solution**: Run benchmarks individually:
```bash
for bench in arithmetic fan_in fan_out fork_join identity join; do
    cargo bench -p benches --bench $bench
done
```

### Permission Errors

**Problem**: Cannot write to target directory

**Solution**: Check directory permissions:
```bash
chmod -R u+w target/
```

## Next Steps

- Read [BENCHMARK_DETAILS.md](BENCHMARK_DETAILS.md) for detailed information about each benchmark
- Check [README.md](README.md) for comprehensive repository documentation
- Review benchmark source code in `benches/benches/` directory
- Explore HTML reports in `target/criterion/` after running benchmarks

## Getting Help

- Check the main Hydro documentation at https://hydro.run
- Review the Criterion documentation at https://bheisler.github.io/criterion.rs/book/
- Open an issue in the main repository for questions

## Performance Tips

1. **Close Other Applications**: For accurate results, close other applications
2. **Stable Power**: Ensure laptop is plugged in (not on battery)
3. **Cooling**: Ensure good system cooling to avoid thermal throttling
4. **Multiple Runs**: Run benchmarks multiple times to verify consistency
5. **Baseline**: Always save a baseline before making changes for comparison
