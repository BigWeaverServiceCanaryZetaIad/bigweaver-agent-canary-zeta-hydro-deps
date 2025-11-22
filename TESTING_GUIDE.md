# Testing and Verification Guide

This document provides comprehensive guidance for testing and verifying the timely and differential-dataflow benchmarks in this repository.

## Overview

This repository contains performance comparison benchmarks that were moved from the main Hydro repository. This guide ensures that all benchmarks function correctly and can run independently.

## Prerequisites

### Required Software

- Rust toolchain (version specified in main repository's `rust-toolchain.toml`)
- Cargo (comes with Rust)
- Git

### Repository Structure

Ensure the following directory structure:
```
/projects/sandbox/
├── bigweaver-agent-canary-hydro-zeta/     # Main Hydro repository
│   ├── dfir_rs/
│   ├── sinktools/
│   └── ...
└── bigweaver-agent-canary-zeta-hydro-deps/ # This repository
    ├── benches/
    ├── README.md
    └── ...
```

## Verification Steps

### 1. Repository Setup Verification

```bash
# Verify main repository exists
ls -la ../bigweaver-agent-canary-hydro-zeta/dfir_rs
ls -la ../bigweaver-agent-canary-hydro-zeta/sinktools

# Expected: Both directories should exist
```

### 2. Dependency Verification

```bash
# Check that all dependencies are correctly specified
cargo tree -p benches-timely-differential

# Expected: Should show dependency tree including:
# - dfir_rs (local path)
# - sinktools (local path)
# - timely
# - differential-dataflow
# - criterion
```

### 3. Build Verification

```bash
# Clean build to ensure everything works from scratch
cargo clean
cargo build -p benches-timely-differential

# Expected: Build should succeed without errors
```

### 4. Benchmark Files Verification

```bash
# Verify all benchmark files exist
ls -l benches/benches/

# Expected files:
# - arithmetic.rs
# - fan_in.rs
# - fan_out.rs
# - fork_join.rs
# - identity.rs
# - join.rs
# - upcase.rs
# - reachability.rs
# - reachability_edges.txt
# - reachability_reachable.txt
```

### 5. Individual Benchmark Verification

Test each benchmark individually to ensure they run correctly:

```bash
# Test arithmetic benchmark
cargo bench -p benches-timely-differential --bench arithmetic

# Test fan_in benchmark
cargo bench -p benches-timely-differential --bench fan_in

# Test fan_out benchmark
cargo bench -p benches-timely-differential --bench fan_out

# Test fork_join benchmark
cargo bench -p benches-timely-differential --bench fork_join

# Test identity benchmark
cargo bench -p benches-timely-differential --bench identity

# Test join benchmark
cargo bench -p benches-timely-differential --bench join

# Test upcase benchmark
cargo bench -p benches-timely-differential --bench upcase

# Test reachability benchmark (most comprehensive)
cargo bench -p benches-timely-differential --bench reachability
```

### 6. Filter Verification

Test that filtering works correctly:

```bash
# Test dfir_rs implementations only
cargo bench -p benches-timely-differential --bench reachability -- dfir

# Test timely implementations only
cargo bench -p benches-timely-differential --bench reachability -- timely

# Test differential implementations only
cargo bench -p benches-timely-differential --bench reachability -- differential
```

### 7. Quick Mode Verification

Test quick mode for faster iteration:

```bash
# Run in quick mode (fewer iterations)
cargo bench -p benches-timely-differential --bench identity -- --quick
```

### 8. All Benchmarks Verification

```bash
# Run all benchmarks together
cargo bench -p benches-timely-differential

# Expected: All benchmarks should complete successfully
```

## Performance Comparison Testing

### Baseline Comparison

1. **Save a baseline:**
   ```bash
   cargo bench -p benches-timely-differential -- --save-baseline initial
   ```

2. **Make changes to main repository** (if testing changes)

3. **Compare against baseline:**
   ```bash
   cargo bench -p benches-timely-differential -- --baseline initial
   ```

4. **View comparison results:**
   ```bash
   # Open HTML report
   open target/criterion/report/index.html
   ```

### Cross-Implementation Comparison

Each benchmark should show performance metrics for:
- Hydro (dfir_rs) implementations
- Timely dataflow implementations
- Differential dataflow implementations (where applicable)

Example output from reachability benchmark:
```
reachability/dfir/scheduled
reachability/dfir/surface
reachability/timely
reachability/differential
```

## Expected Results

### Build Results

- ✅ All dependencies resolve correctly
- ✅ No compilation errors
- ✅ No missing files errors
- ✅ Build completes in reasonable time

### Benchmark Results

Each benchmark should:
- ✅ Execute without panics or errors
- ✅ Complete within reasonable time
- ✅ Generate Criterion reports
- ✅ Show timing measurements
- ✅ Display comparison data (if baseline exists)

### Output Verification

Benchmarks should generate:
- ✅ Console output with timing information
- ✅ HTML reports in `target/criterion/report/`
- ✅ Data files in `target/criterion/[benchmark_name]/`
- ✅ Comparison charts (when baseline exists)

## Troubleshooting

### Build Failures

**Problem:** Cannot find `dfir_rs` or `sinktools`

**Solution:**
```bash
# Verify path in benches/Cargo.toml
grep -A 1 "dfir_rs\|sinktools" benches/Cargo.toml

# Should show:
# dfir_rs = { path = "../../bigweaver-agent-canary-hydro-zeta/dfir_rs", ...
# sinktools = { path = "../../bigweaver-agent-canary-hydro-zeta/sinktools" }

# If paths are incorrect, update them to point to your main repository
```

**Problem:** Version conflicts with timely or differential-dataflow

**Solution:**
```bash
# Check versions in main repository
grep -r "timely\|differential" ../bigweaver-agent-canary-hydro-zeta/Cargo.lock | head -20

# Update benches/Cargo.toml to match compatible versions
```

### Runtime Failures

**Problem:** Benchmark panics or fails during execution

**Solution:**
```bash
# Run with backtrace to see error details
RUST_BACKTRACE=1 cargo bench -p benches-timely-differential --bench [benchmark_name]

# Check data files exist
ls -l benches/benches/*.txt
```

**Problem:** Data files not found

**Solution:**
```bash
# Verify data files exist
ls -l benches/benches/reachability_edges.txt
ls -l benches/benches/reachability_reachable.txt

# Check file permissions
stat benches/benches/*.txt
```

### Performance Issues

**Problem:** Benchmarks take too long

**Solution:**
```bash
# Use quick mode for faster iteration
cargo bench -p benches-timely-differential -- --quick

# Or run specific benchmarks only
cargo bench -p benches-timely-differential --bench identity
```

## Continuous Integration Testing

### Automated Verification Script

Create a CI script that runs all verification steps:

```bash
#!/bin/bash
set -e

echo "Running automated verification..."

echo "1. Checking repository structure..."
test -d ../bigweaver-agent-canary-hydro-zeta/dfir_rs || exit 1
test -d ../bigweaver-agent-canary-hydro-zeta/sinktools || exit 1

echo "2. Building benchmarks..."
cargo build -p benches-timely-differential

echo "3. Running quick benchmarks..."
cargo bench -p benches-timely-differential -- --quick

echo "All verification steps passed!"
```

### GitHub Actions Integration

Example workflow:

```yaml
name: Benchmark Tests

on: [push, pull_request]

jobs:
  benchmark:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout deps repo
        uses: actions/checkout@v3
        
      - name: Checkout main repo
        uses: actions/checkout@v3
        with:
          repository: hydro-project/hydro
          path: ../bigweaver-agent-canary-hydro-zeta
          
      - name: Setup Rust
        uses: actions-rs/toolchain@v1
        with:
          toolchain: stable
          
      - name: Run benchmarks
        run: cargo bench -p benches-timely-differential -- --quick
```

## Success Criteria

### Complete Test Suite

All verification steps should pass:

- [x] Repository structure is correct
- [x] All dependencies resolve
- [x] Clean build succeeds
- [x] All benchmark files exist
- [x] Each individual benchmark runs
- [x] Filtering works correctly
- [x] Quick mode works
- [x] All benchmarks run together
- [x] Performance comparisons work
- [x] HTML reports are generated

### Performance Validation

- [x] Benchmarks complete in reasonable time
- [x] Results are consistent across runs
- [x] Comparisons between implementations are valid
- [x] No unexpected performance regressions

### Documentation Validation

- [x] README is accurate and complete
- [x] TESTING_GUIDE is comprehensive
- [x] Example commands work as documented
- [x] Troubleshooting steps are effective

## Maintenance

### Regular Testing Schedule

1. **Before commits:** Run quick benchmarks
   ```bash
   cargo bench -p benches-timely-differential -- --quick
   ```

2. **Before PRs:** Run full benchmark suite
   ```bash
   cargo bench -p benches-timely-differential
   ```

3. **Weekly:** Run full suite with baseline comparison
   ```bash
   cargo bench -p benches-timely-differential -- --save-baseline weekly
   ```

4. **Before releases:** Full verification with documentation review

### Adding New Benchmarks

When adding new benchmarks, update this checklist:

1. Create benchmark file in `benches/benches/`
2. Add benchmark definition to `benches/Cargo.toml`
3. Test benchmark runs successfully
4. Update README with benchmark description
5. Add benchmark to verification steps in this guide
6. Document expected behavior
7. Add to CI pipeline

## Reporting Issues

If verification fails:

1. Document which step failed
2. Include error messages
3. Share output of `cargo tree -p benches-timely-differential`
4. Note your environment (OS, Rust version)
5. Describe any local modifications
6. Open issue in appropriate repository

## References

- Main repository: https://github.com/hydro-project/hydro
- Criterion documentation: https://bheisler.github.io/criterion.rs/book/
- Rust benchmark documentation: https://doc.rust-lang.org/cargo/commands/cargo-bench.html
- Migration documentation: See REMOVAL_SUMMARY.md and MIGRATION_NOTES.md in main repository

## Contact

For questions about testing:
- Review this guide and README.md
- Check main repository documentation
- Consult REMOVAL_SUMMARY.md in main repository
- Open issue with verification results
