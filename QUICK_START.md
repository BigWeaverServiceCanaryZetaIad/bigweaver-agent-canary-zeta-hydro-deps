# Quick Start Guide

This guide will help you quickly get started with running the Hydro benchmarks.

## Prerequisites

- Rust toolchain (1.82 or later recommended)
- Cargo package manager
- Git

## Setup

1. **Clone the repository**:
   ```bash
   git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
   cd bigweaver-agent-canary-zeta-hydro-deps
   ```

2. **Verify setup**:
   ```bash
   cargo --version
   ```

## Running Benchmarks

### Quick Test

Run a single fast benchmark to verify everything works:

```bash
cargo bench -p benches --bench identity
```

This should complete in a few minutes and produce HTML reports in `target/criterion/`.

### Run All Benchmarks

⚠️ **Note**: Running all benchmarks can take significant time (30+ minutes).

```bash
cargo bench -p benches
```

### Run Specific Benchmarks

Choose specific benchmarks based on what you want to test:

**Fast benchmarks** (good for quick testing):
```bash
cargo bench -p benches --bench identity
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench fan_in
```

**Medium complexity benchmarks**:
```bash
cargo bench -p benches --bench join
cargo bench -p benches --bench fork_join
cargo bench -p benches --bench upcase
```

**Intensive benchmarks** (may take longer):
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench words_diamond
```

### Quick Performance Comparison

To run benchmarks in quick mode (fewer iterations, faster results):

```bash
cargo bench -p benches -- --quick
```

## Understanding Results

### HTML Reports

After running benchmarks, open the generated HTML reports:

```bash
# On Linux
xdg-open target/criterion/report/index.html

# On macOS
open target/criterion/report/index.html

# On Windows
start target/criterion/report/index.html
```

### Terminal Output

Benchmark results are also displayed in the terminal, showing:
- **Time**: Execution time statistics (mean, median, std dev)
- **Throughput**: Items/operations per second
- **Comparison**: Performance relative to previous runs

## Common Tasks

### Build Without Running

```bash
cargo build -p benches --release
```

### Clean Build Artifacts

```bash
cargo clean
```

### Update Dependencies

```bash
cargo update
```

### Run Tests

```bash
cargo test -p benches
```

## Benchmarks Overview

| Benchmark | Description | Typical Runtime |
|-----------|-------------|----------------|
| identity | Baseline transformation | ~1 min |
| arithmetic | Math operations | ~2 min |
| fan_in | Multiple streams merging | ~2 min |
| fan_out | Stream splitting | ~2 min |
| fork_join | Fork-join pattern | ~3 min |
| join | Stream joins | ~3 min |
| upcase | String transformation | ~3 min |
| micro_ops | Micro-operations suite | ~5 min |
| symmetric_hash_join | Hash join operations | ~5 min |
| futures | Async futures handling | ~5 min |
| reachability | Graph reachability | ~8 min |
| words_diamond | Word processing | ~10 min |

*Runtimes are approximate and may vary based on system performance.*

## Performance Tips

1. **Close other applications**: For more consistent results
2. **Run on consistent hardware**: Results are most comparable when run on the same machine
3. **Multiple runs**: Run benchmarks multiple times for statistical validity
4. **Baseline comparison**: Criterion automatically compares against previous runs

## Troubleshooting

### Build Failures

If you encounter build errors:

1. **Update Rust toolchain**:
   ```bash
   rustup update stable
   ```

2. **Clean and rebuild**:
   ```bash
   cargo clean
   cargo build -p benches
   ```

3. **Check dependency versions**:
   ```bash
   cargo tree -p benches
   ```

### Out of Memory

If benchmarks fail due to memory:

1. Run benchmarks individually
2. Reduce dataset sizes if possible
3. Increase system swap space

### Slow Performance

If benchmarks are unexpectedly slow:

1. Ensure you're building in release mode (cargo bench does this automatically)
2. Check system resource usage
3. Close background applications
4. Use `--quick` flag for faster iteration during development

## Next Steps

- Read the main [README.md](README.md) for detailed information
- Review benchmark source code in `benches/benches/`
- Explore criterion reports for detailed performance analysis
- Compare results across different Hydro versions
- Add custom benchmarks for your use cases

## Getting Help

- Main repository: [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)
- Criterion documentation: https://bheisler.github.io/criterion.rs/book/
- Rust documentation: https://doc.rust-lang.org/

## Example Workflow

Here's a typical workflow for performance testing:

```bash
# 1. Clone and enter repository
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps

# 2. Run a quick test to verify setup
cargo bench -p benches --bench identity

# 3. Run specific benchmarks of interest
cargo bench -p benches --bench arithmetic --bench join

# 4. View results
xdg-open target/criterion/report/index.html

# 5. Make changes to main Hydro repository if needed

# 6. Re-run benchmarks to compare
cargo bench -p benches --bench arithmetic --bench join

# 7. Review performance differences in criterion reports
```
