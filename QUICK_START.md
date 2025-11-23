# Quick Start Guide

## Getting Started with Hydro Dependency Benchmarks

This guide will help you quickly get up and running with the timely and differential-dataflow benchmarks.

## Prerequisites

- Rust toolchain (will be automatically installed from `rust-toolchain.toml`)
- Git access to the main hydro repository

## Quick Setup

1. **Clone this repository** (if not already done):
   ```bash
   git clone https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
   cd bigweaver-agent-canary-zeta-hydro-deps
   ```

2. **Verify the setup**:
   ```bash
   ./verify_benchmarks.sh
   ```

3. **Run your first benchmark**:
   ```bash
   cargo bench -p benches --bench arithmetic
   ```

## Common Commands

### Run All Benchmarks
```bash
cargo bench -p benches
```

### Run Specific Benchmark
```bash
# Run arithmetic benchmark
cargo bench -p benches --bench arithmetic

# Run reachability benchmark
cargo bench -p benches --bench reachability

# Run join benchmark
cargo bench -p benches --bench join
```

### Run Specific Comparison
```bash
# Run only timely comparisons in reachability
cargo bench -p benches --bench reachability -- timely

# Run only differential-dataflow comparisons
cargo bench -p benches --bench reachability -- differential

# Run only hydroflow comparisons
cargo bench -p benches --bench reachability -- hydroflow
```

### Quick Test (Faster)
```bash
# Run with quick mode (fewer iterations)
cargo bench -p benches --bench arithmetic -- --quick
```

### Build Without Running
```bash
cargo build -p benches --benches
```

## Available Benchmarks

| Benchmark | Description | Frameworks Compared |
|-----------|-------------|---------------------|
| `arithmetic` | Arithmetic operations | Hydroflow, Timely, Raw Rust |
| `fan_in` | Multiple inputs merging | Hydroflow, Timely |
| `fan_out` | Single input splitting | Hydroflow, Timely |
| `fork_join` | Fork-join patterns | Hydroflow, Timely |
| `identity` | Pass-through operations | Hydroflow, Timely |
| `join` | Stream join operations | Hydroflow, Timely |
| `reachability` | Graph reachability | Hydroflow, Timely, Differential |
| `upcase` | String uppercase | Hydroflow, Timely |
| `futures` | Async/futures | Hydroflow |
| `micro_ops` | Micro operations | Hydroflow |
| `symmetric_hash_join` | Hash joins | Hydroflow |
| `words_diamond` | Word processing | Hydroflow |

## Understanding Results

Benchmark results are displayed in the terminal and saved to `target/criterion/`:

```
arithmetic/timely        time:   [10.234 ms 10.456 ms 10.678 ms]
arithmetic/dfir_rs       time:   [9.123 ms 9.345 ms 9.567 ms]
```

- First value: Lower bound of confidence interval
- Second value: Best estimate
- Third value: Upper bound of confidence interval

## Troubleshooting

### Build Errors

If you encounter build errors:

1. **Check Rust version**:
   ```bash
   rustc --version
   # Should be 1.91.1 or as specified in rust-toolchain.toml
   ```

2. **Clean and rebuild**:
   ```bash
   cargo clean
   cargo build -p benches --benches
   ```

3. **Update dependencies**:
   ```bash
   cargo update
   ```

### Git Dependency Issues

If the git dependencies (dfir_rs, sinktools) fail to resolve:

1. **Check git access** to the main repository
2. **Verify network connectivity**
3. **Try with explicit credentials** if needed

### Benchmark Failures

If benchmarks fail during execution:

1. **Check available memory** (some benchmarks are memory-intensive)
2. **Close other applications** to free resources
3. **Run individual benchmarks** instead of all at once

## Performance Tips

### Faster Development Cycle

```bash
# Build in debug mode (faster compile, slower runtime)
cargo build -p benches

# Check for errors without building
cargo check -p benches
```

### Release Mode Benchmarks

Benchmarks automatically run in release mode, but you can force it:
```bash
cargo bench -p benches --release
```

### Parallel Execution

By default, criterion runs benchmarks sequentially. For parallel execution:
```bash
# Set the number of benchmark threads
RAYON_NUM_THREADS=4 cargo bench -p benches
```

## Viewing Historical Results

Criterion saves benchmark history:

```bash
# View HTML reports
firefox target/criterion/report/index.html
# or
open target/criterion/report/index.html
```

## Comparing Performance

### Before/After Comparison

1. **Baseline**: Run benchmarks before changes
   ```bash
   cargo bench -p benches -- --save-baseline before
   ```

2. **Make your changes** (e.g., update dependencies, modify code)

3. **Compare**: Run benchmarks after changes
   ```bash
   cargo bench -p benches -- --baseline before
   ```

Criterion will show the performance difference.

## Advanced Usage

### Filter Benchmarks by Pattern

```bash
# Run all benchmarks with "join" in the name
cargo bench -p benches -- join

# Run all benchmarks with "timely" in the name
cargo bench -p benches -- timely
```

### Custom Measurement Time

```bash
# Increase measurement time for more accurate results
cargo bench -p benches -- --measurement-time 10
```

### Profile Benchmarks

```bash
# Build with profiling symbols
cargo build -p benches --benches --profile profile

# Run with profiler (example with perf on Linux)
perf record -g target/profile/arithmetic
perf report
```

## Getting Help

- **Documentation**: See [README.md](README.md) for detailed information
- **Benchmark Details**: See [benches/README.md](benches/README.md)
- **Migration Info**: See main repository's [BENCHMARK_MIGRATION.md](https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta/blob/main/BENCHMARK_MIGRATION.md)

## Next Steps

After running your first benchmarks:

1. **Explore individual benchmark implementations** in `benches/benches/`
2. **Compare performance across frameworks** for your use case
3. **Add new benchmarks** if needed for specific scenarios
4. **Share results** with the team for performance discussions

## Quick Reference Card

```bash
# Verify setup
./verify_benchmarks.sh

# Run all benchmarks
cargo bench -p benches

# Run one benchmark
cargo bench -p benches --bench <name>

# Run specific comparison
cargo bench -p benches -- <pattern>

# Save baseline
cargo bench -p benches -- --save-baseline <name>

# Compare to baseline  
cargo bench -p benches -- --baseline <name>

# Quick test
cargo bench -p benches -- --quick

# View reports
open target/criterion/report/index.html
```

Happy benchmarking! 🚀
