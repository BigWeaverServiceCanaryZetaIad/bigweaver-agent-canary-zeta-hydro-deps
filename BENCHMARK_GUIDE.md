# Benchmark Guide

This repository contains benchmarks for Hydro that were moved from the main `bigweaver-agent-canary-hydro-zeta` repository to isolate the timely-dataflow and differential-dataflow dependencies.

## Prerequisites

- Rust toolchain (see `rust-toolchain.toml` in the main repository)
- The main `bigweaver-agent-canary-hydro-zeta` repository must be cloned alongside this repository

## Directory Structure

```
/projects/sandbox/
├── bigweaver-agent-canary-hydro-zeta/  # Main repository
│   ├── dfir_rs/                         # Required by benchmarks
│   └── sinktools/                       # Required by benchmarks
└── bigweaver-agent-canary-zeta-hydro-deps/  # This repository
    └── benches/                         # Benchmark package
        ├── Cargo.toml                   # References ../bigweaver-agent-canary-hydro-zeta
        ├── build.rs                     # Build script for code generation
        ├── benches/                     # Benchmark implementations
        │   ├── arithmetic.rs
        │   ├── fan_in.rs
        │   ├── fan_out.rs
        │   ├── fork_join.rs
        │   ├── futures.rs
        │   ├── identity.rs
        │   ├── join.rs
        │   ├── micro_ops.rs
        │   ├── reachability.rs
        │   ├── symmetric_hash_join.rs
        │   ├── upcase.rs
        │   └── words_diamond.rs
        └── README.md
```

## Running Benchmarks

### Run All Benchmarks

```bash
cd /projects/sandbox/bigweaver-agent-canary-zeta-hydro-deps
cargo bench -p benches
```

### Run Specific Benchmarks

```bash
# Run a single benchmark
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench reachability
cargo bench -p benches --bench identity

# Run benchmarks matching a pattern
cargo bench -p benches -- dfir
cargo bench -p benches -- micro/ops/
```

### Run with Additional Options

```bash
# Generate Bencher output format
cargo bench -p benches -- dfir --output-format bencher

# Run with specific number of iterations
cargo bench -p benches --bench arithmetic -- --sample-size 100

# Save baseline for comparison
cargo bench -p benches -- --save-baseline my-baseline

# Compare against baseline
cargo bench -p benches -- --baseline my-baseline
```

## Benchmark Descriptions

### Performance Benchmarks

- **arithmetic.rs**: Tests arithmetic operations in various frameworks (pipeline, raw copy, dfir, timely)
- **identity.rs**: Tests identity transformations (no-op operations) across frameworks
- **join.rs**: Tests join operations between two data streams
- **symmetric_hash_join.rs**: Tests symmetric hash join implementation
- **reachability.rs**: Graph reachability computation using differential dataflow

### Dataflow Pattern Benchmarks

- **fan_in.rs**: Tests multiple input streams merging into one
- **fan_out.rs**: Tests one input stream splitting to multiple outputs
- **fork_join.rs**: Tests fork-join pattern with parallel processing and merging

### Integration Benchmarks

- **futures.rs**: Tests integration with async/await and Rust futures
- **micro_ops.rs**: Micro-operations benchmarks for basic dfir operations
- **words_diamond.rs**: Word processing with diamond-shaped dataflow pattern
- **upcase.rs**: String uppercase transformation benchmark

## Data Files

The benchmarks use the following data files:

- **words_alpha.txt**: English word list from https://github.com/dwyl/english-words
- **reachability_edges.txt**: Graph edges for reachability benchmark
- **reachability_reachable.txt**: Expected reachability results

## Dependencies

The benchmarks depend on:

- **dfir_rs**: Core DFIR implementation from main repository
- **sinktools**: Utility tools from main repository  
- **timely-master**: Timely dataflow framework (v0.13.0-dev.1)
- **differential-dataflow-master**: Differential dataflow framework (v0.13.0-dev.1)
- **criterion**: Benchmarking framework with statistics and HTML reports

## Troubleshooting

### Path Issues

If you get errors about missing dfir_rs or sinktools:

1. Ensure the main repository is cloned at the same level as this repository
2. Check that the relative paths in `benches/Cargo.toml` are correct:
   ```toml
   dfir_rs = { path = "../../bigweaver-agent-canary-hydro-zeta/dfir_rs", features = [ "debugging" ] }
   sinktools = { path = "../../bigweaver-agent-canary-hydro-zeta/sinktools", version = "^0.0.1" }
   ```

### Build Errors

If you encounter build errors:

1. Ensure you're using the correct Rust toolchain (check `rust-toolchain.toml` in main repo)
2. Try cleaning and rebuilding: `cargo clean && cargo build -p benches`
3. Verify all dependencies are available: `cargo check -p benches`

### Benchmark Failures

If benchmarks fail to run:

1. Check that data files exist in `benches/benches/`
2. Ensure sufficient memory is available (some benchmarks process large datasets)
3. Try running individual benchmarks to isolate the issue

## Performance Comparison

To compare performance across different implementations:

1. Run benchmarks and save baseline:
   ```bash
   cargo bench -p benches -- --save-baseline main
   ```

2. Make changes to the code

3. Run benchmarks again and compare:
   ```bash
   cargo bench -p benches -- --baseline main
   ```

4. View detailed HTML reports in `target/criterion/`

## CI/CD Integration

The benchmarks were previously integrated into the main repository's CI/CD pipeline via `.github/workflows/benchmark.yml`. This workflow:

- Ran on push to main, pull requests, and on a daily schedule
- Could be manually triggered with `[ci-bench]` in commit messages or PR titles
- Generated benchmark history and reports published to GitHub Pages

To integrate these benchmarks into CI/CD for this repository, you would need to:

1. Set up a similar GitHub Actions workflow
2. Configure GitHub Pages for benchmark results
3. Adjust paths to reference the new repository structure

## Notes

- The benchmarks use Criterion for statistical analysis and HTML report generation
- Generated reports are placed in `target/criterion/`
- Build script (`build.rs`) generates code for the fork_join benchmark
- Some benchmarks compare dfir performance against raw implementations and timely dataflow
