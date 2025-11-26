# Verification Checklist

Use this checklist to verify that the benchmark repository is set up correctly and all benchmarks function as expected.

## Pre-Verification Setup

- [ ] Rust toolchain installed (check: `rustc --version`)
- [ ] Cargo installed (check: `cargo --version`)
- [ ] Repository cloned successfully
- [ ] In correct directory: `bigweaver-agent-canary-zeta-hydro-deps`

## Build Verification

### Workspace Build
```bash
cargo build
```
- [ ] Workspace builds without errors
- [ ] No compilation warnings for critical issues
- [ ] `Cargo.toml` workspace configuration is valid

### Benchmark Package Build
```bash
cargo build -p hydro-deps-benches
```
- [ ] Package builds successfully
- [ ] Build script (`build.rs`) executes without errors
- [ ] Generated files appear in `benches/benches/` (e.g., `fork_join_20.hf`)

### Dependency Check
```bash
cargo tree -p hydro-deps-benches | grep -E "timely|differential"
```
- [ ] `timely-master` version 0.13.0-dev.1 present
- [ ] `differential-dataflow-master` version 0.13.0-dev.1 present
- [ ] No conflicting dependency versions

## File Structure Verification

### Required Files

Repository root:
- [ ] `README.md` exists and is comprehensive
- [ ] `Cargo.toml` exists with workspace configuration
- [ ] `QUICKSTART.md` exists
- [ ] `BENCHMARK_DETAILS.md` exists
- [ ] `INTEGRATION_GUIDE.md` exists
- [ ] `CONTRIBUTING.md` exists
- [ ] `VERIFICATION_CHECKLIST.md` exists (this file)

Benchmarks directory (`benches/`):
- [ ] `benches/Cargo.toml` exists
- [ ] `benches/README.md` exists
- [ ] `benches/build.rs` exists

Benchmark files (`benches/benches/`):
- [ ] `arithmetic.rs` exists
- [ ] `fan_in.rs` exists
- [ ] `fan_out.rs` exists
- [ ] `fork_join.rs` exists
- [ ] `identity.rs` exists
- [ ] `join.rs` exists
- [ ] `upcase.rs` exists
- [ ] `reachability.rs` exists
- [ ] `reachability_edges.txt` exists (~532KB)
- [ ] `reachability_reachable.txt` exists (~38KB)
- [ ] `.gitignore` exists

## Benchmark Execution Verification

### Individual Benchmark Tests

Run each benchmark and verify it completes without errors:

#### Arithmetic
```bash
cargo bench -p hydro-deps-benches --bench arithmetic -- --test
```
- [ ] Runs without errors
- [ ] Completes in reasonable time (< 5 minutes)
- [ ] Produces output with timing information

#### Fan-In
```bash
cargo bench -p hydro-deps-benches --bench fan_in -- --test
```
- [ ] Runs without errors
- [ ] Produces valid results

#### Fan-Out
```bash
cargo bench -p hydro-deps-benches --bench fan_out -- --test
```
- [ ] Runs without errors
- [ ] Produces valid results

#### Fork-Join
```bash
cargo bench -p hydro-deps-benches --bench fork_join -- --test
```
- [ ] Runs without errors
- [ ] Uses generated code from build.rs
- [ ] Produces valid results

#### Identity
```bash
cargo bench -p hydro-deps-benches --bench identity -- --test
```
- [ ] Runs without errors
- [ ] Baseline variant runs fastest
- [ ] Produces valid results

#### Join
```bash
cargo bench -p hydro-deps-benches --bench join -- --test
```
- [ ] Runs without errors
- [ ] Produces valid results

#### Upcase
```bash
cargo bench -p hydro-deps-benches --bench upcase -- --test
```
- [ ] Runs without errors
- [ ] Produces valid results

#### Reachability
```bash
cargo bench -p hydro-deps-benches --bench reachability -- --test
```
- [ ] Runs without errors
- [ ] Loads data files successfully
- [ ] Computes correct reachability
- [ ] Produces valid results

### Full Benchmark Suite
```bash
cargo bench -p hydro-deps-benches
```
- [ ] All benchmarks execute
- [ ] No panics or crashes
- [ ] Results are consistent across runs
- [ ] HTML reports generated in `target/criterion/`

## Output Verification

### Console Output

Check that benchmark output includes:
- [ ] Benchmark name
- [ ] Time measurements (lower bound, estimate, upper bound)
- [ ] Performance comparison (if baseline exists)
- [ ] Statistical confidence indicators

Example expected output:
```
arithmetic/timely       time:   [152.34 ms 153.21 ms 154.15 ms]
```

### HTML Reports

Check that HTML reports are generated:
```bash
ls -la target/criterion/*/report/index.html
```
- [ ] Reports exist for each benchmark
- [ ] Reports can be opened in browser
- [ ] Reports contain graphs and statistics
- [ ] Reports show violin plots

### Generated Files

Check build script outputs:
```bash
ls -la benches/benches/*.hf
```
- [ ] `fork_join_20.hf` exists
- [ ] File contains valid Hydroflow syntax

## Performance Sanity Checks

Run quick performance comparison:

```bash
cargo bench -p hydro-deps-benches --bench identity
```

Verify relative performance (approximate):
- [ ] Raw variant is fastest
- [ ] Pipeline variant is slower than raw
- [ ] Timely variant has reasonable overhead

## Data File Verification

### Reachability Data Files

Check data file integrity:

```bash
# Check file sizes
ls -lh benches/benches/reachability*.txt

# Check file format (sample first 10 lines)
head -10 benches/benches/reachability_edges.txt
head -10 benches/benches/reachability_reachable.txt
```

- [ ] `reachability_edges.txt` is approximately 532KB
- [ ] `reachability_reachable.txt` is approximately 38KB
- [ ] Edges file contains two integers per line (source, target)
- [ ] Reachable file contains one integer per line (node ID)
- [ ] Files are readable and well-formatted

## Integration Verification (Optional)

If integrating with main repository:

### Path Dependencies

```bash
# Verify main repository is available
ls -la ../bigweaver-agent-canary-hydro-zeta/dfir_rs
ls -la ../bigweaver-agent-canary-hydro-zeta/sinktools
```

- [ ] Main repository exists at expected path
- [ ] `dfir_rs` directory exists
- [ ] `sinktools` directory exists

### Integrated Build

After uncommenting path dependencies in `benches/Cargo.toml`:

```bash
cargo build -p hydro-deps-benches
```

- [ ] Builds with dfir_rs dependency
- [ ] Builds with sinktools dependency
- [ ] No version conflicts

### Hydroflow Benchmarks

Run benchmarks with Hydroflow variants:

```bash
cargo bench -p hydro-deps-benches --bench arithmetic -- dfir_rs
```

- [ ] Hydroflow variants execute
- [ ] Performance is comparable to other implementations
- [ ] No runtime errors

## Documentation Verification

### README Accuracy

- [ ] All commands in README work as documented
- [ ] Benchmark list is complete and accurate
- [ ] Links to other documents work
- [ ] Quick start instructions are clear

### QUICKSTART Completeness

- [ ] All commands execute successfully
- [ ] Prerequisites are accurate
- [ ] Troubleshooting section is helpful
- [ ] Examples work as shown

### BENCHMARK_DETAILS Accuracy

- [ ] Each benchmark is documented
- [ ] Descriptions match actual implementations
- [ ] Performance characteristics are accurate
- [ ] Example outputs are realistic

### INTEGRATION_GUIDE Correctness

- [ ] Integration methods work as described
- [ ] Path dependencies resolve correctly
- [ ] Troubleshooting section is helpful

## Code Quality Verification

### Formatting

```bash
cargo fmt --all -- --check
```

- [ ] All code is formatted consistently
- [ ] No formatting violations

### Linting

```bash
cargo clippy --all-targets --all-features -- -D warnings
```

- [ ] No clippy warnings
- [ ] No clippy errors
- [ ] Code follows Rust best practices

### Documentation

```bash
cargo doc -p hydro-deps-benches --no-deps
```

- [ ] Documentation builds without warnings
- [ ] Public items have doc comments
- [ ] Examples in docs are valid

## Git Repository Verification

### Repository State

```bash
git status
```

- [ ] All files are tracked or ignored appropriately
- [ ] `.gitignore` excludes build artifacts
- [ ] No unexpected untracked files

### Commit History

```bash
git log --oneline -10
```

- [ ] Commits follow conventional format
- [ ] Commit messages are descriptive
- [ ] History is clean and logical

## Final Checks

### Clean Build

```bash
cargo clean
cargo build -p hydro-deps-benches
cargo bench -p hydro-deps-benches -- --test
```

- [ ] Clean build succeeds
- [ ] All benchmarks run after clean build
- [ ] No cached artifacts affect results

### Cross-Platform (If Applicable)

Test on different platforms if available:
- [ ] Linux build and execution
- [ ] macOS build and execution
- [ ] Windows build and execution

## Performance Baseline

### Establish Baseline

```bash
cargo bench -p hydro-deps-benches -- --save-baseline initial
```

- [ ] Baseline saved successfully
- [ ] Can compare future runs against baseline

### Verify Baseline Comparison

```bash
cargo bench -p hydro-deps-benches -- --baseline initial
```

- [ ] Comparison works
- [ ] Shows "No significant change" or reasonable variation

## Sign-Off

### Verification Complete

- [ ] All mandatory checks passed
- [ ] Documentation is complete and accurate
- [ ] All benchmarks run successfully
- [ ] Repository is ready for use

### Notes

Document any issues or deviations:

```
[Add any notes about failed checks, known issues, or special considerations]
```

### Verified By

- **Name**: ________________
- **Date**: ________________
- **Environment**: 
  - OS: ________________
  - Rust Version: ________________
  - Hardware: ________________

---

## Quick Verification Script

For automated verification, run:

```bash
#!/bin/bash
set -e

echo "Building workspace..."
cargo build

echo "Building benchmarks..."
cargo build -p hydro-deps-benches

echo "Running benchmark tests..."
cargo bench -p hydro-deps-benches -- --test

echo "Checking formatting..."
cargo fmt --all -- --check

echo "Running clippy..."
cargo clippy --all-targets --all-features -- -D warnings

echo "✅ All checks passed!"
```

Save as `verify.sh` and run: `bash verify.sh`
