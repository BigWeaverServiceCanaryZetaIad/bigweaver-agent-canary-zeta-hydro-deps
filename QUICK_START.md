# Quick Start Guide

## Running Benchmarks

### Basic Usage

Run all benchmarks:
```bash
cd benches
cargo bench
```

### Running Specific Benchmarks

Run a single benchmark:
```bash
cargo bench --bench arithmetic
cargo bench --bench reachability
cargo bench --bench join
```

Run multiple specific benchmarks:
```bash
cargo bench --bench arithmetic --bench join --bench fan_out
```

### Filtering by Implementation

Run only timely implementations:
```bash
cargo bench timely
```

Run only Hydro (dfir_rs) implementations:
```bash
cargo bench dfir_rs
```

Run only raw baseline implementations:
```bash
cargo bench raw
```

### Advanced Filtering

Run specific implementation in specific benchmark:
```bash
cargo bench --bench arithmetic timely
cargo bench --bench join dfir_rs
```

Run with specific pattern matching:
```bash
cargo bench "arithmetic/dfir_rs"
cargo bench "fan_out/timely"
```

## Understanding Results

### Criterion Output

Criterion will display:
```
arithmetic/timely       time:   [123.45 ms 125.67 ms 127.89 ms]
                        change: [-2.1234% +0.5678% +3.4567%] (p = 0.23 > 0.05)
                        No change in performance detected.
```

**Key Metrics**:
- **time**: [lower_bound median upper_bound] - 95% confidence interval
- **change**: Performance change vs previous run
- **p-value**: Statistical significance (p < 0.05 = significant change)

### HTML Reports

Detailed reports are generated in:
```
target/criterion/<benchmark_name>/<implementation_name>/report/index.html
```

Open in browser to see:
- Performance plots
- Distribution charts
- Comparison with previous runs
- Statistical analysis

## Performance Comparison Workflow

### Step 1: Baseline Comparison (This Repository)
```bash
cd bigweaver-agent-canary-zeta-hydro-deps/benches
cargo bench > baseline_results.txt
```

Compare Timely vs Hydro implementations in same codebase.

### Step 2: Hydro-Native Benchmarks (Main Repository)
```bash
cd bigweaver-agent-canary-hydro-zeta/benches
cargo bench > hydro_results.txt
```

Run pure Hydro implementations without external dependencies.

### Step 3: Analyze
Compare the results:
- Check Criterion HTML reports in both repositories
- Look for performance patterns
- Identify optimization opportunities

## Common Benchmarks Explained

### arithmetic
**What it tests**: Sequential map operations (x + 1, twenty times)
**Why it matters**: Measures operator overhead and pipeline efficiency

**Run it**: `cargo bench --bench arithmetic`

### reachability
**What it tests**: Graph traversal with real data
**Why it matters**: Tests iterative computation and join performance

**Run it**: `cargo bench --bench reachability`

### fan_out / fan_in
**What they test**: Data flow splitting and merging
**Why they matter**: Common patterns in stream processing

**Run them**: `cargo bench --bench fan_out --bench fan_in`

### fork_join
**What it tests**: Parallel processing with merge
**Why it matters**: Tests parallel execution and synchronization

**Run it**: `cargo bench --bench fork_join`

## Troubleshooting

### Build Issues

**Problem**: Missing dfir_rs or sinktools
```
error: failed to load manifest for dependency `dfir_rs`
```

**Solution**: Ensure git access to main repository, check network connection

### Performance Issues

**Problem**: Benchmarks take too long
**Solution**: Benchmarks are designed to run for a few seconds each. If taking minutes, check system load

**Problem**: Inconsistent results
**Solution**: 
- Close other applications
- Run benchmarks multiple times
- Check CPU frequency scaling

### Dependency Issues

**Problem**: Cannot find timely or differential-dataflow
**Solution**: Check that package registry has access to the dev versions:
- timely-master 0.13.0-dev.1
- differential-dataflow-master 0.13.0-dev.1

## Tips for Accurate Benchmarking

1. **Minimize system load**: Close unnecessary applications
2. **Run multiple times**: Use `--warm-up-time` and `--measurement-time` options
3. **Consistent environment**: Same CPU frequency, same power settings
4. **Compare relative**: Focus on relative differences, not absolute numbers
5. **Check CI**: Automated benchmarks in CI provide consistent environment

## Custom Benchmark Configuration

### Adjust Sample Size
```bash
cargo bench --bench arithmetic -- --sample-size 100
```

### Adjust Measurement Time
```bash
cargo bench --bench arithmetic -- --measurement-time 10
```

### Save Baseline
```bash
cargo bench --bench arithmetic -- --save-baseline my-baseline
```

### Compare Against Baseline
```bash
cargo bench --bench arithmetic -- --baseline my-baseline
```

## Next Steps

- Read [BENCHMARK_ARCHITECTURE.md](BENCHMARK_ARCHITECTURE.md) for detailed architecture
- Read [benches/README.md](benches/README.md) for benchmark descriptions
- Read [README.md](README.md) for repository overview
- Check Criterion documentation: https://bheisler.github.io/criterion.rs/book/

## Quick Reference

| Command | Description |
|---------|-------------|
| `cargo bench` | Run all benchmarks |
| `cargo bench --bench NAME` | Run specific benchmark |
| `cargo bench FILTER` | Run benchmarks matching filter |
| `cargo bench -- --save-baseline BASE` | Save baseline |
| `cargo bench -- --baseline BASE` | Compare to baseline |
| `cargo bench -- --help` | Show all options |

## File Locations

| Path | Content |
|------|---------|
| `benches/benches/*.rs` | Benchmark source files |
| `benches/Cargo.toml` | Dependencies and benchmark config |
| `benches/build.rs` | Build-time code generation |
| `target/criterion/` | Benchmark results and reports |
| `benches/benches/reachability_*.txt` | Test data files |
