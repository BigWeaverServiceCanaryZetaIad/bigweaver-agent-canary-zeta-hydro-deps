# Benchmark Implementations Guide

This document provides a detailed overview of the benchmark implementations available in this repository, specifically highlighting which benchmarks include Timely Dataflow and Differential Dataflow implementations for performance comparison.

## Overview

The benchmarks in this repository enable performance comparisons between different dataflow framework implementations:
- **Hydro/DFIR** - The main Hydro dataflow framework
- **Timely Dataflow** - Low-level dataflow framework
- **Differential Dataflow** - Incremental computation framework built on Timely

## Benchmarks with Timely Implementations

The following benchmarks include Timely Dataflow implementations for direct performance comparison:

### 1. **arithmetic** (`arithmetic.rs`)
Pipeline arithmetic operations with 20 sequential map operations.

**Implementations:**
- `benchmark_timely` - Timely Dataflow implementation
- `benchmark_hydroflow_compiled` - Compiled Hydro implementation
- `benchmark_hydroflow_surface` - Surface syntax Hydro implementation
- `benchmark_pipeline` - Raw channel-based pipeline
- `benchmark_iter` - Pure iterator implementation
- `benchmark_raw_copy` - Minimal overhead baseline

**Use case:** Testing pipeline throughput and operator fusion

### 2. **fan_in** (`fan_in.rs`)
Fan-in dataflow pattern where multiple streams merge into one.

**Implementations:**
- `benchmark_timely` - Timely Dataflow with concatenate operator
- `benchmark_hydroflow_surface` - Hydro surface syntax with union
- `benchmark_iters` - Iterator-based approach
- `benchmark_for_loops` - Simple for-loop baseline

**Use case:** Testing stream merging performance

### 3. **fan_out** (`fan_out.rs`)
Fan-out dataflow pattern where one stream splits into multiple outputs.

**Implementations:**
- `benchmark_timely` - Timely Dataflow implementation
- `benchmark_hydroflow_surface` - Hydro surface syntax with tee
- `benchmark_sol` - Alternative solution

**Use case:** Testing stream distribution performance

### 4. **fork_join** (`fork_join.rs`)
Fork-join pattern with multiple parallel branches that merge.

**Implementations:**
- `benchmark_timely` - Timely Dataflow implementation
- `benchmark_hydroflow` - Hydro compiled dataflow
- `benchmark_hydroflow_surface` - Hydro surface syntax
- `benchmark_raw` - Raw implementation baseline

**Use case:** Testing parallel branch execution and merging

### 5. **identity** (`identity.rs`)
Identity operation passing data through with minimal transformation.

**Implementations:**
- `benchmark_timely` - Timely Dataflow implementation
- `benchmark_hydroflow_compiled` - Compiled Hydro implementation
- `benchmark_hydroflow` - Hydro dataflow
- `benchmark_hydroflow_surface` - Hydro surface syntax
- `benchmark_pipeline` - Channel-based pipeline
- `benchmark_iter` - Iterator implementation
- `benchmark_raw_copy` - Minimal baseline

**Use case:** Measuring framework overhead with minimal computation

### 6. **join** (`join.rs`)
Join operations between two streams.

**Implementations:**
- `benchmark_timely<L, R>` - Generic Timely join implementation
- `benchmark_sol<L, R>` - Alternative solution

**Use case:** Testing join operation performance with different data distributions

### 7. **upcase** (`upcase.rs`)
String transformation benchmarks (uppercase conversion).

**Implementations:**
- `benchmark_timely<O>` - Generic Timely implementation
- `benchmark_raw_copy<O>` - Raw copy baseline
- `benchmark_iter<O>` - Iterator-based approach

Supports multiple operation types:
- `UpcaseInPlace` - In-place modification
- `UpcaseAllocating` - Allocates new strings
- `Concatting` - String concatenation

**Use case:** Testing string processing performance

## Benchmarks with Differential Dataflow Implementations

### 8. **reachability** (`reachability.rs`)
Graph reachability algorithm - finds all nodes reachable from a starting node.

**Implementations:**
- `benchmark_differential` - Differential Dataflow with iteration
- `benchmark_timely` - Timely Dataflow with feedback loops
- `benchmark_hydroflow_scheduled` - Hydro scheduled execution
- `benchmark_hydroflow` - Hydro dataflow
- `benchmark_hydroflow_surface` - Hydro surface syntax
- `benchmark_hydroflow_surface_cheating` - Optimized Hydro variant

**Use case:** Testing incremental computation and iterative algorithms

**Data:** Uses real graph data from included files:
- `reachability_edges.txt` - Edge list
- `reachability_reachable.txt` - Expected reachable nodes

## Hydro-Only Benchmarks

These benchmarks focus on specific Hydro features and don't include Timely/Differential comparisons:

### 9. **futures** (`futures.rs`)
Async/futures handling benchmarks.

**Implementations:**
- `benchmark_immediately_available` - Tests with ready futures
- `benchmark_delayed` - Tests with delayed futures

**Use case:** Testing async operation handling

### 10. **micro_ops** (`micro_ops.rs`)
Micro-benchmarks for individual Hydro operators.

**Operations tested:**
- `identity` - Identity operator
- `unique` - Deduplication
- `map` - Transformation
- `flat_map` - Flattening transformation
- `join` - Join operation
- `filter` - Filtering
- `union` - Stream union
- `cross_join` - Cross product

**Use case:** Measuring per-operator performance characteristics

### 11. **symmetric_hash_join** (`symmetric_hash_join.rs`)
Specialized hash join implementation benchmarks.

**Test cases:**
- `no_match` - Disjoint key sets
- `full_match` - Complete overlap
- `random` - Random distribution

**Use case:** Testing optimized join implementations

### 12. **words_diamond** (`words_diamond.rs`)
Diamond pattern with word processing from a real word list.

**Implementation:** Hydro-specific diamond pattern

**Data:** Uses `words_alpha.txt` (370,000+ English words)

**Use case:** Testing complex dataflow patterns with realistic data

## Running Performance Comparisons

### Compare Hydro vs Timely

Run a benchmark that includes both implementations:

```bash
# Run arithmetic benchmark (includes both Hydro and Timely)
cargo bench -p benches --bench arithmetic

# View detailed results
open target/criterion/arithmetic/report/index.html
```

### Compare Hydro vs Differential

Run the reachability benchmark:

```bash
# Run reachability benchmark (includes Hydro, Timely, and Differential)
cargo bench -p benches --bench reachability

# View detailed results
open target/criterion/reachability/report/index.html
```

### Filter by Framework

Run only specific framework implementations:

```bash
# Run only Timely implementations
cargo bench -p benches -- timely

# Run only Differential implementations
cargo bench -p benches -- differential

# Run only Hydro implementations
cargo bench -p benches -- dfir
```

## Interpreting Results

Criterion generates detailed reports including:
- **Mean execution time** - Average performance
- **Standard deviation** - Performance consistency
- **Throughput** - Operations per second
- **Comparison charts** - Visual performance comparison
- **Historical trends** - Performance over time

Results are saved to `target/criterion/` with HTML reports for each benchmark.

## Adding New Implementations

To add Timely or Differential implementations to existing benchmarks:

1. Add the implementation function following the naming convention:
   ```rust
   fn benchmark_timely(c: &mut Criterion) { ... }
   fn benchmark_differential(c: &mut Criterion) { ... }
   ```

2. Add to the criterion group:
   ```rust
   criterion_group!(
       my_benchmarks,
       benchmark_hydroflow,
       benchmark_timely,
       benchmark_differential,
   );
   ```

3. Document the new implementation in this file

## Performance Testing Workflow

1. **Establish Baseline**
   ```bash
   git checkout main
   cargo bench -p benches > baseline.txt
   ```

2. **Make Changes**
   ```bash
   git checkout feature-branch
   # Edit code in bigweaver-agent-canary-hydro-zeta
   ```

3. **Run Comparisons**
   ```bash
   cargo bench -p benches > feature.txt
   ```

4. **Analyze Results**
   - Compare console output
   - Review Criterion HTML reports
   - Look for performance regressions

## Key Performance Metrics

When comparing implementations, consider:

- **Throughput** - Items processed per second
- **Latency** - Time per operation
- **Memory usage** - Peak memory consumption
- **CPU utilization** - Processor efficiency
- **Scalability** - Performance with increased data

## Dependencies

The benchmarks depend on:
- `timely-master` (v0.13.0-dev.1) - For Timely Dataflow benchmarks
- `differential-dataflow-master` (v0.13.0-dev.1) - For Differential Dataflow benchmarks
- `dfir_rs` - Path dependency from main repository
- `sinktools` - Path dependency from main repository
- `criterion` - Benchmarking framework

## References

- [Timely Dataflow Documentation](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow Documentation](https://github.com/TimelyDataflow/differential-dataflow)
- [Criterion.rs Documentation](https://bheisler.github.io/criterion.rs/book/)
- [Main Repository](../bigweaver-agent-canary-hydro-zeta)
