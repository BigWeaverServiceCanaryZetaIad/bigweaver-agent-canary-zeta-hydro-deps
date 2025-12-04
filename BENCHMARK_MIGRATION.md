# Benchmark Migration Guide

## Overview

The timely and differential-dataflow benchmarks have been moved from the `bigweaver-agent-canary-hydro-zeta` repository to this `bigweaver-agent-canary-zeta-hydro-deps` repository to keep the main repository free of these dependencies while maintaining the ability to run performance comparisons.

## Location

Benchmarks are now located in the `benches/` directory of this repository:
- Repository: `BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps`
- Path: `benches/`

## Running Benchmarks

### Prerequisites

Clone this repository:
```bash
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps
```

### Running All Benchmarks

```bash
cargo bench -p benches
```

### Running Specific Benchmarks

```bash
cargo bench -p benches --bench <benchmark_name>
```

For example:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench micro_ops
cargo bench -p benches --bench arithmetic
```

## Available Benchmarks

The following benchmarks are available:

1. **arithmetic** - Tests arithmetic operations performance
2. **fan_in** - Benchmarks fan-in patterns
3. **fan_out** - Benchmarks fan-out patterns
4. **fork_join** - Tests fork-join patterns
5. **identity** - Identity transformation benchmark
6. **upcase** - Uppercase transformation benchmark
7. **join** - Join operation benchmark
8. **reachability** - Graph reachability analysis
9. **micro_ops** - Micro-operation benchmarks
10. **symmetric_hash_join** - Symmetric hash join operations
11. **words_diamond** - Diamond pattern with word processing
12. **futures** - Futures-based operations

## Dependencies

The benchmarks depend on:
- `timely` (timely-master)
- `differential-dataflow` (differential-dataflow-master)
- `dfir_rs` (from main repository)
- `sinktools` (from main repository)
- `criterion` (for benchmarking framework)

## Performance Comparison

These benchmarks allow comparing Hydro implementations against timely and differential-dataflow implementations to:
- Track performance improvements
- Identify performance regressions
- Validate optimization strategies
- Compare different implementation approaches

## Why the Migration?

The timely and differential-dataflow dependencies were removed from the main repository to:
1. Reduce the dependency footprint of the main project
2. Simplify the build process for users who don't need performance comparisons
3. Maintain clear separation between core functionality and benchmarking tools
4. Keep the ability to run performance comparisons for development and optimization work

## Integration with CI/CD

The benchmarks can be run in CI/CD pipelines by referencing this repository. See the workflow examples in `.github/workflows/` (if available) for automated benchmark execution.
