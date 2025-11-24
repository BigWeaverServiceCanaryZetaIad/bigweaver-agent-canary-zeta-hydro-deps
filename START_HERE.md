# 🚀 START HERE

Welcome to the bigweaver-agent-canary-zeta-hydro-deps benchmark repository!

## ⚡ Quick Start (5 minutes)

```bash
# 1. Verify your setup
./verify_setup.sh

# 2. Run your first benchmark
./run_benchmarks.sh --bench identity

# 3. View results
open target/criterion/report/index.html
```

## 📖 Documentation Guide

**New to this repository?** Follow this path:

1. **[README.md](README.md)** - Start here for overview
2. **[QUICK_START.md](QUICK_START.md)** - Get up and running
3. **[BENCHMARK_GUIDE.md](BENCHMARK_GUIDE.md)** - Understand benchmarks
4. **[PERFORMANCE_COMPARISON.md](PERFORMANCE_COMPARISON.md)** - Analyze performance

**Need something specific?** Check **[INDEX.md](INDEX.md)** for navigation.

## 🎯 Common Tasks

### Run Benchmarks

```bash
# Single benchmark
cargo bench --bench arithmetic

# All benchmarks
cargo bench

# Quick test
./run_benchmarks.sh --quick --bench identity
```

### Compare Performance

```bash
# Save baseline
cargo bench -- --save-baseline before

# After changes...
cargo bench -- --baseline before
```

### Get Help

```bash
# Script help
./run_benchmarks.sh --help

# Check setup
./verify_setup.sh
```

## 📚 Full Documentation

| Document | Purpose |
|----------|---------|
| [README.md](README.md) | Repository overview |
| [QUICK_START.md](QUICK_START.md) | Getting started |
| [BENCHMARK_GUIDE.md](BENCHMARK_GUIDE.md) | Detailed benchmarks |
| [PERFORMANCE_COMPARISON.md](PERFORMANCE_COMPARISON.md) | Performance analysis |
| [CONTRIBUTING.md](CONTRIBUTING.md) | Contributing guide |
| [INDEX.md](INDEX.md) | Documentation index |

## ❓ Need Help?

1. Check [QUICK_START.md § Common Issues](QUICK_START.md#common-issues-and-solutions)
2. Run `./verify_setup.sh` to diagnose problems
3. See [INDEX.md](INDEX.md) to find what you need

## ✅ What's in This Repository?

- **12 benchmarks** comparing Hydro, Timely, and Differential dataflow
- **Performance comparison tools** with statistical analysis
- **Comprehensive documentation** (9 files, ~101 KB)
- **Helper scripts** for easy execution
- **All necessary dependencies** isolated from main repo

---

**Quick Links:**
- 📖 [Full Documentation Index](INDEX.md)
- 🚀 [Quick Start Guide](QUICK_START.md)  
- 📊 [Benchmark Details](BENCHMARK_GUIDE.md)
- 🔍 [Performance Comparison](PERFORMANCE_COMPARISON.md)

**Ready?** Run `./verify_setup.sh` to get started! 🎉
