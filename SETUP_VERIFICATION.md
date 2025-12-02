# Setup Verification Guide

This document helps you verify that the bigweaver-agent-canary-zeta-hydro-deps repository is properly set up and ready to run benchmarks.

## Prerequisites Checklist

Before running benchmarks, ensure the following:

### 1. Repository Structure

Verify both repositories are cloned as siblings:

```bash
ls -la /path/to/parent-directory
```

Expected structure:
```
parent-directory/
├── bigweaver-agent-canary-hydro-zeta/      # Main Hydro repository
└── bigweaver-agent-canary-zeta-hydro-deps/  # This repository (benchmarks)
```

### 2. Rust Toolchain

Check Rust installation:

```bash
rustc --version
cargo --version
```

The Rust version should match the toolchain specified in the main repository's `rust-toolchain.toml`.

### 3. Workspace Members

Verify workspace configuration:

```bash
cd bigweaver-agent-canary-zeta-hydro-deps
cargo metadata --format-version 1 | grep -o '"name":"[^"]*"' | head -10
```

Expected workspace members:
- `benches` - Timely/differential benchmarks
- `hydro_test_examples` - Protocol examples

### 4. Dependencies Resolution

Test that all dependencies can be resolved:

```bash
cargo fetch
```

This should complete without errors.

## Build Verification

### Step 1: Check Workspace

```bash
cargo check --workspace
```

Expected: All packages compile successfully.

### Step 2: Build Benchmarks Package

```bash
cargo build -p benches
```

Expected: Build completes without errors.

### Step 3: Build Examples Package

```bash
cargo build -p hydro_test_examples
```

Expected: Build completes (may take several minutes for first build).

## Benchmark Verification

### Quick Smoke Test

Run a fast benchmark to verify the setup:

```bash
cargo bench -p benches --bench identity -- --sample-size 10
```

Expected: Benchmark runs and produces results.

### Data Files Verification

Check that benchmark data files exist:

```bash
ls -lh benches/benches/reachability_edges.txt
ls -lh benches/benches/reachability_reachable.txt
ls -lh benches/benches/words_alpha.txt
```

Expected sizes:
- `reachability_edges.txt`: ~532 KB
- `reachability_reachable.txt`: ~38 KB
- `words_alpha.txt`: ~3.8 MB

### Generated Files

Verify that build.rs generates necessary files:

```bash
cargo clean -p benches
cargo build -p benches
ls -la benches/benches/fork_join_*.hf
```

Expected: `fork_join_20.hf` should be generated.

## Common Issues and Solutions

### Issue: "Could not find dfir_rs"

**Cause**: Main repository not found or incorrect path.

**Solution**:
1. Verify both repositories are siblings
2. Check path dependencies in `benches/Cargo.toml`:
   ```toml
   dfir_rs = { path = "../../bigweaver-agent-canary-hydro-zeta/dfir_rs" }
   ```
3. Ensure the main repository is up-to-date: `cd ../bigweaver-agent-canary-hydro-zeta && git pull`

### Issue: "Could not find sinktools"

**Cause**: Main repository doesn't have the sinktools package or incorrect version.

**Solution**:
1. Check main repository has `sinktools/` directory
2. Update path in `benches/Cargo.toml` if structure changed

### Issue: Compilation Errors with timely/differential

**Cause**: Version mismatch or incompatible versions.

**Solution**:
1. Check `Cargo.lock` is up-to-date: `cargo update`
2. Verify versions in `benches/Cargo.toml`:
   ```toml
   timely = { package = "timely-master", version = "0.13.0-dev.1" }
   differential-dataflow = { package = "differential-dataflow-master", version = "0.13.0-dev.1" }
   ```

### Issue: Benchmark Results Highly Variable

**Cause**: System load or CPU frequency scaling.

**Solution**:
1. Close unnecessary applications
2. Disable CPU frequency scaling:
   ```bash
   echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
   ```
3. Run on a dedicated benchmark machine

### Issue: "Cannot find binary" when running examples

**Cause**: Examples not built yet.

**Solution**:
```bash
cargo build -p hydro_test_examples --examples
cargo run -p hydro_test_examples --example paxos
```

## Performance Baseline Check

### Expected Performance Ranges

After setup, run a baseline check to verify performance is reasonable:

```bash
cargo bench -p benches --bench arithmetic
```

Expected ranges (approximate, system-dependent):
- `arithmetic/pipeline`: ~50-200 ms
- `arithmetic/raw`: ~5-20 ms
- `arithmetic/iter`: ~5-20 ms
- `arithmetic/dfir`: ~20-100 ms
- `arithmetic/timely`: ~50-200 ms

If results are significantly outside these ranges, investigate:
- System performance (CPU throttling, background processes)
- Build configuration (debug vs release)
- Rust version compatibility

## Next Steps

Once verification is complete:

1. **Run Full Benchmark Suite**:
   ```bash
   cargo bench -p benches -- --save-baseline initial
   ```

2. **Review Results**:
   ```bash
   open target/criterion/report/index.html
   ```

3. **Document Baseline**:
   - Record system specifications
   - Save commit hashes of both repositories
   - Note Rust version used
   - Store initial baseline for future comparisons

4. **Begin Performance Comparison**:
   - See `BENCHMARK_GUIDE.md` for detailed comparison workflows
   - See `README.md` for overview and usage

## Verification Script

Create a quick verification script:

```bash
#!/bin/bash
# verify_setup.sh

echo "Verifying bigweaver-agent-canary-zeta-hydro-deps setup..."

# Check directory structure
if [ ! -d "../bigweaver-agent-canary-hydro-zeta" ]; then
    echo "❌ Main repository not found as sibling"
    exit 1
fi
echo "✓ Repository structure correct"

# Check Rust
if ! command -v cargo &> /dev/null; then
    echo "❌ Cargo not found"
    exit 1
fi
echo "✓ Rust toolchain installed"

# Check data files
if [ ! -f "benches/benches/words_alpha.txt" ]; then
    echo "❌ Benchmark data files missing"
    exit 1
fi
echo "✓ Data files present"

# Test build
if ! cargo check --workspace &> /dev/null; then
    echo "❌ Workspace check failed"
    exit 1
fi
echo "✓ Workspace builds successfully"

echo ""
echo "✓ Setup verification complete!"
echo "Run 'cargo bench -p benches' to execute benchmarks"
```

Save this as `verify_setup.sh`, make it executable (`chmod +x verify_setup.sh`), and run it to verify your setup.

## Support

If you encounter issues not covered here:
1. Check the main repository's CONTRIBUTING.md
2. Review recent commits for potential breaking changes
3. Consult with the Performance Engineering team
4. File an issue with:
   - Error messages
   - System specifications
   - Steps to reproduce
   - Output of `cargo --version` and `rustc --version`
