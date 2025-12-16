# Timely Dataflow and Differential Dataflow Benchmarks

This directory contains performance benchmarks comparing Hydro (DFIR) with Timely Dataflow and Differential Dataflow implementations.

## Overview

These benchmarks were moved from the main `bigweaver-agent-canary-hydro-zeta` repository to isolate dependencies on `timely` and `differential-dataflow` packages. This separation allows the main repository to remain lightweight while still maintaining the ability to run performance comparisons.

**Each benchmark includes multiple implementations** for direct performance comparison within a single test run.

## Available Benchmarks

### Benchmark Details

#### arithmetic
- **Description**: Tests a pipeline of 20 arithmetic operations (`+1`) on 1 million integers
- **Implementations**: 
  - `timely`: Timely Dataflow implementation
  - `dfir_rs/compiled`: Hydro compiled sink builder
  - `dfir_rs/compiled_no_cheating`: Hydro with explicit black_box calls
  - `dfir_rs/surface`: Hydro surface syntax
  - `pipeline`: Multi-threaded channel-based pipeline (baseline)
  - `iter`: Iterator chains (baseline)
  - `iter-collect`: Iterator with collection steps (baseline)
  - `raw`: Raw vector copying (theoretical minimum overhead)
- **Use case**: Tests operator fusion, pipeline efficiency, and baseline overhead

#### fan_in
- **Description**: Multiple input streams concatenate into a single output stream
- **Implementations**: Timely, Hydro
- **Use case**: Tests stream merging and multiplexing performance

#### fan_out
- **Description**: Single input stream splits to multiple output streams
- **Implementations**: Timely, Hydro
- **Use case**: Tests stream branching and demultiplexing performance

#### fork_join
- **Description**: Fork-join pattern with filtering (even/odd split and recombine)
- **Implementations**: Timely, Hydro
- **Use case**: Tests complex dataflow patterns with conditional routing

#### identity
- **Description**: No-op identity transformations to measure framework overhead
- **Implementations**: Timely, Hydro (multiple variants), baselines
- **Use case**: Measures minimum framework overhead without computation

#### join
- **Description**: Join operations between two streams
- **Implementations**: Timely, Hydro
- **Use case**: Tests join algorithm efficiency and state management

#### reachability
- **Description**: Graph reachability computation using iterative dataflow
- **Implementations**: 
  - `timely`: Timely Dataflow with loops
  - `differential`: Differential Dataflow with iteration operator
  - `dfir_rs`: Multiple Hydro variants
- **Data**: Uses `reachability_edges.txt` (graph edges) and `reachability_reachable.txt` (expected results)
- **Use case**: Tests iterative computations, state management, and convergence detection

#### upcase
- **Description**: String uppercase transformations
- **Implementations**: 
  - Timely with different strategies (in-place, allocating, concatenating)
  - Hydro variants
- **Use case**: Tests string processing and memory allocation patterns

## Running Benchmarks

### Quick Start

Run all benchmarks and compare all implementations:

```bash
cargo bench
```

Run a specific benchmark:

```bash
cargo bench --bench arithmetic
cargo bench --bench fan_in
cargo bench --bench reachability
```

### Running Specific Implementations

To run only certain implementations within a benchmark, use filtering:

```bash
# Run only Timely implementations
cargo bench --bench arithmetic timely

# Run only Hydro/DFIR implementations
cargo bench --bench arithmetic dfir_rs

# Run only Differential Dataflow (reachability benchmark)
cargo bench --bench reachability differential
```

### Performance Comparison Commands

#### Compare Hydro vs Timely

```bash
# Run arithmetic benchmark and compare Hydro and Timely
cargo bench --bench arithmetic -- timely dfir_rs

# Run reachability and compare all implementations
cargo bench --bench reachability
```

#### Compare Hydro vs Differential Dataflow

```bash
# Reachability is the primary benchmark with Differential Dataflow
cargo bench --bench reachability
```

#### Baseline Comparisons

```bash
# Compare against raw/baseline implementations
cargo bench --bench arithmetic -- raw iter pipeline
cargo bench --bench identity
```

### Advanced Usage

#### Save Baseline for Comparisons

```bash
# Save current results as baseline
cargo bench -- --save-baseline master

# Compare against baseline
cargo bench -- --baseline master
```

#### Generate Detailed Reports

```bash
# Run with more samples for higher accuracy
cargo bench --bench arithmetic -- --sample-size 1000

# Run specific number of iterations
cargo bench --bench arithmetic -- --measurement-time 60
```

## Benchmark Results

Benchmark results are generated in the `target/criterion` directory and include:

- **HTML Reports**: Interactive visualizations at `target/criterion/report/index.html`
- **Statistical Analysis**: Mean, median, standard deviation, outliers
- **Performance Plots**: Violin plots, probability density functions, iteration time distributions
- **Historical Comparisons**: Trends over time (after multiple runs)
- **Regression Detection**: Automatic detection of performance regressions

### Viewing Results

```bash
# View main report (all benchmarks)
open target/criterion/report/index.html  # macOS
xdg-open target/criterion/report/index.html  # Linux

# View specific benchmark results
open target/criterion/arithmetic/report/index.html
open target/criterion/reachability/report/index.html
```

### Interpreting Results

When comparing implementations, focus on:

1. **Relative Performance**: How do Timely, Differential, and Hydro compare to each other?
2. **Overhead**: How do framework implementations compare to raw baselines?
3. **Consistency**: Are results stable across multiple runs? (Check standard deviation)
4. **Scaling**: How do different implementations handle varying data sizes?

**Example Output**:
```
arithmetic/timely        time:   [45.2 ms 45.8 ms 46.5 ms]
arithmetic/dfir_rs/compiled  time:   [42.1 ms 42.6 ms 43.2 ms]
arithmetic/raw          time:   [38.5 ms 38.9 ms 39.4 ms]
```

This shows Hydro (dfir_rs) is ~7% faster than Timely, while raw implementation is ~9% faster than Hydro.

## Dependencies

These benchmarks depend on:
- `timely-master` (v0.13.0-dev.1): Timely Dataflow framework
- `differential-dataflow-master` (v0.13.0-dev.1): Differential Dataflow framework  
- `dfir_rs`: Hydro's DFIR runtime (from https://github.com/hydro-project/hydro.git)
- `criterion`: Benchmarking framework with statistical analysis
- Supporting libraries: futures, tokio, rand, sinktools

**Note**: All dependencies are fetched automatically by Cargo, including git dependencies. No manual setup required.

## Performance Comparison Guide

### Comparing Hydro vs Timely Dataflow

All benchmarks except `reachability` primarily compare Hydro and Timely:

```bash
# Direct comparison in each benchmark
cargo bench --bench arithmetic    # Compares operator pipelines
cargo bench --bench join          # Compares join algorithms
cargo bench --bench fork_join     # Compares pattern composition
```

**Key insights**:
- **arithmetic**: Tests operator fusion and pipeline efficiency
- **join**: Tests state management and join strategies
- **identity**: Measures minimum framework overhead
- **fan_in/fan_out**: Tests stream multiplexing efficiency

### Comparing Hydro vs Differential Dataflow

The **reachability** benchmark is the primary comparison with Differential Dataflow:

```bash
cargo bench --bench reachability
```

This benchmark tests:
- Iterative dataflow computations
- Incremental computation (Differential's strength)
- State management across iterations
- Convergence detection

**Understanding Differential Dataflow results**:
- Differential excels at incremental updates (not tested here)
- These benchmarks test batch processing (initial computation)
- Hydro and Timely may be faster for batch workloads
- Differential would excel if we tested incremental updates

### Three-Way Comparison Summary

| Framework | Strengths Tested | Benchmarks |
|-----------|------------------|------------|
| **Timely Dataflow** | Low-level dataflow primitives, explicit control | All benchmarks |
| **Differential Dataflow** | Incremental computation, iterative algorithms | reachability |
| **Hydro (DFIR)** | High-level abstractions, ergonomics, compilation | All benchmarks |

### Cross-Repository Performance Comparison

To compare with Hydro-only benchmarks from the main repository:

1. **Run benchmarks in this repository** (with Timely/Differential comparisons):
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps
   cargo bench --bench <benchmark_name>
   ```

2. **Navigate to the main repository** and run equivalent benchmarks:
   ```bash
   cd ../bigweaver-agent-canary-hydro-zeta
   cargo bench
   ```

3. **Compare the results** from both `target/criterion` directories

**Note**: The main repository contains different benchmarks (futures, micro_ops, symmetric_hash_join, words_diamond) that focus on Hydro-specific features without Timely/Differential dependencies.

## Standalone Execution

**This benchmark suite is fully standalone** and does not require the main `bigweaver-agent-canary-hydro-zeta` repository to be present:

- ✅ All dependencies are fetched automatically (including Hydro components from GitHub)
- ✅ Complete workspace configuration in this repository
- ✅ Can be cloned and run independently
- ✅ No path dependencies on other repositories

```bash
# Clone and run (no other repositories needed)
git clone <this-repository-url>
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench
```

## Adding New Benchmarks

To add a new benchmark that uses Timely or Differential Dataflow:

1. Create a new `.rs` file in `benches/benches/`
2. Add the benchmark configuration to `Cargo.toml`:
   ```toml
   [[bench]]
   name = "your_benchmark_name"
   harness = false
   ```
3. Implement the benchmark using the Criterion framework

## Notes

- **Dependency Isolation**: These benchmarks are kept separate to avoid introducing Timely and Differential Dataflow dependencies into the main repository
- **Main Repository Benchmarks**: The main repository contains non-Timely benchmarks (futures, micro_ops, symmetric_hash_join, words_diamond)
- **Clean Separation**: This separation maintains a clean dependency tree while preserving performance comparison capabilities
- **Git Dependencies**: Hydro components (dfir_rs, sinktools) are fetched directly from GitHub, ensuring this repository stays synchronized with the latest Hydro developments
- **Criterion Framework**: All benchmarks use Criterion for consistent, statistically rigorous performance measurement

## Troubleshooting

### Slow Initial Build

First-time builds may take 10-20 minutes due to:
- Compiling Timely Dataflow
- Compiling Differential Dataflow
- Fetching and compiling git dependencies

This is normal. Subsequent builds will be much faster.

### Inconsistent Results

If benchmark results vary significantly between runs:

1. Close other applications to reduce system noise
2. Run benchmarks multiple times: `cargo bench` (Criterion will detect instability)
3. Increase sample size: `cargo bench -- --sample-size 1000`
4. Check for thermal throttling on laptops
5. Run with higher priority: `nice -n -20 cargo bench` (Linux)

### Missing Results

If you don't see comparative results:

- Ensure you've run `cargo bench` at least twice (for historical comparison)
- Check `target/criterion/` directory exists and contains results
- Review terminal output for any errors during benchmark execution
