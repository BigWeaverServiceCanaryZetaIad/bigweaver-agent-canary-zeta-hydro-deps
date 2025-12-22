# Quick Start Guide - Benchmarking After Migration

## Overview

Benchmarks that depend on timely-dataflow and differential-dataflow have been migrated to a separate repository. This guide shows you how to run benchmarks and compare performance.

## Repository Structure

- **bigweaver-agent-canary-hydro-zeta**: Contains benchmarks for babyflow, hydroflow, spinachflow, and baseline implementations
- **bigweaver-agent-canary-zeta-hydro-deps**: Contains isolated timely-dataflow benchmarks

## Running Benchmarks

### Option 1: Run All Benchmarks in Main Repository

```bash
cd /projects/sandbox/bigweaver-agent-canary-hydro-zeta
cargo bench
```

This runs benchmarks for:
- babyflow
- hydroflow  
- spinachflow
- raw/baseline implementations

### Option 2: Run Timely Benchmarks

```bash
cd /projects/sandbox/bigweaver-agent-canary-zeta-hydro-deps
cargo bench
```

This runs benchmarks for:
- timely-dataflow implementations only

### Option 3: Run Specific Benchmark

```bash
# In main repository
cd /projects/sandbox/bigweaver-agent-canary-hydro-zeta
cargo bench --bench arithmetic

# In deps repository
cd /projects/sandbox/bigweaver-agent-canary-zeta-hydro-deps
cargo bench --bench arithmetic
```

### Option 4: Automated Comparison

```bash
cd /projects/sandbox/bigweaver-agent-canary-zeta-hydro-deps
./scripts/compare_benchmarks.sh
```

This script will:
1. Run all timely benchmarks in the deps repository
2. Run all other benchmarks in the main repository
3. Save results in each repository's `target/criterion/` directory

## Viewing Results

After running benchmarks, view detailed results:

```bash
# View timely benchmark results
cd /projects/sandbox/bigweaver-agent-canary-zeta-hydro-deps
open target/criterion/report/index.html  # or xdg-open on Linux

# View main repository benchmark results
cd /projects/sandbox/bigweaver-agent-canary-hydro-zeta
open target/criterion/report/index.html  # or xdg-open on Linux
```

## Available Benchmarks

### In Both Repositories (Different Implementations)

1. **arithmetic**: Chain of arithmetic operations
2. **fan_in**: Multiple inputs merging into one stream
3. **fan_out**: One input fanning out to multiple outputs
4. **fork_join**: Forking and joining streams with filtering
5. **identity**: Identity operations (pass-through)
6. **join**: Hash join operations
7. **reachability**: Graph reachability with feedback loops
8. **upcase**: String manipulation operations

### Only in Main Repository

9. **zip**: Zipping two streams together (no timely implementation)

## Comparing Performance

### Manual Comparison

1. Run benchmarks in both repositories
2. Compare the results from `target/criterion/` directories
3. Look for performance differences between implementations

### What to Compare

- **Throughput**: Operations per second
- **Latency**: Time per operation
- **Memory usage**: Check criterion reports
- **Scalability**: Run with different input sizes

## Adding New Benchmarks

### Adding a Timely Benchmark

Add to the deps repository:

```bash
cd /projects/sandbox/bigweaver-agent-canary-zeta-hydro-deps
# 1. Create new benchmark file in timely-differential-benches/benches/
# 2. Add [[bench]] entry to timely-differential-benches/Cargo.toml
# 3. Test with: cargo bench --bench <name>
```

### Adding a Non-Timely Benchmark

Add to the main repository:

```bash
cd /projects/sandbox/bigweaver-agent-canary-hydro-zeta
# 1. Create new benchmark file in benches/benches/
# 2. Add [[bench]] entry to benches/Cargo.toml
# 3. Test with: cargo bench --bench <name>
```

## Troubleshooting

### Build Errors in Main Repository

If you see errors about missing timely imports:
- Check that all `use timely::*` imports have been removed
- Check that all `benchmark_timely` function calls have been removed from `criterion_group!` macros

### Build Errors in Deps Repository

If you see errors about missing babyflow/hydroflow/spinachflow:
- These should NOT be in the deps repository
- The deps repository should only contain timely-specific code

### Benchmark Not Found

Make sure the benchmark is declared in the appropriate Cargo.toml:
- Main repository: `benches/Cargo.toml`
- Deps repository: `timely-differential-benches/Cargo.toml`

## Performance Tips

1. **Run in Release Mode**: Always use `cargo bench` (not `cargo test`)
2. **Stable Environment**: Close other applications for consistent results
3. **Multiple Runs**: Run benchmarks multiple times and average results
4. **Warm Up**: Criterion automatically warms up, but first run may be slower
5. **Save Baselines**: Use `cargo bench -- --save-baseline <name>` to save results

## Further Reading

- See `MIGRATION.md` in bigweaver-agent-canary-zeta-hydro-deps for detailed migration documentation
- See README.md files in each repository for more information
- Criterion documentation: https://bheisler.github.io/criterion.rs/book/
