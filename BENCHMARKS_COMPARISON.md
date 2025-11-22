# Benchmark Comparison Reference

This document provides a quick reference for understanding which benchmarks test which features and how they compare across systems.

## Benchmark Matrix

| Benchmark | Hydro | Timely | Differential | Baseline | Primary Focus |
|-----------|-------|--------|--------------|----------|---------------|
| arithmetic | ✅ | ✅ | ❌ | ✅ (iter, pipeline, raw) | Sequential operations, operator fusion |
| fan_in | ✅ | ✅ | ❌ | ❌ | Stream merging, concatenation |
| fan_out | ✅ | ✅ | ❌ | ❌ | Stream splitting, broadcasting |
| fork_join | ✅ | ✅ | ❌ | ❌ | Conditional routing, filters |
| identity | ✅ | ✅ | ❌ | ✅ (raw) | Minimal overhead, pass-through |
| join | ✅ | ✅ | ❌ | ❌ | Binary operations, state management |
| reachability | ✅ | ✅ | ✅ | ❌ | Graph algorithms, iteration |
| upcase | ✅ | ✅ | ❌ | ❌ | String operations, mapping |

## Feature Coverage

### Data Flow Patterns

#### Fan-In (Merge)
- **Benchmarks**: `fan_in.rs`
- **Tests**: Combining multiple input streams into one
- **Key Metric**: Throughput with multiple sources
- **Hydro operators**: `union()`
- **Timely operators**: `concat()`

#### Fan-Out (Split/Broadcast)
- **Benchmarks**: `fan_out.rs`
- **Tests**: Splitting one stream to multiple destinations
- **Key Metric**: Overhead of stream duplication
- **Hydro operators**: `tee()`
- **Timely operators**: Multiple `map()` consumers

#### Fork-Join
- **Benchmarks**: `fork_join.rs`
- **Tests**: Conditional routing and rejoining
- **Key Metric**: Filter + merge efficiency
- **Hydro operators**: `filter()`, `union()`
- **Timely operators**: `filter()`, `concat()`

### Operation Types

#### Map/Transform
- **Benchmarks**: `arithmetic.rs`, `upcase.rs`, `identity.rs`
- **Tests**: Element-wise transformations
- **Key Metric**: Per-element overhead
- **Complexity**: O(n) where n = number of elements

#### Join
- **Benchmarks**: `join.rs`
- **Tests**: Combining two streams by key
- **Key Metric**: State management overhead
- **Complexity**: Depends on join strategy

#### Iteration
- **Benchmarks**: `reachability.rs`
- **Tests**: Fixed-point computation, loops
- **Key Metric**: Convergence speed, iteration overhead
- **Complexity**: O(iterations × edges)

## Implementation Variants

### Hydro Variants

Most benchmarks include multiple Hydro implementations:

1. **Surface Syntax** (`dfir_syntax!` macro)
   - Most readable
   - Compile-time code generation
   - Example: `benchmark_hydroflow_surface`

2. **Compiled** (`SinkBuilder` API)
   - Type-safe builder pattern
   - More explicit control
   - Example: `benchmark_hydroflow_compiled`

3. **Optimized** (Various techniques)
   - Tick-based execution
   - Specialized operators
   - Example: `benchmark_hydroflow_tick_reachability`

### Timely Variants

Timely benchmarks typically use:
- Dataflow operators (`ToStream`, `Map`, `Filter`, etc.)
- `timely::example()` for simple cases
- `timely::execute_directly()` for more control

### Differential Variants

Differential benchmarks (reachability only) use:
- Collections and incremental computation
- `iterate()` for fixed-point algorithms
- Ideal for graph algorithms with updates

## Performance Characteristics

### Expected Performance Order

Different benchmarks favor different systems:

#### Hydro Advantages
- **Simple pipelines**: Low overhead, good fusion
- **Static graphs**: Compile-time optimization
- **Single-threaded**: Minimal coordination cost

#### Timely Advantages
- **Complex dataflow**: Mature operator library
- **Multi-threaded**: Built-in parallelism
- **Dynamic graphs**: Runtime flexibility

#### Differential Advantages
- **Incremental**: Updates cheaper than full recomputation
- **Iterative**: Efficient convergence
- **Maintenance**: State persistence across updates

### Benchmark-Specific Notes

#### arithmetic.rs
- **Baseline winner**: Raw iterator (no framework overhead)
- **Hydro competitive**: Good operator fusion
- **Timely overhead**: Dataflow coordination cost
- **Key insight**: Framework overhead vs. abstractions

#### reachability.rs
- **Differential shines**: Natural fit for graph algorithms
- **Hydro tick-based**: Competitive with manual iteration control
- **Timely loops**: Explicit feedback mechanism
- **Key insight**: Algorithm-framework fit matters

#### join.rs
- **State management**: Critical performance factor
- **Data layout**: Vec vs HashMap significantly affects performance
- **Hydro variants**: Multiple implementations show trade-offs
- **Key insight**: No one-size-fits-all solution

## Data Characteristics

### Dataset Sizes

| Benchmark | Input Size | Working Set | Notes |
|-----------|-----------|-------------|-------|
| arithmetic | 1M integers | Minimal | Sequential processing |
| fan_in | Varies | Minimal | Multiple small streams |
| fan_out | Varies | Minimal | Single stream split |
| fork_join | Varies | Minimal | Conditional routing |
| identity | 1M integers | Minimal | Pass-through only |
| join | Configurable | Medium | Depends on join type |
| reachability | ~50K edges | Large | Graph structure |
| upcase | ~370K words | Minimal | String processing |

### Data Sources

- **reachability_edges.txt**: Real graph data (50,000+ edges)
- **reachability_reachable.txt**: Expected output for verification
- **words_alpha.txt**: English dictionary (~370,000 words)

## Interpreting Results

### Metrics to Compare

1. **Throughput**: Elements processed per second
2. **Latency**: Time to first output
3. **Memory**: Peak working set size
4. **Overhead**: Framework cost vs. raw implementation

### Statistical Significance

Criterion provides:
- **Mean**: Average execution time
- **Std Dev**: Variability
- **Outliers**: Anomalous measurements
- **Confidence**: Statistical reliability

Look for:
- ✅ Low variability (< 5% std dev)
- ✅ No severe outliers
- ✅ Tight confidence intervals

### Common Pitfalls

❌ **Don't compare**:
- Different data sizes
- Different optimization levels
- Different hardware

✅ **Do compare**:
- Same benchmark, different systems
- Relative performance (e.g., "2x faster")
- Trends over time (regressions)

## Benchmark Selection Guide

### When to Run Each Benchmark

#### Quick Smoke Test
```bash
cargo bench --bench arithmetic
cargo bench --bench identity
```
- Fast to run
- Good indicator of basic overhead

#### Comprehensive Comparison
```bash
cargo bench
```
- All benchmarks
- Full system comparison
- Takes significant time

#### Feature-Specific Testing

**Testing joins**:
```bash
cargo bench --bench join
```

**Testing iteration**:
```bash
cargo bench --bench reachability
```

**Testing basic operations**:
```bash
cargo bench --bench arithmetic --bench identity --bench upcase
```

**Testing dataflow patterns**:
```bash
cargo bench --bench fan_in --bench fan_out --bench fork_join
```

## Result Analysis Examples

### Example 1: Arithmetic Benchmark

Typical results might show:
```
arithmetic/raw           1.2 ms   (baseline)
arithmetic/iter          1.5 ms   (25% slower)
arithmetic/hydroflow     2.0 ms   (67% slower)
arithmetic/timely        3.5 ms   (192% slower)
```

**Interpretation**:
- Raw has no framework overhead (baseline)
- Iterator has minimal overhead
- Hydro has moderate framework cost
- Timely has coordination overhead

**Conclusion**: For simple pipelines, overhead matters. Hydro competitive with iterators.

### Example 2: Reachability Benchmark

Typical results might show:
```
reachability/hydroflow       45 ms
reachability/timely          50 ms  
reachability/differential    30 ms
```

**Interpretation**:
- Differential optimized for this workload
- Hydro and Timely similar (both use explicit loops)
- Choice depends on whether updates are expected

**Conclusion**: Match algorithm to framework strengths.

## Cross-Benchmark Insights

### Operator Fusion

**Observable in**: `arithmetic`, `identity`, `upcase`

Hydro's compile-time optimization can fuse operators, reducing overhead. Compare:
- `benchmark_hydroflow_compiled` (potential fusion)
- `benchmark_hydroflow_surface` (guaranteed fusion)

### State Management

**Observable in**: `join`, `reachability`

Different systems handle state differently:
- **Hydro**: Explicit state in dataflow
- **Timely**: Operator-managed state
- **Differential**: Collection-based state

### Coordination Overhead

**Observable in**: All benchmarks

Multi-threaded systems (Timely) pay coordination costs even with one worker. Single-threaded Hydro avoids this.

## Future Benchmark Ideas

### Additional Patterns to Test
- **Window aggregations**: Time-based grouping
- **Sorting**: Order-dependent processing
- **Barriers**: Synchronization points
- **Multi-input operators**: Complex routing

### Additional Systems to Compare
- **Flink**: JVM-based streaming
- **Spark**: Batch processing
- **Native iterators**: Pure Rust baseline

### Additional Metrics
- **Energy consumption**: Efficiency
- **Compilation time**: Developer experience
- **Code size**: Binary size impact

## References

- [Criterion.rs Book](https://bheisler.github.io/criterion.rs/book/)
- [Timely Dataflow Documentation](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow Documentation](https://github.com/TimelyDataflow/differential-dataflow)
- [Hydro Documentation](../../bigweaver-agent-canary-hydro-zeta/README.md)
