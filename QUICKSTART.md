# Quick Start Guide

Get up and running with Hydro performance benchmarks in minutes.

## 1. Clone the Repository

```bash
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps
```

## 2. Verify Setup

```bash
# Check Rust installation
rustc --version

# Should show: rustc 1.91.1 (or later)
# If not installed: https://rustup.rs/
```

## 3. Build (First Time)

```bash
# This will download and compile all dependencies
cargo build --release

# Note: First build may take several minutes as it compiles
# timely-dataflow, differential-dataflow, and other dependencies
```

## 4. Run Your First Benchmark

```bash
# Run a simple benchmark (identity operation)
cargo bench --bench identity

# This will:
# - Compile the benchmark if needed
# - Run the benchmark multiple times for statistical accuracy
# - Generate an HTML report with results
```

## 5. View Results

```bash
# Results are saved in target/criterion/
# Open the HTML report (adjust path based on your OS):

# On macOS:
open target/criterion/report/index.html

# On Linux:
xdg-open target/criterion/report/index.html

# On Windows:
start target/criterion/report/index.html
```

## 6. Run More Benchmarks

```bash
# Run all benchmarks (takes longer)
cargo bench

# Run specific benchmarks
cargo bench --bench arithmetic    # Arithmetic operations
cargo bench --bench join          # Join operations
cargo bench --bench reachability  # Graph reachability

# Run benchmarks for specific framework
cargo bench -- dfir              # Only DFIR benchmarks
cargo bench -- timely            # Only Timely benchmarks
cargo bench -- differential      # Only Differential benchmarks
```

## Common Commands

### Building
```bash
cargo build              # Debug build
cargo build --release    # Release build (faster runtime)
cargo check              # Check compilation without building
```

### Benchmarking
```bash
cargo bench                        # All benchmarks
cargo bench --bench <name>         # Specific benchmark
cargo bench --bench <name> -- <test>  # Specific test within benchmark
cargo bench --no-fail-fast         # Continue even if one fails
```

### Cleaning
```bash
cargo clean                        # Remove all build artifacts
rm -rf target/criterion            # Remove benchmark results
```

## Troubleshooting

### Build is Slow
**Normal**: First build compiles many dependencies and can take 5-10 minutes.
**Solution**: Subsequent builds will be much faster (incremental compilation).

### Out of Memory During Build
**Solution**: Add `cargo build --release -j 1` to use only one CPU core.

### Git Dependencies Not Working
**Solution**: Check network connection or use local path dependencies (see CONFIGURATION.md).

### Benchmark Results Look Wrong
**Check**: Are you building with `--release`? Debug builds are much slower.
**Try**: `cargo clean` then `cargo bench` to rebuild from scratch.

## Next Steps

- **Read the full README**: For complete documentation
- **Check CONFIGURATION.md**: To customize dependency sources  
- **See MIGRATION.md**: For background on the repository
- **Add your own benchmarks**: Follow patterns in existing benchmarks

## Example Output

When you run a benchmark, you'll see output like:

```
Running benches/identity.rs
identity/dfir/1000000   time:   [45.231 ms 45.891 ms 46.612 ms]
identity/timely/1000000 time:   [52.112 ms 52.834 ms 53.621 ms]

Benchmarking identity/differential/1000000: Warming up for 3.0000 s
identity/differential/1000000
                        time:   [48.734 ms 49.123 ms 49.556 ms]
```

This shows:
- **identity/dfir**: DFIR implementation took ~45.9ms
- **identity/timely**: Timely implementation took ~52.8ms  
- **identity/differential**: Differential implementation took ~49.1ms

## Key Files

- `Cargo.toml` - Dependencies and benchmark configuration
- `benches/*.rs` - Individual benchmark implementations
- `benches/*.txt` - Test data for benchmarks
- `build.rs` - Build script for code generation

## Getting Help

- **Documentation**: Check README.md, CONFIGURATION.md, MIGRATION.md
- **Issues**: Open an issue in this repository
- **Main Project**: Visit [hydro.run](https://hydro.run) for Hydro documentation

## Happy Benchmarking! 🚀
