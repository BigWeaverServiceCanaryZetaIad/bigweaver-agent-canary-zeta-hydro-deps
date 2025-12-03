# Benchmark Files

This directory contains the individual benchmark implementations comparing Hydro (dfir_rs) with Timely Dataflow and Differential Dataflow.

## Available Benchmarks

### Dataflow Pattern Benchmarks
- **identity.rs**: Identity/passthrough operations (baseline performance)
- **fan_in.rs**: Multiple inputs converging to single output
- **fan_out.rs**: Single input splitting to multiple outputs
- **fork_join.rs**: Parallel processing with fork-join pattern

### Operation Benchmarks
- **arithmetic.rs**: Arithmetic operations across dataflow systems
- **upcase.rs**: String transformation operations
- **micro_ops.rs**: Micro-benchmarks of individual operations
- **futures.rs**: Async/futures-based operations

### Join Benchmarks
- **join.rs**: General join operations between streams
- **symmetric_hash_join.rs**: Symmetric hash join implementations

### Complex Benchmarks
- **reachability.rs**: Graph reachability algorithms
- **words_diamond.rs**: Word processing with diamond-shaped dataflow

## Test Data Files

- **words_alpha.txt**: Word list from https://github.com/dwyl/english-words/blob/master/words_alpha.txt
- **reachability_edges.txt**: Graph edges for reachability benchmarks
- **reachability_reachable.txt**: Expected reachability results

## Running Benchmarks

From the repository root:

```bash
# Run all benchmarks
cargo bench

# Run specific benchmark
cargo bench --bench reachability

# Run benchmarks matching a filter
cargo bench --bench identity -- dfir
```

See the main [README.md](../README.md) and [BENCHMARKS_GUIDE.md](../BENCHMARKS_GUIDE.md) for detailed instructions.
