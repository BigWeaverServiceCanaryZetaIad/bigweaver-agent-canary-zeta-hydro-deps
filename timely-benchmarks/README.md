# Timely Dataflow Benchmarks

This package contains performance benchmarks for the Timely Dataflow system.

## Benchmarks

### Barrier (`barrier.rs`)
Measures the performance of barrier synchronization across different data stream sizes.

**Scenarios:**
- Single-threaded execution with varying data sizes (1K, 10K, 100K elements)

**Use Case:** Understanding synchronization overhead in streaming computations

### Exchange (`exchange.rs`)
Tests data exchange and partitioning patterns.

**Scenarios:**
- Round-robin partitioning
- Hash-based partitioning with varying key distributions

**Use Case:** Optimizing data distribution in distributed dataflow

### Dataflow Construction (`dataflow_construction.rs`)
Evaluates the overhead of building dataflow computation graphs.

**Scenarios:**
- Simple pipelines (map → filter → inspect)
- Deep pipelines (5, 10, 20 operators in sequence)
- Wide pipelines (5, 10, 20 parallel streams)

**Use Case:** Understanding graph construction costs for dynamic dataflows

### Progress Tracking (`progress_tracking.rs`)
Analyzes the performance of Timely's progress tracking mechanism.

**Scenarios:**
- Linear operator chains
- Branching dataflows (2, 4, 8 branches)

**Use Case:** Evaluating coordination overhead in complex dataflows

### Unary Operators (`unary_operators.rs`)
Measures basic operator performance.

**Scenarios:**
- Map operations
- Filter operations
- FlatMap operations
- Varying data sizes (1K, 10K, 100K elements)

**Use Case:** Baseline performance metrics for common operations

## Running Benchmarks

```bash
# Run all timely benchmarks
cargo bench --package timely-benchmarks

# Run specific benchmark
cargo bench --package timely-benchmarks --bench barrier

# Run with specific filter
cargo bench --package timely-benchmarks -- exchange/round_robin
```

## Interpreting Results

Results show:
- **Time**: Wall-clock execution time
- **Throughput**: Elements processed per second (where applicable)
- **Comparison**: Against previous runs (if available)

## Customization

Modify parameters in each benchmark file:
- Data sizes: Change the array `[1000, 10000, 100000]`
- Iterations: Adjust in Criterion configuration
- Worker threads: Set via environment variable `TIMELY_WORKER_THREADS`
