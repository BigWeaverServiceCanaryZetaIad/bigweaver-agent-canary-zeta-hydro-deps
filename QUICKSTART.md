# Quick Start Guide

## Getting Started in 5 Minutes

This guide will help you quickly set up and run the benchmark suite.

## Prerequisites

✅ Rust toolchain installed  
✅ Main repository `bigweaver-agent-canary-hydro-zeta` cloned  
✅ Both repositories at the same directory level

## Expected Directory Structure

```
/projects/sandbox/
├── bigweaver-agent-canary-hydro-zeta/    # Main repository
│   ├── dfir_rs/
│   ├── sinktools/
│   └── ...
└── bigweaver-agent-canary-zeta-hydro-deps/  # This repository
    ├── benches/
    ├── BENCHMARKS.md
    └── README.md
```

## Step 1: Verify Setup

```bash
# Check directory structure
ls -la /projects/sandbox/

# Should see both repositories:
# - bigweaver-agent-canary-hydro-zeta
# - bigweaver-agent-canary-zeta-hydro-deps
```

## Step 2: Navigate to Benchmarks

```bash
cd /projects/sandbox/bigweaver-agent-canary-zeta-hydro-deps/benches
```

## Step 3: Build Benchmarks

```bash
# Build all benchmarks (this may take a few minutes)
cargo build --release --benches
```

**Expected**: Successful build with no errors

## Step 4: Run Your First Benchmark

```bash
# Run the identity benchmark (fastest)
cargo bench --bench identity
```

**Expected Output**:
```
   Compiling benches v0.0.0
    Finished bench [optimized] target(s) in X.XXs
     Running benches/identity.rs
identity/timely         time: [XXX.XX µs XXX.XX µs XXX.XX µs]
```

## Step 5: Try More Benchmarks

```bash
# Run arithmetic comparison
cargo bench --bench arithmetic

# Run graph reachability (more complex)
cargo bench --bench reachability

# Run all benchmarks (takes longer)
cargo bench
```

## Common Commands

### Run Specific Benchmark
```bash
cargo bench --bench <name>
```

Available benchmarks:
- `arithmetic` - Arithmetic operations comparison
- `fan_in` - Fan-in pattern tests
- `fan_out` - Fan-out pattern tests
- `fork_join` - Fork-join concurrency
- `identity` - Identity operations baseline
- `join` - Join operations
- `reachability` - Graph algorithms
- `upcase` - String transformations

### Run with Filter
```bash
# Run only tests matching "pipeline"
cargo bench --bench arithmetic -- pipeline
```

### Quick Run (Fewer Samples)
```bash
cargo bench --bench identity -- --quick
```

### Save Baseline
```bash
cargo bench -- --save-baseline my-baseline
```

### Compare with Baseline
```bash
cargo bench -- --baseline my-baseline
```

## View Results

### Console Output
Results are displayed in the terminal immediately after running.

### HTML Reports
```bash
# Reports are automatically generated in target/criterion/
open target/criterion/report/index.html

# Or browse individual reports
ls target/criterion/
```

## Troubleshooting

### Issue: "Cannot find dfir_rs"

**Cause**: Main repository not at expected location

**Fix**:
```bash
# Verify main repository exists
ls -la ../bigweaver-agent-canary-hydro-zeta/dfir_rs

# If missing, clone it:
cd /projects/sandbox
git clone <url> bigweaver-agent-canary-hydro-zeta
```

### Issue: "Cannot find sinktools"

**Cause**: Same as above - main repository path issue

**Fix**: Ensure main repository is properly set up

### Issue: Build errors about timely/differential-dataflow

**Cause**: Dependency resolution issues

**Fix**:
```bash
# Clean and rebuild
cargo clean
cargo build --release --benches
```

### Issue: Benchmarks run but results are inconsistent

**Cause**: System load or background processes

**Fix**:
- Close unnecessary applications
- Run again with more samples: `cargo bench -- --sample-size 200`
- Check system resources: `htop` or `top`

## Understanding Output

### Basic Output Format
```
benchmark_name          time: [lower_bound estimate upper_bound]
                       change: [% change from previous run]
```

### Example
```
arithmetic/timely       time: [45.2 ms 45.8 ms 46.4 ms]
                       change: [-2.3% +0.1% +2.5%]
```

**Interpretation**:
- **Estimate**: ~45.8 ms is the best estimate
- **Bounds**: True value likely between 45.2-46.4 ms (95% confidence)
- **Change**: ~0.1% faster than previous run

### Performance Indicators

✅ **Good**:
- Narrow confidence intervals (e.g., 45.2-46.4 ms)
- Low variance (consistent results)
- Few outliers detected

⚠️ **Check**:
- Wide intervals (e.g., 40-60 ms)
- High variance
- Many outliers

## Next Steps

### 1. Compare with dfir_rs Benchmarks

```bash
# Run dfir_rs benchmarks (main repo)
cd ../bigweaver-agent-canary-hydro-zeta/benches
cargo bench -- --save-baseline dfir

# Run these benchmarks
cd ../bigweaver-agent-canary-zeta-hydro-deps/benches
cargo bench -- --save-baseline external

# Compare results manually or in HTML reports
```

### 2. Explore Test Data

```bash
# View reachability graph structure
head benches/reachability_edges.txt

# Check word list
wc -l benches/words_alpha.txt
head benches/words_alpha.txt
```

### 3. Read Detailed Documentation

- **BENCHMARKS.md** - Detailed benchmark descriptions
- **README.md** - Complete repository documentation
- **benches/README.md** - Benchmark-specific notes

### 4. Run Performance Comparisons

```bash
# Establish baseline
cargo bench -- --save-baseline before

# Make changes or test different conditions

# Compare
cargo bench -- --baseline before
```

## Quick Reference Card

```bash
# Essential Commands
cargo bench                              # Run all benchmarks
cargo bench --bench <name>               # Run specific benchmark
cargo bench -- --quick                   # Fast run (fewer samples)
cargo bench -- --save-baseline <name>    # Save baseline
cargo bench -- --baseline <name>         # Compare with baseline

# Viewing Results
open target/criterion/report/index.html  # View HTML reports
ls target/criterion/                     # List all results

# Troubleshooting
cargo clean                              # Clean build artifacts
cargo build --release --benches          # Rebuild benchmarks
cargo bench -- --verbose                 # Verbose output
```

## Benchmark Characteristics

| Benchmark | Speed | Complexity | Memory | Dependencies |
|-----------|-------|------------|---------|--------------|
| identity | ⚡⚡⚡ | ⭐ | Low | timely |
| arithmetic | ⚡⚡ | ⭐⭐ | Low | timely |
| fan_in | ⚡⚡ | ⭐⭐ | Low | timely |
| fan_out | ⚡⚡ | ⭐⭐ | Low | timely |
| fork_join | ⚡⚡ | ⭐⭐ | Medium | timely |
| join | ⚡ | ⭐⭐⭐ | Medium | timely |
| upcase | ⚡ | ⭐⭐ | Medium | timely |
| reachability | ⚡ | ⭐⭐⭐⭐ | High | timely, differential |

Legend:
- ⚡ = Speed (more = faster to run)
- ⭐ = Complexity (more = more complex)

## Example Session

Here's a complete example session:

```bash
# Navigate to benchmarks
cd /projects/sandbox/bigweaver-agent-canary-zeta-hydro-deps/benches

# Build
cargo build --release --benches
# ✅ Compilation successful

# Run simple benchmark
cargo bench --bench identity
# ✅ identity/timely: 125.3 µs

# Run complex benchmark
cargo bench --bench reachability
# ✅ reachability/differential: 234.7 ms

# Save baseline
cargo bench -- --save-baseline initial
# ✅ Baseline saved

# View results
open target/criterion/report/index.html
# ✅ Opens in browser with charts

# Success! 🎉
```

## Tips for Best Results

1. **Close background apps** - Reduces interference
2. **Run multiple times** - Ensures consistency
3. **Use release mode** - cargo bench does this automatically
4. **Check system load** - Use `htop` to monitor
5. **Warm up first** - First run may be slower
6. **Document conditions** - Note any special setup

## Getting Help

If you encounter issues:

1. Check this QUICKSTART.md
2. Read BENCHMARKS.md for detailed info
3. Review README.md for architecture
4. Check main repository documentation
5. Verify directory structure matches expected layout

## What's Next?

Now that you're up and running:

- 📊 **Analyze results** - Look at HTML reports
- 🔍 **Dig deeper** - Read individual benchmark code
- 📈 **Compare** - Run dfir_rs benchmarks for comparison
- 🛠️ **Experiment** - Try different parameters
- 📝 **Contribute** - Add your own benchmarks

Happy benchmarking! 🚀
