# Microbenchmarks

Performance benchmarks comparing Hydro (dfir_rs) with timely and differential-dataflow.

**Note**: These benchmarks were moved from the main [hydro repository](https://github.com/hydro-project/hydro) 
to this separate repository to isolate timely and differential-dataflow dependencies.

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench
```

Run specific benchmarks:
```bash
cargo bench --bench reachability
cargo bench --bench arithmetic
cargo bench --bench join
```

Run only timely/differential-dataflow benchmarks:
```bash
# Benchmarks that use timely
cargo bench --bench arithmetic
cargo bench --bench fan_in
cargo bench --bench fan_out
cargo bench --bench fork_join
cargo bench --bench identity
cargo bench --bench join
cargo bench --bench upcase

# Benchmark that uses differential-dataflow
cargo bench --bench reachability
```

## Benchmark Categories

### Timely Dataflow Benchmarks
- `arithmetic` - Arithmetic operations comparison
- `fan_in` - Fan-in pattern performance
- `fan_out` - Fan-out pattern performance  
- `fork_join` - Fork-join pattern performance
- `identity` - Identity operation performance
- `join` - Join operation performance
- `upcase` - String uppercase transformation

### Differential Dataflow Benchmarks
- `reachability` - Graph reachability computation

### Hydro-only Benchmarks
- `futures` - Futures handling performance
- `micro_ops` - Micro-operation benchmarks
- `symmetric_hash_join` - Symmetric hash join performance
- `words_diamond` - Word processing diamond pattern

## Data Files

- Wordlist: https://github.com/dwyl/english-words/blob/master/words_alpha.txt
- Reachability edges: `benches/reachability_edges.txt`
- Reachability reachable nodes: `benches/reachability_reachable.txt`

## Performance Comparison

These benchmarks enable performance comparisons between:
- Hydro (dfir_rs) implementations
- Timely dataflow implementations
- Differential dataflow implementations
- Raw Rust implementations

This allows tracking relative performance improvements and identifying optimization opportunities.
