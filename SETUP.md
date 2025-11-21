# Setup and Installation Guide

This guide walks you through setting up the Hydroflow External Framework Benchmarks repository.

## Prerequisites

### Required

- **Rust**: 1.70 or later (uses 2021 edition features)
- **Cargo**: Comes with Rust
- **Git**: For version control
- **4GB+ RAM**: For larger benchmarks

### Recommended

- **8+ CPU cores**: For faster compilation
- **SSD storage**: For faster I/O during benchmarks
- **Linux/macOS**: Best performance (Windows works but may have higher variance)

## Installation

### 1. Install Rust

If you don't have Rust installed:

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env
```

Verify installation:
```bash
rustc --version
cargo --version
```

### 2. Clone or Navigate to Repository

This repository should be alongside the main Hydroflow repository:

```bash
cd /projects/sandbox
ls -la
# Should show:
#   bigweaver-agent-canary-hydro-zeta/       (main repository)
#   bigweaver-agent-canary-zeta-hydro-deps/  (this repository)
```

### 3. Verify Repository Structure

```bash
cd bigweaver-agent-canary-zeta-hydro-deps
tree -L 2
```

Expected structure:
```
.
├── Cargo.toml
├── README.md
├── BENCHMARKING_GUIDE.md
├── FRAMEWORK_COMPARISON.md
├── SETUP.md
├── run_benchmarks.sh
├── src/
│   └── lib.rs
└── benches/
    ├── data/
    │   ├── reachability_edges.txt
    │   └── reachability_reachable.txt
    ├── identity_comparison.rs
    ├── join_comparison.rs
    ├── reachability_comparison.rs
    ├── fan_in_comparison.rs
    ├── fan_out_comparison.rs
    ├── fork_join_comparison.rs
    └── arithmetic_comparison.rs
```

## Building

### Initial Build

This will download and compile all dependencies (may take 10-30 minutes first time):

```bash
cargo build --release
```

**Note**: Timely and Differential Dataflow use heavy generics and will take significant time to compile. This is normal.

### Faster Compilation (Optional)

Use `sccache` for caching:

```bash
cargo install sccache
export RUSTC_WRAPPER=sccache
cargo build --release
```

### Check Build Without Full Compilation

```bash
cargo check
```

## Verification

### 1. Test Library Builds

```bash
cargo test
```

Expected output:
```
running 2 tests
test tests::test_generate_ints ... ok
test tests::test_generate_join_pairs ... ok
```

### 2. Verify Benchmarks Compile

```bash
cargo bench --no-run
```

This compiles benchmarks without running them.

### 3. Quick Benchmark Test

Run a single quick benchmark to verify everything works:

```bash
cargo bench --bench identity_comparison -- --quick
```

Expected output:
```
identity/timely        time:   [... ms ... ms ... ms]
identity/hydroflow/... time:   [... ms ... ms ... ms]
...
```

## Running Benchmarks

### Using the Helper Script

The easiest way to run benchmarks:

```bash
./run_benchmarks.sh
```

Options:
```bash
./run_benchmarks.sh --help           # Show help
./run_benchmarks.sh --quick          # Quick run
./run_benchmarks.sh --bench identity # Run specific benchmark
```

### Manual Commands

Run all benchmarks:
```bash
cargo bench
```

Run specific benchmark:
```bash
cargo bench --bench identity_comparison
```

Run with custom options:
```bash
cargo bench -- --sample-size 100
```

## Viewing Results

### HTML Reports

After running benchmarks:

```bash
# macOS
open target/criterion/report/index.html

# Linux
xdg-open target/criterion/report/index.html

# Or manually navigate to:
# target/criterion/report/index.html
```

### Command Line Summary

Criterion prints summary to terminal after each benchmark:
```
identity/timely        time:   [45.234 ms 45.891 ms 46.612 ms]
                       change: [-2.3456% +0.1234% +2.7890%] (p = 0.89)
```

## Troubleshooting

### Build Failures

#### Problem: "error: could not find `dfir_rs`"

**Solution**: Verify main repository exists:
```bash
ls -la ../bigweaver-agent-canary-hydro-zeta/dfir_rs
```

If missing, the path in Cargo.toml needs updating.

#### Problem: "error: linker `cc` not found"

**Solution**: Install C compiler:
```bash
# Ubuntu/Debian
sudo apt-get install build-essential

# macOS
xcode-select --install

# Fedora/RHEL
sudo dnf install gcc
```

#### Problem: Very slow compilation

**Solution**: This is expected for first build. Timely/Differential use heavy generics.

To speed up:
1. Use `sccache` (see above)
2. Use `--jobs` flag: `cargo build --jobs 4`
3. Close other applications

### Runtime Issues

#### Problem: "Segmentation fault" during benchmark

**Solution**: 
1. Ensure running in release mode: `cargo bench` (not `cargo test`)
2. Check available memory: benchmarks need 4GB+
3. Try smaller benchmark first: `cargo bench --bench fan_in_comparison`

#### Problem: Very high variance in results

**Solution**:
1. Close other applications
2. Disable CPU frequency scaling
3. Run more samples: `cargo bench -- --sample-size 100`
4. Check system isn't thermally throttling

#### Problem: Out of memory

**Solution**:
1. Close other applications
2. Run benchmarks individually
3. Reduce input sizes (edit benchmark files)

### Dependency Issues

#### Problem: Version conflicts

**Solution**:
```bash
cargo update
cargo clean
cargo build --release
```

#### Problem: "timely-master not found"

**Solution**: The package name might have changed. Check crates.io:
```bash
# Update to published version if needed
cargo search timely
```

## Performance Optimization

### For Most Accurate Results

```bash
# Set CPU governor to performance mode (Linux)
echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor

# Disable turbo boost for consistency (Linux)
echo 1 | sudo tee /sys/devices/system/cpu/intel_pstate/no_turbo

# Run benchmarks
cargo bench

# Restore normal settings
echo powersave | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
echo 0 | sudo tee /sys/devices/system/cpu/intel_pstate/no_turbo
```

### For Fastest Benchmarks

```bash
# Use native CPU optimizations
export RUSTFLAGS="-C target-cpu=native -C opt-level=3"
cargo bench
```

## Updating Dependencies

### Update All Dependencies

```bash
cargo update
```

### Update Specific Dependency

```bash
cargo update -p timely-master
cargo update -p differential-dataflow-master
```

### Use Latest Main Repository

If the main Hydroflow repository has updates:

```bash
cd ../bigweaver-agent-canary-hydro-zeta
git pull
cd ../bigweaver-agent-canary-zeta-hydro-deps
cargo clean
cargo build --release
```

## Development Workflow

### Adding a New Benchmark

1. Create file: `benches/my_benchmark_comparison.rs`
2. Add to `Cargo.toml`:
```toml
[[bench]]
name = "my_benchmark_comparison"
harness = false
```
3. Implement benchmark (see existing files as templates)
4. Test: `cargo bench --bench my_benchmark_comparison`

### Modifying Existing Benchmarks

1. Edit benchmark file in `benches/`
2. Rebuild: `cargo bench --no-run`
3. Run: `cargo bench --bench <name>`

### Testing Changes

```bash
# Quick check (doesn't run benchmarks)
cargo check

# Run tests
cargo test

# Quick benchmark run
cargo bench -- --quick
```

## CI/CD Integration

### GitHub Actions Example

```yaml
name: Benchmarks

on:
  push:
    branches: [ main ]

jobs:
  benchmark:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: actions-rs/toolchain@v1
        with:
          toolchain: stable
      - name: Run benchmarks
        run: cargo bench
      - name: Upload results
        uses: actions/upload-artifact@v2
        with:
          name: benchmark-results
          path: target/criterion/
```

## Best Practices

### Before Running Benchmarks

1. **Close unnecessary applications**
2. **Ensure system is cool** (check `sensors` output)
3. **Plug in laptop** (don't run on battery)
4. **Disable background tasks** (backups, indexing, etc.)
5. **Run multiple times** for consistency

### When Comparing Results

1. **Use same hardware** for all runs
2. **Save baselines** for comparison
3. **Document system state** (CPU freq, governor, etc.)
4. **Run multiple iterations**
5. **Check for statistical significance**

### Repository Maintenance

1. **Keep dependencies updated** regularly
2. **Document any changes** in benchmark implementations
3. **Verify correctness** with tests
4. **Archive old results** for historical comparison
5. **Update documentation** when adding benchmarks

## Getting Help

### Documentation

- This repository's documentation:
  - [README.md](README.md) - Overview
  - [BENCHMARKING_GUIDE.md](BENCHMARKING_GUIDE.md) - Detailed guide
  - [FRAMEWORK_COMPARISON.md](FRAMEWORK_COMPARISON.md) - Framework comparison

- Main repository:
  - [BENCHMARK_COMPARISON_ARCHIVE.md](../bigweaver-agent-canary-hydro-zeta/BENCHMARK_COMPARISON_ARCHIVE.md)

### External Resources

- [Criterion Documentation](https://bheisler.github.io/criterion.rs/book/)
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)
- [Hydroflow](https://hydro.run/)

### Common Commands Reference

```bash
# Build
cargo build --release          # Full build
cargo check                    # Quick check
cargo clean                    # Clean build artifacts

# Run
cargo bench                    # All benchmarks
cargo bench --bench NAME       # Specific benchmark
cargo bench -- --quick         # Quick mode
./run_benchmarks.sh           # Using helper script

# Test
cargo test                     # Run tests
cargo bench --no-run          # Compile benchmarks only

# Update
cargo update                   # Update dependencies
cargo update -p PACKAGE       # Update specific package

# Help
cargo bench -- --help          # Benchmark options
./run_benchmarks.sh --help    # Script options
```

## Verification Checklist

After setup, verify:

- [ ] Rust installed: `rustc --version`
- [ ] Repository structure correct
- [ ] Main repository exists at `../bigweaver-agent-canary-hydro-zeta`
- [ ] Dependencies build: `cargo build --release`
- [ ] Tests pass: `cargo test`
- [ ] Benchmarks compile: `cargo bench --no-run`
- [ ] Quick benchmark works: `cargo bench --bench identity_comparison -- --quick`
- [ ] Results viewable: Open `target/criterion/report/index.html`

## Next Steps

1. **Read the documentation**:
   - [README.md](README.md) for overview
   - [BENCHMARKING_GUIDE.md](BENCHMARKING_GUIDE.md) for details
   - [FRAMEWORK_COMPARISON.md](FRAMEWORK_COMPARISON.md) for framework comparison

2. **Run initial benchmarks**:
   ```bash
   ./run_benchmarks.sh --quick
   ```

3. **Explore results**:
   - Open HTML reports
   - Compare different implementations
   - Understand performance characteristics

4. **Start comparing**:
   - Run full benchmarks
   - Save baselines
   - Compare different configurations

## Support

If you encounter issues not covered in this guide:

1. Check the troubleshooting section above
2. Review the comprehensive [BENCHMARKING_GUIDE.md](BENCHMARKING_GUIDE.md)
3. Look at the main repository documentation
4. Check Criterion.rs documentation for benchmark-specific issues
