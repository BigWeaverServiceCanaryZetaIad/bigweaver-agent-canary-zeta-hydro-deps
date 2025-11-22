# Quick Start Guide

Get up and running with Timely and Differential Dataflow benchmarks in minutes.

## Prerequisites

Install Rust if you haven't already:
```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env
```

## 5-Minute Quick Start

### 1. Navigate to the benchmark directory
```bash
cd bigweaver-agent-canary-zeta-hydro-deps/timely-differential-benchmarks
```

### 2. Run a quick benchmark
```bash
# Run the arithmetic benchmark (fastest)
cargo bench --bench arithmetic
```

Expected output:
```
arithmetic/timely       time:   [12.345 ms 12.456 ms 12.567 ms]
```

### 3. View the results
```bash
# Open the HTML report in your browser
open target/criterion/report/index.html  # macOS
xdg-open target/criterion/report/index.html  # Linux
```

**Success!** You've run your first benchmark.

## Run All Benchmarks

```bash
# This will take 5-10 minutes
cargo bench
```

Benchmarks will run in this order:
1. arithmetic (30 seconds)
2. fan_in (45 seconds)
3. fan_out (40 seconds)
4. fork_join (60 seconds)
5. identity (25 seconds)
6. join (90 seconds)
7. reachability (120 seconds) - Includes Differential!
8. upcase (90 seconds)

## Run Specific Benchmarks

### Quick benchmarks (< 1 minute each)
```bash
cargo bench --bench arithmetic
cargo bench --bench identity
cargo bench --bench fan_out
```

### Medium benchmarks (1-2 minutes each)
```bash
cargo bench --bench fan_in
cargo bench --bench fork_join
cargo bench --bench upcase
```

### Longer benchmarks (2+ minutes each)
```bash
cargo bench --bench join
cargo bench --bench reachability  # The most important one!
```

## Understanding Results

### Simple interpretation
```
arithmetic/timely       time:   [12.345 ms 12.456 ms 12.567 ms]
                                 ^^^^^^^^   ^^^^^^^^   ^^^^^^^^
                                 Lower      Mean       Upper
                                 bound               bound
```

- **Mean**: The average execution time
- **Bounds**: 95% confidence interval
- **Lower is better**: Faster execution

### With comparison
```
arithmetic/timely       time:   [12.345 ms 12.456 ms 12.567 ms]
                        change: [-2.1234% -1.2345% -0.3456%] (p = 0.02 < 0.05)
                        Performance has improved.
```

- **Negative change**: Performance improved (faster)
- **Positive change**: Performance regressed (slower)
- **p < 0.05**: Change is statistically significant

## Quick Validation

Verify everything works:

```bash
# Check compilation
cargo check

# Build release version
cargo build --release

# Run quick test of all benchmarks
cargo bench -- --quick
```

## Benchmark Highlights

### 🔥 Most Important: Reachability
```bash
cargo bench --bench reachability
```
- Tests both Timely AND Differential Dataflow
- Real graph data (55K edges)
- Includes correctness validation
- Shows iterative computation performance

### ⚡ Fastest: Identity
```bash
cargo bench --bench identity
```
- Measures baseline operator overhead
- Runs in ~25 seconds
- Good for quick validation

### 🎯 Most Complex: Join
```bash
cargo bench --bench join
```
- Tests hash join with different types
- Shows type handling overhead
- Good for comparing join strategies

## Common Commands

### Save baseline for comparison
```bash
cargo bench -- --save-baseline initial
```

### Compare against baseline
```bash
# Make some changes, then:
cargo bench -- --baseline initial
```

### Run with minimal iterations (for testing)
```bash
cargo bench -- --quick
```

### Run specific benchmark variant
```bash
cargo bench --bench reachability -- "reachability/timely"
cargo bench --bench reachability -- "reachability/differential"
cargo bench --bench join -- "join/usize/usize/timely"
```

## Interpreting Benchmark Names

### Pattern: `benchmark_name/variant/timely_or_differential`

Examples:
- `arithmetic/timely` - Timely implementation of arithmetic
- `reachability/timely` - Timely implementation of reachability
- `reachability/differential` - Differential implementation of reachability
- `join/usize/usize/timely` - Join of two usize columns using Timely
- `join/String/String/timely` - Join of two String columns using Timely
- `upcase_in_place/timely` - In-place uppercase using Timely

## Troubleshooting

### Error: "Cannot find timely"
```bash
cargo update
cargo clean
cargo build --release
```

### Benchmarks taking too long
```bash
# Run in quick mode
cargo bench -- --quick

# Or run specific benchmarks
cargo bench --bench arithmetic
```

### No HTML report generated
```bash
# HTML reports are in target/criterion/
ls target/criterion/report/

# Make sure you have run at least one benchmark
cargo bench --bench arithmetic
```

## Next Steps

### 1. Read the full documentation
- [README.md](README.md) - Complete benchmark descriptions
- [TESTING.md](TESTING.md) - Validation procedures
- [BENCHMARK_COMPARISON.md](BENCHMARK_COMPARISON.md) - How to compare with Hydro

### 2. Run comprehensive benchmarks
```bash
# Save initial baseline
cargo bench -- --save-baseline initial

# Review HTML reports
open target/criterion/report/index.html
```

### 3. Compare with Hydro
See [BENCHMARK_COMPARISON.md](BENCHMARK_COMPARISON.md) for detailed instructions.

## Quick Reference Card

| Command | Purpose | Time |
|---------|---------|------|
| `cargo check` | Verify compilation | 30s |
| `cargo bench --bench arithmetic` | Quick test | 30s |
| `cargo bench -- --quick` | Fast validation | 2m |
| `cargo bench` | Full benchmark suite | 8-10m |
| `cargo bench --bench reachability` | Critical test | 2m |

## Performance Tips

### For accurate benchmarks:
```bash
# Close unnecessary applications
# Use performance CPU governor (Linux)
echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor

# Build with optimizations
RUSTFLAGS="-C target-cpu=native" cargo bench
```

### For quick testing:
```bash
# Use --quick flag
cargo bench -- --quick

# Run single benchmark
cargo bench --bench arithmetic
```

## Understanding the Benchmarks

### What each benchmark tests:

| Benchmark | Tests | Why It Matters |
|-----------|-------|----------------|
| arithmetic | Pipeline throughput | Basic dataflow efficiency |
| fan_in | Stream merging | Multi-source handling |
| fan_out | Stream splitting | Broadcasting capability |
| fork_join | Complex patterns | Real-world dataflow |
| identity | Operator overhead | Baseline performance |
| join | Hash join | Relational operations |
| reachability | Iterative algorithms | Graph processing |
| upcase | String handling | Text processing |

### Data sizes:

- **Small**: identity, arithmetic, upcase (< 1M elements)
- **Medium**: fan_in, fan_out, fork_join (1M - 10M elements)
- **Large**: join, reachability (100K tuples, 55K edges)

## Getting Help

### Check the documentation:
1. [README.md](README.md) - Complete reference
2. [TESTING.md](TESTING.md) - Testing guide
3. [BENCHMARK_COMPARISON.md](BENCHMARK_COMPARISON.md) - Comparison guide
4. [MIGRATION.md](MIGRATION.md) - Historical context

### Common issues:
- Compilation errors → `cargo clean && cargo build`
- Slow benchmarks → Use `--quick` flag
- Missing reports → Check `target/criterion/`
- Unexpected results → Run multiple times

## Success Checklist

After following this guide, you should have:
- [x] Compiled the benchmark suite
- [x] Run at least one benchmark
- [x] Viewed HTML reports
- [x] Understood result format
- [x] Know how to run specific benchmarks

**Ready for more?** Check out the full [README.md](README.md)!
