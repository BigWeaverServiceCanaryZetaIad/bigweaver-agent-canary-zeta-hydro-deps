# Performance Comparison Benchmarks

These microbenchmarks compare Hydro (dfir_rs) performance with Timely Dataflow and Differential Dataflow.

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench join
```

## Benchmark Descriptions

### arithmetic.rs
Compares arithmetic operations across multiple implementations:
- Raw iteration
- Pipeline (channels + threads)
- Iterator chains
- Hydro (compiled and surface syntax)
- Timely Dataflow

Performs 20 operations on 1,000,000 integers.

### fan_in.rs
Tests merging multiple data streams into a single stream.
- Hydro implementation
- Timely Dataflow implementation

### fan_out.rs
Tests splitting a single data stream into multiple streams.
- Hydro implementation
- Timely Dataflow implementation

### fork_join.rs
Tests fork-join parallelism patterns with filtering.
- Hydro implementation (compiled and surface syntax)
- Timely Dataflow implementation

### identity.rs
Tests simple pass-through/identity transformations.
- Hydro implementation
- Timely Dataflow implementation

### join.rs
Tests join operations between two streams with various data types.
- Hydro implementation (multiple variants)
- Timely Dataflow implementation

Tests different join strategies and data layouts.

### reachability.rs
Graph reachability algorithm benchmark using real graph data.
- Hydro implementation (multiple variants including tick-based)
- Timely Dataflow implementation
- Differential Dataflow implementation

This is the most complex benchmark, testing iterative dataflow patterns.

### upcase.rs
String uppercasing operations on word lists.
- Hydro implementation
- Timely Dataflow implementation

Uses words_alpha.txt as test data.

## Test Data Files

- **reachability_edges.txt**: Graph edges for reachability benchmark
- **reachability_reachable.txt**: Expected reachable nodes
- **words_alpha.txt**: English word list for string operations

Wordlist is from https://github.com/dwyl/english-words/blob/master/words_alpha.txt

## Performance Comparison Guide

When interpreting results:
1. Compare similar implementations (e.g., Hydro compiled vs. Timely)
2. Consider overhead vs. throughput tradeoffs
3. Note that different systems have different optimization strategies
4. Surface syntax in Hydro may have different characteristics than compiled versions

## Cross-Repository Workflow

These benchmarks reference the main Hydro repository for:
- `dfir_rs` package (core Hydro implementation)
- `sinktools` package (utilities)

If you're developing Hydro:
1. Make changes in the main repository
2. Run these benchmarks to compare with timely/differential
3. Run benchmarks in the main repository for Hydro-only comparisons

## Build Configuration

The build.rs script generates code for some benchmarks (e.g., fork_join).
This ensures consistency in generated code structure across implementations.
