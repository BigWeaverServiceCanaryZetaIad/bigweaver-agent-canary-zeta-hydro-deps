# Integration Guide

This guide explains how to integrate the timely and differential-dataflow benchmarks with the main `bigweaver-agent-canary-hydro-zeta` repository and how to set up dependencies.

## Overview

The benchmarks in this repository can run in two modes:

1. **Standalone Mode**: Only timely and differential-dataflow benchmarks without Hydroflow integration
2. **Integrated Mode**: Full benchmarks including Hydroflow comparisons using dfir_rs and sinktools

## Repository Layout

For proper integration, clone both repositories side-by-side:

```
projects/
├── bigweaver-agent-canary-hydro-zeta/         # Main repository
│   ├── dfir_rs/
│   ├── sinktools/
│   └── ...
└── bigweaver-agent-canary-zeta-hydro-deps/    # This repository
    └── benches/
```

## Integration Methods

### Method 1: Path Dependencies (Recommended for Development)

This method uses local path references to the main repository.

#### Step 1: Clone Both Repositories

```bash
cd /path/to/projects
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
```

#### Step 2: Update benches/Cargo.toml

Edit `benches/Cargo.toml` and uncomment the path dependencies:

```toml
[dev-dependencies]
# ... existing dependencies ...

# Uncomment these lines for integration:
dfir_rs = { path = "../../bigweaver-agent-canary-hydro-zeta/dfir_rs", features = [ "debugging" ] }
sinktools = { path = "../../bigweaver-agent-canary-hydro-zeta/sinktools", version = "^0.0.1" }
```

#### Step 3: Verify Integration

```bash
cd bigweaver-agent-canary-zeta-hydro-deps
cargo build -p hydro-deps-benches
cargo bench -p hydro-deps-benches --bench arithmetic
```

### Method 2: Git Dependencies (For CI/CD)

Use Git references for automated builds.

#### Update benches/Cargo.toml:

```toml
[dev-dependencies]
# ... existing dependencies ...

dfir_rs = { git = "https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git", features = [ "debugging" ] }
sinktools = { git = "https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git", version = "^0.0.1" }
```

### Method 3: Standalone Mode (Default)

Run only the timely and differential-dataflow benchmarks without Hydroflow integration.

This is the default configuration. Some benchmark functions that require dfir_rs will be commented out or conditionally compiled.

#### Running Standalone Benchmarks:

```bash
# These work without integration:
cargo bench -p hydro-deps-benches --bench join
cargo bench -p hydro-deps-benches --bench upcase
cargo bench -p hydro-deps-benches --bench reachability -- differential
```

## Benchmark-Specific Integration

### Benchmarks Requiring Integration

These benchmarks include Hydroflow implementations and require dfir_rs:

- **arithmetic.rs**: Includes dfir_rs/interpreted and dfir_rs/compiled variants
- **fan_in.rs**: Includes dfir_rs variant
- **fan_out.rs**: Includes dfir_rs variant
- **fork_join.rs**: Includes dfir_rs/interpreted and dfir_rs/compiled variants
- **identity.rs**: Includes dfir_rs/interpreted and dfir_rs/compiled variants
- **reachability.rs**: Includes dfir_rs variant and uses sinktools

### Standalone Benchmarks

These benchmarks work without integration:

- **join.rs**: Pure timely implementation
- **upcase.rs**: Pure timely implementation
- Partial runs of other benchmarks (timely/differential variants only)

## Conditional Compilation

To support both modes, you can use conditional compilation in the benchmarks:

```rust
#[cfg(feature = "with-hydroflow")]
fn benchmark_hydroflow(c: &mut Criterion) {
    use dfir_rs::dfir_syntax;
    // ... implementation
}

#[cfg(feature = "with-hydroflow")]
benchmark_hydroflow(&mut criterion);
```

Add to `benches/Cargo.toml`:

```toml
[features]
default = []
with-hydroflow = ["dfir_rs", "sinktools"]
```

Then run with:

```bash
cargo bench -p hydro-deps-benches --features with-hydroflow
```

## CI/CD Integration

### GitHub Actions Example

Create `.github/workflows/benchmarks.yml`:

```yaml
name: Benchmarks

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  benchmark:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout hydro-deps
        uses: actions/checkout@v3
        with:
          path: hydro-deps

      - name: Checkout main repo
        uses: actions/checkout@v3
        with:
          repository: BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta
          path: bigweaver-agent-canary-hydro-zeta

      - name: Setup Rust
        uses: actions-rs/toolchain@v1
        with:
          toolchain: stable
          override: true

      - name: Run Benchmarks
        run: |
          cd hydro-deps
          cargo bench -p hydro-deps-benches
```

## Version Compatibility

### Ensuring Compatible Versions

The benchmarks depend on specific versions of timely and differential-dataflow. Ensure these match the versions used in the main repository.

Check versions:

```bash
# In main repository
cd bigweaver-agent-canary-hydro-zeta
cargo tree | grep timely

# In deps repository
cd bigweaver-agent-canary-zeta-hydro-deps
cargo tree -p hydro-deps-benches | grep timely
```

### Updating Dependency Versions

When updating timely or differential-dataflow:

1. Update in main repository first
2. Update in this repository to match
3. Test compatibility
4. Update both repositories together in PRs

## Performance Comparison Workflow

### Comparing Implementations

To compare Hydroflow vs. Timely implementations:

1. **Set up integration** using Method 1 or 2
2. **Run specific benchmark**:
   ```bash
   cargo bench -p hydro-deps-benches --bench arithmetic
   ```
3. **Review HTML reports** in `target/criterion/arithmetic/report/`
4. **Analyze differences** between implementations

### Tracking Performance Over Time

1. **Establish baseline** in both repositories:
   ```bash
   cd bigweaver-agent-canary-hydro-zeta
   cargo bench -p benches -- --save-baseline main-repo
   
   cd ../bigweaver-agent-canary-zeta-hydro-deps
   cargo bench -p hydro-deps-benches -- --save-baseline deps-repo
   ```

2. **Make changes** in either repository

3. **Compare performance**:
   ```bash
   cargo bench -p hydro-deps-benches -- --baseline deps-repo
   ```

## Troubleshooting Integration Issues

### Issue: Cannot find dfir_rs

**Solution**: Verify path or git reference is correct in `benches/Cargo.toml`.

```bash
# Check if main repo is cloned:
ls -la ../bigweaver-agent-canary-hydro-zeta/dfir_rs

# Verify Cargo.toml path:
cat benches/Cargo.toml | grep dfir_rs
```

### Issue: Version Mismatch

**Error**: `the trait bound ... is not satisfied`

**Solution**: Ensure timely/differential versions match between repositories.

```bash
# Compare versions
grep -A1 "timely.*=" benches/Cargo.toml
grep -A1 "timely.*=" ../bigweaver-agent-canary-hydro-zeta/*/Cargo.toml
```

### Issue: Build Script Fails

**Error**: `benches/build.rs error`

**Solution**: Check that build.rs has proper permissions and dependencies.

```bash
# Rebuild clean
cargo clean
cargo build -p hydro-deps-benches -v
```

### Issue: Benchmark Data Files Missing

**Error**: `No such file or directory: reachability_edges.txt`

**Solution**: Ensure data files are in the correct location.

```bash
# Verify data files exist:
ls -lh benches/benches/*.txt

# Check working directory during benchmark:
cargo bench -p hydro-deps-benches --bench reachability -- --verbose
```

## Synchronized Updates

When making changes that affect both repositories:

### Creating Companion PRs

1. **Create feature branch** in both repositories:
   ```bash
   cd bigweaver-agent-canary-hydro-zeta
   git checkout -b feature-update-benchmarks-20251126
   
   cd ../bigweaver-agent-canary-zeta-hydro-deps
   git checkout -b feature-update-benchmarks-20251126
   ```

2. **Make coordinated changes** in both repositories

3. **Test integration**:
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps
   cargo bench -p hydro-deps-benches
   ```

4. **Create PRs** referencing each other:
   - PR in main repo: "Update benchmarks (companion: hydro-deps#123)"
   - PR in deps repo: "Update benchmarks (companion: hydro-zeta#456)"

5. **Review and merge together**

## Best Practices

### For Development

- Use **path dependencies** for local development
- Keep **versions synchronized** between repositories
- Run **benchmarks in both repos** before committing
- Document **breaking changes** clearly

### For CI/CD

- Use **git dependencies** with specific commits or tags
- Pin **specific versions** for reproducible builds
- Cache **Cargo builds** to speed up CI
- Run **subset of benchmarks** for quick feedback

### For Performance Testing

- Establish **consistent baseline** across repositories
- Use **same hardware** for comparative benchmarks
- Document **configuration** in benchmark reports
- Track **performance trends** over time

## Migration from Main Repository

If you previously ran these benchmarks from the main repository:

### Update Scripts

Old command:
```bash
cd bigweaver-agent-canary-hydro-zeta
cargo bench -p benches --bench arithmetic
```

New command:
```bash
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench -p hydro-deps-benches --bench arithmetic
```

### Update CI/CD Pipelines

Update benchmark workflows to:
1. Clone both repositories
2. Use path dependencies
3. Run benchmarks from deps repository

### Update Documentation

Update references in documentation from:
- `benches` package → `hydro-deps-benches` package
- Main repository path → Deps repository path

## Support

For integration issues:

1. Check this guide for common solutions
2. Review [QUICKSTART.md](QUICKSTART.md) for setup
3. Consult [BENCHMARK_DETAILS.md](BENCHMARK_DETAILS.md) for specifics
4. Contact the Development Team or Performance Testing Team
5. Open an issue in the repository

---

**Related Documentation**:
- [README.md](README.md) - Repository overview
- [QUICKSTART.md](QUICKSTART.md) - Quick setup guide
- [BENCHMARK_DETAILS.md](BENCHMARK_DETAILS.md) - Benchmark descriptions
- Main repository: [BENCHMARK_MIGRATION_GUIDE.md](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta/blob/main/BENCHMARK_MIGRATION_GUIDE.md)
