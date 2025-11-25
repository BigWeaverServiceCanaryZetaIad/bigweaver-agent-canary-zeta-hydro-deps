# Verification Checklist

## Post-Migration Verification

Use this checklist to verify that the timely and differential-dataflow benchmarks 
are functional in their new location.

### ✅ File Integrity

- [ ] All benchmark source files present in `timely-benchmarks/benches/`
  - [ ] arithmetic.rs
  - [ ] fan_in.rs
  - [ ] fan_out.rs
  - [ ] fork_join.rs
  - [ ] identity.rs
  - [ ] join.rs
  - [ ] reachability.rs
  - [ ] upcase.rs

- [ ] All data files present in `timely-benchmarks/benches/`
  - [ ] reachability_edges.txt
  - [ ] reachability_reachable.txt
  - [ ] words_alpha.txt

- [ ] Configuration files present
  - [ ] timely-benchmarks/Cargo.toml
  - [ ] timely-benchmarks/build.rs
  - [ ] Cargo.toml (workspace root)

- [ ] Documentation files present
  - [ ] README.md (repository root)
  - [ ] timely-benchmarks/README.md
  - [ ] MIGRATION.md
  - [ ] VERIFICATION_CHECKLIST.md (this file)

### ✅ Build Verification

Run these commands and verify they succeed:

```bash
# Check workspace configuration
cargo metadata --no-deps --format-version 1 | grep -q "timely-benchmarks"
```
- [ ] Workspace includes timely-benchmarks package

```bash
# Check all packages
cargo check --workspace
```
- [ ] All packages compile without errors

```bash
# Check benchmark package specifically
cargo check -p timely-benchmarks
```
- [ ] Benchmark package compiles without errors

```bash
# Check with all features
cargo check -p timely-benchmarks --all-features
```
- [ ] Compiles with all features enabled

### ✅ Individual Benchmark Verification

Run each benchmark and verify it executes without errors:

```bash
# Arithmetic benchmark
cargo bench -p timely-benchmarks --bench arithmetic -- --test
```
- [ ] arithmetic benchmark runs successfully

```bash
# Fan-in benchmark
cargo bench -p timely-benchmarks --bench fan_in -- --test
```
- [ ] fan_in benchmark runs successfully

```bash
# Fan-out benchmark
cargo bench -p timely-benchmarks --bench fan_out -- --test
```
- [ ] fan_out benchmark runs successfully

```bash
# Fork-join benchmark
cargo bench -p timely-benchmarks --bench fork_join -- --test
```
- [ ] fork_join benchmark runs successfully

```bash
# Identity benchmark
cargo bench -p timely-benchmarks --bench identity -- --test
```
- [ ] identity benchmark runs successfully

```bash
# Join benchmark
cargo bench -p timely-benchmarks --bench join -- --test
```
- [ ] join benchmark runs successfully

```bash
# Reachability benchmark
cargo bench -p timely-benchmarks --bench reachability -- --test
```
- [ ] reachability benchmark runs successfully

```bash
# Upcase benchmark
cargo bench -p timely-benchmarks --bench upcase -- --test
```
- [ ] upcase benchmark runs successfully

### ✅ Benchmark Pattern Verification

Verify specific benchmark patterns work:

```bash
# All timely benchmarks
cargo bench -p timely-benchmarks -- timely --test
```
- [ ] All timely-dataflow benchmarks run

```bash
# Differential benchmark
cargo bench -p timely-benchmarks -- differential --test
```
- [ ] Differential-dataflow benchmark runs

```bash
# Baseline benchmarks
cargo bench -p timely-benchmarks -- raw --test
cargo bench -p timely-benchmarks -- iter --test
```
- [ ] Baseline comparison benchmarks run

### ✅ Data File Verification

Verify data files are accessible:

```bash
# Check file sizes
ls -lh timely-benchmarks/benches/*.txt
```

Expected sizes:
- [ ] reachability_edges.txt (~524KB)
- [ ] reachability_reachable.txt (~40KB)  
- [ ] words_alpha.txt (~3.7MB)

```bash
# Verify reachability data loads
grep -c "^" timely-benchmarks/benches/reachability_edges.txt
grep -c "^" timely-benchmarks/benches/reachability_reachable.txt
```
- [ ] reachability_edges.txt has expected line count
- [ ] reachability_reachable.txt has expected line count

### ✅ Dependency Verification

Check that only expected dependencies are present:

```bash
# List dependencies
cargo tree -p timely-benchmarks | grep -E "timely|differential|criterion"
```

Expected dependencies:
- [ ] timely-master (timely)
- [ ] differential-dataflow-master (differential-dataflow)
- [ ] criterion

Unexpected dependencies (should NOT be present):
- [ ] ✗ dfir_rs
- [ ] ✗ sinktools

### ✅ Performance Comparison Capability

Verify performance comparisons work:

```bash
# Run arithmetic with multiple implementations
cargo bench -p timely-benchmarks --bench arithmetic
```
- [ ] Multiple benchmark variants execute
- [ ] Criterion generates comparison reports

```bash
# Check criterion output directory
ls -la target/criterion/
```
- [ ] Criterion reports are generated
- [ ] HTML reports are available

```bash
# Run comparative benchmarks
cargo bench -p timely-benchmarks --bench join
```
- [ ] Multiple value types benchmarked (usize, String)
- [ ] Comparison results available

### ✅ Full Suite Verification

Run the complete benchmark suite:

```bash
# Run all benchmarks (this will take several minutes)
cargo bench --workspace
```
- [ ] All benchmarks complete successfully
- [ ] No errors or panics occur
- [ ] Results are generated for all benchmarks

### ✅ Documentation Verification

Review documentation for accuracy:

- [ ] README.md describes repository purpose
- [ ] README.md lists all benchmarks
- [ ] README.md has correct usage examples
- [ ] timely-benchmarks/README.md describes each benchmark
- [ ] timely-benchmarks/README.md has run instructions
- [ ] MIGRATION.md documents the migration process
- [ ] MIGRATION.md lists all migrated files
- [ ] File structure in docs matches reality

### ✅ Code Quality Verification

Check code follows standards:

```bash
# Check formatting (if rustfmt available)
cargo fmt -p timely-benchmarks -- --check
```
- [ ] Code is properly formatted

```bash
# Check for common issues (if clippy available)
cargo clippy -p timely-benchmarks
```
- [ ] No clippy warnings (or only acceptable ones)

### ✅ Git Repository Verification

Verify git status:

```bash
# Check git status
cd /projects/sandbox/bigweaver-agent-canary-zeta-hydro-deps
git status
```

- [ ] All new files are tracked
- [ ] No unexpected files are untracked
- [ ] .gitignore is appropriate

```bash
# Check file permissions
find timely-benchmarks -type f -name "*.rs" -o -name "*.toml" -o -name "*.txt"
```
- [ ] All files have appropriate permissions

### ✅ Cross-Repository Verification

If applicable, verify relationship with source repository:

- [ ] Source repository still compiles (if benchmarks removed)
- [ ] No broken references in source repository
- [ ] Documentation in source repo updated (if needed)

## Summary Template

After completing verification, fill out this summary:

**Verification Date**: ________________  
**Verified By**: ________________  
**Rust Version**: ________________  
**Cargo Version**: ________________  

**Results**:
- [ ] ✅ All checks passed
- [ ] ⚠️ Some checks passed with warnings (list below)
- [ ] ❌ Some checks failed (list below)

**Issues Found**:
_List any issues discovered during verification_

**Warnings**:
_List any warnings that need attention_

**Notes**:
_Additional observations or comments_

## Quick Verification Script

For rapid verification, run this script:

```bash
#!/bin/bash
set -e

cd /projects/sandbox/bigweaver-agent-canary-zeta-hydro-deps

echo "=== File Structure Check ==="
ls -la
ls -la timely-benchmarks/
ls -la timely-benchmarks/benches/

echo "=== Build Check ==="
cargo check --workspace

echo "=== Quick Benchmark Test ==="
cargo bench -p timely-benchmarks --bench arithmetic -- --test

echo "=== Data File Check ==="
ls -lh timely-benchmarks/benches/*.txt

echo "=== Verification Complete ==="
echo "All basic checks passed! ✅"
echo "Run full benchmark suite with: cargo bench --workspace"
```

Save as `verify.sh`, make executable with `chmod +x verify.sh`, and run with `./verify.sh`.
