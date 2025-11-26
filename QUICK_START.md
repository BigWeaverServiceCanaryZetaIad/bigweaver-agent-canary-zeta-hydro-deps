# Quick Start Guide

Get started with the benchmarks in 5 minutes!

## Prerequisites

- Rust toolchain installed ([rustup.rs](https://rustup.rs/))
- ~4GB RAM available
- ~2GB disk space for build artifacts

## Setup (One-Time)

```bash
# Navigate to repository
cd bigweaver-agent-canary-zeta-hydro-deps

# Verify setup (optional but recommended)
./verify_setup.sh
```

## Running Benchmarks

### Run All Benchmarks

```bash
cargo bench
```

Expected time: 10-30 minutes  
Output location: `target/criterion/`

### Run One Benchmark (Faster)

```bash
# Fastest benchmark (~30 seconds)
cargo bench --bench identity

# Other individual benchmarks
cargo bench --bench fork_join     # ~1 minute
cargo bench --bench join           # ~1 minute
cargo bench --bench upcase         # ~30 seconds
cargo bench --bench fan_in         # ~1 minute
cargo bench --bench fan_out        # ~1 minute
cargo bench --bench arithmetic     # ~2 minutes
cargo bench --bench reachability   # ~5 minutes (slowest)
```

### View Results

```bash
# HTML reports
open target/criterion/report/index.html

# Or browse individual reports
ls target/criterion/*/report/index.html
```

## What Each Benchmark Does

| Benchmark | What It Tests | Time |
|-----------|--------------|------|
| **identity** | Data transformation overhead | ~30s |
| **fork_join** | Parallel split-merge patterns | ~1m |
| **join** | Relational join operations | ~1m |
| **upcase** | String processing | ~30s |
| **fan_in** | Multiple sources → one sink | ~1m |
| **fan_out** | One source → multiple sinks | ~1m |
| **arithmetic** | Computational dataflow | ~2m |
| **reachability** | Graph algorithms (differential) | ~5m |

## Common Commands

```bash
# Verify everything is set up
./verify_setup.sh

# Just compile (don't run)
cargo build --benches

# Quick test (less accurate, faster)
cargo bench -- --quick

# Clean build
cargo clean && cargo build --benches

# Help
cargo bench --help
```

## What's Being Compared?

Each benchmark compares:
- ✅ **Raw Rust** - Direct implementation baseline
- ✅ **Iterator** - Rust standard library
- ✅ **Timely** - Timely dataflow framework
- ✅ **Hydro** - Hydro's dfir_rs implementation
- ✅ **Differential** - Differential-dataflow (reachability only)

## Understanding Results

Console output shows:
```
identity/timely    time: [45.123 ms 45.456 ms 45.789 ms]
                   change: [-2.5% -1.2% +0.3%]
```

- **time**: [lower_bound estimate upper_bound]
- **change**: Compared to previous run (if available)

Lower time = Better performance

## First Time? Try This:

```bash
# 1. Run the fastest benchmark
cargo bench --bench identity

# 2. View the results
open target/criterion/identity/report/index.html

# 3. Compare implementations
# Look at the performance differences between:
# - identity/raw (baseline)
# - identity/timely
# - identity/dfir
```

## Troubleshooting

**Build fails?**
```bash
cargo clean
cargo build --benches
```

**Out of memory?**
- Close other applications
- Run individual benchmarks instead of all at once

**Too slow?**
- Run specific benchmarks: `cargo bench --bench identity`
- Use quick mode: `cargo bench -- --quick`

## Need More Help?

- 📖 Full documentation: [README.md](README.md)
- 🔧 Detailed guide: [RUNNING_BENCHMARKS.md](RUNNING_BENCHMARKS.md)
- 🔄 Migration info: [MIGRATION.md](MIGRATION.md)
- ✅ Setup details: [SETUP_COMPLETE.md](SETUP_COMPLETE.md)

## Example Session

```bash
# Start fresh
cd bigweaver-agent-canary-zeta-hydro-deps

# Run a quick benchmark
cargo bench --bench identity

# Wait ~30 seconds...

# View results
open target/criterion/identity/report/index.html

# Success! You've run your first benchmark.
```

---

**That's it!** You're ready to run performance comparisons. 🚀

For more advanced usage, see the full documentation files.
