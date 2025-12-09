# Hydro Performance Benchmarks

Comparative benchmarks of Hydro/DFIR against timely and differential-dataflow implementations.

## Running Benchmarks

### Run all benchmarks:
```bash
cargo bench -p benches
```

### Run specific benchmarks:
```bash
# Arithmetic operations
cargo bench -p benches --bench arithmetic

# Fan patterns
cargo bench -p benches --bench fan_in
cargo bench -p benches --bench fan_out

# Fork-join
cargo bench -p benches --bench fork_join

# Identity
cargo bench -p benches --bench identity

# Join operations
cargo bench -p benches --bench join

# Reachability (differential-dataflow)
cargo bench -p benches --bench reachability

# Micro operations
cargo bench -p benches --bench micro_ops

# Symmetric hash join
cargo bench -p benches --bench symmetric_hash_join

# String operations
cargo bench -p benches --bench upcase

# Words diamond
cargo bench -p benches --bench words_diamond

# Futures
cargo bench -p benches --bench futures
```

## Benchmark Descriptions

- **arithmetic** - Basic arithmetic operations comparison
- **fan_in** - Fan-in pattern (multiple inputs, single output)
- **fan_out** - Fan-out pattern (single input, multiple outputs)
- **fork_join** - Fork-join parallel pattern
- **futures** - Async futures operations
- **identity** - Identity transformation (passthrough)
- **join** - Join operations on streams
- **micro_ops** - Micro-level operations performance
- **reachability** - Graph reachability using differential-dataflow
- **symmetric_hash_join** - Symmetric hash join implementation
- **upcase** - String uppercase transformations
- **words_diamond** - Word processing diamond pattern

## Data Files

- **words_alpha.txt** - English word list from https://github.com/dwyl/english-words/blob/master/words_alpha.txt
- **reachability_edges.txt** - Graph edges for reachability benchmark
- **reachability_reachable.txt** - Expected reachability results

## Performance Comparison

These benchmarks compare:
- **DFIR** - Hydro's Dataflow Intermediate Representation
- **Timely** - Low-latency data-parallel dataflow
- **Differential** - Incremental data-parallel dataflow

Results show relative performance characteristics of each implementation for various dataflow patterns.
