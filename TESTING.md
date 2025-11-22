# Testing and Verification Guide

This document describes how to test and verify the benchmarks in this repository.

## Quick Verification

### ✅ Build Test

Verify that all benchmarks compile:

```bash
cargo build --release
```

**Expected**: No compilation errors, builds complete successfully.

### ✅ Smoke Test

Run a quick benchmark to verify basic functionality:

```bash
cargo bench -p timely-benchmarks --bench identity -- --sample-size 10
```

**Expected**: Benchmark completes without panics, produces timing output.

### ✅ Full Suite Test

Run all benchmarks (takes 10-20 minutes):

```bash
cargo bench
```

**Expected**: All benchmarks complete, HTML reports generated in `target/criterion/`.

## Detailed Testing

### Unit Test Structure

While these are benchmarks (not unit tests), they should:

1. **Complete without panics**
2. **Produce consistent results** (within expected variance)
3. **Scale predictably** with input size
4. **Generate valid Criterion output**

### Testing Individual Benchmarks

#### Test: Timely Identity Benchmark

```bash
cargo bench -p timely-benchmarks --bench identity
```

**Verification checklist:**
- ✅ Runs for multiple input sizes (100, 1K, 10K, 100K)
- ✅ Produces timing measurements for each size
- ✅ Timing increases with input size
- ✅ No panics or errors

#### Test: Timely Arithmetic Benchmark

```bash
cargo bench -p timely-benchmarks --bench arithmetic
```

**Verification checklist:**
- ✅ Performs arithmetic operations correctly
- ✅ Results scale with input size
- ✅ Memory usage is reasonable

#### Test: Timely Fan-in Benchmark

```bash
cargo bench -p timely-benchmarks --bench fan_in
```

**Verification checklist:**
- ✅ Tests multiple branch counts (2, 4, 8, 16)
- ✅ Merges streams correctly
- ✅ Timing increases with branch count

#### Test: Timely Fan-out Benchmark

```bash
cargo bench -p timely-benchmarks --bench fan_out
```

**Verification checklist:**
- ✅ Tests multiple branch counts (2, 4, 8, 16)
- ✅ Splits streams correctly
- ✅ All branches receive data

#### Test: Timely Micro Ops Benchmark

```bash
cargo bench -p timely-benchmarks --bench micro_ops
```

**Verification checklist:**
- ✅ Tests filter operations
- ✅ Tests map operations
- ✅ Tests chained operations
- ✅ All variants produce valid results

#### Test: Timely Reachability Benchmark

```bash
cargo bench -p timely-benchmarks --bench reachability
```

**Verification checklist:**
- ✅ Constructs graph correctly
- ✅ Traverses reachable nodes
- ✅ Results are consistent

#### Test: Differential Identity Benchmark

```bash
cargo bench -p differential-benchmarks --bench identity
```

**Verification checklist:**
- ✅ Runs for multiple input sizes
- ✅ Uses differential dataflow correctly
- ✅ Timing measurements are valid

#### Test: Differential Arithmetic Benchmark

```bash
cargo bench -p differential-benchmarks --bench arithmetic
```

**Verification checklist:**
- ✅ Performs incremental computation correctly
- ✅ Results match expected values
- ✅ Memory usage is reasonable

#### Test: Differential Fan-in Benchmark

```bash
cargo bench -p differential-benchmarks --bench fan_in
```

**Verification checklist:**
- ✅ Merges collections correctly
- ✅ All input collections are processed
- ✅ Results are deterministic

#### Test: Differential Fan-out Benchmark

```bash
cargo bench -p differential-benchmarks --bench fan_out
```

**Verification checklist:**
- ✅ Multiple consumers receive data
- ✅ Data is not lost or duplicated incorrectly
- ✅ Performance scales reasonably

#### Test: Differential Micro Ops Benchmark

```bash
cargo bench -p differential-benchmarks --bench micro_ops
```

**Verification checklist:**
- ✅ Filter, map, and chain operations work correctly
- ✅ Incremental updates are handled properly
- ✅ All variants produce valid results

#### Test: Differential Reachability Benchmark

```bash
cargo bench -p differential-benchmarks --bench reachability
```

**Verification checklist:**
- ✅ Iterative computation converges
- ✅ Graph traversal is correct
- ✅ Uses differential dataflow's iteration operators
- ✅ Results match expected reachability

## Verification Checklist

Use this checklist to verify the complete repository:

### Build Verification

- [ ] `cargo build --release` completes without errors
- [ ] All benchmark binaries are created in `target/release/`
- [ ] No warnings about missing dependencies

### Timely Benchmarks Verification

- [ ] All 6 Timely benchmarks compile
- [ ] `identity` benchmark runs successfully
- [ ] `arithmetic` benchmark runs successfully
- [ ] `fan_in` benchmark runs successfully
- [ ] `fan_out` benchmark runs successfully
- [ ] `micro_ops` benchmark runs successfully
- [ ] `reachability` benchmark runs successfully

### Differential Benchmarks Verification

- [ ] All 6 Differential benchmarks compile
- [ ] `identity` benchmark runs successfully
- [ ] `arithmetic` benchmark runs successfully
- [ ] `fan_in` benchmark runs successfully
- [ ] `fan_out` benchmark runs successfully
- [ ] `micro_ops` benchmark runs successfully
- [ ] `reachability` benchmark runs successfully

### Output Verification

- [ ] Criterion generates console output
- [ ] HTML reports are generated in `target/criterion/`
- [ ] JSON data files are created
- [ ] Baseline comparisons work (if baseline exists)

### Documentation Verification

- [ ] README.md is comprehensive and accurate
- [ ] BENCHMARK_COMPARISON.md provides useful guidance
- [ ] QUICKSTART.md helps new users get started
- [ ] All code examples in documentation work

## Performance Regression Testing

### Setting Up Baselines

Create a baseline for comparison:

```bash
cargo bench -- --save-baseline main
```

### Comparing Against Baselines

After making changes:

```bash
cargo bench -- --baseline main
```

Criterion will show performance differences.

### Automated Regression Detection

Look for output like:

```
Performance has regressed.
```

or

```
Performance has improved.
```

### Acceptable Variance

Benchmark measurements have natural variance. Consider:

- **< 5% change**: Likely noise, not significant
- **5-10% change**: Potentially significant, investigate
- **> 10% change**: Likely real, requires investigation
- **p < 0.05**: Statistically significant change

## Continuous Integration

### Recommended CI Pipeline

```yaml
# Example for GitHub Actions
name: Benchmarks
on: [push, pull_request]

jobs:
  benchmark:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: actions-rs/toolchain@v1
        with:
          toolchain: stable
      - name: Run benchmarks
        run: cargo bench --no-fail-fast
      - name: Archive benchmark results
        uses: actions/upload-artifact@v2
        with:
          name: benchmark-results
          path: target/criterion/
```

## Troubleshooting Tests

### Problem: Benchmark Fails to Compile

**Solution:**
```bash
# Update dependencies
cargo update

# Clean and rebuild
cargo clean
cargo build --release
```

### Problem: Benchmark Panics

**Solution:**
Check the panic message. Common issues:
- Input size too large (reduce test size)
- Resource exhaustion (run on machine with more memory)
- Bug in benchmark code (file an issue)

### Problem: Results Are Inconsistent

**Solution:**
```bash
# Increase sample size
cargo bench -- --sample-size 100

# Run on quieter system
# Close other applications
# Disable CPU frequency scaling

# Use warm-up iterations
cargo bench -- --warm-up-time 5
```

### Problem: Benchmarks Take Too Long

**Solution:**
```bash
# Reduce sample size for quick testing
cargo bench -- --sample-size 10

# Run specific benchmarks only
cargo bench --bench identity

# Use quick validation script
./run_quick_benchmarks.sh
```

## Manual Testing Procedures

### Procedure 1: Fresh Install Test

Simulates a new user:

```bash
# Start with clean slate
rm -rf target/

# Build from scratch
cargo build --release

# Run smoke test
cargo bench --bench identity -- --sample-size 10

# Verify HTML report
ls target/criterion/report/index.html
```

### Procedure 2: Comparison Test

Verifies baseline comparison works:

```bash
# Create baseline
cargo bench -- --save-baseline test

# Make trivial change (e.g., comment in code)

# Compare
cargo bench -- --baseline test

# Verify comparison output shows
```

### Procedure 3: Cross-Framework Test

Verifies both frameworks work:

```bash
# Test Timely
cargo bench -p timely-benchmarks --bench identity

# Test Differential
cargo bench -p differential-benchmarks --bench identity

# Compare results
# Both should complete successfully
```

## Reporting Issues

When reporting test failures, include:

1. **Command used**: Exact `cargo bench` command
2. **Error output**: Full error message
3. **Environment**: OS, Rust version (`rustc --version`)
4. **Context**: What you were trying to do
5. **Reproduction**: Steps to reproduce the issue

Example issue report:

```
Title: Reachability benchmark panics on large graphs

Command:
cargo bench -p differential-benchmarks --bench reachability

Error:
thread 'main' panicked at 'index out of bounds'

Environment:
- OS: Ubuntu 22.04
- Rust: 1.75.0
- CPU: Intel i7-9700K
- RAM: 16GB

Steps to reproduce:
1. Run: cargo bench -p differential-benchmarks --bench reachability
2. Wait for size=1000 variant
3. Panic occurs

Expected: Benchmark completes successfully
Actual: Panic at graph size 1000
```

## Success Criteria

All tests pass if:

✅ All benchmarks compile without errors
✅ All benchmarks run without panics
✅ Results scale predictably with input size
✅ HTML reports are generated
✅ Documentation is accurate and helpful
✅ Scripts work as documented

## Next Steps After Testing

Once all tests pass:

1. Review [BENCHMARK_COMPARISON.md](./BENCHMARK_COMPARISON.md) to compare with Hydro
2. Run benchmarks with different configurations
3. Create baselines for tracking performance over time
4. Share results with the team
