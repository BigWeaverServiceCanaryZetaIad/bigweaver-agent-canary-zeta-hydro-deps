# Integration Guide: Timely/Differential-Dataflow Benchmarks

This document explains how the timely and differential-dataflow benchmarks have been organized in this repository and how to use them for performance comparisons with the main Hydro repository.

## 📋 Background

The benchmarks in this repository were created to:

1. **Isolate Dependencies**: Keep timely and differential-dataflow dependencies separate from the main Hydro codebase
2. **Improve Build Times**: Reduce compilation overhead in the main repository
3. **Enable Performance Comparisons**: Provide a dedicated space for performance regression testing
4. **Maintain Clean Architecture**: Follow the team's preference for dependency management and code organization

## 🎯 Repository Purpose

This repository (`bigweaver-agent-canary-zeta-hydro-deps`) serves as the dedicated location for:

- Timely dataflow benchmarks
- Differential-dataflow benchmarks
- Performance comparison infrastructure
- Statistical analysis tools

The main repository (`bigweaver-agent-canary-hydro-zeta`) remains focused on core Hydro functionality without these heavy dependencies.

## 🔧 Architecture

### Dependencies

**This Repository (hydro-deps)**:
```toml
[dependencies]
timely = "0.12"
differential-dataflow = "0.12"
criterion = "0.5.0"
```

**Main Repository (hydro)**:
- No timely or differential-dataflow dependencies
- Focused on core Hydro components
- Leaner build process

### Benchmark Organization

```
benches/
├── benches/
│   ├── micro_ops.rs          # Basic operation benchmarks
│   ├── reachability.rs       # Graph algorithm benchmarks
│   └── dataflow_patterns.rs  # Distributed pattern benchmarks
├── src/
│   └── lib.rs                # Shared utilities
└── Cargo.toml                # Benchmark dependencies
```

## 🚀 Usage Workflows

### Workflow 1: Performance Regression Testing

When making changes to the main Hydro repository:

1. **Establish Baseline** (before changes):
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps
   bash run_benchmarks.sh --all --baseline before-changes
   ```

2. **Make Changes** in main repository:
   ```bash
   cd ../bigweaver-agent-canary-hydro-zeta
   # Make your changes
   cargo build
   cargo test
   ```

3. **Run Comparison**:
   ```bash
   cd ../bigweaver-agent-canary-zeta-hydro-deps
   bash run_benchmarks.sh --all --compare before-changes
   ```

4. **Review Results**: Check for regressions in `target/criterion/`

### Workflow 2: Optimization Validation

After implementing performance optimizations:

1. **Baseline from main branch**:
   ```bash
   git checkout main
   cd bigweaver-agent-canary-zeta-hydro-deps
   bash run_benchmarks.sh --all --baseline main
   ```

2. **Test optimization**:
   ```bash
   git checkout feature/optimization
   bash run_benchmarks.sh --all --compare main --save-html
   ```

3. **Analyze improvements** in the HTML reports

### Workflow 3: Continuous Integration

The repository includes GitHub Actions workflow (`.github/workflows/benchmarks.yml`) that:

- Runs automatically on PRs and main branch pushes
- Compares performance against baselines
- Posts results as PR comments
- Archives results as artifacts

## 🔗 Cross-Repository Coordination

### Companion Changes

When changes in the main repository affect benchmark expectations:

1. Create PR in main repository with the functional changes
2. Create companion PR in this repository updating benchmarks if needed
3. Reference PRs cross-repository in descriptions:
   - Main PR: "Companion benchmark update: bigweaver-agent-canary-zeta-hydro-deps#XYZ"
   - Deps PR: "Benchmarks for: bigweaver-agent-canary-hydro-zeta#ABC"

### Merge Order

For coordinated changes:

1. ✅ Merge main repository PR first
2. ✅ Then merge deps repository PR
3. ✅ Verify benchmarks pass in CI

## 📊 Benchmark Suites

### Micro-Operations

**Purpose**: Test fundamental dataflow operations  
**Use Case**: Detect regressions in basic operations  
**What It Measures**:
- Map transformation throughput
- Filter operation performance
- Combined operation overhead

**Example**:
```bash
cargo bench --bench micro_ops -- timely_map
```

### Reachability

**Purpose**: Test graph algorithms and iterative computations  
**Use Case**: Validate differential-dataflow performance  
**What It Measures**:
- Iterative computation performance
- Join operation efficiency
- State management overhead

**Example**:
```bash
cargo bench --bench reachability -- small_graph
```

### Dataflow Patterns

**Purpose**: Test common distributed patterns  
**Use Case**: End-to-end performance validation  
**What It Measures**:
- Aggregation performance
- Join throughput
- Map-reduce pipeline efficiency

**Example**:
```bash
cargo bench --bench dataflow_patterns
```

## 📈 Interpreting Results

### Performance Changes

Criterion provides statistical analysis:

```
timely_map/1000         time:   [45.2 μs 46.1 μs 47.3 μs]
                        change: [-5.2% -3.1% -0.8%] (p = 0.02 < 0.05)
                        Performance has improved.
```

**Interpretation**:
- **Time range**: 95% confidence interval for execution time
- **Change**: Percentage difference from baseline
- **P-value**: Statistical significance (< 0.05 means significant change)

### Thresholds

Consider investigating when:
- Any benchmark regresses > 10%
- Multiple benchmarks show consistent small regressions (> 5%)
- New features cause unexpected performance changes

## 🛠️ Maintenance

### Updating Dependencies

When timely/differential-dataflow release new versions:

1. Update `benches/Cargo.toml`
2. Run all benchmarks to establish new baseline
3. Document any API changes
4. Update benchmark code if necessary

### Adding New Benchmarks

To add benchmarks for new Hydro features:

1. Create new benchmark file in `benches/benches/`
2. Add entry to `benches/Cargo.toml`
3. Document in `benches/README.md`
4. Update this integration guide

### Removing Benchmarks

If benchmarks become obsolete:

1. Comment out in `Cargo.toml` (keep code for reference)
2. Document reason in commit message
3. Archive results if historical comparison needed

## 🔍 Troubleshooting

### Build Issues

**Problem**: Benchmark compilation fails  
**Solution**: Ensure Rust version matches main repository:
```bash
rustc --version  # Should match rust-toolchain.toml
```

### Inconsistent Results

**Problem**: Benchmark results vary widely  
**Solution**:
- Run on dedicated hardware
- Close background applications
- Use `--save-baseline` for stable references
- Increase sample size in benchmark configuration

### Missing Baselines

**Problem**: Cannot compare against baseline  
**Solution**: Re-establish baseline:
```bash
git checkout main
bash run_benchmarks.sh --all --baseline main
git checkout your-branch
```

## 📝 Best Practices

### Before Committing

- [ ] Run `cargo fmt` in benches directory
- [ ] Run `cargo clippy` and fix warnings
- [ ] Run `cargo test` to ensure utilities work
- [ ] Update documentation if adding benchmarks

### For PRs

- [ ] Explain what benchmarks test
- [ ] Show performance comparison if relevant
- [ ] Reference main repository changes
- [ ] Update CHANGELOG if adding features

### For Releases

- [ ] Tag synchronized with main repository versions
- [ ] Archive baseline results
- [ ] Document major performance changes
- [ ] Update dependencies

## 🔗 Related Documentation

- Main Repository: [bigweaver-agent-canary-hydro-zeta/README.md](../bigweaver-agent-canary-hydro-zeta/README.md)
- Benchmark Details: [benches/README.md](benches/README.md)
- Criterion Documentation: [https://bheisler.github.io/criterion.rs](https://bheisler.github.io/criterion.rs)

## 📞 Support

For questions about:
- **Benchmark implementation**: See `benches/README.md`
- **Integration issues**: File issue in this repository
- **Hydro functionality**: File issue in main repository

---

This separation enables the team to maintain "the ability to run performance comparisons" while following best practices for dependency management and code organization.
