# Benchmark Guide

This repository contains benchmarks for Hydro that depend on external packages like `timely` and `differential-dataflow`. These benchmarks have been separated from the main repository to avoid unnecessary dependencies.

## Overview

The benchmarks in the `benches/` directory allow for performance comparisons between Hydro implementations and other dataflow systems like Timely Dataflow and Differential Dataflow.

## Running Benchmarks

### Prerequisites

Ensure you have Rust and Cargo installed with the correct toolchain version specified in the main repository.

### Running All Benchmarks

```bash
cargo bench -p benches
```

### Running Specific Benchmarks

Run a single benchmark:
```bash
cargo bench -p benches --bench reachability
```

Available benchmarks:
- `arithmetic` - Arithmetic operations
- `fan_in` - Fan-in operations
- `fan_out` - Fan-out operations  
- `fork_join` - Fork-join patterns
- `identity` - Identity transformations
- `upcase` - String case transformations
- `join` - Join operations
- `reachability` - Graph reachability
- `micro_ops` - Micro-operations
- `symmetric_hash_join` - Symmetric hash join
- `words_diamond` - Word processing diamond pattern
- `futures` - Async/await patterns

## Performance Comparison Workflow

### 1. Run Benchmarks in This Repository

```bash
cargo bench -p benches --bench <benchmark_name>
```

Results are saved in `target/criterion/` directory.

### 2. Compare with Main Repository

The main repository (`bigweaver-agent-canary-hydro-zeta`) contains Hydro-native implementations. To compare:

1. Run benchmarks in the main repository
2. Run equivalent benchmarks in this repository
3. Use Criterion's comparison features:

```bash
# Save baseline
cargo bench -p benches --bench <benchmark_name> -- --save-baseline baseline-name

# Compare against baseline
cargo bench -p benches --bench <benchmark_name> -- --baseline baseline-name
```

### 3. Analyzing Results

Criterion generates HTML reports in `target/criterion/<benchmark_name>/report/index.html`. These reports include:
- Throughput measurements
- Latency distributions
- Statistical analysis
- Comparison graphs (when using baselines)

## Benchmark Structure

Each benchmark typically includes multiple implementations:
- **Hydro implementation**: Using the Hydro dataflow framework
- **Timely/Differential implementation**: Using Timely Dataflow or Differential Dataflow
- **Naive implementation**: Simple baseline implementation

This allows for direct performance comparison between different approaches.

## Dependencies

The benchmarks depend on:
- `dfir_rs` - From the main repository (referenced via git)
- `sinktools` - From the main repository (referenced via git)
- `timely-master` - Timely Dataflow
- `differential-dataflow-master` - Differential Dataflow
- `criterion` - Benchmarking harness

## Updating Dependencies

When the main repository is updated, you may need to update the git dependencies:

```bash
cargo update
```

To use a specific commit or branch from the main repository, update `benches/Cargo.toml`:

```toml
dfir_rs = { git = "...", rev = "commit-hash", features = [ "debugging" ] }
```

## CI/CD Integration

These benchmarks can be integrated into CI/CD pipelines for continuous performance monitoring. Refer to the main repository's CI configuration for examples.

## Troubleshooting

### Build Failures

If builds fail due to missing dependencies:
1. Ensure the main repository is accessible via git
2. Check that the correct git URL is specified in `benches/Cargo.toml`
3. Verify network connectivity to git repositories

### Performance Regression

If benchmarks show performance regression:
1. Check recent changes in the main repository
2. Compare against multiple baselines
3. Review Criterion's statistical analysis
4. Consider environmental factors (CPU load, thermal throttling, etc.)

## Contributing

When adding new benchmarks:
1. Follow the existing benchmark structure
2. Include multiple implementations for comparison
3. Document the benchmark purpose and expected behavior
4. Update this guide with the new benchmark name
