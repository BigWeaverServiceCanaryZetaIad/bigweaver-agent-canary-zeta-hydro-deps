# Verification Guide

This document provides steps to verify the benchmark infrastructure is correctly set up and functional.

## 📋 Pre-requisites

- Rust toolchain installed (stable or nightly as per main repository)
- Cargo available in PATH
- Git configured

## ✅ Verification Steps

### 1. Workspace Configuration

Verify the workspace is correctly configured:

```bash
cd /path/to/bigweaver-agent-canary-zeta-hydro-deps
cargo --version
```

Expected: Rust version output

### 2. Build Verification

Test that the workspace builds:

```bash
cargo build --workspace
```

Expected: Clean build with no errors

### 3. Benchmark Compilation

Verify benchmarks compile:

```bash
cd benches
cargo build --benches --release
```

Expected: All benchmarks compile successfully

### 4. Test Suite

Run the test suite:

```bash
cd benches
cargo test
```

Expected: All tests pass

### 5. Library Tests

Verify utility functions work:

```bash
cd benches
cargo test --lib
```

Expected output includes:
- `test_generate_sequence ... ok`
- `test_generate_key_value_pairs ... ok`
- `test_generate_chain_graph ... ok`
- `test_format_throughput ... ok`

### 6. Code Quality

Check formatting:

```bash
cd benches
cargo fmt -- --check
```

Expected: No formatting issues

Run linter:

```bash
cd benches
cargo clippy
```

Expected: No warnings (or only acceptable warnings)

### 7. Run Quick Benchmark

Run a quick benchmark to verify functionality:

```bash
cd benches
cargo bench --bench micro_ops -- --quick
```

Expected: Benchmarks execute and produce results

### 8. Verify Script Permissions

Check the convenience script:

```bash
cd /path/to/bigweaver-agent-canary-zeta-hydro-deps
bash run_benchmarks.sh --help
```

Expected: Usage information displayed

### 9. Documentation Check

Verify documentation builds:

```bash
cd benches
cargo doc --no-deps
```

Expected: Documentation generates successfully

### 10. Benchmark Structure

Verify all benchmark files exist:

```bash
ls -la benches/benches/
```

Expected files:
- `micro_ops.rs`
- `reachability.rs`
- `dataflow_patterns.rs`

## 🔍 Troubleshooting

### Build Fails

**Issue**: Compilation errors

**Solutions**:
1. Update dependencies: `cargo update`
2. Clean build: `cargo clean && cargo build`
3. Check Rust version matches main repository

### Benchmarks Don't Run

**Issue**: Runtime errors when executing benchmarks

**Solutions**:
1. Verify you're in the `benches` directory
2. Try with release mode: `cargo bench --release`
3. Check system resources (benchmarks are CPU intensive)

### Script Permission Denied

**Issue**: Cannot execute `run_benchmarks.sh`

**Solution**:
```bash
bash run_benchmarks.sh --all  # Use bash directly
```

### Missing Dependencies

**Issue**: Timely or differential-dataflow not found

**Solution**:
```bash
cd benches
cargo update -p timely -p differential-dataflow
```

## 📊 Expected Benchmark Output

When running benchmarks, you should see output like:

```
Benchmarking timely_map/100: Collecting 100 samples
timely_map/100          time:   [45.2 μs 46.1 μs 47.3 μs]
                        thrpt:  [2.11M elem/s 2.17M elem/s 2.21M elem/s]

Benchmarking timely_map/1000: Collecting 100 samples  
timely_map/1000         time:   [421 μs 425 μs 431 μs]
                        thrpt:  [2.32M elem/s 2.35M elem/s 2.37M elem/s]
```

## ✨ Success Criteria

The setup is verified when:

- [x] Workspace builds without errors
- [x] All tests pass
- [x] Benchmarks compile
- [x] At least one benchmark runs successfully
- [x] Code quality checks pass
- [x] Documentation generates
- [x] Scripts are executable

## 🔄 Regular Verification

For ongoing verification:

**Weekly**:
```bash
cargo update
cargo test
cargo clippy
```

**Before Major Changes**:
```bash
bash run_benchmarks.sh --all --baseline current
```

**After Major Changes**:
```bash
bash run_benchmarks.sh --all --compare current
```

## 📝 Reporting Issues

If verification fails:

1. Document the exact command that failed
2. Include the full error message
3. Note your Rust version: `rustc --version`
4. Check if issue exists in main repository too
5. File issue with "Verification Failed" tag

## 🎯 Next Steps

After successful verification:

1. Read [README.md](README.md) for usage instructions
2. Review [INTEGRATION.md](INTEGRATION.md) for workflow details
3. Explore [benches/README.md](benches/README.md) for benchmark details
4. Start using benchmarks for performance testing

---

**Note**: This verification should be run after initial setup and after any major changes to the infrastructure.
