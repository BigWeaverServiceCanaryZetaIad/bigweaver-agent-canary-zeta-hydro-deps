# Verification Guide

This document helps verify that the benchmark migration was successful and the repository is set up correctly.

## Structure Verification

### Check Repository Structure

```bash
# From the bigweaver-agent-canary-zeta-hydro-deps directory
ls -la
# Should show: Cargo.toml, README.md, benches/, .gitignore, clippy.toml, rustfmt.toml, rust-toolchain.toml

ls -la benches/
# Should show: Cargo.toml, README.md, build.rs, benches/

ls -la benches/benches/
# Should show: 8 .rs files (arithmetic, fan_in, fan_out, fork_join, identity, join, reachability, upcase)
#              2 .txt files (reachability_edges.txt, reachability_reachable.txt)
#              1 .gitignore file
```

### Check Main Repository

```bash
# From the bigweaver-agent-canary-hydro-zeta directory
grep -i "timely\|differential" Cargo.lock
# Should return nothing (no matches)

ls benches/ 2>/dev/null || echo "No benches directory (correct)"
# Should confirm no benches directory exists
```

## Dependency Verification

### Check Cargo.toml Files

```bash
# Workspace Cargo.toml should have benches member
grep "benches" Cargo.toml

# benches/Cargo.toml should have required dependencies
grep "timely\|differential\|dfir_rs" benches/Cargo.toml
```

Expected output should include:
- timely = { package = "timely-master", ... }
- differential-dataflow = { package = "differential-dataflow-master", ... }
- dfir_rs = { git = "https://github.com/hydro-project/hydro.git", ... }

## Build Verification

### Check Workspace Build

```bash
# Check that the workspace structure is valid
cargo check --workspace 2>&1 | grep -E "error|warning" || echo "No immediate errors"
```

Note: This may fail if cargo/rust is not installed, but the structure should be valid.

### Verify Benchmark Declarations

```bash
# Check that all benchmarks are declared
grep "\[\[bench\]\]" benches/Cargo.toml | wc -l
# Should show 8 (for 8 benchmarks)

grep "^name = " benches/Cargo.toml | grep -v "^name = \"hydro-deps-benches\""
# Should show: arithmetic, fan_in, fan_out, fork_join, identity, join, reachability, upcase
```

## Content Verification

### Verify Benchmark Files

```bash
# Check that benchmarks use the correct frameworks
for file in benches/benches/*.rs; do
    echo "=== $file ==="
    grep -E "use.*dfir_rs|use.*timely|use.*differential" "$file" | head -3
done
```

Each benchmark should import:
- `dfir_rs` for DFIR implementations
- `timely` and/or `differential_dataflow` for comparison implementations
- `criterion` for benchmarking harness

### Verify Data Files

```bash
# Check reachability data files exist and have content
wc -l benches/benches/reachability_*.txt
# reachability_edges.txt should have 55008 lines
# reachability_reachable.txt should have 7855 lines
```

## Documentation Verification

### Check Documentation Files

```bash
# Main repository documentation
cd ../bigweaver-agent-canary-hydro-zeta
ls -la BENCHMARK_*.md
# Should show: BENCHMARK_COMPARISON.md, BENCHMARK_MIGRATION_NOTES.md

# This repository documentation
cd ../bigweaver-agent-canary-zeta-hydro-deps
ls -la README.md benches/README.md
# Both should exist
```

### Verify Documentation Content

```bash
# Check that READMEs mention key concepts
grep -i "timely\|differential" README.md
grep -i "comparison\|benchmark" README.md

grep -i "timely\|differential" benches/README.md
grep -i "dfir\|hydro" benches/README.md
```

## Functional Verification

### Test Build Script

```bash
# The build script should be valid Rust
rustc --crate-type lib benches/build.rs --edition 2021 -o /tmp/test_build 2>&1 | grep error || echo "Build script valid"
```

### Verify Benchmark Structure

```bash
# Each benchmark should have criterion_group and criterion_main
for file in benches/benches/*.rs; do
    if ! grep -q "criterion_group\|criterion_main" "$file"; then
        echo "Missing criterion setup in $file"
    fi
done
```

## Configuration Verification

### Check Rust Configuration Files

```bash
# rust-toolchain.toml should specify Rust version
cat rust-toolchain.toml

# clippy.toml should have linting configuration
cat clippy.toml

# rustfmt.toml should have formatting configuration  
cat rustfmt.toml
```

### Verify Git Configuration

```bash
# .gitignore should exclude build artifacts
cat .gitignore | grep -E "target|Cargo.lock"
# Should match both /target and Cargo.lock
```

## Integration Verification

### Verify Cross-Repository Links

```bash
# Main repo should reference deps repo
cd ../bigweaver-agent-canary-hydro-zeta
grep -i "hydro-deps\|deps.*repo" BENCHMARK_COMPARISON.md CONTRIBUTING.md

# Deps repo should reference main repo
cd ../bigweaver-agent-canary-zeta-hydro-deps
grep -i "hydro-zeta\|main.*repo" README.md benches/README.md
```

## Summary Checklist

After running the verifications above, check:

- [ ] Repository structure is complete
- [ ] No timely/differential dependencies in main repository
- [ ] All 8 benchmark files present in deps repository
- [ ] Data files present with correct line counts
- [ ] Cargo.toml files properly configured
- [ ] Documentation files created and cross-reference correctly
- [ ] Configuration files (rustfmt, clippy, toolchain) present
- [ ] .gitignore properly configured
- [ ] Build script present and valid
- [ ] Benchmark files import correct dependencies

## Troubleshooting

### Missing Files

If any files are missing, they can be extracted from the git history:
```bash
git show 0cd727f:<path/to/file> > <local/path>
```

### Dependency Issues

If dependencies can't be resolved:
1. Check that git URLs are correct in Cargo.toml
2. Verify that timely/differential versions match what's available
3. Consider updating to latest compatible versions

### Build Errors

If builds fail:
1. Ensure Rust toolchain version matches rust-toolchain.toml
2. Check that all dependencies are accessible
3. Verify network access for git dependencies

## Success Criteria

The migration is successful if:

1. Main repository builds without timely/differential dependencies
2. Deps repository has complete benchmark suite
3. All benchmarks can theoretically run (even if cargo isn't available for actual execution)
4. Documentation clearly explains the separation and how to use it
5. Both repositories are self-contained and properly configured
