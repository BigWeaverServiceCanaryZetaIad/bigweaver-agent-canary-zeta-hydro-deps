# Benchmark Details

This document provides detailed information about each benchmark in this repository, including what they measure, their implementations, and how to interpret results.

## Overview

All benchmarks in this repository compare dfir_rs (Hydro) implementations against timely and/or differential-dataflow implementations. They use the Criterion benchmarking framework for statistical rigor.

---

## arithmetic.rs

### Purpose
Measures performance of basic arithmetic operations in dataflow systems.

### Implementations Compared
1. **timely** - Uses timely dataflow operators
2. **dfir_rs/surface** - Uses dfir_rs surface syntax
3. **dfir_rs** - Uses dfir_rs runtime

### What It Tests
- Basic map operations
- Arithmetic transformations
- Dataflow overhead for simple operations

### Key Operations
- Integer arithmetic
- Stream transformations
- Operator composition

### Expected Performance
- Low latency for simple operations
- Minimal framework overhead
- Linear scaling with input size

---

## fan_in.rs

### Purpose
Tests multiple input streams merging into a single output stream.

### Implementations Compared
1. **timely** - Uses `Concatenate` operator
2. **dfir_rs** - Uses `union` operator

### What It Tests
- Stream concatenation performance
- Multiple input handling
- Merge operation overhead

### Key Operations
- Multiple `ToStream` sources
- Concatenation/union
- Single output collection

### Expected Performance
- Overhead proportional to number of inputs
- Good throughput for merging operations

---

## fan_out.rs

### Purpose
Tests single input stream distributing to multiple outputs.

### Implementations Compared
1. **timely** - Uses multiple map operations
2. **dfir_rs** - Uses tee operator with multiple outputs

### What It Tests
- Stream splitting performance
- Data distribution overhead
- Parallel output handling

### Key Operations
- Single input stream
- Multiple map/tee operations
- Parallel outputs

### Expected Performance
- Overhead proportional to number of outputs
- Each output should receive all data

---

## fork_join.rs

### Purpose
Tests splitting a stream, processing independently, then rejoining.

### Implementations Compared
1. **timely** - Uses filter and concatenate
2. **dfir_rs** - Uses dfir_rs operators

### What It Tests
- Stream splitting
- Independent processing paths
- Stream rejoining
- Coordination overhead

### Key Operations
- Filter operations
- Independent transformations
- Concatenation/union

### Expected Performance
- Higher latency than fan_in or fan_out alone
- Tests coordination between paths

---

## identity.rs

### Purpose
Baseline benchmark with minimal operations.

### Implementations Compared
1. **timely** - Simple pass-through
2. **dfir_rs** - Simple pass-through

### What It Tests
- Framework overhead
- Minimal operation latency
- Baseline for comparison

### Key Operations
- Identity map (input → output unchanged)
- Basic dataflow setup

### Expected Performance
- Lowest latency of all benchmarks
- Framework overhead comparison
- Reference point for other benchmarks

---

## join.rs

### Purpose
Tests binary join operations between two streams.

### Implementations Compared
1. **timely** - Uses custom `Operator` with `Pipeline` pact
2. **dfir_rs** - Uses `join` operator

### What It Tests
- Join operation performance
- Key-based stream correlation
- State management for joins

### Key Operations
- Two input streams with keys
- Join on matching keys
- Stateful operation

### Expected Performance
- Higher latency than simple operations
- Performance depends on:
  - Number of matching keys
  - Size of input streams
  - State management efficiency

---

## upcase.rs

### Purpose
Tests string transformation operations on real text data.

### Implementations Compared
1. **timely** - Basic uppercase transformation
2. **dfir_rs** - Multiple implementation styles

### What It Tests
- String operations in dataflow
- Map operations on real data
- Different transformation strategies

### Data
- Uses `words_alpha.txt` (English word list)
- Real-world text processing scenario

### Key Operations
- String loading
- Uppercase transformation
- Different implementation variants:
  - In-place transformation
  - Allocating transformation

### Expected Performance
- Performance varies by strategy:
  - In-place: Lower memory allocation
  - Allocating: More memory but potentially better cache usage

---

## reachability.rs

### Purpose
**Most comprehensive benchmark** - Tests graph reachability algorithms.

### Implementations Compared
1. **timely** - Iterative graph traversal
2. **differential** - Differential dataflow with iteration
3. **dfir_rs/scheduled** - Scheduled execution model
4. **dfir_rs** - Standard runtime
5. **dfir_rs/surface** - Surface syntax
6. **dfir_rs/surface_cheating** - Optimized surface version

### What It Tests
- Iterative computation
- Fixed-point iteration
- Graph algorithms
- State management across iterations
- Complex dataflow patterns

### Data
- `reachability_edges.txt` - Graph edge list
- `reachability_reachable.txt` - Expected results for verification

### Algorithm
Computes all nodes reachable from node 1 in a directed graph:
1. Start with root node (1)
2. Find all neighbors of current nodes
3. Add new nodes to reachable set
4. Repeat until no new nodes found (fixed point)

### Key Operations
- Iterative loops
- Join operations (nodes with edges)
- Distinct/deduplication
- State management (seen set)
- Fixed-point detection

### Expected Performance
- Most expensive benchmark
- Performance depends on:
  - Graph structure
  - Number of iterations to convergence
  - State management efficiency
- Differential dataflow may show benefits for incremental computation

### Performance Notes
- **timely**: Manual iteration with feedback loops
- **differential**: Automatic incremental maintenance
- **dfir_rs variants**: Different API styles, similar performance
- **surface_cheating**: Uses direct map access (non-dataflow)

---

## Interpreting Results

### Criterion Output

Criterion provides:
- **Mean time**: Average execution time
- **Std deviation**: Variability in measurements
- **Median**: Middle value (less affected by outliers)
- **Throughput**: Items processed per second (where applicable)

### HTML Reports

Generated in `target/criterion/<benchmark_name>/report/`:
- Violin plots showing distribution
- Change over time (if baseline exists)
- Statistical analysis

### Comparison Guidelines

When comparing implementations:

1. **Look at mean times** for typical performance
2. **Check std deviation** for consistency
3. **Consider throughput** for scalability
4. **Review change %** when comparing to baseline

### Expected Patterns

- **Simple operations** (identity, arithmetic): Framework overhead dominates
- **Complex operations** (join, reachability): Algorithm efficiency matters more
- **Timely vs dfir_rs**: Should be within same order of magnitude
- **Different dfir_rs styles**: Similar performance, different APIs

### Red Flags

⚠️ Large standard deviations (>10%) may indicate:
- System interference
- Timing issues
- Inconsistent warm-up

⚠️ Unexpected performance differences may indicate:
- Algorithm changes
- Dependency version changes
- System configuration changes

---

## Running Specific Benchmarks

```bash
# All benchmarks
cargo bench -p hydro-deps-benches

# Single benchmark
cargo bench -p hydro-deps-benches --bench reachability

# Specific function within benchmark
cargo bench -p hydro-deps-benches --bench reachability -- "timely"

# Save baseline for comparison
cargo bench -p hydro-deps-benches -- --save-baseline my-baseline

# Compare to baseline
cargo bench -p hydro-deps-benches -- --baseline my-baseline
```

---

## Contributing New Benchmarks

When adding benchmarks to this repository:

1. **Compare against timely/differential** - That's the purpose of this repo
2. **Follow naming conventions**:
   - Function: `benchmark_<implementation_name>`
   - Groups: Use `criterion_group!` and `criterion_main!`
3. **Include multiple implementations** when possible
4. **Document what you're testing** in comments
5. **Use appropriate data sizes** (not too large, not too small)
6. **Verify correctness** - Assert results match expected values
7. **Update this document** with benchmark details

### Benchmark Template

```rust
use criterion::{Criterion, criterion_group, criterion_main};

fn benchmark_timely(c: &mut Criterion) {
    c.bench_function("my_benchmark/timely", |b| {
        b.iter(|| {
            // timely implementation
        });
    });
}

fn benchmark_hydroflow(c: &mut Criterion) {
    c.bench_function("my_benchmark/dfir_rs", |b| {
        b.iter(|| {
            // dfir_rs implementation
        });
    });
}

criterion_group!(my_benchmark, benchmark_timely, benchmark_hydroflow);
criterion_main!(my_benchmark);
```

---

## References

- [Criterion.rs Documentation](https://bheisler.github.io/criterion.rs/book/)
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)
- [Hydro Project](https://github.com/hydro-project/hydro)
