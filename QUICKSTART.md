# Quick Start Guide

Get up and running with the Hydro benchmarks in 5 minutes.

## 🚀 Setup

### Step 1: Clone Repositories

Clone both repositories as siblings:

```bash
# Create a workspace directory
mkdir hydro-workspace
cd hydro-workspace

# Clone main repository
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git

# Clone benchmark repository
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
```

Your directory structure should look like:
```
hydro-workspace/
├── bigweaver-agent-canary-hydro-zeta/
└── bigweaver-agent-canary-zeta-hydro-deps/
```

### Step 2: Verify Setup

```bash
cd bigweaver-agent-canary-zeta-hydro-deps/benches
cargo check
```

If successful, you're ready to run benchmarks!

## 🏃 Running Benchmarks

### Run All Benchmarks

```bash
cd bigweaver-agent-canary-zeta-hydro-deps/benches
cargo bench
```

### Run a Single Benchmark

```bash
cargo bench --bench reachability
```

### Run Benchmarks for a Specific Category

```bash
# Run only timely dataflow benchmarks
cargo bench --bench arithmetic --bench fan_in --bench fan_out --bench fork_join --bench identity --bench join --bench upcase
```

## 📊 Quick Performance Comparison

Compare performance before and after making changes:

```bash
# Save baseline
cd bigweaver-agent-canary-zeta-hydro-deps/benches
cargo bench -- --save-baseline before

# Make your changes in bigweaver-agent-canary-hydro-zeta repository
cd ../../bigweaver-agent-canary-hydro-zeta
# ... edit files ...

# Compare
cd ../bigweaver-agent-canary-zeta-hydro-deps/benches
cargo bench -- --baseline before
```

## 📋 Available Benchmarks

### Timely Dataflow (7 benchmarks)
- `arithmetic` - Arithmetic operations
- `fan_in` - Stream concatenation
- `fan_out` - Stream splitting
- `fork_join` - Fork-join patterns
- `identity` - Baseline performance
- `join` - Join operations
- `upcase` - String transformation

### Differential Dataflow (1 benchmark)
- `reachability` - Graph reachability

### Other (4 benchmarks)
- `futures` - Async futures
- `micro_ops` - Micro-operations
- `symmetric_hash_join` - Hash join
- `words_diamond` - Diamond pattern

## 🔍 Understanding Results

Criterion will show output like:
```
reachability/dfir    time:   [45.234 ms 45.567 ms 45.901 ms]
                     change: [-2.34% -1.23% +0.12%] (p = 0.08 > 0.05)
                     No change in performance detected.
```

- **Time**: Lower/Estimate/Upper bounds
- **Change**: Performance change from baseline
- **p-value**: Statistical significance (< 0.05 = significant)

## 🛠️ Common Tasks

### Test a Specific Change

```bash
# 1. Save baseline
cargo bench --bench arithmetic -- --save-baseline test

# 2. Make changes in main repo
# 3. Test
cargo bench --bench arithmetic -- --baseline test
```

### Generate HTML Reports

```bash
cargo bench
# Reports are in: target/criterion/*/report/index.html
```

### Clean Build

```bash
cargo clean
cargo bench
```

## 🆘 Troubleshooting

### "Cannot find dfir_rs"
- Ensure both repos are cloned as siblings
- Check relative paths in `Cargo.toml`

### "Compilation error"
```bash
cd bigweaver-agent-canary-zeta-hydro-deps/benches
cargo clean
cargo check
```

### "Inconsistent results"
- Close other applications
- Run benchmarks multiple times
- Use baseline comparisons

## 📚 Learn More

- [README.md](README.md) - Full documentation
- [CONTRIBUTING.md](CONTRIBUTING.md) - Adding new benchmarks
- [PERFORMANCE_COMPARISON_GUIDE.md](PERFORMANCE_COMPARISON_GUIDE.md) - Advanced comparisons

## 💡 Tips

1. **First run is slower**: Includes compilation time
2. **Use baselines**: More reliable than comparing runs
3. **Multiple runs**: Average variance with several runs
4. **Check git status**: Know what version you're testing
5. **Document changes**: Note what changed between benchmarks

## ⚡ One-Liners

```bash
# Quick benchmark run
cd benches && cargo bench --bench reachability

# Compare branches
cd ../bigweaver-agent-canary-hydro-zeta && git checkout main && \
cd ../bigweaver-agent-canary-zeta-hydro-deps/benches && \
cargo bench -- --save-baseline main && \
cd ../../bigweaver-agent-canary-hydro-zeta && git checkout feature && \
cd ../bigweaver-agent-canary-zeta-hydro-deps/benches && \
cargo bench -- --baseline main

# Clean everything
cd benches && cargo clean && cd ../.. && \
cd bigweaver-agent-canary-hydro-zeta && cargo clean
```

Happy benchmarking! 🚀
