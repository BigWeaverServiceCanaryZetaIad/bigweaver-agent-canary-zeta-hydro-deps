# 👋 Welcome to bigweaver-agent-canary-zeta-hydro-deps

## What is This Repository?

This repository contains **performance benchmarks** that compare [Hydroflow/dfir_rs](https://github.com/hydro-project/hydro) with other dataflow frameworks (Timely and Differential-Dataflow).

## Quick Overview

- **Purpose**: Compare performance of different dataflow frameworks
- **Benchmarks**: 8 comprehensive benchmarks testing various patterns
- **Frameworks**: Hydroflow (compiled/interpreted), Timely, Differential-Dataflow
- **Tool**: Uses Criterion for statistical benchmarking

## 🚀 Quick Start (5 Minutes)

### 1. Run a Quick Benchmark

```bash
# Try the identity benchmark (measures pure framework overhead)
cargo bench -p benches --bench identity -- --quick
```

### 2. View Results

Results will be printed to your terminal and saved to `target/criterion/`.

### 3. See HTML Report

```bash
# Open the detailed HTML report
open target/criterion/report/index.html       # macOS
xdg-open target/criterion/report/index.html   # Linux
start target/criterion/report/index.html      # Windows
```

## 📚 Where to Go Next?

Depending on your goal, start with:

| If you want to... | Read this... |
|-------------------|-------------|
| **Get started quickly** | [QUICK_START.md](QUICK_START.md) |
| **Understand the benchmarks** | [benches/README.md](benches/README.md) |
| **Compare framework performance** | [PERFORMANCE_COMPARISON_GUIDE.md](PERFORMANCE_COMPARISON_GUIDE.md) |
| **Learn about the migration** | [MIGRATION_SUMMARY.md](MIGRATION_SUMMARY.md) |
| **See what changed** | [CHANGES.md](CHANGES.md) |
| **Understand the task** | [TASK_COMPLETION_SUMMARY.md](TASK_COMPLETION_SUMMARY.md) |
| **General information** | [README.md](README.md) |

## 🎯 Common Use Cases

### I want to see how Hydroflow compares to Timely

```bash
# Run arithmetic benchmark comparing frameworks
cargo bench -p benches --bench arithmetic

# Check results - look for "arithmetic/dfir_rs/compiled" vs "arithmetic/timely"
```

### I want to run all benchmarks

```bash
# This takes ~10-15 minutes
cargo bench -p benches

# View comprehensive HTML reports
open target/criterion/report/index.html
```

### I want to track performance over time

```bash
# Save current performance as baseline
cargo bench -p benches --save-baseline today

# Later, compare new results
cargo bench -p benches --baseline today
```

## 📊 Available Benchmarks

| Benchmark | What It Tests | Complexity |
|-----------|---------------|------------|
| `identity` | Pure framework overhead | ⭐ Simple |
| `arithmetic` | Arithmetic operations | ⭐⭐ Medium |
| `upcase` | String transformations | ⭐⭐ Medium |
| `fan_in` | Multiple inputs → one output | ⭐⭐ Medium |
| `fan_out` | One input → multiple outputs | ⭐⭐ Medium |
| `fork_join` | Parallel processing | ⭐⭐⭐ Complex |
| `join` | Stream joins | ⭐⭐⭐ Complex |
| `reachability` | Graph algorithms | ⭐⭐⭐⭐ Very Complex |

## 🔧 System Requirements

- **Rust**: 1.75+ (automatically handled by `rust-toolchain.toml`)
- **Cargo**: Included with Rust
- **Disk Space**: ~5 MB for code, ~100 MB for build artifacts
- **Time**: 1-3 minutes per benchmark, ~15 minutes for all

## ❓ FAQ

### Why is this in a separate repository?

To keep the main Hydroflow repository clean and avoid including timely/differential-dataflow as dependencies when they're only needed for benchmarking.

### Can I run just one benchmark?

Yes! Use `cargo bench -p benches --bench <name>`, for example:
```bash
cargo bench -p benches --bench arithmetic
```

### What if I don't have much time?

Use the `--quick` flag for faster (but less precise) results:
```bash
cargo bench -p benches -- --quick
```

### How do I interpret results?

- **Lower time is better** (faster execution)
- **Higher throughput is better** (more operations per second)
- Criterion shows confidence intervals [lower, mean, upper]
- See [PERFORMANCE_COMPARISON_GUIDE.md](PERFORMANCE_COMPARISON_GUIDE.md) for detailed interpretation

### What frameworks are compared?

1. **Hydroflow (Compiled)**: Ahead-of-time compiled dfir_rs
2. **Hydroflow (Interpreted)**: Runtime interpreted dfir_rs
3. **Timely**: Timely dataflow framework
4. **Differential**: Differential-dataflow (reachability benchmark only)

### Where are results saved?

- **Terminal**: Printed during benchmark execution
- **Files**: `target/criterion/<benchmark-name>/`
- **HTML**: `target/criterion/report/index.html`

## 🆘 Need Help?

1. **Quick help**: See [QUICK_START.md](QUICK_START.md)
2. **Troubleshooting**: Check the troubleshooting sections in:
   - [benches/README.md](benches/README.md#troubleshooting)
   - [PERFORMANCE_COMPARISON_GUIDE.md](PERFORMANCE_COMPARISON_GUIDE.md#troubleshooting)
3. **Issues**: Open an issue on GitHub

## 🏗️ Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── benches/                    # Benchmark package
│   ├── benches/               # Benchmark source files
│   │   ├── *.rs              # 8 benchmark implementations
│   │   └── *.txt             # Data files for reachability
│   └── Cargo.toml            # Dependencies & configuration
├── *.md                       # Documentation files
└── *.toml                     # Configuration files
```

## 📝 Essential Commands

```bash
# Run all benchmarks
cargo bench -p benches

# Run one benchmark
cargo bench -p benches --bench arithmetic

# Quick test
cargo bench -p benches -- --quick

# View results
open target/criterion/report/index.html

# Save baseline
cargo bench -p benches --save-baseline main

# Compare to baseline
cargo bench -p benches --baseline main
```

## 🎓 Learning Path

**Beginner?** Start here:
1. Read this file (you're doing it! ✓)
2. Run a quick benchmark: `cargo bench -p benches --bench identity -- --quick`
3. Read [QUICK_START.md](QUICK_START.md)

**Intermediate?** Try this:
1. Run all benchmarks: `cargo bench -p benches`
2. Read [benches/README.md](benches/README.md)
3. Explore HTML reports

**Advanced?** Dive deeper:
1. Read [PERFORMANCE_COMPARISON_GUIDE.md](PERFORMANCE_COMPARISON_GUIDE.md)
2. Set up baseline tracking
3. Integrate with your workflow

## ✅ Verify Everything Works

Run the verification script:

```bash
bash verify_setup.sh
```

This checks:
- All files are present
- Configuration is correct
- Dependencies are set up
- Structure is valid

## 🚀 Ready to Start?

Pick one:

**Option 1**: Quick test (30 seconds)
```bash
cargo bench -p benches --bench identity -- --quick
```

**Option 2**: Medium test (2-3 minutes)
```bash
cargo bench -p benches --bench arithmetic
```

**Option 3**: Full suite (10-15 minutes)
```bash
cargo bench -p benches
```

---

**Questions?** Check the documentation files or open an issue!

**Happy Benchmarking! 🎉**
