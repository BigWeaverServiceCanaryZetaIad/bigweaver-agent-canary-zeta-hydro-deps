# Differential Dataflow Benchmarks

This package contains performance benchmarks for Differential Dataflow, an incremental computation framework.

## Benchmarks

### Arrange (`arrange.rs`)
Tests the performance of arranging data by key for efficient lookups.

**Scenarios:**
- Basic arrangement with varying data sizes (1K, 10K, 100K elements)
- Arrangement with varying key cardinalities (10, 100, 1K unique keys)

**Use Case:** Understanding the cost of preparing data for joins and indexed access

### Join (`join.rs`)
Measures join operation performance under different conditions.

**Scenarios:**
- Simple joins with varying input sizes (100, 1K, 10K elements)
- Joins with different selectivities (1, 10, 50 keys)

**Use Case:** Optimizing multi-way join queries

### Count (`count.rs`)
Tests aggregation and counting performance.

**Scenarios:**
- Basic counting with varying data sizes (1K, 10K, 100K elements)
- Counting with different numbers of distinct keys (10, 100, 1K)

**Use Case:** Performance of grouping and aggregation operations

### Consolidate (`consolidate.rs`)
Evaluates data consolidation and compaction performance.

**Scenarios:**
- Basic consolidation with varying data sizes
- Consolidation with multiple updates (1, 10, 100 updates per key)

**Use Case:** Understanding the cost of maintaining consolidated state

### Distinct (`distinct.rs`)
Measures duplicate elimination performance.

**Scenarios:**
- Basic distinct operation with varying data sizes
- Distinct with different duplication factors (1, 10, 100 duplicates)

**Use Case:** Performance of deduplication in streaming data

## Incremental Updates

Differential Dataflow's key strength is incremental computation. These benchmarks measure:
- Initial computation cost
- Update processing efficiency
- Memory overhead of maintaining indices

## Running Benchmarks

```bash
# Run all differential benchmarks
cargo bench --package differential-benchmarks

# Run specific benchmark
cargo bench --package differential-benchmarks --bench join

# Run with specific filter
cargo bench --package differential-benchmarks -- join/simple_join
```

## Interpreting Results

Key metrics:
- **Initial Computation**: Time to process first batch
- **Update Latency**: Time to process incremental changes
- **Memory Usage**: Size of maintained arrangements and indices
- **Throughput**: Updates processed per second

## Performance Tips

1. **Arrangement**: Pre-arrange data that will be joined multiple times
2. **Key Selectivity**: High-cardinality keys may have different performance characteristics
3. **Batch Size**: Larger batches can amortize coordination overhead
4. **Update Patterns**: Sequential updates may perform differently than random updates

## Customization

Modify parameters in each benchmark file:
- Input sizes: Change size arrays
- Key distributions: Adjust modulo operations for key generation
- Update patterns: Modify insert/remove sequences
- Worker configuration: Set `TIMELY_WORKER_THREADS` environment variable
