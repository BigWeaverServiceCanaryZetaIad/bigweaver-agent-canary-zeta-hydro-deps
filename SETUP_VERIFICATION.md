# Setup Verification Checklist

This document helps you verify that the timely and differential-dataflow benchmarks are properly configured in the bigweaver-agent-canary-zeta-hydro-deps repository.

## Automated Verification

Run the verification script to automatically check all components:

```bash
cd bigweaver-agent-canary-zeta-hydro-deps
bash scripts/verify_benchmarks.sh
```

This script checks:
- Directory structure
- Cargo.toml configuration
- Benchmark files presence
- Data files
- Dependencies
- Documentation
- Helper scripts

## Manual Verification

If you prefer to verify manually or if the script is not available, follow these steps:

### 1. Directory Structure

Verify the repository structure:

```bash
tree -L 3 bigweaver-agent-canary-zeta-hydro-deps
```

Expected structure:
```
bigweaver-agent-canary-zeta-hydro-deps/
├── Cargo.toml
├── LICENSE
├── README.md
├── MIGRATION.md
├── BENCHMARK_USAGE.md
├── QUICK_REFERENCE.md
├── SETUP_VERIFICATION.md
├── benches/
│   ├── Cargo.toml
│   ├── README.md
│   └── benches/
│       ├── arithmetic.rs
│       ├── fan_in.rs
│       ├── fan_out.rs
│       ├── fork_join.rs
│       ├── identity.rs
│       ├── join.rs
│       ├── reachability.rs
│       ├── reachability_edges.txt
│       ├── reachability_reachable.txt
│       └── upcase.rs
└── scripts/
    ├── compare_with_main.sh
    └── verify_benchmarks.sh
```

### 2. Benchmark Files

Check that all 8 benchmark files exist:

```bash
ls -1 benches/benches/*.rs
```

Expected output:
```
benches/benches/arithmetic.rs
benches/benches/fan_in.rs
benches/benches/fan_out.rs
benches/benches/fork_join.rs
benches/benches/identity.rs
benches/benches/join.rs
benches/benches/reachability.rs
benches/benches/upcase.rs
```

### 3. Data Files

Check that data files for reachability benchmarks exist:

```bash
ls -lh benches/benches/*.txt
```

Expected:
- `reachability_edges.txt` (~520 KB)
- `reachability_reachable.txt` (~38 KB)

### 4. Dependencies in Cargo.toml

Check that all required dependencies are configured:

```bash
grep -A 1 "timely\|differential-dataflow\|dfir_rs\|criterion\|sinktools" benches/Cargo.toml
```

Expected dependencies:
- ✓ criterion = "0.5.0"
- ✓ dfir_rs (git dependency)
- ✓ differential-dataflow (aliased as differential-dataflow-master)
- ✓ timely (aliased as timely-master)
- ✓ sinktools (git dependency)

### 5. Benchmark Entries in Cargo.toml

Check that all benchmarks are registered:

```bash
grep -c "^\[\[bench\]\]" benches/Cargo.toml
```

Expected: 8 entries (one for each benchmark)

Verify specific entries:
```bash
grep "name = " benches/Cargo.toml | grep bench -A 1
```

### 6. Criterion Imports in Benchmarks

Check that benchmarks have proper criterion setup:

```bash
for bench in benches/benches/*.rs; do
    echo "Checking $(basename $bench)..."
    grep -q "use criterion" "$bench" && echo "  ✓ Has criterion imports"
    grep -q "criterion_main" "$bench" && echo "  ✓ Has criterion_main"
done
```

All benchmarks should pass both checks.

### 7. Documentation Files

Check that all documentation is present:

```bash
ls -1 *.md
```

Expected:
- README.md
- MIGRATION.md
- BENCHMARK_USAGE.md
- QUICK_REFERENCE.md
- SETUP_VERIFICATION.md (this file)

### 8. Scripts

Check that helper scripts exist:

```bash
ls -1 scripts/*.sh
```

Expected:
- compare_with_main.sh
- verify_benchmarks.sh

## Functional Verification

### Test Cargo Check

Verify that the benchmarks can be type-checked (requires Rust/Cargo):

```bash
cd bigweaver-agent-canary-zeta-hydro-deps
cargo check --package hydro-benches-comparison
```

Expected: No errors (warnings are acceptable)

### Test Benchmark Discovery

List all discoverable benchmarks:

```bash
cargo bench --package hydro-benches-comparison --no-run 2>&1 | grep "Compiling"
```

This should show compilation of the benchmark package.

### Test Single Benchmark (Quick)

Run a quick test of one benchmark with minimal samples:

```bash
cargo bench --bench identity -- --sample-size 10 --warm-up-time 1
```

This should complete in under a minute and produce timing results.

## Dependency Verification

### Check Git Dependencies

Verify that git dependencies can be fetched:

```bash
cargo fetch
```

Expected: Downloads dfir_rs and sinktools from GitHub

If this fails:
- Check network connectivity
- Verify git credentials
- Check GitHub access

### Check Package Versions

Verify timely and differential versions:

```bash
cargo metadata --format-version 1 | grep -A 3 "timely-master\|differential-dataflow-master"
```

Expected:
- timely-master: 0.13.0-dev.1
- differential-dataflow-master: 0.13.0-dev.1

## Cross-Repository Verification

### Check Main Repository Location

If you plan to use cross-repository comparison:

```bash
ls -d ../bigweaver-agent-canary-hydro-zeta 2>/dev/null && echo "✓ Main repository found" || echo "✗ Main repository not found"
```

If not found, you can:
1. Clone the main repository alongside this one
2. Use `--main-repo` option with comparison script
3. Skip main repository benchmarks with `--no-main`

### Test Comparison Script

Test the comparison script in dry-run mode:

```bash
bash scripts/compare_with_main.sh --help
```

Should display usage information.

## Common Issues and Solutions

### Issue: "cargo: command not found"

**Solution**: Install Rust toolchain
```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

### Issue: Git dependency fetch fails

**Solution**: Check GitHub access and credentials
```bash
ssh -T git@github.com
```

If SSH fails, the repository will try HTTPS with credentials.

### Issue: Benchmark files exist but cargo doesn't find them

**Solution**: Check [[bench]] entries in Cargo.toml
```bash
grep -B 1 -A 2 "^\[\[bench\]\]" benches/Cargo.toml
```

Each benchmark needs:
```toml
[[bench]]
name = "benchmark_name"
harness = false
```

### Issue: "package `hydro-benches-comparison` not found"

**Solution**: You're in the wrong directory
```bash
cd bigweaver-agent-canary-zeta-hydro-deps
cargo check --package hydro-benches-comparison
```

### Issue: Compilation errors in benchmark files

**Solution**: Update dependencies
```bash
cargo update
cargo clean
cargo check
```

## Performance Baseline

Once verification is complete, establish a performance baseline:

```bash
# Run all benchmarks and save as baseline
cargo bench --save-baseline initial

# Results are saved for future comparison
ls -d target/criterion/*/base/
```

## Integration Verification

### Verify DFIR Integration

Check that benchmarks can import DFIR components:

```bash
grep "use dfir_rs" benches/benches/*.rs | wc -l
```

Expected: Multiple uses across benchmark files

### Verify Timely Integration

Check that benchmarks can import timely components:

```bash
grep "use timely" benches/benches/*.rs | wc -l
```

Expected: Multiple uses across benchmark files

### Verify Differential Integration

Check that benchmarks can import differential components:

```bash
grep "use differential_dataflow" benches/benches/*.rs | wc -l
```

Expected: Uses in reachability and other benchmarks

## Final Checklist

Before considering the setup complete:

- [ ] All 8 benchmark files present
- [ ] Both data files present (reachability_*.txt)
- [ ] All dependencies configured in Cargo.toml
- [ ] All benchmark entries in Cargo.toml
- [ ] All documentation files present
- [ ] Helper scripts present
- [ ] `cargo check` passes without errors
- [ ] `cargo fetch` completes successfully
- [ ] At least one benchmark runs successfully
- [ ] Verification script passes (if available)

## Next Steps

Once verification is complete:

1. **Read the documentation**:
   - Start with README.md for overview
   - Read BENCHMARK_USAGE.md for detailed usage
   - Keep QUICK_REFERENCE.md handy

2. **Run your first benchmarks**:
   ```bash
   cargo bench --bench identity    # Quick benchmark
   cargo bench --bench arithmetic  # Medium benchmark
   ```

3. **Set up cross-repository comparison** (if needed):
   ```bash
   bash scripts/compare_with_main.sh
   ```

4. **Establish baseline performance**:
   ```bash
   cargo bench --save-baseline $(date +%Y%m%d)
   ```

## Getting Help

If verification fails or you encounter issues:

1. Check the Troubleshooting section in BENCHMARK_USAGE.md
2. Review MIGRATION.md for context on the repository structure
3. Check the main repository's BENCHMARK_MIGRATION.md
4. File an issue in the appropriate repository

## Maintenance

This verification should be run:
- After initial repository clone
- After major dependency updates
- After adding new benchmarks
- When experiencing unexpected benchmark failures
- As part of CI/CD setup verification

Regular verification helps catch configuration drift early.
