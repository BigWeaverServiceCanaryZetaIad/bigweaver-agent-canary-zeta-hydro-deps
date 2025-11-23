# Quick Start Guide

Get started with Hydro performance benchmarks in minutes.

## Installation

### Prerequisites

- Rust toolchain (1.70 or later recommended)
- Git

### Clone Repository

```bash
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps
```

## Basic Usage

### Run All Benchmarks

```bash
cargo bench -p hydro-benchmarks
```

This will:
- Compile all benchmarks
- Run each benchmark multiple times
- Generate statistical analysis
- Create HTML reports in `target/criterion/report/`

**Note**: First run may take 5-10 minutes to compile dependencies.

### Run Single Benchmark

```bash
# Run only arithmetic benchmarks
cargo bench -p hydro-benchmarks --bench arithmetic
```

Available benchmarks:
- `arithmetic` - Pipeline operations
- `fan_in` - Fan-in pattern
- `fan_out` - Fan-out pattern
- `fork_join` - Fork-join pattern
- `identity` - Identity operations
- `join` - Join operations
- `reachability` - Graph reachability
- `upcase` - String transformations

### Quick Test (Faster)

For rapid iteration during development:

```bash
./run_benchmarks.sh --quick --bench arithmetic
```

This reduces sample size for faster results (less statistical rigor).

## Performance Comparison

### Compare Before/After Changes

Use the comparison script for guided workflow:

```bash
./run_comparison.sh
```

This will:
1. Run baseline benchmarks
2. Prompt you to make changes
3. Run comparison benchmarks
4. Show performance differences

### Manual Comparison

```bash
# Step 1: Save baseline
cargo bench -p hydro-benchmarks -- --save-baseline main

# Step 2: Make your changes to dfir_rs

# Step 3: Compare
cargo bench -p hydro-benchmarks -- --baseline main
```

## View Results

### HTML Reports

Criterion generates detailed HTML reports:

```bash
# Linux
xdg-open target/criterion/report/index.html

# macOS
open target/criterion/report/index.html

# Windows
start target/criterion/report/index.html
```

Reports include:
- Performance graphs
- Statistical analysis
- Historical comparisons
- Individual benchmark details

### Terminal Output

Benchmark results are also printed to terminal:

```
arithmetic/dfir_rs/compiled
                        time:   [45.123 ms 45.456 ms 45.789 ms]
                        change: [-5.2% -4.8% -4.4%] (p = 0.00 < 0.05)
                        Performance has improved.
```

**Reading results:**
- `time`: Mean execution time [lower bound, estimate, upper bound]
- `change`: Performance difference from baseline (negative = faster)
- `p value`: Statistical significance (< 0.05 = significant)

## Local Development

### Using Local dfir_rs

To benchmark local changes to dfir_rs:

1. **Clone main repository** (if not already done):
   ```bash
   cd ..
   git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git
   cd bigweaver-agent-canary-zeta-hydro-deps
   ```

2. **Update benches/Cargo.toml**:
   ```toml
   # Change from:
   dfir_rs = { git = "https://github.com/hydro-project/hydro.git", features = ["debugging"] }
   
   # To:
   dfir_rs = { path = "../bigweaver-agent-canary-hydro-zeta/dfir_rs", features = ["debugging"] }
   ```

3. **Also update sinktools**:
   ```toml
   # Change from:
   sinktools = { git = "https://github.com/hydro-project/hydro.git", version = "^0.0.1" }
   
   # To:
   sinktools = { path = "../bigweaver-agent-canary-hydro-zeta/sinktools", version = "^0.0.1" }
   ```

4. **Run benchmarks**:
   ```bash
   cargo bench -p hydro-benchmarks
   ```

### Reverting to Git Dependencies

Before committing, revert to git dependencies:

```toml
dfir_rs = { git = "https://github.com/hydro-project/hydro.git", features = ["debugging"] }
sinktools = { git = "https://github.com/hydro-project/hydro.git", version = "^0.0.1" }
```

## Common Tasks

### Test Specific Optimization

```bash
# 1. Save baseline before optimization
./run_benchmarks.sh --save-baseline before-opt --bench arithmetic

# 2. Make optimization changes

# 3. Test improvement
./run_benchmarks.sh --baseline before-opt --bench arithmetic
```

### CI/CD Integration

Add to your CI configuration:

```yaml
# .github/workflows/benchmark.yml
- name: Run benchmarks
  run: cargo bench -p hydro-benchmarks --no-fail-fast
```

### Compare Multiple Baselines

```bash
# Save multiple baselines
cargo bench -p hydro-benchmarks -- --save-baseline v1.0
cargo bench -p hydro-benchmarks -- --save-baseline v1.1
cargo bench -p hydro-benchmarks -- --save-baseline v2.0

# Compare against any baseline
cargo bench -p hydro-benchmarks -- --baseline v1.0
```

## Troubleshooting

### Long Compile Times

First compilation includes heavy dependencies (timely, differential-dataflow):

```bash
# Solution: Be patient, it's normal
# Or use --quick mode for faster iteration
./run_benchmarks.sh --quick
```

### Out of Memory

If benchmarks fail with OOM:

```bash
# Run benchmarks individually
cargo bench -p hydro-benchmarks --bench arithmetic
cargo bench -p hydro-benchmarks --bench fan_in
# ... etc
```

### Inconsistent Results

For consistent benchmark results:

```bash
# 1. Close background applications
# 2. Disable CPU frequency scaling (Linux)
sudo cpupower frequency-set --governor performance

# 3. Run multiple times
./run_benchmarks.sh --save-baseline run1
./run_benchmarks.sh --save-baseline run2
./run_benchmarks.sh --save-baseline run3
```

### Build Errors

```bash
# Clean and rebuild
cargo clean
cargo build -p hydro-benchmarks

# Update dependencies
cargo update

# Check Rust version
rustc --version
```

## Next Steps

### Detailed Documentation

- **[README.md](README.md)**: Repository overview and comprehensive documentation
- **[benches/README.md](benches/README.md)**: Detailed benchmark documentation
- **Main repository**: [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)

### Advanced Usage

- Set up automated performance tracking
- Integrate with CI/CD pipelines
- Create custom benchmarks
- Analyze performance regressions

### Contributing

See [README.md](README.md) for contribution guidelines.

## Quick Reference

### Essential Commands

```bash
# Run all benchmarks
cargo bench -p hydro-benchmarks

# Run specific benchmark
cargo bench -p hydro-benchmarks --bench <name>

# Save baseline
cargo bench -p hydro-benchmarks -- --save-baseline <name>

# Compare to baseline
cargo bench -p hydro-benchmarks -- --baseline <name>

# Quick mode
./run_benchmarks.sh --quick

# Guided comparison
./run_comparison.sh
```

### Benchmark Names

- `arithmetic` - Pipeline arithmetic operations
- `fan_in` - Fan-in pattern
- `fan_out` - Fan-out pattern
- `fork_join` - Fork-join pattern
- `identity` - Identity operations
- `join` - Join operations
- `reachability` - Graph reachability
- `upcase` - String transformations

### Helper Scripts

- `./run_benchmarks.sh` - Run benchmarks with options
- `./run_comparison.sh` - Guided performance comparison

## Support

Need help?

1. Check [benches/README.md](benches/README.md) for detailed documentation
2. Review benchmark source code in `benches/benches/`
3. Contact the team

---

**Ready to benchmark? Start with:**

```bash
cargo bench -p hydro-benchmarks
```

Then open `target/criterion/report/index.html` to view results!
