# Quick Start Guide

Get up and running with Hydro performance comparison benchmarks in 5 minutes.

## Prerequisites

- **Rust**: Install from [rustup.rs](https://rustup.rs/)
- **Main Hydro Repository**: Must be checked out at `../bigweaver-agent-canary-hydro-zeta`

## Quick Setup

### 1. Verify Installation

```bash
# Run the setup script
./scripts/setup.sh
```

This will verify:
- ✓ Rust is installed
- ✓ Main Hydro repository is accessible
- ✓ All benchmark files are present
- ✓ Test data is available
- ✓ Dependencies are configured

### 2. Run Your First Benchmark

```bash
# Quick smoke test (2-3 minutes)
./scripts/run_benchmarks.sh -m quick
```

This runs the fastest benchmarks (`arithmetic` and `identity`) to verify everything works.

### 3. View Results

```bash
# Open the HTML report
open target/criterion/report/index.html
# Or on Linux:
xdg-open target/criterion/report/index.html
```

## Common Use Cases

### Developer: Testing a Hydro Change

```bash
# 1. Make changes in main Hydro repository
cd ../bigweaver-agent-canary-hydro-zeta
# ... make your changes ...

# 2. Save current performance as baseline
cd ../bigweaver-agent-canary-zeta-hydro-deps
./scripts/run_benchmarks.sh -m all -s before-change

# 3. Test your changes
cd ../bigweaver-agent-canary-hydro-zeta
# ... test changes ...

# 4. Compare performance
cd ../bigweaver-agent-canary-zeta-hydro-deps
./scripts/run_benchmarks.sh -m all -l before-change

# 5. View comparison in browser
open target/criterion/report/index.html
```

### Performance Engineer: Full System Comparison

```bash
# Run all benchmarks (10-15 minutes)
./scripts/run_benchmarks.sh -m all

# Analyze results
python3 scripts/analyze_results.py

# View detailed HTML reports
open target/criterion/report/index.html
```

### Researcher: Specific Algorithm Analysis

```bash
# Test graph algorithms
./scripts/run_benchmarks.sh -m specific -b reachability

# Test join operations
./scripts/run_benchmarks.sh -m specific -b join

# View results for this benchmark
open target/criterion/reachability/report/index.html
```

## Benchmark Modes

| Mode | Duration | Benchmarks | Use Case |
|------|----------|-----------|----------|
| `quick` | 2-3 min | arithmetic, identity | Smoke test |
| `patterns` | 5-7 min | fan_in, fan_out, fork_join | Dataflow patterns |
| `operations` | 7-10 min | arithmetic, join, identity, upcase | Basic operations |
| `iterative` | 3-5 min | reachability | Graph algorithms |
| `all` | 10-15 min | All 8 benchmarks | Comprehensive |

## Understanding Results

### Benchmark Output

```
arithmetic/hydro_surface    time:   [1.234 ms 1.250 ms 1.267 ms]
                           change: [-5.234% -2.145% +1.023%] (p = 0.52 > 0.05)
                           No change in performance detected.
```

**Reading:**
- **1.250 ms**: Mean execution time
- **[1.234 ms ... 1.267 ms]**: Confidence interval
- **change**: Comparison to previous run (if baseline exists)
- **p = 0.52**: Statistical significance (> 0.05 = not significant)

### System Comparisons

Each benchmark typically includes variants for:
- **Hydro (dfir_rs)**: Multiple implementations (surface syntax, compiled, optimized)
- **Timely Dataflow**: Direct comparison
- **Differential Dataflow**: For iterative benchmarks
- **Baseline**: Raw Rust implementations (no framework)

### HTML Reports

The HTML reports show:
- **Violin plots**: Distribution of measurements
- **Time series**: Performance over multiple runs
- **Comparison charts**: When using baselines
- **Statistics**: Detailed statistical analysis

## Troubleshooting

### "Cannot find dfir_rs"

**Problem**: Main repository not found

**Solution**:
```bash
# Verify main repository location
ls ../bigweaver-agent-canary-hydro-zeta/dfir_rs

# If not found, clone it:
cd ..
git clone <main-repo-url> bigweaver-agent-canary-hydro-zeta
```

### Benchmarks Take Too Long

**Problem**: Full suite takes 15+ minutes

**Solutions**:
```bash
# Run quick smoke test instead
./scripts/run_benchmarks.sh -m quick

# Or run specific benchmark
./scripts/run_benchmarks.sh -m specific -b arithmetic

# Or reduce Criterion's sample size (in benches/Cargo.toml):
# criterion = { version = "0.5.0", features = ["html_reports"], default-features = false }
```

### Inconsistent Results

**Problem**: Results vary between runs

**Causes & Solutions**:
1. **Background processes**: Close other applications
2. **CPU throttling**: Disable power saving, enable performance mode
3. **Thermal throttling**: Ensure good cooling
4. **Measurements too short**: Increase sample size in benchmark code

```bash
# Run with more samples (slower but more accurate)
CRITERION_SAMPLE_SIZE=200 cargo bench -p benches
```

### Build Errors

**Problem**: Compilation fails

**Solutions**:
```bash
# Update Rust
rustup update

# Clean build
cargo clean
cargo build -p benches

# Check for conflicting dependencies
cargo tree -p benches | grep -E "timely|differential|dfir"
```

## Benchmark Details

### Available Benchmarks

| Benchmark | Hydro | Timely | Differential | Description |
|-----------|-------|--------|--------------|-------------|
| **arithmetic** | ✅ | ✅ | ❌ | Basic arithmetic operations |
| **identity** | ✅ | ✅ | ❌ | Pass-through (minimal overhead) |
| **upcase** | ✅ | ✅ | ❌ | String transformation |
| **fan_in** | ✅ | ✅ | ❌ | Merge multiple streams |
| **fan_out** | ✅ | ✅ | ❌ | Split stream to multiple |
| **fork_join** | ✅ | ✅ | ❌ | Conditional routing |
| **join** | ✅ | ✅ | ❌ | Stream join operations |
| **reachability** | ✅ | ✅ | ✅ | Graph reachability |

### Test Data

Located in `benches/benches/`:
- **words_alpha.txt**: ~370,000 English words (3.8 MB)
- **reachability_edges.txt**: ~50,000 graph edges (532 KB)
- **reachability_reachable.txt**: Expected reachability output (38 KB)

## Next Steps

### Learn More

- **[BENCHMARKS_COMPARISON.md](BENCHMARKS_COMPARISON.md)**: Detailed benchmark analysis
- **[DEVELOPMENT.md](DEVELOPMENT.md)**: Developer guide
- **[README.md](README.md)**: Repository overview

### Advanced Usage

```bash
# List available baselines
./scripts/compare_results.sh -l

# Compare two baselines
./scripts/compare_results.sh -1 main -2 feature-branch

# Analyze results with Python script
python3 scripts/analyze_results.py

# Generate comparison report
./scripts/compare_results.sh -1 baseline1 -2 baseline2 -r
```

### Customize Benchmarks

Edit benchmark files in `benches/benches/`:
- Modify input sizes
- Add new variants
- Change iteration counts
- Add new test cases

After changes:
```bash
cargo bench -p benches --bench <modified_benchmark>
```

## Tips for Accurate Benchmarks

1. **Close other applications** to reduce noise
2. **Disable CPU frequency scaling**:
   ```bash
   # Linux
   echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
   ```
3. **Run multiple times** and compare:
   ```bash
   for i in 1 2 3; do
       ./scripts/run_benchmarks.sh -m quick -s run-$i
   done
   ```
4. **Use baseline comparisons** for regression testing
5. **Check confidence intervals** - wide intervals indicate noise

## Getting Help

- **Setup issues**: Run `./scripts/setup.sh` for diagnostics
- **Benchmark questions**: See [BENCHMARKS_COMPARISON.md](BENCHMARKS_COMPARISON.md)
- **Development**: See [DEVELOPMENT.md](DEVELOPMENT.md)
- **Main Hydro repo**: See `../bigweaver-agent-canary-hydro-zeta/README.md`

## Quick Reference

```bash
# Setup
./scripts/setup.sh                           # Verify installation

# Run benchmarks
./scripts/run_benchmarks.sh -m quick        # Quick test
./scripts/run_benchmarks.sh -m all          # All benchmarks
./scripts/run_benchmarks.sh -m specific -b reachability  # One benchmark

# Save/compare
./scripts/run_benchmarks.sh -m all -s main  # Save baseline
./scripts/run_benchmarks.sh -m all -l main  # Compare with baseline

# Analyze
python3 scripts/analyze_results.py          # Detailed analysis
./scripts/compare_results.sh -l             # List baselines
./scripts/compare_results.sh -1 a -2 b      # Compare two baselines

# View results
open target/criterion/report/index.html     # HTML report
```

---

**Ready to start?** Run: `./scripts/run_benchmarks.sh -m quick`
