# Quick Start Guide

Get up and running with the performance comparison benchmarks in minutes.

## Prerequisites

- Rust toolchain (2024 edition or later)
- Git
- 4GB+ available RAM
- 5GB+ available disk space

## Installation

### Step 1: Clone the Repository

```bash
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps
```

### Step 2: Build the Benchmarks

```bash
cargo build -p benches --release
```

This will:
- Download dependencies (timely, differential-dataflow, dfir_rs, etc.)
- Compile all benchmark code
- Generate any needed build artifacts

**Note**: First build may take 10-15 minutes due to dependency compilation.

### Step 3: Verify Installation

```bash
# Verify benchmarks compile
cargo bench -p benches --no-run
```

## Running Your First Benchmark

### Quick Test Run

Run a single benchmark with reduced samples:

```bash
cargo bench -p benches --bench arithmetic -- --quick
```

**Output**:
```
arithmetic/raw          time:   [247.23 µs 248.91 µs 250.67 µs]
arithmetic/timely       time:   [897.12 µs 902.34 µs 907.89 µs]
arithmetic/dfir_rs      time:   [658.90 µs 663.87 µs 669.12 µs]
```

### Full Benchmark Suite

Run all benchmarks (takes 15-30 minutes):

```bash
cargo bench -p benches
```

### View Results

Open the HTML reports:

```bash
# macOS
open target/criterion/arithmetic/report/index.html

# Linux
xdg-open target/criterion/arithmetic/report/index.html

# Windows
start target/criterion/arithmetic/report/index.html
```

## Common Tasks

### Run Specific Benchmark

```bash
# Arithmetic operations
cargo bench -p benches --bench arithmetic

# Graph reachability
cargo bench -p benches --bench reachability

# Join operations
cargo bench -p benches --bench join
```

### Compare Frameworks

```bash
# All timely implementations
cargo bench -p benches -- timely

# All dfir_rs implementations
cargo bench -p benches -- dfir_rs

# All differential implementations
cargo bench -p benches -- differential
```

### Quick Performance Check

For rapid iteration:

```bash
# Reduced sample size
cargo bench -p benches -- --quick --sample-size 10
```

## Local Development Setup

If you have both repositories checked out locally:

### Step 1: Create Cargo Configuration

```bash
mkdir -p .cargo
cat > .cargo/config.toml << 'EOF'
[patch."https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git"]
dfir_rs = { path = "../bigweaver-agent-canary-hydro-zeta/dfir_rs" }
sinktools = { path = "../bigweaver-agent-canary-hydro-zeta/sinktools" }
EOF
```

**Note**: Adjust paths if your repositories are in different locations.

### Step 2: Rebuild

```bash
cargo clean
cargo build -p benches
```

This uses local paths instead of git dependencies for faster iteration.

## Understanding Results

### Benchmark Output

```
arithmetic/raw          time:   [247 µs 248 µs 250 µs]
                        change: [-2.3% -1.9% -1.4%] (p = 0.00 < 0.05)
                        Performance has improved.
```

**Reading**:
- **Time**: Mean execution time with 95% confidence interval
- **Change**: Performance change vs previous run
- **p-value**: Statistical significance (< 0.05 is significant)
- **Status**: Improved, regressed, or no change

### Performance Comparison

Example output shows:
```
arithmetic/raw          time:   [247 µs]   <- Baseline
arithmetic/dfir_compiled time:  [436 µs]   <- 1.8× slower than baseline
arithmetic/dfir_rs      time:   [659 µs]   <- 2.7× slower than baseline
arithmetic/timely       time:   [897 µs]   <- 3.6× slower than baseline
```

**Interpretation**:
- **Lower is better**: Less time = faster execution
- **Relative to baseline**: How much overhead does each framework add?
- **Framework comparison**: dfir_compiled is 2× faster than timely

## Troubleshooting

### Build Errors

**Problem**: Dependencies won't download

```bash
# Solution: Clear cache and retry
rm -rf ~/.cargo/registry
cargo clean
cargo build -p benches
```

**Problem**: Git dependencies fail

```bash
# Solution: Use local paths (see Local Development Setup above)
```

### Slow Performance

**Problem**: Benchmarks taking too long

```bash
# Solution: Use quick mode
cargo bench -p benches -- --quick

# Or run specific benchmarks
cargo bench -p benches --bench micro_ops
```

### Inconsistent Results

**Problem**: Results vary between runs

```bash
# Solution: Ensure system stability
# 1. Close other applications
# 2. Disable CPU frequency scaling (Linux):
echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor

# 3. Use more samples
cargo bench -p benches -- --sample-size 200
```

## Next Steps

### Learn More

- [README.md](README.md) - Complete repository overview
- [benches/README.md](benches/README.md) - Detailed benchmark documentation
- [TESTING_GUIDE.md](TESTING_GUIDE.md) - Comprehensive testing instructions
- [CONTRIBUTING.md](CONTRIBUTING.md) - Contribution guidelines

### Explore Benchmarks

All available benchmarks:

| Benchmark | Description | Command |
|-----------|-------------|---------|
| arithmetic | Arithmetic operations | `cargo bench -p benches --bench arithmetic` |
| fan_in | Fan-in patterns | `cargo bench -p benches --bench fan_in` |
| fan_out | Fan-out patterns | `cargo bench -p benches --bench fan_out` |
| fork_join | Fork-join patterns | `cargo bench -p benches --bench fork_join` |
| identity | Identity operations | `cargo bench -p benches --bench identity` |
| join | Join operations | `cargo bench -p benches --bench join` |
| reachability | Graph reachability | `cargo bench -p benches --bench reachability` |
| upcase | String transformations | `cargo bench -p benches --bench upcase` |

### Add Custom Benchmarks

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines on adding new benchmarks.

## Tips

### Faster Builds

```bash
# Use more CPU cores for compilation
export CARGO_BUILD_JOBS=8
cargo build -p benches
```

### Save Results

```bash
# Save current results as baseline
cargo bench -p benches --save-baseline my-baseline

# Compare future runs against baseline
cargo bench -p benches --baseline my-baseline
```

### Filter Benchmarks

```bash
# Run only specific variants
cargo bench -p benches -- "arithmetic/dfir"

# Use regex patterns
cargo bench -p benches -- "timely|differential"
```

### Export Results

```bash
# Machine-readable format
cargo bench -p benches --output-format bencher > results.txt

# JSON format (requires custom setup)
cargo bench -p benches --output-format json > results.json
```

## Getting Help

### Documentation

- Check this guide for quick answers
- See [TESTING_GUIDE.md](TESTING_GUIDE.md) for detailed testing instructions
- Review [benches/README.md](benches/README.md) for benchmark-specific details

### Issues

- Search existing issues: [GitHub Issues](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps/issues)
- Open a new issue with:
  - Description of the problem
  - Steps to reproduce
  - System information
  - Error messages

### Resources

- [Criterion.rs Book](https://bheisler.github.io/criterion.rs/book/)
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)

## Summary

**Basic workflow**:
```bash
# 1. Clone and build
git clone <repository-url>
cd bigweaver-agent-canary-zeta-hydro-deps
cargo build -p benches

# 2. Run benchmarks
cargo bench -p benches --bench arithmetic

# 3. View results
open target/criterion/arithmetic/report/index.html
```

**Quick commands**:
```bash
# All benchmarks (quick mode)
cargo bench -p benches -- --quick

# Specific benchmark
cargo bench -p benches --bench <name>

# Filter by pattern
cargo bench -p benches -- <pattern>

# Save baseline
cargo bench -p benches --save-baseline <name>
```

You're ready to start benchmarking! 🚀
