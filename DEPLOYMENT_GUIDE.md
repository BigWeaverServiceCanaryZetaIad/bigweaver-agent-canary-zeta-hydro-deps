# Deployment and Setup Guide

This guide provides complete instructions for deploying and using the timely and differential-dataflow benchmarks in the bigweaver-agent-canary-zeta-hydro-deps repository.

## ✅ What Has Been Created

### Repository Structure

The repository now contains a complete benchmark suite with:

#### 📁 Core Files
- ✅ `Cargo.toml` - Workspace configuration with dependencies
- ✅ `README.md` - Main documentation and quick start guide
- ✅ `.gitignore` - Git ignore rules for Rust projects
- ✅ `Makefile` - Convenient build and test commands

#### 📁 Benchmark Packages

**Timely Benchmarks** (`timely-benchmarks/`)
- ✅ 5 comprehensive benchmark suites
- ✅ Utility library with data generators
- ✅ Unit tests for utilities
- ✅ Package-specific documentation

**Differential Benchmarks** (`differential-benchmarks/`)
- ✅ 5 incremental computation benchmarks
- ✅ Utility library with helpers
- ✅ Unit tests for utilities
- ✅ Package-specific documentation

#### 📁 Documentation
- ✅ `INSTALLATION.md` - Detailed setup instructions
- ✅ `BENCHMARKING.md` - Complete benchmarking guide
- ✅ `COMPARISON.md` - Performance comparison methodology
- ✅ `CONTRIBUTING.md` - Contribution guidelines
- ✅ `PROJECT_SUMMARY.md` - Comprehensive project overview
- ✅ `DEPLOYMENT_GUIDE.md` - This file

#### 📁 Tooling
- ✅ `run-benchmarks.sh` - Flexible benchmark runner
- ✅ `setup-validation.sh` - Installation verification
- ✅ `integration-test.sh` - Complete integration tests
- ✅ `.github/workflows/benchmarks.yml` - CI/CD configuration

### Benchmark Coverage

| Framework | Benchmarks | Operations Tested |
|-----------|-----------|-------------------|
| Timely | 5 suites | barrier, exchange, dataflow construction, progress tracking, unary operators |
| Differential | 5 suites | arrange, join, count, consolidate, distinct |

## 🚀 Quick Deployment Steps

### 1. Verify Repository

```bash
cd /projects/sandbox/bigweaver-agent-canary-zeta-hydro-deps
ls -la
```

Expected output should show all files listed above.

### 2. Run Integration Tests

```bash
./integration-test.sh
```

This validates the complete repository structure (52+ checks).

### 3. Install Rust (if needed)

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env
```

### 4. Validate Setup

```bash
./setup-validation.sh
```

This will:
- Check Rust installation
- Build all packages
- Run tests
- Verify benchmarks compile

### 5. Run Benchmarks

```bash
# Quick test
make bench-quick

# Full benchmark suite
make bench

# Specific framework
make bench-timely
make bench-differential
```

## 📦 Dependencies Configuration

### Workspace Dependencies (Cargo.toml)

```toml
[workspace.dependencies]
timely = "0.12"
differential-dataflow = "0.12"
criterion = { version = "0.5", features = ["html_reports"] }
rand = "0.8"
```

### Build Profile

```toml
[profile.release]
strip = true
opt-level = 3
lto = "fat"
codegen-units = 1
```

Optimized for:
- Maximum performance
- Minimal binary size
- Fast benchmarks

## 🔧 Configuration Options

### Environment Variables

```bash
# Set worker threads
export TIMELY_WORKER_THREADS=4

# Enable debug logging
export RUST_LOG=timely=debug,differential_dataflow=debug

# Run benchmarks
cargo bench
```

### Benchmark Parameters

Each benchmark can be customized by editing the `.rs` files:

```rust
// Change data sizes
for size in [1000, 10000, 100000].iter() {
    // Change to [100, 1000, 10000] for faster runs
}

// Adjust Criterion settings
Criterion::default()
    .sample_size(100)  // Number of iterations
    .measurement_time(Duration::from_secs(10))
```

## 🎯 Use Cases

### 1. Performance Testing

```bash
# Baseline before changes
./run-benchmarks.sh --save-baseline main

# After optimization
./run-benchmarks.sh --baseline main
```

### 2. Framework Comparison

```bash
# Compare timely vs differential
cargo bench --package timely-benchmarks --bench unary_operators
cargo bench --package differential-benchmarks --bench distinct

# View results
make view-results
```

### 3. Scalability Analysis

```bash
# Test with different worker counts
make bench-all-workers  # Tests 1, 2, 4 workers
```

### 4. CI/CD Integration

The included GitHub Actions workflow will:
- Run on every push and PR
- Test multiple worker configurations
- Generate and upload reports
- Compare against baselines

## 📊 Benchmark Details

### Timely Dataflow Benchmarks

1. **Barrier** (`barrier.rs`)
   - Tests: Synchronization overhead
   - Sizes: 1K, 10K, 100K elements
   - Purpose: Understanding sync costs

2. **Exchange** (`exchange.rs`)
   - Tests: Data partitioning patterns
   - Variants: Round-robin, hash partitioning
   - Purpose: Optimizing data distribution

3. **Dataflow Construction** (`dataflow_construction.rs`)
   - Tests: Graph building overhead
   - Variants: Deep (5-20 ops), Wide (5-20 streams)
   - Purpose: Understanding construction costs

4. **Progress Tracking** (`progress_tracking.rs`)
   - Tests: Coordination mechanisms
   - Variants: Linear chains, branching
   - Purpose: Evaluating tracking overhead

5. **Unary Operators** (`unary_operators.rs`)
   - Tests: Map, filter, flat_map
   - Sizes: 1K, 10K, 100K elements
   - Purpose: Baseline operator performance

### Differential Dataflow Benchmarks

1. **Arrange** (`arrange.rs`)
   - Tests: Data arrangement by key
   - Variants: Varying sizes and key counts
   - Purpose: Index creation costs

2. **Join** (`join.rs`)
   - Tests: Join operations
   - Variants: Different sizes and selectivities
   - Purpose: Multi-way join optimization

3. **Count** (`count.rs`)
   - Tests: Aggregation performance
   - Variants: Different key distributions
   - Purpose: Grouping efficiency

4. **Consolidate** (`consolidate.rs`)
   - Tests: Data compaction
   - Variants: Different update patterns
   - Purpose: State maintenance costs

5. **Distinct** (`distinct.rs`)
   - Tests: Deduplication
   - Variants: Different duplicate factors
   - Purpose: Unique value performance

## 🔍 Validation Checklist

Before considering setup complete, verify:

- [x] Repository structure matches documentation
- [x] All 10 benchmark files present
- [x] All 6 documentation files present
- [x] Scripts are executable
- [x] Cargo.toml has correct workspace configuration
- [x] Dependencies specified correctly
- [x] GitHub Actions workflow present
- [x] Integration tests pass (52+ checks)
- [x] Utility libraries have unit tests
- [x] Each benchmark has proper Criterion setup

## 🎓 Learning Path

### For New Users

1. **Read** `README.md` - Overview
2. **Install** following `INSTALLATION.md`
3. **Run** `make bench-quick` - Quick test
4. **Explore** `target/criterion/report/index.html` - Results
5. **Study** benchmark source files - Implementation
6. **Read** `BENCHMARKING.md` - Advanced techniques

### For Contributors

1. **Read** `CONTRIBUTING.md` - Guidelines
2. **Study** existing benchmarks - Patterns
3. **Add** new benchmarks - Following structure
4. **Test** using `./integration-test.sh`
5. **Submit** PR - With documentation

### For Researchers

1. **Read** `COMPARISON.md` - Methodology
2. **Run** benchmarks with various parameters
3. **Analyze** HTML reports and statistics
4. **Compare** frameworks for use case
5. **Document** findings and insights

## 🔄 Maintenance

### Regular Updates

```bash
# Update dependencies
cargo update

# Check for outdated packages
cargo outdated

# Run full test suite
make all
```

### Adding New Benchmarks

1. Create benchmark file in appropriate `benches/` directory
2. Add to package `Cargo.toml`
3. Update package README
4. Test with `cargo bench --bench <name>`
5. Update main documentation

### Quality Checks

Before committing:

```bash
make format       # Format code
make lint         # Run clippy
make test         # Run tests
make bench-quick  # Verify benchmarks work
```

## 🚨 Troubleshooting

### Common Issues

**Issue**: Rust not found
```bash
# Install Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env
```

**Issue**: Build fails
```bash
# Clean and rebuild
cargo clean
cargo build --all
```

**Issue**: Benchmarks too slow
```bash
# Use quick mode
make bench-quick
```

**Issue**: Permission denied on scripts
```bash
chmod +x *.sh
```

## 📈 Performance Tips

### For Accurate Results

1. **Close background applications**
2. **Disable CPU frequency scaling** (Linux):
   ```bash
   echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
   ```
3. **Run multiple times** for consistency
4. **Use consistent hardware** for comparisons
5. **Check CPU temperature** (avoid throttling)

### For Faster Iteration

1. **Use quick mode** during development
2. **Run specific benchmarks** only
3. **Reduce sample sizes** temporarily
4. **Use fewer worker threads**

## 🌐 CI/CD Integration

The GitHub Actions workflow will:

```yaml
- Build all packages
- Run tests
- Execute benchmarks (quick mode)
- Test with 1, 2, 4 workers
- Upload artifacts
- Compare against baselines (on PRs)
```

Configure in `.github/workflows/benchmarks.yml`

## 📝 Documentation Files

| File | Purpose | Audience |
|------|---------|----------|
| README.md | Quick start | All users |
| INSTALLATION.md | Setup guide | New users |
| BENCHMARKING.md | Advanced usage | Power users |
| COMPARISON.md | Performance analysis | Researchers |
| CONTRIBUTING.md | Development guide | Contributors |
| PROJECT_SUMMARY.md | Complete overview | Stakeholders |
| DEPLOYMENT_GUIDE.md | This file | Deployers |

## ✅ Success Criteria

Setup is complete when:

1. ✅ `./integration-test.sh` passes all checks
2. ✅ `./setup-validation.sh` completes successfully
3. ✅ `make bench-quick` runs without errors
4. ✅ HTML reports generated in `target/criterion/`
5. ✅ All documentation accessible and clear

## 🎉 Next Steps

After successful deployment:

1. **Explore** benchmark results
2. **Customize** for your use case
3. **Add** new benchmarks if needed
4. **Share** findings with team
5. **Contribute** improvements back

## 📧 Support

- **Issues**: GitHub issue tracker
- **Documentation**: All `.md` files in repository
- **Community**: Timely/Differential Dataflow projects

## 📄 License

Apache-2.0 - See repository for details

---

**Deployment Status**: ✅ Complete
**Last Updated**: 2024
**Version**: 0.1.0
