# Benchmark Details

This document provides detailed information about each benchmark in this repository, including their purpose, methodology, and interpretation of results.

## Overview

All benchmarks use the [Criterion](https://github.com/bheisler/criterion.rs) benchmarking framework, which provides:
- Statistical analysis of results
- Outlier detection
- Historical performance tracking
- HTML report generation
- Confidence intervals

## Benchmark Descriptions

### 1. arithmetic.rs

**Purpose**: Compare arithmetic operation performance across different dataflow implementations.

**Workload**: 
- 20 arithmetic operations (`+1`) chained together
- 1,000,000 integers processed through the pipeline

**Implementations Compared**:
- **Pipeline**: Native Rust channels and threads
- **Raw**: Minimal overhead baseline using vectors
- **Timely**: Timely dataflow with Map operators
- **Hydro (dfir_rs)**: Hydro's dataflow implementation

**Key Metrics**:
- Throughput (operations/second)
- Latency (time per operation)
- Overhead comparison vs. raw implementation

**Expected Results**:
- Raw should be fastest (baseline)
- Pipeline shows channel/thread overhead
- Timely and Hydro show framework overhead vs. flexibility trade-off

**Use Cases**:
- Understanding framework overhead for simple operations
- Evaluating when framework benefits outweigh overhead costs
- Performance tuning for arithmetic-heavy workloads

---

### 2. identity.rs

**Purpose**: Measure pure framework overhead by passing data through without transformation.

**Workload**:
- 20 identity (pass-through) operations
- 1,000,000 integers
- No actual computation, only data movement

**Implementations Compared**:
- **Pipeline**: Channel-based pass-through
- **Raw**: Vector copying baseline
- **Timely**: Identity operations in timely
- **Hydro (dfir_rs)**: Pass-through in hydro

**Key Metrics**:
- Pure overhead measurement
- Data movement costs
- Framework initialization costs

**Expected Results**:
- Reveals minimum overhead of each framework
- Helps understand cost of abstraction
- Useful for optimizing hot paths

**Use Cases**:
- Framework selection for low-overhead requirements
- Understanding baseline costs
- Optimizing data-intensive pipelines

---

### 3. fan_in.rs

**Purpose**: Test performance of merging multiple input streams into one.

**Workload**:
- Multiple independent streams
- Convergence into single output stream
- Measures merge/concatenate performance

**Implementations Compared**:
- **Timely**: Concatenate operator
- **Hydro (dfir_rs)**: Union operator

**Key Metrics**:
- Merge throughput
- Synchronization overhead
- Scalability with number of inputs

**Expected Results**:
- Efficiency of stream merging strategies
- Overhead of coordination between streams
- Scalability characteristics

**Use Cases**:
- Multi-source data aggregation
- Event stream merging
- Distributed data collection patterns

---

### 4. fan_out.rs

**Purpose**: Test performance of splitting one input stream into multiple outputs.

**Workload**:
- Single input stream
- Multiple independent output streams
- Measures broadcast/tee performance

**Implementations Compared**:
- **Timely**: Broadcasting to multiple consumers
- **Hydro (dfir_rs)**: Tee operator for stream duplication

**Key Metrics**:
- Broadcast throughput
- Memory efficiency
- Duplication overhead

**Expected Results**:
- Efficiency of data duplication
- Memory vs. computation trade-offs
- Scalability with number of outputs

**Use Cases**:
- Multi-consumer patterns
- Stream replication
- Parallel processing pipelines

---

### 5. fork_join.rs

**Purpose**: Test complex dataflow patterns with branching and joining.

**Workload**:
- Stream splits based on filter conditions (even/odd)
- Multiple filter and join operations
- Dynamic graph construction

**Implementations Compared**:
- **Timely**: Filter and concatenate operations
- **Hydro (dfir_rs)**: Dynamic graph with filters and unions

**Key Metrics**:
- Complex pattern performance
- Filter efficiency
- Join performance
- Overall pipeline throughput

**Expected Results**:
- Performance of complex dataflow graphs
- Efficiency of dynamic graph construction
- Filter and join optimization effectiveness

**Use Cases**:
- ETL pipelines
- Conditional processing
- Complex event processing

**Special Features**:
- Uses `build.rs` to generate optimized code
- Configurable complexity via `NUM_OPS` constant
- Tests scalability of graph complexity

---

### 6. join.rs

**Purpose**: Measure join operation performance.

**Workload**:
- Two data streams with matching keys
- Join operation to combine related data
- Hash-based join implementation

**Implementations Compared**:
- **Timely**: Timely's join operator
- **Hydro (dfir_rs)**: Hydro's join implementation

**Key Metrics**:
- Join throughput
- Memory usage during join
- Hash table efficiency

**Expected Results**:
- Join performance characteristics
- Memory vs. speed trade-offs
- Scalability with data size

**Use Cases**:
- Database-style joins
- Stream enrichment
- Relational operations on streams

---

### 7. upcase.rs

**Purpose**: Benchmark string transformation operations.

**Workload**:
- Stream of strings
- Uppercase transformation
- String processing overhead

**Implementations Compared**:
- **Timely**: Map operator for string transformation
- **Hydro (dfir_rs)**: Map operator in hydro

**Key Metrics**:
- String processing throughput
- Allocation overhead
- Transformation efficiency

**Expected Results**:
- Framework overhead for string operations
- Memory allocation patterns
- String handling efficiency

**Use Cases**:
- Text processing pipelines
- Data normalization
- String manipulation in streams

---

### 8. reachability.rs

**Purpose**: Test graph algorithm performance using dataflow frameworks.

**Workload**:
- Graph reachability analysis
- Iterative computation
- Fixed-point algorithm
- Real graph data from included files

**Data Files**:
- `reachability_edges.txt` (521 KB): Edge list defining graph structure
- `reachability_reachable.txt` (38 KB): Expected reachable nodes for verification

**Implementations Compared**:
- **Differential Dataflow**: Using iterate, join, and threshold operators
- **Hydro (dfir_rs)**: Recursive graph traversal implementation

**Key Metrics**:
- Iteration count to convergence
- Time per iteration
- Total computation time
- Memory efficiency

**Expected Results**:
- Differential dataflow's incremental computation benefits
- Iteration efficiency
- Graph algorithm performance

**Use Cases**:
- Graph analytics
- Recursive queries
- Iterative algorithms
- Fixed-point computations

**Special Features**:
- Uses real graph data (not synthetic)
- Tests incremental computation capabilities
- Validates correctness with expected results
- Demonstrates differential dataflow's strengths

---

## Running Individual Benchmarks

### Quick Test Run
```bash
cargo bench --bench <name> -- --test
```

### Full Benchmark Run
```bash
cargo bench --bench <name>
```

### Filter Specific Tests
```bash
# Run only timely benchmarks within a file
cargo bench --bench arithmetic -- timely

# Run only hydro benchmarks
cargo bench --bench arithmetic -- dfir
```

## Interpreting Results

### Criterion Output
Criterion provides several key metrics:
- **Time**: Mean execution time with confidence interval
- **Change**: Percentage change from previous run (if available)
- **Outliers**: Detection and reporting of anomalous measurements
- **R²**: Goodness of fit for the performance model

### HTML Reports
Generated in `target/criterion/`:
- Line plots showing performance distribution
- Comparison charts (if historical data exists)
- Detailed statistics
- Outlier analysis

### What to Look For
1. **Absolute Performance**: Raw execution time
2. **Relative Performance**: Comparison between implementations
3. **Consistency**: Low variance indicates stable performance
4. **Outliers**: High outlier count may indicate system noise
5. **Trends**: Performance changes over time (with historical data)

## Performance Considerations

### System Factors
- CPU frequency scaling
- Background processes
- Thermal throttling
- Memory availability
- Cache effects

### Best Practices
1. Close unnecessary applications before benchmarking
2. Run on a consistent system state
3. Allow warmup iterations
4. Run multiple times for confidence
5. Consider using `taskset` to pin to specific cores
6. Disable CPU frequency scaling for consistent results

### Comparison Guidelines
- Compare within same benchmark run when possible
- Consider relative rather than absolute differences
- Look for patterns across multiple benchmarks
- Context matters: different workloads favor different approaches

## Adding New Benchmarks

### Template
```rust
use criterion::{Criterion, black_box, criterion_group, criterion_main};

fn benchmark_name(c: &mut Criterion) {
    c.bench_function("category/name", |b| {
        b.iter(|| {
            // Benchmark code here
            black_box(result);
        });
    });
}

criterion_group!(benches, benchmark_name);
criterion_main!(benches);
```

### Steps
1. Create new `.rs` file in `benches/benches/`
2. Implement benchmark following template
3. Add `[[bench]]` entry to `Cargo.toml`
4. Document in this file
5. Update `benches/README.md`
6. Test with `cargo bench --bench <name>`

## Troubleshooting

### Benchmarks Won't Compile
- Check dependency versions in `Cargo.toml`
- Verify dfir_rs API compatibility
- Ensure all required features are enabled

### Inconsistent Results
- Check for background processes
- Verify system is not thermal throttling
- Ensure sufficient warmup iterations
- Consider increasing sample size

### Out of Memory
- Reduce workload size constants
- Check for memory leaks
- Monitor memory usage during benchmarks

## References

- [Criterion.rs Documentation](https://bheisler.github.io/criterion.rs/book/)
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)
- [Hydro Project](https://github.com/hydro-project/hydro)
