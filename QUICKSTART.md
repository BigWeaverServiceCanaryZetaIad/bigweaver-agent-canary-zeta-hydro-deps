# Quick Start Guide

Get up and running with Hydro performance comparison benchmarks in 5 minutes.

## Prerequisites

- Rust toolchain installed
- Main Hydro repository at `../bigweaver-agent-canary-hydro-zeta`

## Quick Start

### 1. Verify Setup

```bash
# Check that main repository is accessible
ls ../bigweaver-agent-canary-hydro-zeta/dfir_rs
```

### 2. Run Your First Benchmark

```bash
# Run a simple identity benchmark
cargo bench -p benches-timely-differential --bench identity
```

This will:
- Compile all dependencies
- Run the identity benchmark comparing Hydro and Timely
- Generate performance reports

### 3. View Results

```bash
# Open the HTML report (macOS)
open target/criterion/report/index.html

# Or on Linux
xdg-open target/criterion/report/index.html
```

## Common Commands

### Run All Benchmarks

```bash
cargo bench -p benches-timely-differential
```

### Run Specific Benchmark

```bash
cargo bench -p benches-timely-differential --bench reachability
cargo bench -p benches-timely-differential --bench arithmetic
cargo bench -p benches-timely-differential --bench join
```

### Quick Mode (Faster for Development)

```bash
cargo bench -p benches-timely-differential -- --quick
```

### Filter by Implementation

```bash
# Only Hydro (dfir_rs) benchmarks
cargo bench -p benches-timely-differential --bench reachability -- dfir

# Only Timely benchmarks
cargo bench -p benches-timely-differential --bench reachability -- timely

# Only Differential Dataflow benchmarks
cargo bench -p benches-timely-differential --bench reachability -- differential
```

## Available Benchmarks

### Simple Pattern Benchmarks
- `identity` - Basic identity transformation
- `fan_in` - Multiple inputs to single output
- `fan_out` - Single input to multiple outputs
- `fork_join` - Fork-join pattern
- `upcase` - String transformation

### Computation Benchmarks
- `arithmetic` - Arithmetic pipeline operations
- `join` - Join operations
- `reachability` - Graph reachability (most comprehensive)

## Understanding Results

Each benchmark shows:
- **Time:** How long the operation took
- **Comparison:** Performance relative to other implementations
- **Variance:** Consistency of results

Example output:
```
identity/dfir_rs        time:   [45.234 µs 45.789 µs 46.401 µs]
identity/timely         time:   [52.123 µs 52.678 µs 53.289 µs]
                        change: [+14.2% +15.0% +15.9%] (slower)
```

## Using the Helper Script

```bash
# Run with the convenience script
./run_comparisons.sh

# Quick mode
./run_comparisons.sh --quick

# Specific benchmark
./run_comparisons.sh --bench reachability

# With filter
./run_comparisons.sh --bench reachability --filter dfir

# Save as baseline for future comparisons
./run_comparisons.sh --save-baseline

# Show help
./run_comparisons.sh --help
```

## Next Steps

1. **Explore Benchmarks:** Try running different benchmarks to understand what they measure
2. **Read Documentation:** See `README.md` for detailed information
3. **Testing Guide:** Review `TESTING_GUIDE.md` for comprehensive testing procedures
4. **Add Benchmarks:** Create your own benchmarks following the examples

## Troubleshooting

### Can't find main repository

**Error:** `error: failed to load manifest for dependency 'dfir_rs'`

**Fix:** Ensure main repository is at correct path:
```bash
ls ../bigweaver-agent-canary-hydro-zeta/dfir_rs
# If not found, update path in benches/Cargo.toml
```

### Build takes too long

**Solution:** Use cached builds:
```bash
# First build takes longer
cargo build -p benches-timely-differential

# Subsequent builds are faster
cargo bench -p benches-timely-differential
```

### Benchmarks take too long

**Solution:** Use quick mode:
```bash
cargo bench -p benches-timely-differential -- --quick
```

## Getting Help

- **Full documentation:** `README.md`
- **Testing guide:** `TESTING_GUIDE.md`
- **Migration info:** `../bigweaver-agent-canary-hydro-zeta/REMOVAL_SUMMARY.md`
- **Main repository:** https://github.com/hydro-project/hydro

## Tips

💡 **First run is slower:** Initial compilation takes time. Subsequent runs are faster.

💡 **Quick mode for dev:** Use `--quick` flag during development, full runs before commits.

💡 **Save baselines:** Use `--save-baseline` to track performance over time.

💡 **HTML reports:** Criterion generates beautiful HTML reports with charts.

💡 **Compare implementations:** Use filters to compare different dataflow systems.

## Example Workflow

```bash
# 1. Quick sanity check
cargo bench -p benches-timely-differential --bench identity -- --quick

# 2. Save current performance as baseline
cargo bench -p benches-timely-differential -- --save-baseline before-changes

# 3. Make changes to main repository
cd ../bigweaver-agent-canary-hydro-zeta
# ... make your changes ...

# 4. Return and compare
cd ../bigweaver-agent-canary-zeta-hydro-deps
cargo bench -p benches-timely-differential -- --baseline before-changes

# 5. View results
open target/criterion/report/index.html
```

Happy benchmarking! 🚀
