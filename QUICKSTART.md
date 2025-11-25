# Quick Start Guide

This guide will help you get started with the timely and differential-dataflow benchmarks.

## Prerequisites

- Rust toolchain 1.91.1 or later (automatically installed via rust-toolchain.toml)
- Cargo (comes with Rust)
- At least 4GB of free RAM for running benchmarks
- Git (for cloning the repository)

## Setup

### 1. Clone the Repository

```bash
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps
```

### 2. Verify Setup

Run the verification script to ensure everything is properly configured:

```bash
./verify_benchmarks.sh
```

This will check:
- All required files are present
- Dependencies are correctly configured
- Benchmarks compile successfully

### 3. Build the Benchmarks

```bash
cargo build --release
```

The first build may take several minutes as it compiles all dependencies.

## Running Benchmarks

### Run All Benchmarks

```bash
cargo bench
```

⚠️ **Warning**: Running all benchmarks can take 30-60 minutes depending on your hardware.

### Run a Specific Benchmark

```bash
# Run arithmetic benchmark
cargo bench --bench arithmetic

# Run reachability benchmark
cargo bench --bench reachability

# Run join benchmark
cargo bench --bench join
```

### Quick Test Run

To verify benchmarks work without running full benchmarks:

```bash
cargo bench --bench arithmetic -- --test
```

The `--test` flag runs a quick validation instead of full benchmark iterations.

## Understanding Results

### Console Output

Criterion will display results like:

```
arithmetic/pipeline     time:   [45.123 ms 45.456 ms 45.789 ms]
                        change: [-2.3% -1.5% -0.7%] (p = 0.00 < 0.05)
                        Performance has improved.
```

- **time**: Mean execution time with confidence interval
- **change**: Performance change from previous run (if available)
- **Performance**: Interpretation of the change

### HTML Reports

Detailed reports are generated in `target/criterion/`:

```bash
# Open the main report
open target/criterion/report/index.html

# Or for a specific benchmark
open target/criterion/arithmetic/report/index.html
```

Reports include:
- Line plots of performance
- Statistical analysis
- Comparison with historical runs
- Outlier detection

## Available Benchmarks

| Benchmark | Description | Frameworks Compared |
|-----------|-------------|---------------------|
| `arithmetic` | Arithmetic operations | Timely, Hydro, Pipeline, Raw |
| `identity` | Pass-through operations | Timely, Hydro, Pipeline, Raw |
| `fan_in` | Multiple input merging | Timely, Hydro |
| `fan_out` | Single input splitting | Timely, Hydro |
| `fork_join` | Branching and joining | Timely, Hydro |
| `join` | Join operations | Timely, Hydro |
| `upcase` | String transformation | Timely, Hydro |
| `reachability` | Graph algorithms | Differential, Hydro |

For detailed descriptions, see [BENCHMARK_DETAILS.md](BENCHMARK_DETAILS.md).

## Common Commands

```bash
# Build without running
cargo build --release

# Check for errors without building
cargo check

# Run specific benchmark group
cargo bench --bench arithmetic -- timely
cargo bench --bench arithmetic -- dfir

# Format code
cargo fmt

# Run linter
cargo clippy

# Clean build artifacts
cargo clean
```

## Troubleshooting

### Build Errors

**Problem**: Dependency resolution fails
```bash
error: no matching package named `timely-master` found
```

**Solution**: The timely-master package may not be available. Check Cargo.toml for correct version.

---

**Problem**: Out of memory during compilation
```bash
error: could not compile `differential-dataflow`
```

**Solution**: Increase available RAM or build with fewer parallel jobs:
```bash
cargo build -j 2
```

---

### Runtime Errors

**Problem**: Benchmark takes too long
```bash
# Times out or runs for hours
```

**Solution**: Run specific benchmarks instead of all at once, or use quick mode:
```bash
cargo bench --bench arithmetic -- --test
```

---

**Problem**: Inconsistent results
```bash
# Large variance in measurements
```

**Solution**: 
1. Close other applications
2. Disable CPU frequency scaling
3. Run benchmarks multiple times
4. Check system isn't thermal throttling

---

### Permission Issues

**Problem**: Cannot execute verification script
```bash
permission denied: ./verify_benchmarks.sh
```

**Solution**:
```bash
chmod +x verify_benchmarks.sh
./verify_benchmarks.sh
```

## Best Practices

### For Accurate Benchmarking

1. **Close unnecessary applications** before running benchmarks
2. **Run on wall power** (not battery) for laptops
3. **Disable CPU frequency scaling** for consistent results
4. **Run multiple times** to establish baseline
5. **Document system configuration** when sharing results

### For Development

1. **Run quick tests** first: `cargo bench --bench <name> -- --test`
2. **Test specific functions**: `cargo bench --bench arithmetic -- pipeline`
3. **Use cargo check** for fast iteration: `cargo check`
4. **Format before committing**: `cargo fmt`
5. **Run clippy**: `cargo clippy`

## Performance Tips

### System Configuration

```bash
# Disable CPU frequency scaling (Linux)
sudo cpupower frequency-set -g performance

# Pin to specific cores
taskset -c 0-3 cargo bench

# Increase priority
sudo nice -n -20 cargo bench
```

### Benchmark Configuration

Edit constants in benchmark files to adjust workload:
- `NUM_OPS`: Number of operations
- `NUM_INTS`: Number of data items
- `BATCH_SIZE`: Size of data batches

## Next Steps

- Read [BENCHMARK_DETAILS.md](BENCHMARK_DETAILS.md) for in-depth benchmark descriptions
- Review [MIGRATION.md](MIGRATION.md) to understand the repository structure
- Check [README.md](README.md) for comprehensive documentation
- Explore benchmark source code in `benches/benches/`

## Getting Help

- Review documentation in this repository
- Check main hydro project: https://github.com/hydro-project/hydro
- See timely-dataflow docs: https://github.com/TimelyDataflow/timely-dataflow
- See differential-dataflow docs: https://github.com/TimelyDataflow/differential-dataflow

## Contributing

When contributing new benchmarks or improvements:

1. Follow existing code style (use `cargo fmt`)
2. Add documentation for new benchmarks
3. Update README.md and this guide
4. Test thoroughly before submitting
5. Include benchmark results in pull request

For more details, see the main repository's contributing guidelines.
