# Setup Verification Checklist

This document provides a checklist to verify that the bigweaver-agent-canary-zeta-hydro-deps repository is correctly set up.

## Repository Structure

### Root Files
- [x] `Cargo.toml` - Workspace configuration
- [x] `README.md` - Repository overview and usage instructions
- [x] `BENCHMARK_GUIDE.md` - Comprehensive benchmark documentation
- [x] `MIGRATION_SUMMARY.md` - Migration details from main repository
- [x] `SETUP_VERIFICATION.md` - This verification checklist
- [x] `rust-toolchain.toml` - Rust version specification
- [x] `rustfmt.toml` - Code formatting configuration
- [x] `clippy.toml` - Linting configuration
- [x] `.gitignore` - Git ignore patterns

### Benches Directory
- [x] `benches/Cargo.toml` - Package manifest with dependencies and benchmark declarations
- [x] `benches/README.md` - Quick usage guide
- [x] `benches/build.rs` - Build script for generating fork_join benchmark code

### Benchmark Files (benches/benches/)
- [x] `arithmetic.rs` - Arithmetic operations benchmarks
- [x] `fan_in.rs` - Multiple input merging benchmarks
- [x] `fan_out.rs` - Stream splitting benchmarks
- [x] `fork_join.rs` - Fork-join parallel patterns
- [x] `futures.rs` - Async futures implementations
- [x] `identity.rs` - Identity transformation benchmarks
- [x] `join.rs` - Join operation benchmarks
- [x] `micro_ops.rs` - Individual operator microbenchmarks
- [x] `reachability.rs` - Graph reachability algorithms
- [x] `symmetric_hash_join.rs` - Symmetric hash join benchmarks
- [x] `upcase.rs` - String transformation benchmarks
- [x] `words_diamond.rs` - Diamond dataflow pattern benchmarks

### Data Files (benches/benches/)
- [x] `words_alpha.txt` - English word list (3.7 MB)
- [x] `reachability_edges.txt` - Graph edge data (521 KB)
- [x] `reachability_reachable.txt` - Expected reachable nodes (38 KB)
- [x] `.gitignore` - Ignore generated files

## Configuration Verification

### Workspace Configuration (Cargo.toml)
```bash
# Verify workspace is properly configured
grep -q "members.*benches" Cargo.toml && echo "✓ Workspace members configured"
grep -q "resolver.*2" Cargo.toml && echo "✓ Resolver 2 enabled"
```

### Package Configuration (benches/Cargo.toml)
```bash
# Verify all dependencies are present
cd benches
grep -q "criterion" Cargo.toml && echo "✓ Criterion dependency"
grep -q "dfir_rs" Cargo.toml && echo "✓ dfir_rs dependency"
grep -q "timely" Cargo.toml && echo "✓ Timely dependency"
grep -q "differential-dataflow" Cargo.toml && echo "✓ Differential-dataflow dependency"

# Verify all benchmarks are declared
for bench in arithmetic fan_in fan_out fork_join identity upcase join reachability micro_ops symmetric_hash_join words_diamond futures; do
    grep -q "name.*$bench" Cargo.toml && echo "✓ Benchmark $bench declared"
done
```

## Build Verification

### Compilation Check
```bash
# Verify workspace builds
cargo check --workspace

# Verify benchmarks compile
cargo check --workspace --benches

# Verify build script runs
cargo build -p benches
```

### File Presence Check
```bash
# Verify all benchmark files exist
for file in arithmetic fan_in fan_out fork_join futures identity join micro_ops reachability symmetric_hash_join upcase words_diamond; do
    test -f benches/benches/${file}.rs && echo "✓ ${file}.rs exists"
done

# Verify data files exist
test -f benches/benches/words_alpha.txt && echo "✓ words_alpha.txt exists"
test -f benches/benches/reachability_edges.txt && echo "✓ reachability_edges.txt exists"
test -f benches/benches/reachability_reachable.txt && echo "✓ reachability_reachable.txt exists"

# Verify data files are not empty
test -s benches/benches/words_alpha.txt && echo "✓ words_alpha.txt not empty"
test -s benches/benches/reachability_edges.txt && echo "✓ reachability_edges.txt not empty"
test -s benches/benches/reachability_reachable.txt && echo "✓ reachability_reachable.txt not empty"
```

## Runtime Verification

### Quick Benchmark Test
```bash
# Run one benchmark to verify everything works
cargo bench -p benches --bench identity -- --sample-size 10

# Check criterion output directory was created
test -d target/criterion && echo "✓ Criterion reports generated"
```

### Performance Comparison Test
```bash
# Run a benchmark that includes all implementations
cargo bench -p benches --bench arithmetic -- --sample-size 10

# Verify it tests Hydro, Timely, and Differential
cargo bench -p benches --bench arithmetic -- --sample-size 10 2>&1 | grep -q "hydro\|timely\|differential" && echo "✓ Multiple implementations tested"
```

## Documentation Verification

### Documentation Completeness
```bash
# Verify README has essential sections
grep -q "## Benchmarks" README.md && echo "✓ Benchmarks section"
grep -q "## Running Benchmarks" README.md && echo "✓ Running instructions"
grep -q "## Dependencies" README.md && echo "✓ Dependencies section"

# Verify BENCHMARK_GUIDE has all benchmarks documented
for bench in arithmetic fan_in fan_out fork_join identity join micro_ops reachability symmetric_hash_join upcase words_diamond futures; do
    grep -qi "$bench" BENCHMARK_GUIDE.md && echo "✓ $bench documented"
done

# Verify MIGRATION_SUMMARY exists
test -f MIGRATION_SUMMARY.md && echo "✓ Migration summary present"
```

## Git Configuration Verification

### Git Ignore Patterns
```bash
# Verify important patterns are ignored
grep -q "target" .gitignore && echo "✓ Target directory ignored"
grep -q "Cargo.lock" .gitignore && echo "✓ Cargo.lock ignored"
grep -q "\.rs\.bk" .gitignore && echo "✓ Backup files ignored"
```

## Dependency Verification

### External Dependencies Check
```bash
# Verify git dependencies reference correct repository
grep -q "BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta" benches/Cargo.toml && echo "✓ Main repo git dependency"

# Verify package aliases are correct
grep -q "package.*timely-master" benches/Cargo.toml && echo "✓ Timely package alias"
grep -q "package.*differential-dataflow-master" benches/Cargo.toml && echo "✓ Differential package alias"
```

## Integration Tests

### Full Build and Test
```bash
# Clean build to verify everything from scratch
cargo clean
cargo build --workspace --release

# Run all benchmarks (quick mode)
cargo bench -p benches -- --sample-size 10 --quick

# Check for warnings
cargo clippy --workspace -- -D warnings

# Check formatting
cargo fmt --check --all
```

## Success Criteria

All items should be checked (✓) for the repository to be considered properly set up:

1. **Structure**: All directories and files in place
2. **Configuration**: Cargo.toml files properly configured
3. **Compilation**: Code compiles without errors
4. **Execution**: Benchmarks run successfully
5. **Documentation**: All documentation complete and accurate
6. **Integration**: Works with main repository dependencies

## Troubleshooting

### Common Issues

1. **Compilation Errors**
   - Ensure Rust toolchain matches `rust-toolchain.toml`
   - Update dependencies: `cargo update`
   - Clear cache: `cargo clean`

2. **Missing Data Files**
   - Verify data files exist in `benches/benches/`
   - Check file sizes match expected values

3. **Benchmark Failures**
   - Reduce sample size for faster testing
   - Check available system resources
   - Verify criterion version compatibility

4. **Git Dependency Issues**
   - Ensure network connectivity
   - Verify git repository URLs are correct
   - Check git credentials if private repository

## Verification Script

Run this script to perform all checks:

```bash
#!/bin/bash
set -e

echo "=== Repository Structure ==="
test -f Cargo.toml && echo "✓ Root Cargo.toml"
test -f benches/Cargo.toml && echo "✓ Benches Cargo.toml"
test -d benches/benches && echo "✓ Benches directory"

echo -e "\n=== Benchmark Files ==="
for file in arithmetic fan_in fan_out fork_join futures identity join micro_ops reachability symmetric_hash_join upcase words_diamond; do
    test -f benches/benches/${file}.rs && echo "✓ ${file}.rs"
done

echo -e "\n=== Data Files ==="
test -s benches/benches/words_alpha.txt && echo "✓ words_alpha.txt"
test -s benches/benches/reachability_edges.txt && echo "✓ reachability_edges.txt"
test -s benches/benches/reachability_reachable.txt && echo "✓ reachability_reachable.txt"

echo -e "\n=== Documentation ==="
test -f README.md && echo "✓ README.md"
test -f BENCHMARK_GUIDE.md && echo "✓ BENCHMARK_GUIDE.md"
test -f MIGRATION_SUMMARY.md && echo "✓ MIGRATION_SUMMARY.md"

echo -e "\n=== Build Check ==="
cargo check --workspace 2>&1 | tail -1

echo -e "\n✅ All verifications complete!"
```

Save this script as `verify.sh`, make it executable with `chmod +x verify.sh`, and run it to verify the setup.
