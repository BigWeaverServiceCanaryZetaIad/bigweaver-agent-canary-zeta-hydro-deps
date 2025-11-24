# Quick Start Guide

## TL;DR

```bash
# Run all benchmarks
cargo bench

# Run specific benchmark
cargo bench --bench reachability

# Compare performance
./compare_performance.sh

# Verify everything works
./verify_migration.sh
```

## What's This Repository?

This repository contains the **timely and differential-dataflow benchmarks** that were migrated from the main `bigweaver-agent-canary-hydro-zeta` repository.

## Why Was It Migrated?

- ✅ Remove heavy dependencies from main repository
- ✅ Faster compilation times for main codebase
- ✅ Better code organization
- ✅ Independent benchmark development

## Repository Layout

```
.
├── benches/               # 12 benchmark files + data
├── Cargo.toml            # Dependencies and configuration
├── README.md             # Full documentation
├── compare_performance.sh # Performance comparison tool
└── verify_migration.sh   # Verification script
```

## Common Commands

### Running Benchmarks

```bash
# All benchmarks
cargo bench

# Single benchmark
cargo bench --bench identity

# Benchmarks matching pattern
cargo bench --bench fan_

# Save baseline for later comparison
cargo bench -- --save-baseline my-baseline

# Compare with saved baseline  
cargo bench -- --baseline my-baseline
```

### Performance Comparison

```bash
# Full comparison with automated reports
./compare_performance.sh

# Run specific benchmarks only
./compare_performance.sh --bench reachability --bench join

# Compare with git baseline
./compare_performance.sh --baseline main

# List available benchmarks
./compare_performance.sh --list

# Show help
./compare_performance.sh --help
```

### Viewing Results

```bash
# Open HTML report in browser
xdg-open target/criterion/report/index.html

# View comparison reports
ls -lh comparison_results/
cat comparison_results/*_report.md
```

### Verification

```bash
# Verify migration is complete
./verify_migration.sh
```

## Available Benchmarks

1. **arithmetic** - Arithmetic operations
2. **fan_in** - Fan-in patterns
3. **fan_out** - Fan-out patterns  
4. **fork_join** - Fork-join operations
5. **futures** - Async futures
6. **identity** - Identity baseline
7. **join** - Join operations
8. **micro_ops** - Micro-operations
9. **reachability** - Graph reachability
10. **symmetric_hash_join** - Hash joins
11. **upcase** - String operations
12. **words_diamond** - Diamond patterns

## Requirements

Both repositories must be in the same parent directory:

```
parent_directory/
├── bigweaver-agent-canary-hydro-zeta/      # Main repo
└── bigweaver-agent-canary-zeta-hydro-deps/ # This repo
```

## Dependencies

This repository depends on:
- **timely-master** (v0.13.0-dev.1)
- **differential-dataflow-master** (v0.13.0-dev.1)
- **dfir_rs** (from main repo)
- **sinktools** (from main repo)
- **criterion** (v0.5.0)

## Need More Info?

- **Full documentation**: See [README.md](README.md)
- **Migration details**: See [MIGRATION_SUMMARY.md](MIGRATION_SUMMARY.md)
- **Changes**: See [CHANGES.md](CHANGES.md)
- **Comparison tool help**: Run `./compare_performance.sh --help`

## Quick Examples

### Example 1: Run and Compare
```bash
# Save current performance as baseline
cargo bench -- --save-baseline before-changes

# Make changes to main repository...
# cd ../bigweaver-agent-canary-hydro-zeta
# ... make changes ...

# Compare new performance
cargo bench -- --baseline before-changes
```

### Example 2: Specific Benchmark Deep Dive
```bash
# Run single benchmark with detailed output
cargo bench --bench reachability -- --verbose

# View results
xdg-open target/criterion/reachability/report/index.html
```

### Example 3: Automated Comparison
```bash
# Run comparison with all features
./compare_performance.sh

# Check generated reports
cat comparison_results/*_summary.txt
cat comparison_results/*_report.md
```

## Troubleshooting

### Build Errors
```bash
# Ensure main repo is accessible
ls ../bigweaver-agent-canary-hydro-zeta

# Check dependencies
cargo check --benches
```

### Permission Issues
```bash
# Make scripts executable
chmod +x compare_performance.sh verify_migration.sh
```

### Path Issues
```bash
# Verify repository structure
pwd  # Should end in bigweaver-agent-canary-zeta-hydro-deps
ls ../bigweaver-agent-canary-hydro-zeta  # Should show main repo
```

## Status

✅ Migration Complete (November 24, 2024)
✅ All 12 benchmarks functional
✅ Performance comparison working
✅ Documentation comprehensive

---

**For complete documentation, see [README.md](README.md)**
