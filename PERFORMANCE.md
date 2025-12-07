# Performance Comparison Guide

This document explains how to run performance comparisons between benchmarks in this repository (which depend on timely/differential-dataflow) and benchmarks in the main `bigweaver-agent-canary-hydro-zeta` repository (which do not).

## Overview

The benchmarks have been split across two repositories:

1. **This repository (bigweaver-agent-canary-zeta-hydro-deps)**: Contains benchmarks that depend on `timely` and `differential-dataflow` packages
2. **Main repository (bigweaver-agent-canary-hydro-zeta)**: Contains benchmarks that do not depend on those packages

This separation allows the main repository to remain free of timely/differential-dataflow dependencies while retaining the ability to run performance comparisons.

## Running Benchmarks

### In This Repository

```bash
# Clone this repository if you haven't already
git clone https://github.com/hydro-project/hydro-deps bigweaver-agent-canary-zeta-hydro-deps
cd bigweaver-agent-canary-zeta-hydro-deps

# Run all benchmarks
cargo bench -p benches

# Run specific benchmarks
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench reachability
cargo bench -p benches --bench fan_in
```

Available benchmarks in this repository:
- `arithmetic` - Arithmetic operations pipeline
- `fan_in` - Fan-in pattern
- `fan_out` - Fan-out pattern
- `fork_join` - Fork-join pattern
- `identity` - Identity operation
- `join` - Join operation
- `reachability` - Graph reachability (uses differential-dataflow)
- `upcase` - String uppercase transformation

### In Main Repository

```bash
# Clone the main repository if you haven't already
git clone https://github.com/hydro-project/hydro bigweaver-agent-canary-hydro-zeta
cd bigweaver-agent-canary-hydro-zeta

# Run all benchmarks
cargo bench -p benches

# Run specific benchmarks
cargo bench -p benches --bench micro_ops
cargo bench -p benches --bench words_diamond
```

Available benchmarks in main repository:
- `micro_ops` - Microbenchmarks of individual operators
- `symmetric_hash_join` - Symmetric hash join
- `words_diamond` - Words diamond pattern

## Comparing Results

Benchmark results are stored in the `target/criterion` directory of each repository. You can compare results by:

1. **Running benchmarks in both repositories**:
   ```bash
   # In this repository
   cd bigweaver-agent-canary-zeta-hydro-deps
   cargo bench -p benches
   
   # In main repository
   cd bigweaver-agent-canary-hydro-zeta
   cargo bench -p benches
   ```

2. **Examining HTML reports**: Criterion generates HTML reports in `target/criterion/`. Open `target/criterion/report/index.html` in a web browser to view detailed results with graphs.

3. **Comparing specific metrics**: Look at the console output for quick comparisons, or compare the detailed reports in the HTML files.

## Performance Testing Workflow

### For Regular Performance Testing

1. Run benchmarks in both repositories after making changes
2. Compare results with baseline measurements
3. Investigate any significant performance regressions

### For Performance Comparisons Between Approaches

If you want to compare DFIR/Hydroflow implementations with timely/differential-dataflow implementations:

1. Ensure both repositories are at compatible versions
2. Run comparable benchmarks in both repositories
3. Compare throughput, latency, and resource usage
4. Document findings in your performance analysis

## Notes

- The benchmarks in this repository reference `dfir_rs` from the main repository via git dependency
- Ensure you have sufficient system resources when running benchmarks
- For consistent results, close other applications and run benchmarks multiple times
- Consider system state (cache warmth, CPU frequency scaling) when comparing results
