# bigweaver-agent-canary-zeta-hydro-deps

## Overview

This repository contains benchmarks and dependencies for **timely-dataflow** and **differential-dataflow** that have been separated from the main `bigweaver-agent-canary-hydro-zeta` repository. This separation allows for performance comparisons between different dataflow frameworks without adding these dependencies to the main codebase.

### Why This Repository Exists

The benchmarks in this repository compare the performance of different dataflow computation frameworks:
- **Timely Dataflow**: A low-latency cyclic dataflow computational model
- **Differential Dataflow**: An incremental computation framework built on Timely
- **Hydroflow**: The dataflow framework used in the main repository
- **Babyflow**: A simpler dataflow implementation for comparison
- **Spinachflow**: Another dataflow framework variant
- **Pipeline**: A basic multi-threaded pipeline implementation for baseline comparison

By keeping these benchmarks separate, the main repository remains lightweight while still enabling comprehensive performance analysis.

## Repository Structure

```
.
├── Cargo.toml                           # Workspace configuration
├── README.md                            # This file
├── MIGRATION.md                         # Detailed migration documentation
├── scripts/
│   └── compare_benchmarks.sh           # Cross-repository benchmark comparison script
└── timely-differential-benches/
    ├── Cargo.toml                       # Benchmark package configuration
    ├── README.md                        # Detailed benchmark documentation
    └── benches/                         # Benchmark implementations
        ├── arithmetic.rs                # Arithmetic operations test
        ├── fan_in.rs                    # Stream aggregation test
        ├── fan_out.rs                   # Stream distribution test
        ├── fork_join.rs                 # Fork-join pattern test
        ├── identity.rs                  # Pass-through overhead test
        ├── join.rs                      # Stream join operations test
        ├── reachability.rs              # Graph reachability test
        ├── reachability_edges.txt       # Test data (532 KB graph)
        ├── reachability_reachable.txt   # Expected results (38 KB)
        ├── upcase.rs                    # String transformation test
        └── zip.rs                       # Stream zipping test
```

## Benchmark Details

This repository contains 9 comprehensive benchmarks that compare multiple dataflow frameworks:

### 1. **arithmetic** - Arithmetic Operations Performance
Tests chained arithmetic operations (+1 repeated 20 times) on 1M integers. Measures optimization effectiveness and basic operator overhead.

### 2. **identity** - Minimum Framework Overhead  
Passes 1M integers through 20 identity operators with no transformation. This is the baseline benchmark showing pure framework overhead without computation.

### 3. **fan_in** - Stream Aggregation
Tests merging multiple input streams into a single output. Critical for scatter-gather patterns and multi-source data processing.

### 4. **fan_out** - Stream Distribution
Tests broadcasting a single stream to multiple consumers. Important for parallel processing and replication patterns.

### 5. **fork_join** - Parallel Fork-Join Patterns
Tests splitting work into parallel branches, processing independently, and rejoining. Tests multiple join strategies.

### 6. **join** - Stream Join Operations
Tests database-style joins of two streams on key values. Includes tests with different data types (integers and strings) processing 100K elements per stream.

### 7. **reachability** - Graph Reachability (Cyclic Dataflow)
Computes which nodes in a graph are reachable from a starting node. Uses real graph data (532 KB) and tests iterative algorithms with feedback loops. Verifies correctness against known results.

### 8. **upcase** - String Transformations
Tests string manipulation operations, showing performance with heap-allocated data and string handling overhead.

### 9. **zip** - Stream Synchronization
Tests pairing elements from two streams. Shows buffering behavior and synchronization overhead for correlated stream processing.

### Frameworks Compared

Each benchmark typically tests multiple implementations:
- **Timely Dataflow**: Low-latency cyclic dataflow (excellent for iterative algorithms)
- **Differential Dataflow**: Incremental computation built on Timely
- **Hydroflow**: Stream processing framework (main repository's implementation)
- **Hydroflow+**: Enhanced Hydroflow with additional optimizations
- **Babyflow**: Simplified reference implementation
- **Spinachflow**: Alternative dataflow variant
- **Pipeline**: Multi-threaded baseline for comparison

## Dependencies

This repository includes the following external dependencies:

- **timely-dataflow** (`timely`): A low-latency data-parallel dataflow system
- **differential-dataflow**: Incremental computation based on timely-dataflow
- **criterion**: Benchmarking framework
- Other supporting dependencies (lazy_static, rand, seq-macro, tokio)

## Running Benchmarks

### Prerequisites

Before running benchmarks, ensure you have:
- **Rust toolchain** (1.70 or later recommended)
- **Cargo** (comes with Rust)
- Sufficient memory (at least 4GB available)
- Time for compilation (initial build may take 5-10 minutes)

### Quick Start

#### Run All Benchmarks

```bash
# From repository root
cargo bench
```

This will:
1. Compile all benchmark code
2. Run each benchmark multiple times for statistical significance
3. Generate reports in `target/criterion/`
4. Display results in the terminal

#### Run Specific Benchmark

```bash
cargo bench -p timely-differential-benches --bench <benchmark_name>
```

**Available benchmarks:**
- `arithmetic` - Arithmetic operations performance
- `fan_in` - Data aggregation patterns
- `fan_out` - Data distribution patterns
- `fork_join` - Parallel fork-join operations
- `identity` - Pass-through overhead measurement
- `join` - Stream join operations
- `reachability` - Graph reachability computation
- `upcase` - String transformation
- `zip` - Stream zipping operations

#### Run Benchmarks for Specific Framework

Each benchmark typically tests multiple frameworks. To filter by framework name:

```bash
# Run only timely benchmarks
cargo bench -p timely-differential-benches -- timely

# Run only hydroflow benchmarks
cargo bench -p timely-differential-benches -- hydroflow

# Run only babyflow benchmarks
cargo bench -p timely-differential-benches -- babyflow
```

### Understanding Benchmark Results

After running benchmarks, results are available in multiple formats:

1. **Terminal Output**: Summary statistics with mean execution time and standard deviation
2. **HTML Reports**: Located at `target/criterion/report/index.html` - open in a browser for detailed visualizations
3. **Historical Data**: Criterion automatically tracks performance over time

**Example output:**
```
identity/babyflow       time:   [45.234 ms 45.678 ms 46.123 ms]
                        change: [-2.5% -1.2% +0.3%] (p = 0.15 > 0.05)
```

This shows:
- Mean time: 45.678 ms
- Confidence interval: 45.234 ms to 46.123 ms
- Change from previous run: -1.2% (faster)
- Statistical significance: p-value indicates if change is meaningful

### Cross-Repository Comparison

To compare performance between this repository and the main `bigweaver-agent-canary-hydro-zeta` repository:

```bash
./scripts/compare_benchmarks.sh
```

#### What This Script Does

The comparison script:
1. **Runs timely/differential-dataflow benchmarks** in this repository
2. **Runs benchmarks in the main repository** (if available)
3. **Generates side-by-side comparison reports**
4. **Saves results** to `target/criterion/` in each repository

#### Setting Up Cross-Repository Comparison

The script expects the main repository to be at `../bigweaver-agent-canary-hydro-zeta` relative to this repository. If it's located elsewhere, set the `MAIN_REPO_DIR` environment variable:

```bash
# Custom main repository location
export MAIN_REPO_DIR=/path/to/bigweaver-agent-canary-hydro-zeta
./scripts/compare_benchmarks.sh
```

#### Manual Cross-Repository Comparison

If you prefer to run benchmarks separately:

```bash
# Step 1: Run benchmarks in deps repository
cd /path/to/bigweaver-agent-canary-zeta-hydro-deps
cargo bench -p timely-differential-benches

# Step 2: Run benchmarks in main repository
cd /path/to/bigweaver-agent-canary-hydro-zeta
cargo bench -p benches  # If benchmark package exists

# Step 3: Compare HTML reports
# Open target/criterion/report/index.html in each repository
```

#### Interpreting Comparison Results

When comparing frameworks, consider:

1. **Throughput**: How many items/second can be processed?
2. **Latency**: How long does each operation take?
3. **Scalability**: How does performance change with data size?
4. **Overhead**: What's the minimum cost for simple operations (see `identity` benchmark)?

**Typical performance characteristics:**
- **Pipeline approach**: Good baseline, high overhead for small operations
- **Timely/Differential**: Excellent for complex dataflow graphs with cycles
- **Hydroflow**: Optimized for stream processing with low latency
- **Babyflow**: Simpler model with different trade-offs

## Migration Notes

These benchmarks were migrated from the main `bigweaver-agent-canary-hydro-zeta` repository to:

1. **Separate dependencies**: Remove timely and differential-dataflow dependencies from the main codebase
2. **Maintain comparisons**: Allow performance comparisons between different dataflow implementations
3. **Reduce build time**: Avoid compiling these dependencies in the main repository
4. **Focused development**: Keep the main repository focused on its core functionality

### What Was Migrated

**Benchmark files** (9 benchmarks total):
- arithmetic.rs - Chained arithmetic operations
- fan_in.rs - Multiple stream aggregation
- fan_out.rs - Stream distribution to multiple consumers
- fork_join.rs - Parallel fork-join patterns
- identity.rs - Pass-through overhead measurement
- join.rs - Stream join operations
- reachability.rs - Graph reachability with cycles
- upcase.rs - String transformations
- zip.rs - Stream zipping operations

**Data files**:
- reachability_edges.txt - Graph data for reachability tests
- reachability_reachable.txt - Expected results for verification

**Dependencies**:
- timely = "0.12"
- differential-dataflow = "0.12"
- criterion = { version = "0.3", features = ["async_tokio"] }
- Supporting libraries (lazy_static, rand, seq-macro, tokio)

For complete migration details, see `MIGRATION.md`.

## Development

### Building

```bash
cargo build
```

For release builds (optimized):
```bash
cargo build --release
```

### Testing

```bash
cargo test
```

### Benchmarking

```bash
cargo bench
```

Results are saved in `target/criterion/` and can be viewed by opening `target/criterion/report/index.html` in a web browser.

### Adding New Benchmarks

To add a new benchmark to this repository:

1. **Create benchmark file**: Add a new `.rs` file in `timely-differential-benches/benches/`
2. **Implement benchmark**: Follow the pattern from existing benchmarks (see examples below)
3. **Register in Cargo.toml**: Add a `[[bench]]` entry in `timely-differential-benches/Cargo.toml`
4. **Add test data** (if needed): Include any required data files in the benches directory

**Example benchmark structure:**
```rust
use criterion::{criterion_group, criterion_main, Criterion};

fn benchmark_timely(c: &mut Criterion) {
    c.bench_function("my_benchmark/timely", |b| {
        b.iter(|| {
            // Your timely benchmark code
        });
    });
}

fn benchmark_hydroflow(c: &mut Criterion) {
    c.bench_function("my_benchmark/hydroflow", |b| {
        b.iter(|| {
            // Your hydroflow benchmark code
        });
    });
}

criterion_group!(benches, benchmark_timely, benchmark_hydroflow);
criterion_main!(benches);
```

### Troubleshooting

#### Long Compilation Times
- **First build** can take 5-10 minutes due to timely/differential-dataflow compilation
- Use `cargo build --release` first to avoid rebuilding in release mode during benchmarking
- Consider using `cargo build -j 1` if running low on memory

#### Out of Memory During Build
- Reduce parallelism: `cargo build -j 1`
- Increase swap space
- Build with debug symbols disabled: Add to `.cargo/config.toml`:
  ```toml
  [profile.dev]
  debug = 0
  ```

#### Benchmark Results Are Inconsistent
- Close other applications to reduce system noise
- Run benchmarks multiple times and look at trends
- Check for thermal throttling on laptops
- Use `cargo bench -- --sample-size 200` for more samples

#### Main Repository Not Found
- Set `MAIN_REPO_DIR` environment variable before running comparison script
- Ensure the main repository path is correct

## License

See the main repository for license information.

## Quick Reference

### Common Commands

```bash
# Run all benchmarks
cargo bench

# Run specific benchmark
cargo bench --bench identity

# Run only timely implementations
cargo bench -- timely

# Run cross-repository comparison
./scripts/compare_benchmarks.sh

# View results
open target/criterion/report/index.html
```

### Key Files

- **README.md** (this file) - Overview and getting started
- **MIGRATION.md** - Complete migration history and details  
- **timely-differential-benches/README.md** - Detailed benchmark documentation
- **scripts/compare_benchmarks.sh** - Cross-repository comparison tool

### Performance Analysis Checklist

When analyzing benchmark results:

1. ✅ Check `identity` benchmark for baseline overhead
2. ✅ Compare across frameworks for the same workload  
3. ✅ Look at confidence intervals, not just means
4. ✅ Verify statistical significance (p-value < 0.05)
5. ✅ Run multiple times to confirm trends
6. ✅ Consider workload characteristics (simple vs complex)
7. ✅ Review HTML reports for detailed visualizations
8. ✅ Check for system noise (close other applications)

### Getting Help

- **Benchmark details**: See `timely-differential-benches/README.md`
- **Migration info**: See `MIGRATION.md`
- **Main repository**: See `../bigweaver-agent-canary-hydro-zeta/`
- **Criterion documentation**: https://bheisler.github.io/criterion.rs/book/

### Related Repositories

- **Main Repository**: bigweaver-agent-canary-hydro-zeta  
  Contains the Hydroflow implementation and core functionality
- **This Repository**: bigweaver-agent-canary-zeta-hydro-deps  
  Contains timely/differential benchmarks for comparison