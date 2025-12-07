# Setup and Usage Guide

## Overview

This repository contains benchmarks for the Hydro project that compare performance against timely and differential-dataflow. These benchmarks were moved from the main bigweaver-agent-canary-hydro-zeta repository to keep the main codebase free of these external dependencies.

## Prerequisites

- Rust toolchain (1.91.1 or later)
- Git access to the main bigweaver-agent-canary-hydro-zeta repository

## Setup

1. Clone this repository:
```bash
git clone https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps
```

2. The benchmarks automatically fetch dependencies from the main repository via git dependencies, so no additional setup is needed.

## Running Benchmarks

### Run All Benchmarks

```bash
cargo bench -p benches
```

This will run all available benchmarks and output performance results.

### Run Specific Benchmarks

You can run individual benchmarks by name:

```bash
# Run the reachability benchmark
cargo bench -p benches --bench reachability

# Run the identity benchmark
cargo bench -p benches --bench identity

# Run the arithmetic benchmark
cargo bench -p benches --bench arithmetic
```

### Run with Criterion Filters

You can use Criterion's filtering to run specific test cases:

```bash
# Run only DFIR benchmarks
cargo bench -p benches -- dfir

# Run only micro-operation benchmarks
cargo bench -p benches -- micro/ops/
```

## Available Benchmarks

| Benchmark | Description |
|-----------|-------------|
| `arithmetic` | Tests basic arithmetic operations across different dataflow frameworks |
| `fan_in` | Tests fan-in patterns where multiple streams merge |
| `fan_out` | Tests fan-out patterns where one stream splits to multiple |
| `fork_join` | Tests fork-join patterns with parallel processing |
| `futures` | Tests futures-based asynchronous operations |
| `identity` | Tests simple identity operations (baseline) |
| `join` | Tests join operations between streams |
| `micro_ops` | Tests various micro-operations for detailed performance analysis |
| `reachability` | Tests graph reachability algorithms on real graph data |
| `symmetric_hash_join` | Tests symmetric hash join implementations |
| `upcase` | Tests string uppercasing on word lists |
| `words_diamond` | Tests diamond patterns with word processing |

## Benchmark Results

Results are stored in `target/criterion/` after running benchmarks. You can view:
- HTML reports: `target/criterion/*/report/index.html`
- Raw data: `target/criterion/*/base/estimates.json`

## CI/CD

Benchmarks can be triggered in CI by:
- Including `[ci-bench]` in commit messages or PR titles/bodies
- Manual workflow dispatch in GitHub Actions
- Daily scheduled runs at 8:35 PM PDT / 7:35 PM PST

## Performance Comparison Workflow

1. Run benchmarks in this repository to compare Hydro against timely/differential-dataflow
2. Analyze the results to identify performance gaps or improvements
3. If optimizations are needed, make changes in the main bigweaver-agent-canary-hydro-zeta repository
4. Re-run benchmarks to verify improvements

## Dependencies

The benchmark suite depends on:

### External Dependencies
- `timely-master` (0.13.0-dev.1) - Timely dataflow framework
- `differential-dataflow-master` (0.13.0-dev.1) - Differential dataflow framework
- `criterion` (0.5.0) - Benchmarking framework

### Internal Dependencies (from main repository)
- `dfir_rs` - Core Hydro dataflow runtime
- `sinktools` - Utilities for stream sinks

These are fetched automatically via git dependencies from the main repository.

## Troubleshooting

### Build Failures

If builds fail, ensure:
1. You have network access to fetch git dependencies
2. The main repository is accessible
3. Rust toolchain version is compatible (1.91.1+)

### Benchmark Failures

If benchmarks fail or produce unexpected results:
1. Check that input data files are present (e.g., `words_alpha.txt`, `reachability_edges.txt`)
2. Verify sufficient system resources (some benchmarks are memory-intensive)
3. Check the Criterion output for specific error messages

## Contributing

When adding new benchmarks:
1. Add the benchmark implementation in `benches/benches/`
2. Update `benches/Cargo.toml` with a new `[[bench]]` section
3. Update this SETUP.md and the main README.md
4. Test locally before submitting PR

## Questions and Support

For issues related to:
- Benchmark failures: Check this repository's issues
- Hydro performance: Check the main bigweaver-agent-canary-hydro-zeta repository
- Timely/differential-dataflow: Check their respective upstream repositories
