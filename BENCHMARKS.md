# Benchmark Suite Documentation

This document provides detailed information about each benchmark in the suite and how to interpret the performance comparison results.

## Benchmark Descriptions

### 1. Arithmetic (`arithmetic.rs`)
**Purpose**: Tests basic arithmetic operations in dataflow pipelines.

**Implementations**:
- Timely Dataflow
- DFIR Scheduled
- DFIR Surface (compiled)

**What it measures**: Overhead of dataflow operators when performing simple computations.

### 2. Fan-In (`fan_in.rs`)
**Purpose**: Tests the performance of merging multiple streams into one.

**Pattern**: Multiple input streams → Union operator → Single output

**Implementations**:
- Timely Dataflow
- DFIR Scheduled
- DFIR Surface (compiled)

**What it measures**: Stream union/merge overhead and scheduling efficiency.

### 3. Fan-Out (`fan_out.rs`)
**Purpose**: Tests the performance of splitting one stream into multiple outputs.

**Pattern**: Single input → Tee/Split operator → Multiple outputs

**Implementations**:
- Timely Dataflow
- DFIR Scheduled
- DFIR Surface (compiled)

**What it measures**: Stream splitting overhead and data copying costs.

### 4. Fork-Join (`fork_join.rs`)
**Purpose**: Tests parallel work distribution and aggregation.

**Pattern**: 
```
Input → Fork (filter even/odd) → Multiple paths → Join → Output
```

**Implementations**:
- Timely Dataflow
- DFIR Scheduled
- DFIR Surface (compiled)

**What it measures**: Combined fork and join performance in iterative patterns.

**Note**: Uses generated code from `build.rs` for configurable depth.

### 5. Futures (`futures.rs`)
**Purpose**: Tests asynchronous operation handling.

**Operations**:
- Future creation and resolution
- Async operation scheduling
- Result collection

**Implementations**:
- DFIR Surface with resolve_futures operator

**What it measures**: Overhead of integrating async operations into dataflow.

### 6. Identity (`identity.rs`)
**Purpose**: Baseline test with minimal operations.

**Pattern**: Input → Pass-through → Output

**Implementations**:
- Timely Dataflow
- DFIR Scheduled
- DFIR Surface (compiled)

**What it measures**: Minimum overhead of the dataflow runtime itself.

### 7. Join (`join.rs`)
**Purpose**: Tests two-way stream joins.

**Pattern**: Stream A + Stream B → Join on key → Output

**Implementations**:
- Timely Dataflow
- DFIR Scheduled
- DFIR Surface (compiled)

**What it measures**: Join operator performance and state management overhead.

### 8. Micro Operations (`micro_ops.rs`)
**Purpose**: Detailed micro-benchmarks of individual operators.

**Operators tested**:
- `map`
- `filter`
- `flat_map`
- `fold`
- `reduce`
- And combinations thereof

**Implementations**:
- DFIR Surface for each operator

**What it measures**: Per-operator overhead and optimization effectiveness.

### 9. Reachability (`reachability.rs`)
**Purpose**: Graph reachability computation - a classic dataflow benchmark.

**Algorithm**: Iteratively find all nodes reachable from a starting node in a directed graph.

**Implementations**:
- Timely Dataflow
- Differential Dataflow (with iteration)
- DFIR Scheduled
- DFIR Compiled
- DFIR Surface

**What it measures**: 
- Iteration overhead
- State management
- Fixed-point computation
- Join performance in iterative context

**Data**: Uses real graph data from included text files (~50K edges).

### 10. Symmetric Hash Join (`symmetric_hash_join.rs`)
**Purpose**: Tests symmetric hash join implementation.

**Pattern**: Two streams with incremental updates, both sides queryable.

**Implementations**:
- DFIR Surface

**What it measures**: Bidirectional join state management and update propagation.

### 11. Upcase (`upcase.rs`)
**Purpose**: String processing benchmark.

**Operation**: Convert strings to uppercase

**Implementations**:
- Timely Dataflow
- DFIR Scheduled
- DFIR Surface (compiled)

**What it measures**: Data transformation overhead with non-trivial operations.

### 12. Words Diamond (`words_diamond.rs`)
**Purpose**: Complex string processing pipeline.

**Pattern**: 
```
Input → Split → Multiple transformations → Merge → Output
```

**Implementations**:
- DFIR Surface

**What it measures**: Complex pipeline performance with string operations.

**Data**: Uses large word list (~370K words) from included file.

## Performance Comparison Guide

### Understanding the Results

#### Criterion Output
Benchmarks use Criterion, which provides:
- **Mean time**: Average execution time
- **Std deviation**: Variability in measurements
- **Median**: Middle value (less affected by outliers)
- **MAD**: Median Absolute Deviation
- **Throughput**: Operations per second (when applicable)

#### Comparing Frameworks

**DFIR Scheduled vs Compiled**:
- **Scheduled**: Dynamic runtime with push-based execution
- **Compiled**: Ahead-of-time compiled with optimizations
- **Expected**: Compiled should be faster for most workloads

**DFIR vs Timely**:
- **Timely**: Mature, optimized for data-parallel workloads
- **DFIR**: Newer, optimized for low-latency streaming
- **Trade-offs**: Different design choices affect different workloads

**Timely vs Differential**:
- **Differential**: Adds incremental computation overhead
- **Expected**: Higher overhead but supports incremental updates
- **Best for**: Workloads with frequent small changes

### Interpreting Patterns

#### When DFIR Should Win
- **Low-latency streaming**: Small batches, quick response
- **Simple pipelines**: Minimal state, straightforward dataflow
- **Compiled mode**: Static graphs with known structure

#### When Timely Should Win
- **Large batches**: High throughput data processing
- **Complex coordination**: Multiple workers, synchronization
- **Mature optimizations**: Well-tuned for specific patterns

#### When Differential Should Win
- **Incremental updates**: Small changes to large datasets
- **Iterative computation**: Fixed-point algorithms with changes
- **Maintained state**: Long-running computations with updates

## Running and Analyzing Benchmarks

### Quick Comparison
```bash
# Compare all frameworks on reachability
cargo bench -p benches --bench reachability

# Compare specific implementations
cargo bench -p benches --bench reachability -- timely
cargo bench -p benches --bench reachability -- dfir
```

### Detailed Analysis
```bash
# Generate full HTML report
cargo bench -p benches

# View results
open target/criterion/report/index.html
```

### Statistical Rigor
Criterion automatically:
- Runs warmup iterations
- Performs multiple measurements
- Detects outliers
- Calculates confidence intervals
- Compares to baseline (if available)

### Noise Reduction
For more accurate results:
```bash
# Run on dedicated machine
# Disable CPU frequency scaling
# Close other applications
# Run multiple times and average

cargo bench -p benches --bench reachability -- --sample-size 100
```

## Benchmark Configuration

### Adjusting Parameters

#### Dataset Size
Edit the benchmark file to change input size:
```rust
// In reachability.rs
const NUM_NODES: usize = 10_000;  // Adjust as needed
```

#### Iteration Count
```rust
// Via Criterion configuration
c.bench_function("name", |b| {
    b.iter(|| {
        // benchmark code
    })
})
```

#### Sampling
```bash
# Command line
cargo bench -- --sample-size 50 --measurement-time 10
```

### Build Script Configuration

The `build.rs` script generates code for fork-join benchmarks:

```rust
const NUM_OPS: usize = 20;  // Adjust depth of fork-join
```

Changing this requires rebuilding:
```bash
cargo clean -p benches
cargo bench -p benches --bench fork_join
```

## CI/CD Integration

### Automated Runs
The benchmark workflow runs:
- **Daily**: Scheduled at 03:35 UTC
- **On demand**: Manual workflow dispatch
- **With tag**: Commits/PRs containing `[ci-bench]`

### Viewing Results
Results are available:
1. **Artifacts**: Downloaded from GitHub Actions
2. **gh-pages**: Historical data at `https://[org].github.io/[repo]/bench/`
3. **PR comments**: Comparison to base branch (if configured)

### Historical Tracking
The workflow maintains:
- JSON data file with all historical measurements
- Interactive HTML charts
- Regression detection (sudden slowdowns)

## Best Practices

### Writing Benchmarks
1. **Isolate what you measure**: Avoid measuring setup/teardown
2. **Use realistic workloads**: Match production patterns
3. **Include all frameworks**: Enable fair comparison
4. **Document expectations**: Explain why one might be faster
5. **Validate correctness**: Assert expected outputs

### Analyzing Results
1. **Look for patterns**: Consistent differences across benchmarks
2. **Check variance**: High variance indicates unstable measurements
3. **Compare ratios**: Relative performance more meaningful than absolute
4. **Consider context**: Different workloads favor different systems
5. **Track over time**: Detect regressions early

### Reporting Issues
When benchmarks show unexpected results:
1. Verify correctness first
2. Check for configuration issues
3. Run multiple times to confirm
4. Compare with historical data
5. File issue with reproduction steps

## References

- Criterion documentation: https://bheisler.github.io/criterion.rs/book/
- Timely Dataflow: https://github.com/TimelyDataflow/timely-dataflow
- Differential Dataflow: https://github.com/TimelyDataflow/differential-dataflow
- DFIR documentation: Main repository docs
