# Migration Guide: Benchmark Repository Setup

This document explains how the timely and differential-dataflow benchmarks were migrated from the main Hydro repository to this standalone repository.

## Background

The benchmarks were originally located in the `benches/` directory of the `bigweaver-agent-canary-hydro-zeta` repository. They were moved to enable:

1. **Reduced dependency footprint** in the main repository
2. **Faster CI/CD builds** without heavy benchmark dependencies
3. **Independent benchmark development** and versioning
4. **Optional performance testing** (clone only when needed)

## What Was Moved

### Files Transferred

All files from `benches/` directory:

```
benches/
├── Cargo.toml                          # Benchmark package configuration
├── README.md                           # Benchmark documentation
├── build.rs                            # Build script
└── benches/
    ├── .gitignore
    ├── arithmetic.rs                   # Arithmetic operations benchmark
    ├── fan_in.rs                       # Fan-in pattern benchmark
    ├── fan_out.rs                      # Fan-out pattern benchmark
    ├── fork_join.rs                    # Fork-join pattern benchmark
    ├── futures.rs                      # Async futures benchmark
    ├── identity.rs                     # Identity/passthrough benchmark
    ├── join.rs                         # Join operations benchmark
    ├── micro_ops.rs                    # Micro-operations benchmark
    ├── reachability.rs                 # Graph reachability benchmark
    ├── reachability_edges.txt          # Test data (~524KB)
    ├── reachability_reachable.txt      # Test data (~40KB)
    ├── symmetric_hash_join.rs          # Symmetric hash join benchmark
    ├── upcase.rs                       # String transformation benchmark
    ├── words_alpha.txt                 # Word list test data (~3.7MB)
    └── words_diamond.rs                # Diamond pattern benchmark
```

**Total size**: ~4.4MB (mostly test data files)

### Dependencies Moved

The following dependencies are now only in this repository:

#### Comparison Frameworks
- `timely` (package: "timely-master", version: "0.13.0-dev.1")
- `differential-dataflow` (package: "differential-dataflow-master", version: "0.13.0-dev.1")

#### Benchmarking Infrastructure
- `criterion` (version: "0.5.0", features: ["async_tokio", "html_reports"])
- `rand` (version: "0.8.0")
- `rand_distr` (version: "0.4.3")
- `nameof` (version: "1.0.0")
- `seq-macro` (version: "0.2.0")
- `static_assertions` (version: "1.0.0")

#### Shared Dependencies (Now via Git)
- `dfir_rs` (from main Hydro repository)
- `sinktools` (from main Hydro repository)
- `futures` (version: "0.3")
- `tokio` (version: "1.29.0", features: ["rt-multi-thread"])

## Changes Made

### 1. Created Workspace Structure

Created `Cargo.toml` at repository root:

```toml
[workspace]
members = ["benches"]
resolver = "2"

[workspace.package]
edition = "2024"
license = "Apache-2.0"
repository = "https://github.com/hydro-project/hydro"

[workspace.lints.rust]
# ... (lints configuration)

[workspace.lints.clippy]
# ... (clippy lints)
```

### 2. Updated Benchmark Dependencies

Modified `benches/Cargo.toml` to use git dependencies:

**Before** (path dependencies):
```toml
dfir_rs = { path = "../dfir_rs", features = [ "debugging" ] }
sinktools = { path = "../sinktools", version = "^0.0.1" }
```

**After** (git dependencies):
```toml
dfir_rs = { git = "https://github.com/hydro-project/hydro", features = [ "debugging" ] }
sinktools = { git = "https://github.com/hydro-project/hydro", version = "^0.0.1" }
```

### 3. Enhanced Documentation

- Updated `benches/README.md` with comprehensive benchmark documentation
- Created root `README.md` with repository overview
- Created this `MIGRATION_GUIDE.md`

## Retaining Functionality

### Performance Comparison Capabilities ✅

All performance comparison functionality is retained:

1. **Multi-framework benchmarks**: DFIR, Timely, Differential implementations
2. **Statistical analysis**: Criterion.rs framework with HTML reports
3. **Test data**: All test data files preserved
4. **Build scripts**: `build.rs` for generated code

### Independent Execution ✅

Benchmarks can be executed independently:

```bash
# Clone the benchmark repository
git clone <repo-url>
cd bigweaver-agent-canary-zeta-hydro-deps

# Run benchmarks (fetches dependencies from git)
cargo bench

# Run specific benchmark
cargo bench --bench arithmetic
```

### Continuous Integration Ready ✅

The repository structure supports CI/CD integration:

```yaml
# Example .github/workflows/benchmark.yml
name: Benchmarks
on: [push, pull_request]

jobs:
  benchmark:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions-rs/toolchain@v1
        with:
          toolchain: stable
      - run: cargo bench --no-fail-fast
      - uses: actions/upload-artifact@v3
        with:
          name: benchmark-results
          path: target/criterion/
```

## Verification Steps

To verify the migration is complete and functional:

### 1. Check Repository Structure

```bash
ls -la
# Should show: Cargo.toml, README.md, MIGRATION_GUIDE.md, benches/
```

### 2. Verify All Files Present

```bash
cd benches/benches
ls -la
# Should show all 12 .rs benchmark files and 3 data files
```

### 3. Test Build

```bash
cargo check
# Should compile successfully, fetching dependencies from git
```

### 4. Run Sample Benchmark

```bash
cargo bench --bench arithmetic
# Should execute and generate criterion reports
```

### 5. Check Generated Reports

```bash
ls -la target/criterion/
# Should contain benchmark result directories and HTML reports
```

## Usage for Developers

### Running Benchmarks Locally

```bash
# Clone this repository
git clone <repo-url>
cd bigweaver-agent-canary-zeta-hydro-deps

# Run all benchmarks
cargo bench

# Run specific benchmark
cargo bench --bench reachability

# Run with specific test
cargo bench --bench arithmetic -- arithmetic/timely
```

### Adding New Benchmarks

1. Create `benches/benches/my_benchmark.rs`
2. Add to `benches/Cargo.toml`:
   ```toml
   [[bench]]
   name = "my_benchmark"
   harness = false
   ```
3. Implement framework comparisons
4. Test with `cargo bench --bench my_benchmark`

### Updating Dependencies

To use a specific version of Hydro:

```toml
# In benches/Cargo.toml
dfir_rs = { git = "https://github.com/hydro-project/hydro", rev = "abc123", features = [ "debugging" ] }
```

Or use a branch:

```toml
dfir_rs = { git = "https://github.com/hydro-project/hydro", branch = "main", features = [ "debugging" ] }
```

## Integration with Main Repository

### Reference from Main Repository

The main Hydro repository can reference these benchmarks:

1. **Documentation**: Link to this repository in performance documentation
2. **CI/CD**: Optional benchmark job that clones this repository
3. **Releases**: Coordinate releases if breaking changes affect benchmarks

### Keeping in Sync

When the main repository has breaking changes:

1. Update `benches/Cargo.toml` to use specific commit/tag
2. Fix any compilation errors
3. Verify benchmarks still run correctly
4. Update documentation if behavior changes

## Benefits Achieved

### For Main Repository
- ✅ ~4.4MB smaller repository size
- ✅ Faster builds without benchmark dependencies
- ✅ Cleaner dependency tree
- ✅ Focused on core functionality

### For Benchmarks
- ✅ Independent versioning
- ✅ Can update benchmark dependencies without affecting main repo
- ✅ Easier to add new comparison frameworks
- ✅ Clear purpose and structure

### For Users
- ✅ Optional: clone only if needed
- ✅ Self-contained: works independently
- ✅ Well-documented: clear instructions
- ✅ Maintained: preserves all functionality

## Troubleshooting

### Build Failures

If benchmarks fail to build:

```bash
# Update Cargo.lock
cargo update

# Try specific dependency version
# Edit benches/Cargo.toml to pin versions

# Check main repository compatibility
git log  # Check recent changes to Hydro repo
```

### Missing Dependencies

If git dependencies fail to fetch:

```bash
# Clear cargo cache
cargo clean
rm -rf ~/.cargo/git

# Retry build
cargo build
```

### Benchmark Failures

If benchmarks fail to run:

```bash
# Check test data files
ls -lh benches/benches/*.txt

# Run in verbose mode
cargo bench --bench <name> -- --verbose

# Check individual test
cargo bench --bench <name> -- <specific_test>
```

## Contact and Support

For issues related to:
- **Benchmark infrastructure**: Open issue in this repository
- **DFIR/Hydroflow functionality**: Open issue in main Hydro repository
- **Timely/Differential bugs**: Report to respective projects

## Changelog

- **2024-11-21**: Initial migration from bigweaver-agent-canary-hydro-zeta
  - Moved all benchmark files and test data
  - Created independent workspace structure
  - Updated dependencies to use git sources
  - Added comprehensive documentation
