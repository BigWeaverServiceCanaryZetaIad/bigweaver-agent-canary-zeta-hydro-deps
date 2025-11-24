# Quick Start Guide

## Overview

This guide will help you get started with running benchmarks in the bigweaver-agent-canary-zeta-hydro-deps repository.

## Prerequisites

### 1. Rust Toolchain

Ensure you have Rust installed. The project uses the toolchain specified in the main repository.

```bash
# Check if Rust is installed
rustc --version
cargo --version

# If not installed, install Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env
```

### 2. Main Repository

This repository depends on the main `bigweaver-agent-canary-hydro-zeta` repository for `dfir_rs` and `sinktools` crates.

**Required directory structure**:
```
/projects/sandbox/
├── bigweaver-agent-canary-hydro-zeta/  (main repository)
└── bigweaver-agent-canary-zeta-hydro-deps/  (this repository)
```

Verify the main repository is available:
```bash
ls ../bigweaver-agent-canary-hydro-zeta
```

If the main repository is not in the expected location, you'll need to either:
- Move this repository to be adjacent to the main repository, or
- Update the path dependencies in `Cargo.toml`

## Verification

### 1. Check Compilation

Verify all benchmarks compile without running them:

```bash
cargo check --benches
```

Expected output:
```
   Compiling bigweaver-agent-canary-zeta-hydro-deps v0.1.0
    Finished dev [unoptimized + debuginfo] target(s) in X.XXs
```

### 2. Build Benchmarks

Build benchmarks in release mode (without running):

```bash
cargo bench --no-run
```

This compiles all benchmarks but doesn't execute them.

## Running Your First Benchmark

### Simple Identity Benchmark

The identity benchmark is the simplest and fastest:

```bash
cargo bench --bench identity
```

Expected output:
```
running 5 tests
test identity/dfir_rs/compiled     ... bench:      XX,XXX ns/iter
test identity/timely               ... bench:      XX,XXX ns/iter
...
```

This should complete in under a minute.

### Arithmetic Benchmark

A more comprehensive benchmark with multiple implementations:

```bash
cargo bench --bench arithmetic
```

This benchmark compares:
- Hydro (compiled, surface syntax)
- Timely dataflow
- Raw Rust implementations
- Iterator chains

Runtime: ~2-5 minutes depending on your system.

## Quick Reference Commands

### Run All Benchmarks

```bash
# Run complete benchmark suite (takes ~15-30 minutes)
cargo bench
```

### Run Specific Benchmark

```bash
# Run just one benchmark file
cargo bench --bench reachability
```

### Run Benchmarks Matching Pattern

```bash
# Run all benchmarks with "join" in the name
cargo bench join

# Run all dfir_rs benchmarks
cargo bench dfir_rs
```

### Quick Test Run (Faster)

For development, use smaller sample sizes:

```bash
# Reduce sample size for faster results
cargo bench -- --sample-size 10

# Combine with shorter measurement time
cargo bench -- --sample-size 10 --measurement-time 1
```

## Viewing Results

### Console Output

Results are printed to console:
```
arithmetic/dfir_rs/compiled
                        time:   [123.45 µs 124.67 µs 125.89 µs]
```

- First value: lower confidence bound
- Second value: estimate
- Third value: upper confidence bound

### HTML Reports

Detailed HTML reports are automatically generated:

```bash
# Open the main report index
open target/criterion/report/index.html

# Or on Linux
xdg-open target/criterion/report/index.html
```

HTML reports include:
- Violin plots showing distribution
- Line charts showing history
- Statistical analysis
- Outlier detection

### Report Location

All reports are saved in:
```
target/criterion/<benchmark-name>/report/index.html
```

For example:
```
target/criterion/arithmetic/report/index.html
target/criterion/reachability/report/index.html
```

## Benchmark Overview

### Fast Benchmarks (< 1 minute)
- `identity` - Minimal overhead benchmark
- `fan_in` - Fan-in pattern
- `fan_out` - Fan-out pattern

### Medium Benchmarks (1-5 minutes)
- `arithmetic` - Arithmetic operations
- `fork_join` - Fork-join pattern
- `join` - Join operations
- `upcase` - String processing

### Slower Benchmarks (5-10 minutes)
- `reachability` - Graph algorithms
- `micro_ops` - Detailed operation benchmarks
- `symmetric_hash_join` - Complex join patterns
- `words_diamond` - Large data processing

### Async Benchmarks
- `futures` - Async/await performance

## Common Issues and Solutions

### Issue: "error: could not find `Cargo.toml`"

**Solution**: Make sure you're in the correct directory
```bash
cd /projects/sandbox/bigweaver-agent-canary-zeta-hydro-deps
```

### Issue: "error: failed to select a version for `dfir_rs`"

**Solution**: Ensure the main repository is in the correct location
```bash
ls ../bigweaver-agent-canary-hydro-zeta/dfir_rs
```

### Issue: Benchmarks take too long

**Solution**: Use smaller sample sizes
```bash
cargo bench -- --sample-size 10 --measurement-time 1
```

### Issue: High variance in results

**Solution**: 
1. Close other applications
2. Ensure system is not under load
3. Run multiple times and check consistency
4. Increase sample size for more accuracy:
```bash
cargo bench -- --sample-size 100
```

### Issue: Compilation errors

**Solution**:
1. Verify Rust version matches main repository requirements
2. Clean and rebuild:
```bash
cargo clean
cargo check --benches
```
3. Update dependencies:
```bash
cargo update
```

## Next Steps

After running your first benchmarks:

1. **Review Documentation**:
   - Read `BENCHMARK_GUIDE.md` for detailed benchmark information
   - Read `PERFORMANCE_COMPARISON.md` for comparison strategies
   - Check `README.md` for comprehensive overview

2. **Explore Results**:
   - Open HTML reports
   - Compare different implementations
   - Note performance characteristics

3. **Run Comprehensive Suite**:
   ```bash
   cargo bench
   ```

4. **Set Up Baselines** (if making changes):
   ```bash
   cargo bench -- --save-baseline initial
   ```

## Useful Scripts

### Quick Check Script

Create `quick_check.sh`:
```bash
#!/bin/bash
echo "Checking benchmark compilation..."
cargo check --benches
echo "Running quick benchmark test..."
cargo bench --bench identity -- --sample-size 10
echo "Quick check complete!"
```

### Full Benchmark Script

Create `run_all_benchmarks.sh`:
```bash
#!/bin/bash
echo "Running full benchmark suite..."
cargo bench 2>&1 | tee benchmark_results.txt
echo "Results saved to benchmark_results.txt"
echo "HTML reports: target/criterion/report/index.html"
```

Make scripts executable:
```bash
chmod +x quick_check.sh run_all_benchmarks.sh
```

## Getting Help

If you encounter issues:

1. Check `BENCHMARK_GUIDE.md` for detailed troubleshooting
2. Review `README.md` for setup requirements
3. Verify the main repository is properly set up
4. Ensure all dependencies are installed

## Performance Tips

### For Accurate Measurements

1. **Consistent Environment**:
   - Close unnecessary applications
   - Disable CPU frequency scaling if possible
   - Ensure adequate cooling

2. **Multiple Runs**:
   ```bash
   cargo bench
   cargo bench
   cargo bench
   ```

3. **Baseline Comparison**:
   ```bash
   cargo bench -- --save-baseline baseline
   # Make changes...
   cargo bench -- --baseline baseline
   ```

### For Quick Development Iteration

1. **Small Sample Sizes**:
   ```bash
   cargo bench -- --sample-size 10
   ```

2. **Specific Benchmarks**:
   ```bash
   cargo bench --bench identity
   ```

3. **Pattern Matching**:
   ```bash
   cargo bench dfir_rs
   ```

## Example Session

Here's a typical first-time session:

```bash
# Navigate to repository
cd /projects/sandbox/bigweaver-agent-canary-zeta-hydro-deps

# Verify setup
cargo check --benches

# Run a simple benchmark
cargo bench --bench identity

# View results
open target/criterion/report/index.html

# Run a more complex benchmark
cargo bench --bench arithmetic

# Save baseline for future comparison
cargo bench -- --save-baseline initial_run

# Run full suite (optional, takes longer)
cargo bench
```

## Summary

You're now ready to run benchmarks! Start with:

```bash
# Quick verification
cargo check --benches

# First benchmark
cargo bench --bench identity

# View results
open target/criterion/report/index.html
```

For more detailed information, see:
- `BENCHMARK_GUIDE.md` - Comprehensive benchmark documentation
- `PERFORMANCE_COMPARISON.md` - Performance analysis guide
- `README.md` - Repository overview

---

**Last Updated**: November 24, 2024  
**Maintained By**: BigWeaverServiceCanaryZetaIad Team
