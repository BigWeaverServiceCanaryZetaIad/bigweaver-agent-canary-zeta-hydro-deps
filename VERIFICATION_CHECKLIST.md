# Verification Checklist

Use this checklist to verify that the benchmark repository is properly set up and functional.

## ✅ Repository Structure

- [ ] `Cargo.toml` exists in repository root
- [ ] `benches/Cargo.toml` exists
- [ ] `benches/benches/` directory contains 12 `.rs` files
- [ ] `benches/benches/` directory contains 3 data files (`.txt`)
- [ ] `rust-toolchain.toml` specifies Rust 1.91.1
- [ ] `README.md`, `BENCHMARK_GUIDE.md`, and `QUICK_START.md` exist

### Check Structure

```bash
cd /path/to/bigweaver-agent-canary-zeta-hydro-deps

# Verify workspace structure
ls -l Cargo.toml rust-toolchain.toml
ls -l benches/Cargo.toml benches/build.rs
ls benches/benches/*.rs | wc -l  # Should output: 12
ls benches/benches/*.txt | wc -l  # Should output: 3
```

## ✅ Benchmark Files

Verify all benchmark files exist:

- [ ] `benches/benches/arithmetic.rs`
- [ ] `benches/benches/fan_in.rs`
- [ ] `benches/benches/fan_out.rs`
- [ ] `benches/benches/fork_join.rs`
- [ ] `benches/benches/futures.rs`
- [ ] `benches/benches/identity.rs`
- [ ] `benches/benches/join.rs`
- [ ] `benches/benches/micro_ops.rs`
- [ ] `benches/benches/reachability.rs`
- [ ] `benches/benches/symmetric_hash_join.rs`
- [ ] `benches/benches/upcase.rs`
- [ ] `benches/benches/words_diamond.rs`

### Check Files

```bash
cd /path/to/bigweaver-agent-canary-zeta-hydro-deps
ls -1 benches/benches/*.rs
```

## ✅ Data Files

Verify test data files exist with correct sizes:

- [ ] `reachability_edges.txt` (~55,008 lines)
- [ ] `reachability_reachable.txt` (~7,855 lines)
- [ ] `words_alpha.txt` (~370,104 lines)

### Check Data Files

```bash
cd /path/to/bigweaver-agent-canary-zeta-hydro-deps

wc -l benches/benches/reachability_edges.txt
# Expected: 55008

wc -l benches/benches/reachability_reachable.txt
# Expected: 7855

wc -l benches/benches/words_alpha.txt
# Expected: 370104
```

## ✅ Rust Toolchain

- [ ] Rust 1.91.1 is installed
- [ ] `rustc`, `cargo`, `rustfmt`, and `clippy` are available

### Check Toolchain

```bash
rustc --version
# Expected: rustc 1.91.1 (c4c1663c1 2024-07-31)

cargo --version
# Expected: cargo 1.91.1 (...)

rustfmt --version
# Expected: rustfmt 1.7.0-stable (...)

cargo clippy --version
# Expected: clippy 0.1.91 (...)
```

## ✅ Dependencies

- [ ] Can fetch all dependencies from crates.io and GitHub
- [ ] `dfir_rs` from hydro-project/hydro is accessible
- [ ] `sinktools` from hydro-project/hydro is accessible
- [ ] `timely-master` and `differential-dataflow-master` are accessible

### Check Dependencies

```bash
cd /path/to/bigweaver-agent-canary-zeta-hydro-deps

# Fetch all dependencies (without building)
cargo fetch

# Should complete without errors
# If successful, dependencies are accessible
```

## ✅ Compilation

- [ ] Workspace compiles successfully
- [ ] All benchmarks compile
- [ ] Build script (`build.rs`) runs successfully
- [ ] Generated files (e.g., `fork_join_20.hf`) are created

### Check Compilation

```bash
cd /path/to/bigweaver-agent-canary-zeta-hydro-deps

# Clean previous builds
cargo clean

# Build in release mode (benchmarks use release profile)
cargo build --release

# Check for generated file
ls -l benches/benches/fork_join_20.hf

# Should exist after build
```

## ✅ Benchmark Execution

- [ ] Can run a simple benchmark (identity)
- [ ] Benchmark produces output
- [ ] HTML report is generated
- [ ] Results are in `target/criterion/`

### Run Test Benchmark

```bash
cd /path/to/bigweaver-agent-canary-zeta-hydro-deps

# Run a quick benchmark
cargo bench --bench identity

# Verify report was generated
ls target/criterion/identity/report/index.html

# Should exist
```

## ✅ Performance Comparison Capability

- [ ] Can save baseline results
- [ ] Can compare against baseline
- [ ] HTML reports show comparison data
- [ ] Multiple implementation variants run successfully

### Test Comparison

```bash
cd /path/to/bigweaver-agent-canary-zeta-hydro-deps

# Save baseline
cargo bench --bench arithmetic -- --save-baseline test

# Verify baseline was saved
ls target/criterion/arithmetic/dfir_rs_compiled/base/

# Should contain estimates.json

# Run comparison
cargo bench --bench arithmetic -- --baseline test

# Should show "Performance has..." messages
```

## ✅ Documentation

- [ ] README.md contains repository overview
- [ ] README.md documents all benchmarks
- [ ] BENCHMARK_GUIDE.md contains comprehensive guide
- [ ] BENCHMARK_GUIDE.md documents performance comparison process
- [ ] QUICK_START.md provides quick setup instructions
- [ ] benches/README.md documents benchmark usage

### Check Documentation

```bash
cd /path/to/bigweaver-agent-canary-zeta-hydro-deps

# Verify all documentation files exist
ls -l README.md BENCHMARK_GUIDE.md QUICK_START.md
ls -l benches/README.md

# Check README contains key sections
grep -i "quick start" README.md
grep -i "available benchmarks" README.md
grep -i "performance comparison" README.md
```

## ✅ Git Configuration

- [ ] `.gitignore` exists and includes target/, Cargo.lock, criterion/
- [ ] Generated files are ignored (fork_join_*.hf)
- [ ] IDE and OS files are ignored

### Check Git Configuration

```bash
cd /path/to/bigweaver-agent-canary-zeta-hydro-deps

# Verify .gitignore exists
cat .gitignore

# Should contain:
# - /target/
# - Cargo.lock
# - criterion/
# - benches/benches/fork_join_*.hf
```

## ✅ Code Quality Tools

- [ ] `rustfmt.toml` exists and matches main Hydro repository
- [ ] `clippy.toml` exists and matches main Hydro repository
- [ ] Code passes `cargo fmt --check`
- [ ] Code passes `cargo clippy`

### Check Code Quality

```bash
cd /path/to/bigweaver-agent-canary-zeta-hydro-deps

# Check formatting
cargo fmt --check

# Run clippy
cargo clippy --all-targets

# Should have no errors
```

## ✅ Integration with Main Hydro Repository

- [ ] Dependencies reference correct git repository (hydro-project/hydro)
- [ ] Can update to latest hydro commit
- [ ] Benchmarks still compile after hydro update

### Test Integration

```bash
cd /path/to/bigweaver-agent-canary-zeta-hydro-deps

# Update hydro dependencies
cargo update -p dfir_rs
cargo update -p sinktools

# Verify benchmarks still compile
cargo bench --bench identity --no-run

# Should compile successfully
```

## 🎯 Complete Verification

Run this comprehensive test:

```bash
#!/bin/bash
cd /path/to/bigweaver-agent-canary-zeta-hydro-deps

echo "=== Verification Script ==="

echo "1. Checking structure..."
test -f Cargo.toml && echo "✓ Cargo.toml exists" || echo "✗ Cargo.toml missing"
test -f benches/Cargo.toml && echo "✓ benches/Cargo.toml exists" || echo "✗ benches/Cargo.toml missing"

echo "2. Counting benchmark files..."
BENCH_COUNT=$(ls benches/benches/*.rs 2>/dev/null | wc -l)
test "$BENCH_COUNT" -eq 12 && echo "✓ All 12 benchmark files present" || echo "✗ Expected 12, found $BENCH_COUNT"

echo "3. Checking data files..."
test -f benches/benches/reachability_edges.txt && echo "✓ reachability_edges.txt exists" || echo "✗ reachability_edges.txt missing"
test -f benches/benches/reachability_reachable.txt && echo "✓ reachability_reachable.txt exists" || echo "✗ reachability_reachable.txt missing"
test -f benches/benches/words_alpha.txt && echo "✓ words_alpha.txt exists" || echo "✗ words_alpha.txt missing"

echo "4. Checking Rust toolchain..."
rustc --version | grep -q "1.91.1" && echo "✓ Rust 1.91.1 installed" || echo "✗ Wrong Rust version"

echo "5. Testing compilation..."
cargo check --quiet 2>&1 && echo "✓ Compiles successfully" || echo "✗ Compilation failed"

echo "6. Testing benchmark execution..."
cargo bench --bench identity -- --sample-size 5 > /dev/null 2>&1 && echo "✓ Benchmark runs successfully" || echo "✗ Benchmark failed"

echo "7. Checking documentation..."
test -f README.md && echo "✓ README.md exists" || echo "✗ README.md missing"
test -f BENCHMARK_GUIDE.md && echo "✓ BENCHMARK_GUIDE.md exists" || echo "✗ BENCHMARK_GUIDE.md missing"
test -f QUICK_START.md && echo "✓ QUICK_START.md exists" || echo "✗ QUICK_START.md missing"

echo "=== Verification Complete ==="
```

Save this as `verify.sh`, make it executable, and run:

```bash
chmod +x verify.sh
./verify.sh
```

## Expected Results

All items should have ✓ checkmarks. If any items are ✗:

1. Review the specific section above for that item
2. Check the error messages carefully
3. Consult QUICK_START.md or BENCHMARK_GUIDE.md for troubleshooting
4. Ensure all dependencies are accessible (network connectivity)

## Common Issues

### Issue: Can't fetch git dependencies

**Solution:** Check GitHub access and network connectivity
```bash
ssh -T git@github.com
# Or use HTTPS:
git config --global url."https://github.com/".insteadOf "git@github.com:"
```

### Issue: Wrong Rust version

**Solution:** The repository should auto-select 1.91.1 via rust-toolchain.toml
```bash
rustup show
# Should show 1.91.1
```

### Issue: Compilation errors

**Solution:** Try clean build
```bash
cargo clean
cargo build --release
```

### Issue: Benchmarks don't run

**Solution:** Check if compilation succeeded first
```bash
cargo bench --bench identity --no-run
# If this fails, fix compilation first
```

## Success Criteria

The repository is properly set up when:

✅ All benchmark files compile without errors  
✅ At least one benchmark runs successfully  
✅ HTML reports are generated in target/criterion/  
✅ All data files are present with correct line counts  
✅ Documentation is complete and accessible  
✅ Code quality checks pass (fmt, clippy)  

---

*Last Updated: 2025-11-30*
