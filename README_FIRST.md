# 🎯 Start Here!

Welcome to the **bigweaver-agent-canary-zeta-hydro-deps** repository!

## What is This Repository?

This repository contains performance benchmarks for **timely** and **differential-dataflow** packages that were migrated from the main `bigweaver-agent-canary-hydro-zeta` repository to maintain clean dependency separation.

## Quick Start (3 Steps)

### 1️⃣ Verify Setup
```bash
./verify_setup.sh
```

### 2️⃣ Build Benchmarks
```bash
cargo build --benches
```

### 3️⃣ Run Benchmarks
```bash
cargo bench
```

## 📚 Documentation Guide

**New here?** Read in this order:

1. **[README.md](README.md)** - Repository overview and detailed information
2. **[QUICK_REFERENCE.md](QUICK_REFERENCE.md)** - Command cheat sheet
3. **[BENCHMARK_GUIDE.md](BENCHMARK_GUIDE.md)** - Detailed benchmarking guide

**Looking for something specific?**

- **Contributing**: See [CONTRIBUTING.md](CONTRIBUTING.md)
- **Migration details**: See [MIGRATION_SUMMARY.md](MIGRATION_SUMMARY.md)
- **Version history**: See [CHANGELOG.md](CHANGELOG.md)
- **All docs**: See [INDEX.md](INDEX.md)

## 📊 Available Benchmarks

| Benchmark | Description |
|-----------|-------------|
| arithmetic | Arithmetic pipeline operations |
| fan_in | Stream merging patterns |
| fan_out | Stream splitting patterns |
| fork_join | Parallel fork-join patterns |
| identity | Minimal overhead / identity operations |
| join | Stream join operations |
| reachability | Graph reachability algorithms |
| upcase | String transformations |

## 🔧 Prerequisites

**Required:**
- Rust toolchain (latest stable)
- Main repository (bigweaver-agent-canary-hydro-zeta) cloned as sibling directory

**Directory structure:**
```
parent-directory/
├── bigweaver-agent-canary-hydro-zeta/     ← Main repository
└── bigweaver-agent-canary-zeta-hydro-deps/ ← This repository
```

## ⚡ Common Commands

```bash
# Run all benchmarks
cargo bench

# Run specific benchmark
cargo bench --bench arithmetic

# Quick test (fewer samples)
cargo bench -- --quick

# View HTML reports
open target/criterion/report/index.html
```

## ❓ Need Help?

- **Setup issues**: Run ./verify_setup.sh for diagnostics
- **Usage questions**: Check BENCHMARK_GUIDE.md
- **Contributing**: See CONTRIBUTING.md

## 🎉 You're Ready!

Start by running ./verify_setup.sh to make sure everything is configured correctly, then dive into the benchmarks!

For complete documentation, see [README.md](README.md).
