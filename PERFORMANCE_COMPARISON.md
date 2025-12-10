# Performance Comparison Guide

This document explains how to run performance comparisons between benchmarks in this repository and the main bigweaver-agent-canary-hydro-zeta repository.

## Overview

Both repositories use the [Criterion](https://github.com/bheisler/criterion.rs) benchmarking framework, which provides consistent, statistically rigorous performance measurements.

## Running Benchmarks

### In this repository (timely/differential-dataflow benchmarks):

```bash
cd benches
cargo bench
```

This will run benchmarks:
- arithmetic
- fan_in
- fan_out
- fork_join
- identity
- join
- reachability
- upcase

### In the main repository:

```bash
cd /path/to/bigweaver-agent-canary-hydro-zeta
cargo bench -p benches
```

This will run benchmarks:
- futures
- micro_ops
- symmetric_hash_join
- words_diamond

## Comparing Results

### Using Criterion HTML Reports

After running benchmarks, Criterion generates HTML reports in `target/criterion/`:

1. **This repository**: `target/criterion/*/report/index.html`
2. **Main repository**: `target/criterion/*/report/index.html`

Open these HTML files in a browser to view detailed performance metrics, including:
- Execution time statistics (mean, median, std deviation)
- Performance plots
- Historical comparisons (if run multiple times)

### Comparing Across Changes

To compare performance before and after code changes:

1. **Baseline measurement**: Run benchmarks before making changes
   ```bash
   cargo bench --bench <benchmark_name> -- --save-baseline baseline
   ```

2. **Make your changes** to the code

3. **Comparison measurement**: Run benchmarks again and compare
   ```bash
   cargo bench --bench <benchmark_name> -- --baseline baseline
   ```

Criterion will show percentage changes in performance.

### Cross-Repository Comparison

While benchmarks are in separate repositories, they can still be compared:

1. Note the absolute performance numbers from each repository
2. Use the same hardware and system conditions for both runs
3. Record results in a spreadsheet or document for comparison
4. Consider running multiple times and using median values for accuracy

## Example Workflow

```bash
# 1. Clone both repositories
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git

# 2. Run main repository benchmarks
cd bigweaver-agent-canary-hydro-zeta
cargo bench -p benches

# 3. Run deps repository benchmarks
cd ../bigweaver-agent-canary-zeta-hydro-deps/benches
cargo bench

# 4. Compare HTML reports
open ../bigweaver-agent-canary-hydro-zeta/target/criterion/*/report/index.html
open target/criterion/*/report/index.html
```

## Benchmark Isolation

Since benchmarks are now in separate repositories:
- Dependencies are isolated
- Each repository can be updated independently
- No risk of dependency conflicts between timely/differential-dataflow and main code
- Cleaner dependency tree in the main repository

## CI/CD Integration

For automated performance tracking:
1. Set up CI jobs for each repository
2. Run benchmarks on consistent hardware
3. Store results as artifacts
4. Use tools like [cargo-criterion](https://github.com/bheisler/cargo-criterion) for automated comparison
5. Set up alerts for significant performance regressions
