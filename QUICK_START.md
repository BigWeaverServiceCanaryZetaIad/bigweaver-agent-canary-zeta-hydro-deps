# Quick Start Guide

Get up and running with the benchmark repository in minutes!

## Prerequisites

- Rust toolchain 1.91.1 or later
- Git
- ~17 MB of disk space

## Installation

```bash
# Clone the repository
git clone <repository-url>
cd bigweaver-agent-canary-zeta-hydro-deps

# Verify setup
bash verify_benchmarks.sh
```

## Running Benchmarks

### Run All Benchmarks
```bash
cargo bench -p benches
```

This will:
- Run all 12 benchmarks
- Generate statistical analysis
- Create HTML reports in `target/criterion/`
- Compare with previous runs (if available)

### Run Specific Benchmark
```bash
# Run reachability benchmark
cargo bench -p benches --bench reachability

# Run join benchmark
cargo bench -p benches --bench join
```

### Quick Mode (Faster)
```bash
cargo bench -p benches -- --quick
```

## Viewing Results

### HTML Reports
```bash
# Open main report
open target/criterion/report/index.html

# Or on Linux
xdg-open target/criterion/report/index.html
```

### Console Output
Results are also displayed in the console with:
- Mean execution time
- Standard deviation
- Comparison with previous runs

## Available Benchmarks

| Benchmark | Description | Command |
|-----------|-------------|---------|
| `arithmetic` | Arithmetic operations | `cargo bench -p benches --bench arithmetic` |
| `fan_in` | Fan-in operations | `cargo bench -p benches --bench fan_in` |
| `fan_out` | Fan-out operations | `cargo bench -p benches --bench fan_out` |
| `fork_join` | Fork-join patterns | `cargo bench -p benches --bench fork_join` |
| `futures` | Futures-based operations | `cargo bench -p benches --bench futures` |
| `identity` | Identity operations | `cargo bench -p benches --bench identity` |
| `join` | Join operations | `cargo bench -p benches --bench join` |
| `micro_ops` | Micro-operation benchmarks | `cargo bench -p benches --bench micro_ops` |
| `reachability` | Graph reachability | `cargo bench -p benches --bench reachability` |
| `symmetric_hash_join` | Symmetric hash join | `cargo bench -p benches --bench symmetric_hash_join` |
| `upcase` | String uppercase | `cargo bench -p benches --bench upcase` |
| `words_diamond` | Word processing | `cargo bench -p benches --bench words_diamond` |

## Common Tasks

### Save Baseline for Comparison
```bash
cargo bench -p benches -- --save-baseline my-baseline
```

### Compare with Baseline
```bash
cargo bench -p benches -- --baseline my-baseline
```

### Run Specific Pattern
```bash
# Run benchmarks matching "join"
cargo bench -p benches -- join
```

### Check Workspace
```bash
# Check all packages compile
cargo check --workspace

# Build everything
cargo build --workspace
```

## File Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── benches/                  # Benchmark package
│   ├── benches/             # Benchmark files
│   ├── Cargo.toml          # Dependencies
│   └── README.md           # Benchmark docs
├── [dependencies]/          # Required libraries
├── Cargo.toml              # Workspace config
└── [documentation]/        # Guides and docs
```

## Performance Comparison

Each benchmark typically compares:
- **Hydroflow/DFIR**: High-level dataflow framework
- **Timely Dataflow**: Low-latency cyclic dataflow
- **Differential Dataflow**: Incremental computation

Results show relative performance of each framework for the same algorithm.

## Troubleshooting

### Benchmarks Too Slow
```bash
# Use quick mode
cargo bench -p benches -- --quick

# Or reduce sample size
CRITERION_SAMPLE_SIZE=20 cargo bench -p benches
```

### Compilation Errors
```bash
# Clean build
cargo clean

# Update dependencies
cargo update
```

### Missing Data Files
```bash
# Verify files exist
ls -lh benches/benches/*.txt

# Should show:
# - reachability_edges.txt (~521KB)
# - reachability_reachable.txt (~38KB)
# - words_alpha.txt (~3.7MB)
```

## Next Steps

1. **Read Full Documentation**
   - [README.md](README.md) - Complete overview
   - [PERFORMANCE_COMPARISON_GUIDE.md](PERFORMANCE_COMPARISON_GUIDE.md) - Detailed guide
   - [CHANGES.md](CHANGES.md) - Changelog

2. **Explore Benchmarks**
   - Check out `benches/benches/*.rs` files
   - Understand benchmark implementations
   - See how frameworks are compared

3. **Run Your Own Tests**
   - Modify benchmark parameters
   - Add new benchmarks
   - Experiment with different data sizes

## Documentation Index

| File | Purpose |
|------|---------|
| [README.md](README.md) | Main repository documentation |
| [QUICK_START.md](QUICK_START.md) | This file - get started quickly |
| [PERFORMANCE_COMPARISON_GUIDE.md](PERFORMANCE_COMPARISON_GUIDE.md) | Detailed performance testing guide |
| [CHANGES.md](CHANGES.md) | Changelog and version history |
| [MIGRATION_SUMMARY.md](MIGRATION_SUMMARY.md) | Migration details and task completion |
| [benches/README.md](benches/README.md) | Benchmark-specific documentation |

## Support

For issues or questions:
1. Check the documentation files above
2. Review benchmark source code
3. Consult [Criterion.rs documentation](https://bheisler.github.io/criterion.rs/book/)
4. Refer to main repository documentation

---

**Ready to benchmark?**

```bash
cargo bench -p benches
```

Let the performance testing begin! 🚀
