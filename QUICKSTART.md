# Quick Start Guide

Get up and running with the Timely and Differential Dataflow benchmarks in minutes.

## Prerequisites

- Rust 1.91.1 or later
- Git
- Approximately 50MB of disk space

## Installation

### 1. Clone the Repository

```bash
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps
```

### 2. Build the Project

```bash
cargo build --release
```

This will download and compile all dependencies, including Timely and Differential Dataflow.

## Running Benchmarks

### Run All Benchmarks

```bash
cargo bench -p benches
```

This will run all 8 benchmarks and generate HTML reports in `target/criterion/`.

### Run a Specific Benchmark

```bash
# Run the arithmetic benchmark
cargo bench -p benches --bench arithmetic

# Run the reachability benchmark
cargo bench -p benches --bench reachability

# Run the join benchmark
cargo bench -p benches --bench join
```

### Available Benchmarks

| Benchmark | Description | Data Size |
|-----------|-------------|-----------|
| `arithmetic` | Pipeline arithmetic operations | 1M integers |
| `fan_in` | Multiple inputs to single output | 100K elements |
| `fan_out` | Single input to multiple outputs | 100K elements |
| `fork_join` | Fork-join parallelism pattern | 100K elements |
| `identity` | Pass-through transformation | 1M elements |
| `join` | Join two data streams | 100K elements |
| `reachability` | Graph reachability computation | ~20K nodes |
| `upcase` | String uppercasing operations | ~370K words |

## Viewing Results

### HTML Reports

After running benchmarks, view detailed HTML reports:

```bash
# Open the main index
open target/criterion/report/index.html

# Or view specific benchmark
open target/criterion/arithmetic/report/index.html
```

### Terminal Output

Criterion prints summary statistics to the terminal:
- Mean execution time
- Standard deviation
- Median and quartiles
- Change from previous run (if available)

Example output:
```
arithmetic/hydro        time:   [45.234 ms 45.456 ms 45.678 ms]
arithmetic/timely       time:   [52.123 ms 52.345 ms 52.567 ms]
```

## Common Tasks

### Compare with Previous Results

Criterion automatically compares with previous runs. To explicitly baseline:

```bash
# Save current results as baseline
cargo bench -p benches -- --save-baseline my-baseline

# Compare against baseline
cargo bench -p benches -- --baseline my-baseline
```

### Profile a Benchmark

```bash
# Build with profiling symbols
cargo build --profile=profile

# Run with profiler (example with perf on Linux)
perf record --call-graph=dwarf cargo bench -p benches --bench arithmetic --profile-time 10
perf report
```

### Run Specific Test Cases

Some benchmarks have multiple test cases:

```bash
# Run only Hydro implementations
cargo bench -p benches -- hydro

# Run only Timely implementations
cargo bench -p benches -- timely
```

## Troubleshooting

### Build Fails

**Issue**: Compilation errors
**Solution**: Ensure you have Rust 1.91.1 or later:
```bash
rustup update
rustc --version
```

### Out of Memory

**Issue**: Build runs out of memory
**Solution**: Reduce parallel jobs:
```bash
cargo build --release -j 2
```

### Benchmark Takes Too Long

**Issue**: Benchmarks run for too long
**Solution**: Use quick mode:
```bash
cargo bench -p benches -- --quick
```

Or run shorter benchmarks:
```bash
cargo bench -p benches --bench fan_in
```

### Missing Data Files

**Issue**: Benchmark fails with file not found
**Solution**: Ensure data files are present:
```bash
ls -lh benches/benches/*.txt
```

Files should include:
- `reachability_edges.txt` (521KB)
- `reachability_reachable.txt` (38KB)
- `words_alpha.txt` (3.7MB)

## Next Steps

### Explore the Code

Browse benchmark implementations:
```bash
ls benches/benches/*.rs
```

Read a benchmark to understand the structure:
```bash
less benches/benches/arithmetic.rs
```

### Modify Parameters

Edit benchmark files to experiment with different:
- Data sizes
- Number of operations
- Parallelism levels

For example, in `arithmetic.rs`:
```rust
const NUM_OPS: usize = 20;      // Number of operations
const NUM_INTS: usize = 1_000_000; // Data size
```

### Add New Benchmarks

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines on adding new benchmarks.

## Performance Tips

### Optimize Build Time

```bash
# Use faster linker (Linux)
sudo apt-get install lld
export RUSTFLAGS="-C link-arg=-fuse-ld=lld"

# Use faster linker (macOS)
brew install llvm
export RUSTFLAGS="-C link-arg=-fuse-ld=lld"
```

### Optimize Runtime Performance

```bash
# Build with maximum optimization
cargo build --release

# Use CPU-specific optimizations
RUSTFLAGS="-C target-cpu=native" cargo build --release
```

### Reduce Benchmark Variance

For more stable results:
1. Close other applications
2. Disable CPU frequency scaling
3. Run multiple iterations:
   ```bash
   cargo bench -p benches -- --sample-size 100
   ```

## Understanding Results

### Interpreting Output

```
benchmark_name/variant  time:   [lower_bound estimate upper_bound]
                        change: [-X.XX% -Y.YY% -Z.ZZ%] (p = 0.XX)
```

- **time**: Execution time with confidence interval
- **change**: Performance change vs. previous run
- **p-value**: Statistical significance

### Performance Comparison

Hydro vs Timely/Differential:
- Lower time is better
- Compare mean times across implementations
- Check HTML reports for detailed analysis

## Resources

- [Full Documentation](README.md) - Complete repository overview
- [Migration Guide](MIGRATION.md) - Moving from main repository
- [Contributing](CONTRIBUTING.md) - How to contribute
- [Changelog](CHANGELOG.md) - Version history

## Getting Help

- **Issue Tracker**: Report bugs or request features
- **Discussions**: Ask questions and share ideas
- **Documentation**: Check README and migration guide

## Quick Command Reference

```bash
# Build
cargo build --release

# Run all benchmarks
cargo bench -p benches

# Run specific benchmark
cargo bench -p benches --bench <name>

# Quick benchmark (fewer iterations)
cargo bench -p benches -- --quick

# Save baseline
cargo bench -p benches -- --save-baseline <name>

# Compare to baseline
cargo bench -p benches -- --baseline <name>

# Format code
cargo fmt --all

# Run lints
cargo clippy --all-targets

# Clean build artifacts
cargo clean
```

## Example Session

Complete example workflow:

```bash
# Clone and build
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps
cargo build --release

# Run benchmarks
cargo bench -p benches

# View results
open target/criterion/report/index.html

# Run specific benchmark for comparison
cargo bench -p benches --bench arithmetic

# Save current results
cargo bench -p benches -- --save-baseline current

# Make changes to code...

# Compare with baseline
cargo bench -p benches -- --baseline current
```

Congratulations! You're now ready to run and analyze Hydro benchmarks against Timely and Differential Dataflow.
