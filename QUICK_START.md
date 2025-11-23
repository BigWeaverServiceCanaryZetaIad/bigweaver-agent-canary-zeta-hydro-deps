# Quick Start Guide

Get started with the timely and differential-dataflow benchmarks in minutes.

## Prerequisites

- **Rust**: Version 1.75 or later (specified in `rust-toolchain.toml`)
- **Cargo**: Comes with Rust
- **Git**: For cloning the repository

## Installation

```bash
# Clone the repository
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps

# Verify setup (optional)
bash verify_setup.sh
```

## Running Your First Benchmark

### Option 1: Run All Benchmarks

```bash
cargo bench -p benches
```

This will:
- Run all 8 benchmarks
- Execute multiple frameworks for each
- Generate statistical reports
- Create HTML visualizations

**Time**: ~10-15 minutes depending on your system

### Option 2: Run a Single Benchmark

```bash
# Quick benchmark (identity - measures framework overhead)
cargo bench -p benches --bench identity

# Medium complexity (arithmetic operations)
cargo bench -p benches --bench arithmetic

# Complex benchmark (graph reachability)
cargo bench -p benches --bench reachability
```

**Time**: ~1-3 minutes per benchmark

### Option 3: Run Specific Implementation

```bash
# Test only Hydroflow compiled
cargo bench -p benches --bench arithmetic -- "dfir_rs/compiled"

# Test only Timely
cargo bench -p benches --bench arithmetic -- "timely"

# Test both Hydroflow variants
cargo bench -p benches --bench arithmetic -- "dfir_rs"
```

**Time**: ~30 seconds per implementation

## Viewing Results

### Terminal Output

Criterion prints results directly to the terminal:

```
arithmetic/dfir_rs/compiled
                        time:   [485.23 µs 489.67 µs 494.52 µs]
                        thrpt:  [2.0222 Melem/s 2.0424 Melem/s 2.0611 Melem/s]

arithmetic/timely       time:   [1.2456 ms 1.2523 ms 1.2598 ms]
                        thrpt:  [793.64 Kelem/s 798.36 Kelem/s 802.78 Kelem/s]
```

**Reading results**:
- Lower times are better
- Higher throughput is better
- Values show [lower_bound, mean, upper_bound]

### HTML Reports

After running benchmarks, view detailed HTML reports:

```bash
# Open in browser (Linux)
xdg-open target/criterion/report/index.html

# Open in browser (macOS)
open target/criterion/report/index.html

# Open in browser (Windows)
start target/criterion/report/index.html
```

**HTML reports include**:
- Interactive graphs
- Statistical analysis
- Historical comparisons
- Detailed measurements

## Understanding Benchmarks

### Available Benchmarks

| Benchmark | What It Tests | Complexity |
|-----------|---------------|------------|
| `identity` | Pure framework overhead | ⭐ Simple |
| `arithmetic` | Basic operations + overhead | ⭐⭐ Medium |
| `upcase` | String transformations | ⭐⭐ Medium |
| `fan_in` | Multiple input streams | ⭐⭐ Medium |
| `fan_out` | Multiple output streams | ⭐⭐ Medium |
| `fork_join` | Parallel processing | ⭐⭐⭐ Complex |
| `join` | Stream join operations | ⭐⭐⭐ Complex |
| `reachability` | Graph algorithms | ⭐⭐⭐⭐ Very Complex |

### Framework Implementations

Each benchmark typically includes:

1. **Hydroflow (Compiled)**: Fastest, ahead-of-time compiled
2. **Hydroflow (Interpreted)**: More flexible, runtime interpreted
3. **Timely**: Timely dataflow framework baseline
4. **Differential** (reachability only): Incremental computation

## Common Use Cases

### Use Case 1: Compare All Frameworks

```bash
# Run complete comparison
cargo bench -p benches

# View comparison report
open target/criterion/report/index.html
```

### Use Case 2: Test Hydroflow Performance

```bash
# Test only Hydroflow implementations
cargo bench -p benches -- "dfir_rs"

# Compare compiled vs interpreted
cargo bench -p benches --bench arithmetic -- "dfir_rs"
```

### Use Case 3: Baseline with Timely

```bash
# Test only Timely implementations
cargo bench -p benches -- "timely"

# Compare specific benchmark
cargo bench -p benches --bench identity -- "timely"
```

### Use Case 4: Track Performance Over Time

```bash
# Establish baseline
cargo bench -p benches --save-baseline main

# Make changes to code...

# Compare against baseline
cargo bench -p benches --baseline main
```

## Troubleshooting

### Issue: Build Errors

```bash
# Solution: Clean and rebuild
cargo clean
cargo build --release
cargo bench -p benches
```

### Issue: Slow Benchmarks

```bash
# Solution: Run quick mode for development
cargo bench -p benches -- --quick

# Or increase measurement time for stability
cargo bench -p benches -- --measurement-time 20
```

### Issue: High Variability

```bash
# Solution: Close other applications and increase samples
cargo bench -p benches -- --sample-size 200
```

### Issue: Missing Dependencies

```bash
# Solution: Update dependencies
cargo update
cargo build --release
```

## Next Steps

### Learn More

- **Detailed Documentation**: [benches/README.md](benches/README.md)
- **Performance Guide**: [PERFORMANCE_COMPARISON_GUIDE.md](PERFORMANCE_COMPARISON_GUIDE.md)
- **Change History**: [CHANGES.md](CHANGES.md)

### Advanced Usage

```bash
# Run with custom parameters
cargo bench -p benches -- --sample-size 100 --measurement-time 10

# Profile specific benchmark
cargo flamegraph --bench arithmetic -- --bench

# Export results to JSON
cargo bench -p benches -- --output-format json > results.json
```

### Continuous Benchmarking

Set up automated performance tracking in CI/CD:

1. Add benchmark job to workflow
2. Store results as artifacts
3. Compare against baseline
4. Alert on regressions

See [PERFORMANCE_COMPARISON_GUIDE.md](PERFORMANCE_COMPARISON_GUIDE.md) for details.

## Getting Help

- **Documentation Issues**: Check README files in this repository
- **Performance Questions**: See PERFORMANCE_COMPARISON_GUIDE.md
- **Bug Reports**: Open an issue on GitHub
- **General Questions**: Contact the maintainers

## Summary of Commands

```bash
# Essential commands
cargo bench -p benches                           # Run all benchmarks
cargo bench -p benches --bench arithmetic        # Run specific benchmark
cargo bench -p benches -- "timely"               # Run specific framework
open target/criterion/report/index.html          # View results

# Development commands
cargo bench -p benches -- --quick                # Quick test
cargo bench -p benches --save-baseline main      # Save baseline
cargo bench -p benches --baseline main           # Compare to baseline

# Maintenance commands
cargo clean                                      # Clean build
cargo update                                     # Update dependencies
bash verify_setup.sh                             # Verify setup
```

## Expected Output

After running `cargo bench -p benches`, you should see:

```
Benchmarking arithmetic/dfir_rs/compiled: Warming up for 3.0000 s
Benchmarking arithmetic/dfir_rs/compiled: Collecting 100 samples...
Benchmarking arithmetic/dfir_rs/compiled: Analyzing
arithmetic/dfir_rs/compiled
                        time:   [485.23 µs 489.67 µs 494.52 µs]

... (more benchmarks) ...

Completed in ~10-15 minutes
Results saved to: target/criterion/
```

## Tips for Best Results

1. **Close other applications** before benchmarking
2. **Run multiple times** for stable results
3. **Use --save-baseline** to track changes
4. **Check HTML reports** for detailed analysis
5. **Compare similar benchmarks** to understand trends

---

**Ready to start?** Run `cargo bench -p benches` now!

For detailed information, see the full documentation in [benches/README.md](benches/README.md).
