# Performance Comparison Guide

This guide explains how to use the benchmark suite for performance comparison and analysis.

## Quick Start

### Run All Benchmarks with Comparison

```bash
./run_benchmarks.sh
```

This will:
1. Run all Timely Dataflow benchmarks
2. Run all Differential Dataflow benchmarks
3. Generate comparison reports
4. Create HTML visualizations

### View Results

```bash
# Open HTML reports
open target/criterion/report/index.html

# View comparison results
cat benchmark_comparison.json

# View analysis results
cat benchmark_analysis.json
```

## Performance Comparison Methodology

### 1. Baseline Establishment

Create a baseline for regression testing:

```bash
# Run benchmarks and save as baseline
./run_benchmarks.sh --baseline main

# Later, compare new changes against baseline
./run_benchmarks.sh --baseline main
```

### 2. Comparing Frameworks

To compare Timely vs Differential performance:

```bash
# Run both frameworks
./run_benchmarks.sh

# Results will show:
# - Execution time for each framework
# - Speedup factors
# - Performance differences
```

### 3. Incremental Performance Testing

Test specific scenarios:

```bash
# Test only incremental operations
cargo bench -p differential-benchmarks --bench incremental_join

# Test only graph algorithms
cargo bench -p timely-benchmarks --bench graph_reachability
cargo bench -p differential-benchmarks --bench graph_computation
```

## Understanding Benchmark Results

### Criterion Output

Criterion provides detailed statistical analysis:

```
graph_reachability/join/1000
                        time:   [1.2345 ms 1.2567 ms 1.2789 ms]
                        change: [-5.2% -3.1% -1.0%] (p = 0.02 < 0.05)
                        Performance has improved.
```

Metrics explained:
- **time**: [lower bound, estimate, upper bound] with 95% confidence
- **change**: Percentage change from previous run
- **p-value**: Statistical significance (< 0.05 is significant)

### Throughput Metrics

Benchmarks measure throughput in elements/second:

```
timely/data_parallel/map/10000
                        time:   [123.45 µs 125.67 µs 127.89 µs]
                        thrpt:  [78.15 Melem/s 79.56 Melem/s 80.97 Melem/s]
```

Higher throughput = better performance.

### Comparison Metrics

The comparison tool provides:

1. **Speedup Factor**: Ratio of execution times
   - `1.0x` = Equal performance
   - `> 1.0x` = Differential slower
   - `< 1.0x` = Differential faster

2. **Absolute Differences**: Time differences in nanoseconds

3. **Statistical Significance**: Whether differences are meaningful

## Benchmark Categories and Use Cases

### Timely Dataflow Benchmarks

#### Graph Reachability
**Use Case**: Measuring iterative computation performance
```bash
cargo bench -p timely-benchmarks --bench graph_reachability
```

**What it tests**:
- Iterative dataflow loops
- Join operations
- Data exchange between workers

**Key metrics**:
- Time to compute reachability for various graph sizes
- Throughput of join operations

#### Data Parallel Operations
**Use Case**: Basic transformation performance
```bash
cargo bench -p timely-benchmarks --bench data_parallel
```

**What it tests**:
- Map, filter, flat_map operations
- Pipeline throughput
- CPU efficiency

**Key metrics**:
- Elements processed per second
- Overhead of operators

#### Barrier Synchronization
**Use Case**: Coordination overhead measurement
```bash
cargo bench -p timely-benchmarks --bench barrier_sync
```

**What it tests**:
- Epoch advancement speed
- Synchronization overhead
- Frontier tracking efficiency

**Key metrics**:
- Time per barrier
- Scalability with number of barriers

#### Exchange Patterns
**Use Case**: Network/shuffle performance
```bash
cargo bench -p timely-benchmarks --bench exchange
```

**What it tests**:
- Data shuffling performance
- Hash partitioning
- Communication patterns

**Key metrics**:
- Shuffle throughput
- Partitioning overhead

### Differential Dataflow Benchmarks

#### Incremental Join
**Use Case**: Measuring incremental update efficiency
```bash
cargo bench -p differential-benchmarks --bench incremental_join
```

**What it tests**:
- Join maintenance with updates
- Multi-way joins
- Incremental recomputation

**Key metrics**:
- Initial computation time
- Update processing time
- Memory overhead

#### Graph Computation
**Use Case**: Iterative graph algorithm performance
```bash
cargo bench -p differential-benchmarks --bench graph_computation
```

**What it tests**:
- Connected components
- Transitive closure
- Iterative convergence

**Key metrics**:
- Convergence speed
- Memory consumption
- Update efficiency

#### Group and Reduce
**Use Case**: Aggregation performance
```bash
cargo bench -p differential-benchmarks --bench group_reduce
```

**What it tests**:
- Group-by operations
- Sum, count, average aggregations
- Incremental aggregation updates

**Key metrics**:
- Aggregation throughput
- Update latency
- Memory per group

#### Distinct Operations
**Use Case**: Deduplication performance
```bash
cargo bench -p differential-benchmarks --bench distinct
```

**What it tests**:
- Deduplication with various cardinalities
- Incremental distinct updates
- Memory efficiency

**Key metrics**:
- Throughput by cardinality
- Memory per distinct value
- Update performance

## Advanced Performance Analysis

### CPU Profiling

Use `perf` for detailed CPU profiling:

```bash
# Record CPU profile
perf record --call-graph dwarf \
    cargo bench -p timely-benchmarks --bench graph_reachability

# Analyze profile
perf report
```

### Memory Profiling

Use `heaptrack` for memory profiling:

```bash
# Install heaptrack
sudo apt-get install heaptrack

# Profile memory usage
heaptrack cargo bench -p differential-benchmarks --bench incremental_join

# Analyze results
heaptrack_gui heaptrack.*.gz
```

### Flamegraphs

Generate flamegraphs for visualization:

```bash
# Install cargo-flamegraph
cargo install flamegraph

# Generate flamegraph
cargo flamegraph --bench graph_reachability -p timely-benchmarks

# View flamegraph.svg in browser
```

## Comparing with Hydro

### Running Hydro Benchmarks

```bash
# In the main Hydro repository
cd ../bigweaver-agent-canary-hydro-zeta/benches
cargo bench

# Compare with timely/differential
cd ../../bigweaver-agent-canary-zeta-hydro-deps
./target/release/compare-benchmarks \
    ../bigweaver-agent-canary-hydro-zeta/target/criterion \
    ./target/criterion
```

### Key Comparison Points

1. **Execution Model**:
   - Timely/Differential: Pull-based, explicit frontier tracking
   - Hydro: Push-based, implicit scheduling

2. **API Abstraction**:
   - Timely/Differential: Lower-level, more control
   - Hydro: Higher-level, easier to use

3. **Performance Characteristics**:
   - Timely: Low latency, predictable performance
   - Differential: Incremental efficiency
   - Hydro: Ease of development, optimization opportunities

### Performance Expectations

**When Timely/Differential Might Be Faster**:
- Low-level operations with minimal abstraction
- Hot paths with hand-tuned implementations
- Scenarios leveraging explicit control

**When Hydro Might Be Faster**:
- High-level optimizations (e.g., query optimization)
- Scenarios with automatic operator fusion
- Compiled/specialized code paths

## Best Practices

### 1. Consistent Environment

- Disable CPU frequency scaling
- Close background applications
- Use dedicated benchmark machine
- Run multiple iterations

### 2. Statistical Significance

- Use sufficient sample sizes
- Check confidence intervals
- Verify p-values
- Look for consistent trends

### 3. Fair Comparisons

- Use equivalent algorithms
- Match data sizes
- Consider warm-up effects
- Account for compilation differences

### 4. Documentation

- Document test scenarios
- Record system configuration
- Note performance expectations
- Track regressions over time

## Performance Optimization Tips

### For Timely Benchmarks

1. **Reduce Coordination**: Minimize barrier synchronization
2. **Batch Operations**: Group data for better cache utilization
3. **Optimize Exchange**: Use efficient partitioning functions
4. **Tune Workers**: Match worker count to CPU cores

### For Differential Benchmarks

1. **Minimize Arrangements**: Avoid unnecessary indexing
2. **Batch Updates**: Group changes for better amortization
3. **Use Consolidation**: Compact data regularly
4. **Optimize Arrangements**: Choose appropriate key types

## Troubleshooting

### High Variance in Results

**Causes**:
- Background processes
- CPU frequency scaling
- Thermal throttling
- Memory pressure

**Solutions**:
```bash
# Disable CPU frequency scaling
sudo cpupower frequency-set --governor performance

# Increase sample size
./run_benchmarks.sh --sample-size 1000

# Pin to specific cores
taskset -c 0-3 ./run_benchmarks.sh
```

### Out of Memory

**Solutions**:
- Reduce data sizes in benchmarks
- Run benchmarks individually
- Increase system memory
- Monitor memory with `htop`

### Slow Execution

**Solutions**:
```bash
# Reduce sample size
cargo bench -- --sample-size 10

# Run specific benchmarks
cargo bench --bench graph_reachability

# Use quick mode
cargo bench -- --quick
```

## Continuous Performance Monitoring

### GitHub Actions Integration

Add to `.github/workflows/benchmarks.yml`:

```yaml
name: Performance Benchmarks

on:
  push:
    branches: [main]
  pull_request:

jobs:
  benchmark:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: actions-rs/toolchain@v1
        with:
          toolchain: stable
      - name: Run benchmarks
        run: ./run_benchmarks.sh --sample-size 10
      - name: Upload results
        uses: actions/upload-artifact@v2
        with:
          name: benchmark-results
          path: |
            benchmark_comparison.json
            benchmark_analysis.json
```

### Performance Regression Detection

```bash
# Save baseline on main branch
git checkout main
./run_benchmarks.sh --baseline main

# Test feature branch
git checkout feature-branch
./run_benchmarks.sh --baseline main

# Check for regressions
# Criterion will flag significant performance changes
```

## Resources

- [Timely Dataflow Documentation](https://docs.rs/timely/)
- [Differential Dataflow Documentation](https://docs.rs/differential-dataflow/)
- [Criterion.rs User Guide](https://bheisler.github.io/criterion.rs/book/)
- [Rust Performance Book](https://nnethercote.github.io/perf-book/)
