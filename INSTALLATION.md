# Installation Guide

This guide walks you through setting up the timely and differential-dataflow benchmarks.

## Prerequisites

### System Requirements

- **OS**: Linux, macOS, or Windows (with WSL2)
- **RAM**: 4GB minimum, 8GB+ recommended
- **Disk**: 2GB free space
- **CPU**: Multi-core recommended for parallel benchmarks

### Required Software

1. **Rust** (1.70 or later)
2. **Cargo** (comes with Rust)
3. **Git**

## Step 1: Install Rust

### Linux and macOS

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

Follow the prompts. After installation:

```bash
source $HOME/.cargo/env
```

### Windows

Download and run [rustup-init.exe](https://rustup.rs/)

### Verify Installation

```bash
rustc --version
cargo --version
```

Expected output:
```
rustc 1.70.0 (or later)
cargo 1.70.0 (or later)
```

## Step 2: Clone Repository

```bash
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps
```

## Step 3: Verify Setup

Run the validation script:

```bash
./setup-validation.sh
```

This will:
- ✓ Check Rust installation
- ✓ Validate repository structure
- ✓ Build all packages
- ✓ Run tests
- ✓ Verify benchmarks compile

Expected output:
```
=====================================
Benchmark Repository Validation
=====================================

✓ Rust found: rustc 1.70.0
✓ Cargo found: cargo 1.70.0
✓ Found: Cargo.toml
✓ Found: README.md
...
✓ All validation checks passed!
=====================================
```

## Step 4: Build Packages

```bash
# Build in debug mode
cargo build --all

# Build with optimizations
cargo build --all --release
```

## Step 5: Run Tests

```bash
# Run all tests
cargo test --all

# Or use Make
make test
```

## Step 6: Run Benchmarks

### Quick Test Run

```bash
# Fast run for testing
make bench-quick

# Or manually
cargo bench --all -- --quick
```

### Full Benchmark Run

```bash
# Run all benchmarks
make bench

# Or manually
cargo bench --all
```

### Specific Package

```bash
# Timely only
make bench-timely

# Differential only
make bench-differential
```

## Step 7: View Results

Benchmark results are generated in `target/criterion/`

```bash
# Open HTML report (Linux)
xdg-open target/criterion/report/index.html

# Open HTML report (macOS)
open target/criterion/report/index.html

# Or use Make
make view-results
```

## Troubleshooting

### Issue: "cargo: command not found"

**Solution**: Add Cargo to PATH

```bash
echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

### Issue: Build Fails with Linker Errors

**Solution**: Install build essentials

```bash
# Ubuntu/Debian
sudo apt-get install build-essential

# Fedora/RHEL
sudo dnf install gcc

# macOS
xcode-select --install
```

### Issue: Out of Memory During Build

**Solution**: Build sequentially

```bash
cargo build --all -j 1
```

### Issue: Benchmarks Take Too Long

**Solution**: Use quick mode

```bash
cargo bench --all -- --quick
```

Or reduce sample sizes by editing benchmark files.

### Issue: Permission Denied on Scripts

**Solution**: Make scripts executable

```bash
chmod +x run-benchmarks.sh setup-validation.sh
```

## Configuration

### Environment Variables

```bash
# Set worker thread count
export TIMELY_WORKER_THREADS=4

# Enable debug logging
export RUST_LOG=timely=debug,differential_dataflow=debug

# Then run benchmarks
cargo bench
```

### Custom Criterion Settings

Edit benchmark files to modify:
- Sample size
- Measurement time
- Warm-up time

See `BENCHMARKING.md` for details.

## Updating Dependencies

```bash
# Update to latest compatible versions
cargo update

# Check for outdated dependencies
cargo outdated

# Update to latest versions (may break)
cargo upgrade
```

## IDE Setup

### Visual Studio Code

1. Install extensions:
   - rust-analyzer
   - CodeLLDB (for debugging)
   - Better TOML

2. Configure workspace:
   ```json
   {
     "rust-analyzer.cargo.features": "all",
     "rust-analyzer.checkOnSave.command": "clippy"
   }
   ```

### IntelliJ IDEA / CLion

1. Install Rust plugin
2. Open project root
3. Wait for indexing to complete

### Vim/Neovim

1. Install rust.vim
2. Configure rust-analyzer LSP
3. Add key bindings for cargo commands

## Performance Tuning

### For Best Results

1. **Close Background Applications**
   ```bash
   # Check CPU usage
   top
   
   # Close unnecessary processes
   ```

2. **Disable CPU Frequency Scaling** (Linux)
   ```bash
   echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
   ```

3. **Increase Process Priority**
   ```bash
   sudo nice -n -10 cargo bench
   ```

4. **Use Release Mode**
   ```bash
   cargo bench  # Already uses release mode
   ```

## Next Steps

After successful installation:

1. **Read Documentation**
   - `README.md` - Overview
   - `BENCHMARKING.md` - Detailed guide
   - `COMPARISON.md` - Performance comparisons

2. **Explore Benchmarks**
   ```bash
   # List all benchmarks
   cargo bench --all -- --list
   
   # Run specific benchmark
   cargo bench --bench barrier
   ```

3. **Start Contributing**
   - Read `CONTRIBUTING.md`
   - Add new benchmarks
   - Improve existing ones

## Uninstallation

To remove the project:

```bash
# Remove project directory
rm -rf bigweaver-agent-canary-zeta-hydro-deps

# Optionally remove Rust
rustup self uninstall
```

## Getting Help

- **Documentation**: Check `.md` files in repository
- **Issues**: Open issue on GitHub
- **Community**: 
  - [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
  - [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)

## Verification Checklist

After installation, verify:

- [ ] Rust installed (`rustc --version`)
- [ ] Cargo installed (`cargo --version`)
- [ ] Repository cloned
- [ ] Builds successfully (`cargo build --all`)
- [ ] Tests pass (`cargo test --all`)
- [ ] Benchmarks compile (`cargo bench --all --no-run`)
- [ ] Quick benchmark runs (`cargo bench -- --quick`)
- [ ] HTML reports generated

If all checks pass: ✅ Installation complete!

## Resources

- [Rust Book](https://doc.rust-lang.org/book/)
- [Cargo Book](https://doc.rust-lang.org/cargo/)
- [Criterion.rs Guide](https://bheisler.github.io/criterion.rs/book/)
- [Timely Documentation](https://docs.rs/timely/)
- [Differential Documentation](https://docs.rs/differential-dataflow/)
