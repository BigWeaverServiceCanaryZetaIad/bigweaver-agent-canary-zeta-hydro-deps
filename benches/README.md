# Microbenchmarks

Performance benchmarks for Hydro/DFIR compared to other dataflow systems like Timely and Differential Dataflow.

## Purpose

These benchmarks compare the performance characteristics of DFIR (the Hydro runtime) against established dataflow systems. They help track performance improvements and identify optimization opportunities.

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
```

Generate HTML reports (located in `target/criterion`):
```bash
cargo bench -p benches -- --noplot
```

## Benchmark Categories

### Operator Benchmarks
- `arithmetic.rs` - Pipeline of arithmetic operations
- `identity.rs` - Identity/pass-through operations
- `micro_ops.rs` - Various micro-operations

### Pattern Benchmarks
- `fan_in.rs` - Multiple inputs merging to single output
- `fan_out.rs` - Single input splitting to multiple outputs
- `fork_join.rs` - Fork-join parallelism patterns

### Join Benchmarks
- `join.rs` - Basic join operations
- `symmetric_hash_join.rs` - Symmetric hash join performance

### Graph Benchmarks
- `reachability.rs` - Graph reachability computation (uses included test data)

### String Processing
- `upcase.rs` - String uppercasing operations
- `words_diamond.rs` - Diamond pattern on word processing

### Async Benchmarks
- `futures.rs` - Futures-based async performance

## Data Files

- `reachability_edges.txt` - Edge list for reachability benchmarks
- `reachability_reachable.txt` - Expected reachability results
- `words_alpha.txt` - English word list from https://github.com/dwyl/english-words/blob/master/words_alpha.txt

## Performance Comparison

These benchmarks enable performance comparisons across different implementations:
- Raw Rust implementation (baseline)
- DFIR/Hydro implementation
- Timely Dataflow implementation
- Differential Dataflow implementation (where applicable)

Results help guide optimization decisions and validate that Hydro maintains competitive performance.
