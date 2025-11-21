# Setup and Verification Guide

This guide will help you set up and verify the benchmark suite after the migration.

## Prerequisites

### Required Software
- **Rust**: 1.75.0 or later (stable channel)
- **Git**: For cloning and version control
- **Cargo**: Included with Rust

### Installing Rust
```bash
# Using rustup (recommended)
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Verify installation
rustc --version
cargo --version
```

## Initial Setup

### 1. Clone the Repository
```bash
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps
```

### 2. Verify Repository Structure
```bash
# Check that all files are present
ls -la
ls -la benches/
ls -la benches/benches/
ls -la .github/workflows/
```

Expected structure:
```
.
├── .github/
│   └── workflows/
│       └── benchmark.yml
├── benches/
│   ├── benches/
│   │   ├── *.rs (12 benchmark files)
│   │   ├── *.txt (3 test data files)
│   │   └── .gitignore
│   ├── Cargo.toml
│   ├── README.md
│   └── build.rs
├── .gitignore
├── BENCHMARKS.md
├── Cargo.toml
├── MIGRATION_GUIDE.md
├── README.md
└── SETUP.md
```

### 3. Fetch Dependencies
```bash
# This will download all required crates
cargo fetch
```

This may take a while as it downloads:
- dfir_rs from the main repository
- timely-master
- differential-dataflow-master
- criterion and other dev dependencies

## Verification Steps

### Step 1: Check Compilation
```bash
# Check if the code compiles without running
cargo check --workspace
```

**Expected**: No compilation errors
**Time**: 5-10 minutes first run (downloads and compiles dependencies)

### Step 2: Build Benchmarks
```bash
# Build all benchmarks in release mode
cargo bench --no-run -p benches
```

**Expected**: All benchmarks compile successfully
**Time**: 10-15 minutes first run

### Step 3: Run Quick Test
```bash
# Run the simplest benchmark to verify functionality
cargo bench -p benches --bench identity -- --quick
```

**Expected**: 
- Benchmark runs successfully
- Shows timing results for all implementations
- No errors or panics

**Output should include**:
```
identity/timely         time:   [...]
identity/dfir/scheduled time:   [...]
identity/dfir/surface   time:   [...]
```

### Step 4: Run Full Benchmark
```bash
# Run one complete benchmark
cargo bench -p benches --bench reachability
```

**Expected**:
- All variants run successfully
- Results match expected correctness (assertions pass)
- HTML report generated in `target/criterion/`

**Time**: 2-5 minutes

### Step 5: Verify Test Data
```bash
# Check test data files are readable
wc -l benches/benches/*.txt
```

**Expected output**:
```
  50000 benches/benches/reachability_edges.txt
   4731 benches/benches/reachability_reachable.txt
 370105 benches/benches/words_alpha.txt
```

### Step 6: Check Criterion Output
```bash
# Verify HTML reports are generated
ls -la target/criterion/

# View the report (on systems with a browser)
open target/criterion/report/index.html  # macOS
xdg-open target/criterion/report/index.html  # Linux
```

## Troubleshooting

### Issue: Compilation Errors

#### Symptom
```
error[E0433]: failed to resolve: use of undeclared crate or module `dfir_rs`
```

#### Solution
Check that dfir_rs dependency is correctly specified:
```bash
grep -A 2 "dfir_rs" benches/Cargo.toml
```

Should show:
```toml
dfir_rs = { git = "https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git", features = [ "debugging" ] }
```

#### Alternative: Use specific branch/tag
If main branch is unstable, pin to a specific version:
```toml
dfir_rs = { 
    git = "https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git", 
    tag = "v0.14.0",  # Or appropriate tag
    features = [ "debugging" ] 
}
```

### Issue: Build Takes Too Long

#### Symptom
Compilation appears stuck or takes >30 minutes

#### Solution
1. Check your network connection (git dependencies download)
2. Ensure adequate disk space (3+ GB for target directory)
3. Use release mode sparingly during development:
   ```bash
   cargo check  # Faster than cargo build
   ```

### Issue: Benchmark Fails with Assertion Error

#### Symptom
```
thread 'main' panicked at 'assertion failed: ...'
```

#### Solution
This usually means correctness checks failed, indicating a real bug:
1. Check which benchmark failed
2. Verify test data files are not corrupted
3. Check dfir_rs version compatibility
4. File an issue with details

### Issue: Missing `timely-master` or `differential-dataflow-master`

#### Symptom
```
error: no matching package named `timely-master` found
```

#### Solution
These are non-standard package names. Ensure your Cargo.toml has:
```toml
timely = { package = "timely-master", version = "0.13.0-dev.1" }
differential-dataflow = { package = "differential-dataflow-master", version = "0.13.0-dev.1" }
```

If still failing, these packages may not be available. Update to:
```toml
timely = "0.12"  # Use released version
differential-dataflow = "0.12"
```

### Issue: Performance Results Seem Wrong

#### Symptom
Unexpected performance characteristics or ordering

#### Possible Causes
1. **Debug mode**: Ensure using `cargo bench` not `cargo test`
2. **System load**: Close other applications
3. **CPU frequency scaling**: May need to disable
4. **Insufficient warmup**: Criterion handles this, but very first run may be off
5. **Small dataset**: Some benchmarks use small inputs for quick tests

#### Verification
```bash
# Check build mode
cargo bench -p benches --bench identity -v | grep -i profile

# Should show "release" profile
```

## Running the Full Suite

### All Benchmarks
```bash
# This will take 30-60 minutes
cargo bench -p benches
```

### Specific Categories
```bash
# Only DFIR benchmarks
cargo bench -p benches -- dfir

# Only micro operations
cargo bench -p benches -- micro/ops

# Specific benchmark
cargo bench -p benches --bench reachability
```

### Custom Configuration
```bash
# Adjust sample size and measurement time
cargo bench -p benches -- --sample-size 100 --measurement-time 10

# Save baseline for comparison
cargo bench -p benches -- --save-baseline my-baseline

# Compare to baseline
cargo bench -p benches -- --baseline my-baseline
```

## CI/CD Verification

### Local Workflow Test
You can't run GitHub Actions locally, but verify the workflow file:

```bash
# Check workflow syntax
cat .github/workflows/benchmark.yml

# Verify it references correct package
grep "cargo bench" .github/workflows/benchmark.yml
```

### Triggering on GitHub
1. **Push with tag**: Include `[ci-bench]` in commit message
2. **Pull request**: Include `[ci-bench]` in PR title or body
3. **Manual trigger**: Use GitHub Actions UI

## Performance Baseline

After successful setup, establish a baseline:

```bash
# Run full suite and save baseline
cargo bench -p benches -- --save-baseline initial

# Results will be in target/criterion/
```

This baseline helps detect:
- Performance regressions
- Impact of code changes
- System variations

## Next Steps

After successful setup:

1. **Review BENCHMARKS.md**: Understand what each benchmark measures
2. **Check MIGRATION_GUIDE.md**: Learn about the migration details
3. **Read benchmark source code**: See implementation details
4. **Run specific benchmarks**: Focus on areas of interest
5. **Contribute improvements**: Add new benchmarks or optimize existing ones

## Getting Help

If you encounter issues not covered here:

1. **Check existing issues**: https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps/issues
2. **File a new issue**: Include:
   - Full error message
   - Output of `rustc --version` and `cargo --version`
   - Steps to reproduce
   - Your operating system
3. **Reference main repository**: Issues may be in dfir_rs itself

## System Requirements

### Minimum
- 4 GB RAM
- 10 GB disk space
- 2 CPU cores
- Modern OS (Linux, macOS, Windows)

### Recommended
- 8+ GB RAM
- 20 GB disk space (for multiple builds/baselines)
- 4+ CPU cores
- Linux or macOS for best performance

### Note on Performance
Benchmark results are sensitive to:
- System load
- CPU frequency scaling
- Thermal throttling
- Background processes

For reproducible results, use a dedicated machine or consistent environment.
