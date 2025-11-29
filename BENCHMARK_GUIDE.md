# Benchmark Guide

This guide provides detailed instructions for running, analyzing, and maintaining the benchmarks in this repository.

## Table of Contents

1. [Setup](#setup)
2. [Running Benchmarks](#running-benchmarks)
3. [Analyzing Results](#analyzing-results)
4. [Comparing Performance](#comparing-performance)
5. [Benchmark Details](#benchmark-details)
6. [Troubleshooting](#troubleshooting)

## Setup

### Prerequisites

Ensure you have the following installed:
- Rust 1.70 or later
- Git

### Repository Structure

The benchmarks depend on the main `bigweaver-agent-canary-hydro-zeta` repository. Both repositories should be checked out as siblings:

```
/projects/sandbox/
├── bigweaver-agent-canary-hydro-zeta/   # Main repository
└── bigweaver-agent-canary-zeta-hydro-deps/  # This repository
```

If you have a different directory structure, update the paths in `benches/Cargo.toml`:

```toml
[dev-dependencies]
dfir_rs = { path = "../../bigweaver-agent-canary-hydro-zeta/dfir_rs", features = [ "debugging" ] }
sinktools = { path = "../../bigweaver-agent-canary-hydro-zeta/sinktools", version = "^0.0.1" }
```

### Initial Build

Build the workspace to ensure all dependencies are available:

```bash
cargo build --workspace
```

## Running Benchmarks

### Run All Benchmarks

To run all benchmarks and generate a complete performance report:

```bash
cargo bench -p benches
```

This will:
- Compile all benchmarks in release mode
- Execute each benchmark multiple times
- Generate statistical analysis
- Save results to `target/criterion/`
- Generate HTML reports

### Run Specific Benchmarks

Run individual benchmarks by name:

```bash
# Reachability benchmark
cargo bench -p benches --bench reachability

# Arithmetic operations
cargo bench -p benches --bench arithmetic

# Join operations
cargo bench -p benches --bench join

# Multiple specific benchmarks
cargo bench -p benches --bench reachability --bench join
```

### Run with Filters

Use filters to run specific test cases within a benchmark:

```bash
# Run only tests matching "dfir" in reachability benchmark
cargo bench -p benches --bench reachability dfir

# Run only tests matching "timely"
cargo bench -p benches --bench reachability timely
```

### Baseline Comparisons

Create a baseline for future comparisons:

```bash
# Save current results as baseline
cargo bench -p benches -- --save-baseline my-baseline

# Compare against a baseline
cargo bench -p benches -- --baseline my-baseline
```

## Analyzing Results

### Viewing HTML Reports

After running benchmarks, view detailed HTML reports:

```bash
# Open the Criterion report index
open target/criterion/report/index.html

# Or navigate to specific benchmark reports
open target/criterion/reachability/report/index.html
```

The HTML reports include:
- Execution time distributions
- Confidence intervals
- Comparison with previous runs
- Detailed statistics

### Command-Line Output

The command-line output provides a quick summary:

```
reachability/dfir       time:   [1.2345 ms 1.2456 ms 1.2567 ms]
                        change: [-2.34% -1.23% +0.12%] (p = 0.23 > 0.05)
                        No change in performance detected.
```

Key metrics:
- **time**: Mean execution time with confidence interval [lower, mean, upper]
- **change**: Percentage change compared to previous run
- **p-value**: Statistical significance (p < 0.05 indicates significant change)

### CSV Export

Export results to CSV for further analysis:

```bash
# Results are automatically saved in target/criterion/<benchmark>/base/raw.csv
# Process them with standard tools:
cat target/criterion/reachability/base/raw.csv | column -t -s,
```

## Comparing Performance

### Between Implementations

Compare Hydro (dfir_rs) vs timely/differential implementations:

1. **Identify comparison points**: Most benchmarks include both implementations
2. **Run benchmarks**: `cargo bench -p benches`
3. **Compare results**: Look for test names like:
   - `reachability/dfir` - Hydro implementation
   - `reachability/timely` - Timely implementation
   - `reachability/differential` - Differential implementation

### Over Time

Track performance changes across commits:

```bash
# Baseline from current commit
git checkout main
cargo bench -p benches -- --save-baseline main

# Test changes in feature branch
git checkout feature-branch
cargo bench -p benches -- --baseline main
```

### Between Repositories

To compare with benchmarks that might exist in other repositories:

1. **Export results**: Copy `target/criterion/` directory
2. **Run equivalent benchmarks** in other repository
3. **Compare metrics manually** or use analysis tools
4. **Document findings** in performance tracking documentation

## Benchmark Details

### arithmetic.rs
**Purpose**: Tests arithmetic operations and computational patterns

**Implementations**:
- Hydro (dfir_rs) implementation
- Baseline Rust implementation

**Metrics**: Operations per second, latency

**Data**: Generates random arithmetic operations

---

### fan_in.rs
**Purpose**: Tests fan-in patterns where multiple inputs converge

**Key scenarios**:
- Multiple input streams merging
- Data aggregation patterns
- Union operations

**Metrics**: Throughput, latency under varying input counts

---

### fan_out.rs
**Purpose**: Tests fan-out patterns distributing data to multiple outputs

**Key scenarios**:
- Broadcasting to multiple consumers
- Data partitioning
- Parallel processing

**Metrics**: Distribution efficiency, overall throughput

---

### fork_join.rs
**Purpose**: Tests fork-join parallel processing patterns

**Generated**: This benchmark is partially code-generated by `build.rs`

**Key scenarios**:
- Splitting computation across branches
- Rejoining results
- Filter operations on even/odd numbers

**Metrics**: Parallel efficiency, join overhead

---

### futures.rs
**Purpose**: Tests async/futures-based operations

**Key scenarios**:
- Async stream processing
- Future composition
- Tokio runtime integration

**Metrics**: Async overhead, concurrency performance

---

### identity.rs
**Purpose**: Baseline performance measurement

**Key scenarios**:
- Pass-through operations
- Minimal overhead measurement
- System baseline

**Use case**: Reference point for other benchmarks

---

### join.rs
**Purpose**: Tests join operations between streams

**Implementations**:
- Hash join
- Nested loop join
- Various join strategies

**Metrics**: Join throughput, memory usage

---

### micro_ops.rs
**Purpose**: Tests low-level primitive operations

**Coverage**:
- Map operations
- Filter operations
- Basic transformations

**Metrics**: Per-operation overhead, raw throughput

---

### reachability.rs
**Purpose**: Graph reachability algorithms

**Data**:
- `reachability_edges.txt`: Graph edge data
- `reachability_reachable.txt`: Expected reachable nodes

**Implementations**:
- Hydro iterative implementation
- Timely dataflow implementation
- Differential dataflow implementation

**Metrics**: Iteration count, convergence time, graph traversal efficiency

---

### symmetric_hash_join.rs
**Purpose**: Tests symmetric hash join algorithm

**Key scenarios**:
- Two-way equi-joins
- Hash table construction
- Probe and match operations

**Metrics**: Join latency, hash table overhead

---

### upcase.rs
**Purpose**: String transformation operations

**Data**: Uses word list from `words_alpha.txt`

**Key scenarios**:
- String mapping
- Bulk transformations
- Memory allocation patterns

**Metrics**: Transformation throughput, memory efficiency

---

### words_diamond.rs
**Purpose**: Diamond-pattern dataflow operations

**Data**: Uses word list from `words_alpha.txt`

**Key scenarios**:
- Split-transform-merge patterns
- Complex dataflow graphs
- Multiple transformation paths

**Metrics**: Diamond pattern efficiency, coordination overhead

## Troubleshooting

### Build Failures

**Issue**: Cannot find `dfir_rs` or `sinktools`

**Solution**: Verify the main repository is checked out as a sibling directory and paths in `benches/Cargo.toml` are correct.

```bash
# Check directory structure
ls -la /projects/sandbox/
# Should show both repositories

# Verify paths in Cargo.toml
cat benches/Cargo.toml | grep "path ="
```

---

**Issue**: Compilation errors with timely/differential-dataflow

**Solution**: The versions might be outdated. Update dependencies:

```bash
cargo update -p timely-master
cargo update -p differential-dataflow-master
```

---

### Runtime Failures

**Issue**: Benchmark panics or fails during execution

**Solution**: Run with more verbose output:

```bash
RUST_BACKTRACE=1 cargo bench -p benches --bench <name>
```

Check for:
- Data file availability (reachability_edges.txt, words_alpha.txt)
- Memory constraints
- System resource limits

---

### Performance Issues

**Issue**: Benchmarks taking too long

**Solution**: Run with fewer iterations:

```bash
# Quick mode - fewer samples
cargo bench -p benches -- --quick

# Or run specific fast benchmarks only
cargo bench -p benches --bench identity --bench arithmetic
```

---

**Issue**: Inconsistent results

**Solution**: Ensure system stability:

1. Close resource-intensive applications
2. Disable power management features
3. Run multiple times and average results
4. Use baseline comparisons for relative measurements

---

### Missing Files

**Issue**: Cannot find `reachability_edges.txt` or `words_alpha.txt`

**Solution**: These files should be in `benches/benches/`. If missing:

```bash
# Verify files exist
ls -la benches/benches/*.txt

# If missing, they may need to be restored from git history
# or regenerated from their original sources
```

For `words_alpha.txt`: Download from https://github.com/dwyl/english-words/blob/master/words_alpha.txt

## Best Practices

### When Running Benchmarks

1. **Consistent environment**: Run on the same machine with same conditions
2. **Multiple runs**: Run benchmarks multiple times to account for variance
3. **Baselines**: Always compare against a baseline, not absolute numbers
4. **Documentation**: Document system specs and conditions when sharing results

### When Analyzing Results

1. **Focus on trends**: Look for relative changes, not absolute times
2. **Statistical significance**: Check p-values before drawing conclusions
3. **Context matters**: Consider what changed between runs (code, data, environment)
4. **Multiple metrics**: Don't rely on a single benchmark

### When Reporting Results

1. **Include system info**: CPU, RAM, OS, Rust version
2. **Specify configuration**: Release mode, optimization level, features
3. **Show variance**: Report confidence intervals, not just means
4. **Reproducibility**: Provide exact commands and data used

## Additional Resources

- [Criterion.rs Documentation](https://bheisler.github.io/criterion.rs/book/)
- [Timely Dataflow Book](https://timelydataflow.github.io/timely-dataflow/)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)
- Main Repository: bigweaver-agent-canary-hydro-zeta

## Contributing

When adding new benchmarks:

1. Follow existing patterns and structure
2. Include both Hydro and reference implementations when possible
3. Document benchmark purpose, data, and expected results
4. Add entry to `benches/Cargo.toml`
5. Update this guide with benchmark details
6. Test benchmark runs successfully before committing

---

Last updated: 2025-11-29
