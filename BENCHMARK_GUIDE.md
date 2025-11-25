# Benchmark Guide

Complete guide for running, understanding, and analyzing benchmarks in the bigweaver-agent-canary-zeta-hydro-deps repository.

## Table of Contents

- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Quick Start](#quick-start)
- [Available Benchmarks](#available-benchmarks)
- [Running Benchmarks](#running-benchmarks)
- [Understanding Results](#understanding-results)
- [Performance Comparison](#performance-comparison)
- [Troubleshooting](#troubleshooting)
- [Advanced Usage](#advanced-usage)

## Overview

This repository contains benchmarks that compare DFIR (DataFlow Intermediate Representation) implementations with timely-dataflow and differential-dataflow implementations. These benchmarks were moved from the main `bigweaver-agent-canary-hydro-zeta` repository to isolate the `timely` and `differential-dataflow` dependencies.

### Purpose

- **Performance Tracking**: Monitor performance across different implementations
- **Regression Detection**: Identify performance degradations early
- **Implementation Comparison**: Compare DFIR vs timely/differential approaches
- **Optimization Validation**: Verify that optimizations provide expected benefits

## Prerequisites

### Required Setup

1. **Repository Structure**: The main Hydro repository must be cloned alongside this repository:
   ```
   /projects/sandbox/
   ├── bigweaver-agent-canary-hydro-zeta/      # Main repository
   └── bigweaver-agent-canary-zeta-hydro-deps/ # This repository
   ```

2. **Rust Toolchain**: The repository uses Rust 1.91.1 (specified in `rust-toolchain.toml`)
   - Components: rustfmt, clippy, rust-src
   - Targets: wasm32-unknown-unknown, x86_64-unknown-linux-musl

3. **Dependencies**: All required dependencies are managed via Cargo
   - `criterion` for benchmarking framework
   - `timely` and `differential-dataflow` for comparison benchmarks
   - `dfir_rs` and `sinktools` from the main repository

### Verification

Run the verification script to ensure your setup is correct:
```bash
./verify_setup.sh
```

## Quick Start

### Running All Benchmarks

```bash
# Using the helper script (recommended)
./run_benchmarks.sh

# Using Cargo directly
cargo bench -p benches
```

### Running a Specific Benchmark

```bash
# Using the helper script
./run_benchmarks.sh reachability

# Using Cargo
cargo bench -p benches --bench reachability
```

### Viewing Results

After running benchmarks, open the HTML report:
```bash
# Results are in target/criterion/
open target/criterion/report/index.html
```

## Available Benchmarks

### Micro Operations (`micro_ops.rs`)

Tests fundamental operations and patterns.

**Purpose**: Identify performance characteristics of basic building blocks

**Scenarios**:
- Basic data transformations
- Filter operations
- Map operations

**When to run**: After changes to core operators

### Graph Operations

#### Reachability (`reachability.rs`)

Graph reachability computation using iterative algorithms.

**Purpose**: Compare iterative dataflow performance

**Implementations tested**:
- `reachability/timely` - Pure timely-dataflow
- `reachability/differential` - Differential-dataflow with iteration
- `reachability/dfir_rs/scheduled` - DFIR scheduled runtime
- `reachability/dfir_rs` - DFIR standard runtime
- `reachability/dfir_rs/surface` - DFIR surface syntax
- `reachability/dfir_rs/surface_cheating` - Optimized surface syntax

**Input data**:
- `reachability_edges.txt` - Graph edges (524KB)
- `reachability_reachable.txt` - Expected reachable nodes (40KB)

**When to run**: After changes to iteration or join operators

#### Join Operations (`join.rs`, `symmetric_hash_join.rs`)

Join operation benchmarks.

**Purpose**: Compare join implementation strategies

**Scenarios**:
- Standard join operations
- Symmetric hash joins
- Multi-way joins

**When to run**: After changes to join operators or hash implementations

### Data Flow Patterns

#### Fan In (`fan_in.rs`)

Multiple sources merging into a single stream.

**Purpose**: Test union/merge performance

**When to run**: After changes to union operators

#### Fan Out (`fan_out.rs`)

Single source splitting into multiple streams.

**Purpose**: Test tee/broadcast performance

**When to run**: After changes to tee or broadcast operators

#### Fork-Join (`fork_join.rs`)

Fork-join parallelism pattern.

**Purpose**: Test parallel execution and synchronization

**When to run**: After changes to parallel execution or scheduling

#### Identity (`identity.rs`)

Pass-through operations with minimal processing.

**Purpose**: Measure baseline overhead

**When to run**: To establish performance baseline

### Real-World Scenarios

#### Word Processing (`words_diamond.rs`, `upcase.rs`)

String processing benchmarks.

**Purpose**: Test real-world data processing scenarios

**Input data**:
- `words_alpha.txt` - English words dictionary (3.7MB)

**Scenarios**:
- Diamond pattern processing
- Case transformations
- String operations

**When to run**: After changes to string handling or data operators

### Async Operations (`futures.rs`)

Futures-based asynchronous operations.

**Purpose**: Test async/await integration

**When to run**: After changes to async runtime or integration

### Arithmetic Operations (`arithmetic.rs`)

Mathematical computations in dataflows.

**Purpose**: Test numeric operation performance

**When to run**: After changes to arithmetic operators

## Running Benchmarks

### Basic Usage

```bash
# Run all benchmarks
./run_benchmarks.sh

# Run specific benchmark
./run_benchmarks.sh reachability

# List available benchmarks
./run_benchmarks.sh --list

# Get help
./run_benchmarks.sh --help
```

### Cargo Options

```bash
# Run with custom sample size (faster for testing)
cargo bench -p benches --bench reachability -- --sample-size 10

# Run specific test within a benchmark
cargo bench -p benches --bench reachability -- "reachability/timely"

# Verbose output
cargo bench -p benches --bench reachability -- --verbose

# Generate only specific measurements
cargo bench -p benches --bench reachability -- --measurement-time 5
```

### Cargo Profiles

The repository uses optimized build profiles:

**Release Profile** (default for benchmarks):
```toml
[profile.release]
strip = true
opt-level = 3
lto = "fat"
codegen-units = 1
```

**Profile Profile** (for profiling with debug symbols):
```toml
[profile.profile]
inherits = "release"
debug = 2
lto = "off"
strip = "none"
```

To use the profile mode:
```bash
cargo bench -p benches --profile profile
```

## Understanding Results

### Console Output

Criterion provides console output with:
- **Time**: Estimated execution time
- **Change**: Percentage change from previous run
- **Confidence**: Statistical confidence in the measurement
- **Outliers**: Number of outlier measurements

Example:
```
reachability/timely     time:   [12.345 ms 12.456 ms 12.567 ms]
                        change: [-2.3456% -1.2345% -0.1234%] (p = 0.03 < 0.05)
                        Performance has improved.
```

### HTML Reports

Open `target/criterion/report/index.html` to view:
- Detailed timing charts
- Distribution plots
- Comparison with previous runs
- Regression analysis

### Interpreting Changes

- **Green/Improvement**: Performance got faster
- **Red/Regression**: Performance got slower
- **Gray/No change**: No significant performance difference
- **P-value < 0.05**: Statistically significant change

## Performance Comparison

### Comparing Implementations

Each benchmark typically tests multiple implementations:

1. **Timely-dataflow**: Pure timely implementation
2. **Differential-dataflow**: Differential with incremental computation
3. **DFIR variants**: Different DFIR execution strategies

Example from reachability benchmark:
- `reachability/timely` - Baseline timely implementation
- `reachability/differential` - Differential approach
- `reachability/dfir_rs` - DFIR standard
- `reachability/dfir_rs/scheduled` - DFIR scheduled
- `reachability/dfir_rs/surface` - DFIR surface syntax

### Tracking Performance Over Time

#### Save Baseline

```bash
# Save current performance as baseline
cargo bench -p benches --bench reachability -- --save-baseline main
```

#### Compare Against Baseline

```bash
# Compare current performance with baseline
cargo bench -p benches --bench reachability -- --baseline main
```

#### Workflow Example

```bash
# 1. On main branch, save baseline
git checkout main
cargo bench -p benches -- --save-baseline main

# 2. Switch to feature branch
git checkout feature/optimization

# 3. Run benchmarks and compare
cargo bench -p benches -- --baseline main

# 4. Review changes in HTML report
open target/criterion/report/index.html
```

### Cross-Implementation Comparison

Use the HTML reports to compare:
1. Navigate to `target/criterion/report/index.html`
2. Select benchmark group (e.g., "reachability")
3. View comparison charts showing all implementations
4. Identify which implementation performs best for your use case

## Troubleshooting

### Common Issues

#### Issue: Main Repository Not Found

**Error**:
```
error: failed to load manifest for dependency `dfir_rs`
```

**Solution**:
Ensure the main repository is cloned alongside this repository:
```bash
cd /projects/sandbox
git clone <url> bigweaver-agent-canary-hydro-zeta
```

#### Issue: Compilation Errors

**Error**: Various compilation errors

**Solution**:
```bash
# Clean build artifacts
cargo clean

# Update dependencies
cargo update

# Check workspace
cargo check --workspace
```

#### Issue: Benchmark Times Out

**Error**: Benchmark takes too long

**Solution**:
```bash
# Reduce sample size for faster testing
cargo bench -p benches --bench reachability -- --sample-size 10 --measurement-time 1
```

#### Issue: Permission Denied on Scripts

**Error**: `Permission denied` when running `.sh` scripts

**Solution**:
```bash
chmod +x run_benchmarks.sh verify_setup.sh
```

### Verification

Run the setup verification script:
```bash
./verify_setup.sh
```

This checks:
- Main repository location
- Workspace structure
- Path dependencies
- Compilation status

## Advanced Usage

### Custom Benchmark Configuration

Edit `benches/Cargo.toml` to add new benchmarks:

```toml
[[bench]]
name = "my_benchmark"
harness = false
```

Then create `benches/benches/my_benchmark.rs`:

```rust
use criterion::{Criterion, criterion_group, criterion_main};

fn my_bench(c: &mut Criterion) {
    c.bench_function("my_operation", |b| {
        b.iter(|| {
            // Your benchmark code
        });
    });
}

criterion_group!(benches, my_bench);
criterion_main!(benches);
```

### Profiling

To profile benchmarks:

```bash
# Build with profile mode
cargo bench -p benches --profile profile --no-run

# Find the benchmark binary
find target/profile -name "reachability*" -type f

# Profile with perf (Linux)
perf record -g target/profile/deps/reachability-<hash> --bench

# Analyze profile
perf report
```

### CI/CD Integration

For automated performance tracking:

```bash
# Quick validation (faster, fewer samples)
cargo bench -p benches -- --sample-size 10

# Full benchmark suite
cargo bench -p benches

# Export results for storage
cp -r target/criterion results-$(date +%Y%m%d)
```

### Comparing Branches

```bash
# Script to compare two branches
#!/bin/bash
git checkout main
cargo bench -p benches -- --save-baseline main

git checkout feature-branch
cargo bench -p benches -- --baseline main

# Results show comparison automatically
```

## Best Practices

1. **Consistent Environment**: Run benchmarks on the same machine with minimal background processes
2. **Multiple Runs**: Criterion automatically handles this, but be aware of statistical significance
3. **Warm-up**: Criterion includes warm-up iterations
4. **Sample Size**: Default (100) is good for accuracy; reduce (10-20) for quick tests
5. **Save Baselines**: Always save a baseline before making changes
6. **Document Changes**: If performance changes significantly, document why in commit messages

## Additional Resources

- [Criterion.rs Book](https://bheisler.github.io/criterion.rs/book/)
- [Timely Dataflow Documentation](https://timelydataflow.github.io/timely-dataflow/)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)
- [Main Repository](../bigweaver-agent-canary-hydro-zeta/)
- [CONTRIBUTING.md](CONTRIBUTING.md) - Contributing guidelines
- [QUICK_REFERENCE.md](QUICK_REFERENCE.md) - Quick command reference
