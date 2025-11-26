# Quick Start Guide

## Prerequisites

1. **Rust toolchain** - Install from https://rustup.rs/ or ensure cargo is in your PATH
2. **Companion repository** - Ensure `bigweaver-agent-canary-hydro-zeta` is cloned at `../bigweaver-agent-canary-hydro-zeta`

## Verify Setup

Run the verification script to ensure everything is in place:

```bash
./verify_setup.sh
```

Expected output: All checks should pass with ✓ marks.

## Build the Benchmarks

```bash
cargo build -p benches
```

This will:
- Download and compile all dependencies (timely, differential-dataflow, etc.)
- Build all 12 benchmark files
- Run the build.rs script to generate fork_join code

## Run All Benchmarks

```bash
cargo bench -p benches
```

⚠️ **Note**: Running all benchmarks will take considerable time (potentially hours) as it includes:
- 7 timely comparative benchmarks
- 1 differential-dataflow comparative benchmark
- 4 Hydro-specific benchmarks

## Run Specific Benchmarks

### Quick Test Run

Run a single benchmark for testing:

```bash
cargo bench -p benches --bench micro_ops
```

### Run by Category

**Timely benchmarks only:**
```bash
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench fan_in
cargo bench -p benches --bench fan_out
cargo bench -p benches --bench fork_join
cargo bench -p benches --bench identity
cargo bench -p benches --bench join
cargo bench -p benches --bench upcase
```

**Differential-dataflow benchmark:**
```bash
cargo bench -p benches --bench reachability
```

**Hydro-specific benchmarks:**
```bash
cargo bench -p benches --bench micro_ops
cargo bench -p benches --bench futures
cargo bench -p benches --bench symmetric_hash_join
cargo bench -p benches --bench words_diamond
```

## View Benchmark Results

After running benchmarks, view the HTML reports:

```bash
# Open in browser (Linux)
xdg-open target/criterion/index.html

# Open in browser (macOS)
open target/criterion/index.html

# Or navigate to: target/criterion/<benchmark-name>/report/index.html
```

## Troubleshooting

### Error: "package not found"

**Problem**: cargo can't find dfir_rs or sinktools

**Solution**: Ensure `bigweaver-agent-canary-hydro-zeta` repository is at the correct location:
```bash
ls ../bigweaver-agent-canary-hydro-zeta/dfir_rs
ls ../bigweaver-agent-canary-hydro-zeta/sinktools
```

If not present, clone it:
```bash
cd ..
git clone <repository-url> bigweaver-agent-canary-hydro-zeta
cd bigweaver-agent-canary-zeta-hydro-deps
```

### Error: "failed to download"

**Problem**: Network issues downloading timely or differential-dataflow

**Solution**: 
- Check internet connection
- Try again with verbose output: `cargo build -p benches -v`
- Check if crates.io is accessible

### Slow Build Times

**Expected**: First build will be slow as it compiles:
- timely-dataflow (large dependency)
- differential-dataflow (large dependency)
- All benchmark code

**Tips**:
- Use `cargo build --release -p benches` for optimized builds
- Subsequent builds will be much faster due to caching
- Use `cargo check -p benches` for faster validation without full compilation

### Benchmarks Take Too Long

**Solution**: Run a subset of benchmarks:
```bash
# Run just one benchmark
cargo bench -p benches --bench micro_ops

# Run with shorter execution time (faster but less accurate)
cargo bench -p benches --bench micro_ops -- --quick
```

## Understanding Results

Each benchmark generates:
1. **Console output** - Summary statistics (mean, median, std dev)
2. **HTML reports** - Detailed charts and comparisons in `target/criterion/`
3. **Baseline comparisons** - Compares against previous runs if available

### Interpreting Comparative Benchmarks

Benchmarks like `arithmetic`, `fan_in`, etc. include multiple implementations:
- `arithmetic/raw` - Raw Rust baseline
- `arithmetic/dfir` - Hydro (dfir_rs) implementation
- `arithmetic/timely` - Timely dataflow implementation

Compare these to see relative performance.

## Next Steps

1. **Run initial baseline**:
   ```bash
   cargo bench -p benches
   ```
   This establishes baseline for future comparisons.

2. **Make changes** to dfir_rs in the main repository

3. **Re-run benchmarks**:
   ```bash
   cargo bench -p benches
   ```
   Criterion will automatically compare to baseline.

4. **Review performance impact** in the generated HTML reports

## Configuration

### Changing Number of Operations

Edit `benches/build.rs`:
```rust
const NUM_OPS: usize = 20;  // Change this value
```

Then rebuild:
```bash
cargo clean -p benches
cargo build -p benches
```

### Adjusting Benchmark Parameters

Edit individual benchmark files in `benches/benches/`:
- Look for `const NUM_OPS`, `const NUM_INTS`, etc.
- Modify values as needed
- Rebuild and re-run benchmarks

## Resources

- Full documentation: [README.md](README.md)
- Implementation details: [IMPLEMENTATION_SUMMARY.md](IMPLEMENTATION_SUMMARY.md)
- Benchmark-specific docs: [benches/README.md](benches/README.md)
- Criterion.rs docs: https://bheisler.github.io/criterion.rs/book/

## Common Commands Reference

```bash
# Build everything
cargo build -p benches

# Check for errors without full build
cargo check -p benches

# Run all benchmarks
cargo bench -p benches

# Run specific benchmark
cargo bench -p benches --bench <name>

# Run benchmarks matching pattern
cargo bench -p benches -- <pattern>

# Clean build artifacts
cargo clean

# Update dependencies
cargo update

# View dependency tree
cargo tree -p benches

# Format code
cargo fmt -p benches

# Run linter
cargo clippy -p benches
```

## Getting Help

- Check [README.md](README.md) for comprehensive documentation
- Review [IMPLEMENTATION_SUMMARY.md](IMPLEMENTATION_SUMMARY.md) for technical details
- Run `./verify_setup.sh` to diagnose setup issues
- Check benchmark-specific documentation in individual `.rs` files
