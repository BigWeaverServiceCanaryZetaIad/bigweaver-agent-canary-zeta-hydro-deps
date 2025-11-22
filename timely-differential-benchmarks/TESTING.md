# Testing and Validation Guide

This document provides instructions for testing and validating the Timely and Differential Dataflow benchmarks.

## Prerequisites

### Required Software
- Rust toolchain (1.70.0 or later recommended)
- Cargo package manager
- Git

### Installation
```bash
# Install Rust (if not already installed)
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Verify installation
rustc --version
cargo --version
```

## Quick Validation

### 1. Check Compilation
```bash
cd timely-differential-benchmarks
cargo check
```

Expected output: All benchmarks should compile without errors.

### 2. Build Release Version
```bash
cargo build --release
```

Expected output: Clean build with no warnings or errors.

### 3. Run All Benchmarks (Quick)
```bash
# Run with minimal iterations for quick validation
cargo bench -- --quick
```

Expected: All benchmarks execute and complete successfully.

## Comprehensive Testing

### Individual Benchmark Testing

#### Arithmetic Benchmark
```bash
cargo bench --bench arithmetic
```

**Expected behavior:**
- Processes 1,000,000 integers through 20 map operations
- Completes in reasonable time (typically < 5 seconds per iteration)
- Produces statistical output with mean, std dev, and confidence intervals

#### Fan-In Benchmark
```bash
cargo bench --bench fan_in
```

**Expected behavior:**
- Concatenates 20 streams of 1,000,000 integers each
- Tests stream merging efficiency
- Should show consistent performance across iterations

#### Fan-Out Benchmark
```bash
cargo bench --bench fan_out
```

**Expected behavior:**
- Broadcasts 1,000,000 integers to 20 consumers
- Tests stream splitting efficiency
- Performance should scale with number of consumers

#### Fork-Join Benchmark
```bash
cargo bench --bench fork_join
```

**Expected behavior:**
- Performs 20 iterations of fork-join with branch factor 2
- Processes 100,000 integers
- Tests complex dataflow patterns

#### Identity Benchmark
```bash
cargo bench --bench identity
```

**Expected behavior:**
- Minimal overhead test with 20 identity operations
- 1,000,000 integers
- Should show baseline operator overhead

#### Join Benchmark
```bash
cargo bench --bench join
```

**Expected behavior:**
- Runs two variants: usize×usize and String×String
- Performs hash joins on 100,000 tuples each
- String variant should be slower than usize variant

#### Reachability Benchmark (Critical Test)
```bash
cargo bench --bench reachability
```

**Expected behavior:**
- Runs both Timely and Differential implementations
- Processes graph with 55,008 edges
- Validates result against expected 7,855 reachable nodes
- **IMPORTANT**: Includes assertions that will fail if logic is incorrect
- Differential variant should show incremental computation benefits

**Validation checks:**
```rust
assert_eq!(&reached, reachable); // Must pass in both implementations
```

#### Upcase Benchmark
```bash
cargo bench --bench upcase
```

**Expected behavior:**
- Runs three variants: in-place, allocating, concatenating
- Processes 100,000 strings through 20 operations each
- In-place should be fastest, allocating slowest

## Performance Validation

### Expected Performance Characteristics

#### Relative Performance (from fastest to slowest)
1. **identity**: Minimal computation overhead
2. **arithmetic**: Simple integer operations
3. **fan_in/fan_out**: Stream management overhead
4. **fork_join**: Complex dataflow patterns
5. **join** (usize): Hash join with simple types
6. **join** (String): Hash join with complex types
7. **upcase** (in-place): String manipulation
8. **upcase** (allocating): String allocation overhead
9. **reachability**: Iterative graph computation

### Performance Regression Detection

Run benchmarks and save baseline:
```bash
cargo bench -- --save-baseline initial
```

After making changes, compare:
```bash
cargo bench -- --baseline initial
```

Criterion will show:
- Performance improvements (faster)
- Performance regressions (slower)
- Changes outside noise threshold

## Correctness Validation

### Critical Validation Points

1. **Reachability Correctness**
   ```bash
   cargo test --release --bench reachability
   ```
   The reachability benchmark includes assertions that validate:
   - All expected nodes are reached
   - No extra nodes are reached
   - Both Timely and Differential implementations produce identical results

2. **Join Correctness**
   The join benchmark validates:
   - All matching tuples are produced
   - No duplicate outputs
   - Correct key-value associations

### Data File Validation

Verify benchmark data files are present and intact:

```bash
cd benches
ls -lh reachability_edges.txt      # Should be ~521KB
ls -lh reachability_reachable.txt  # Should be ~38KB
ls -lh words_alpha.txt             # Should be ~3.7MB

# Verify edge count
wc -l reachability_edges.txt       # Should be 55,008 lines

# Verify reachable node count
wc -l reachability_reachable.txt   # Should be 7,855 lines
```

## Troubleshooting

### Compilation Errors

**Error: Cannot find timely/differential-dataflow**
```bash
# Update dependencies
cargo update

# Clean and rebuild
cargo clean
cargo build --release
```

**Error: Conflicting versions**
```bash
# Check Cargo.lock
cat Cargo.lock | grep -A5 "timely\|differential"

# Force update to correct versions
cargo update -p timely-master
cargo update -p differential-dataflow-master
```

### Runtime Errors

**Error: File not found (reachability_edges.txt)**
- Ensure you're running from the correct directory
- Data files must be in `benches/` subdirectory
- Use `include_bytes!()` macro which embeds files at compile time

**Error: Assertion failed in reachability**
- Indicates a logic error in the benchmark implementation
- Verify data files are not corrupted
- Check that graph algorithms are implemented correctly

### Performance Issues

**Benchmarks taking too long**
```bash
# Reduce sample size temporarily
cargo bench -- --sample-size 10

# Run quick mode
cargo bench -- --quick
```

**Inconsistent results**
- Ensure system is not under heavy load
- Close other applications
- Run with elevated priority if possible
- Check for thermal throttling

## Continuous Integration

### Recommended CI Checks

1. **Compilation Check**
   ```bash
   cargo check --all-targets
   ```

2. **Build Check**
   ```bash
   cargo build --release
   ```

3. **Quick Benchmark Run**
   ```bash
   cargo bench -- --quick
   ```

4. **Specific Critical Tests**
   ```bash
   # Run reachability to verify correctness
   cargo bench --bench reachability -- --quick
   ```

### CI Configuration Example

```yaml
name: Benchmark Tests
on: [push, pull_request]

jobs:
  benchmark:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: actions-rs/toolchain@v1
        with:
          toolchain: stable
      - name: Check compilation
        run: cargo check
      - name: Run quick benchmarks
        run: cargo bench -- --quick
```

## Performance Tracking

### Long-term Performance Monitoring

1. **Establish Baseline**
   ```bash
   cargo bench -- --save-baseline v1.0
   ```

2. **Regular Comparison**
   ```bash
   # After changes
   cargo bench -- --baseline v1.0
   ```

3. **Export Results**
   ```bash
   # Results are in target/criterion/
   # HTML reports available at target/criterion/report/index.html
   ```

### Automated Performance Tracking

Consider using:
- Criterion's built-in HTML reports
- Custom scripts to parse Criterion JSON output
- Integration with performance tracking tools
- Automated regression detection in CI

## Expected Output Examples

### Successful Benchmark Run
```
arithmetic/timely       time:   [12.345 ms 12.456 ms 12.567 ms]
                        change: [-2.1234% -1.2345% -0.3456%] (p = 0.02 < 0.05)
                        Performance has improved.
```

### Benchmark with Validation
```
reachability/timely     time:   [45.678 ms 46.789 ms 47.890 ms]
                        Validation: PASSED (7,855 nodes reached)
```

## Additional Resources

- [Criterion.rs Documentation](https://bheisler.github.io/criterion.rs/book/)
- [Timely Dataflow Documentation](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow Documentation](https://github.com/TimelyDataflow/differential-dataflow)
- [Rust Performance Book](https://nnethercote.github.io/perf-book/)

## Reporting Issues

When reporting issues with benchmarks:

1. Include full error message
2. Specify Rust version (`rustc --version`)
3. Include system information (OS, CPU, RAM)
4. Attach relevant log output
5. Describe steps to reproduce
6. Note any deviations from standard setup

## Success Criteria

The benchmark suite is considered validated when:

✅ All benchmarks compile without warnings  
✅ All benchmarks run to completion  
✅ Reachability assertions pass (correctness validation)  
✅ Performance results are consistent across runs (< 5% variation)  
✅ Results are comparable to historical data  
✅ HTML reports are generated successfully  
✅ No memory leaks or resource exhaustion  
✅ Reasonable execution times (complete suite < 10 minutes)
