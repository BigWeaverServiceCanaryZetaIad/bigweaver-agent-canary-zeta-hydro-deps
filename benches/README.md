# Hydro Microbenchmarks

Microbenchmarks of Hydro and other crates that depend on timely and differential-dataflow.

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
```

## Benchmark Descriptions

- **arithmetic** - Tests basic arithmetic operations and dataflow patterns
- **fan_in** - Benchmarks fan-in communication patterns
- **fan_out** - Benchmarks fan-out communication patterns  
- **fork_join** - Tests fork-join parallelism patterns
- **futures** - Benchmarks async futures-based operations
- **identity** - Tests identity transformations for baseline performance
- **join** - Benchmarks join operations between streams
- **micro_ops** - Low-level micro-operations for granular performance analysis
- **reachability** - Graph reachability computation benchmarks
- **symmetric_hash_join** - Tests symmetric hash join algorithms
- **upcase** - String transformation benchmarks (uppercase operations)
- **words_diamond** - Diamond-shaped dataflow patterns with word processing

## Data Files

- `words_alpha.txt` - English word list from https://github.com/dwyl/english-words
- `reachability_edges.txt` - Graph edge data for reachability benchmarks
- `reachability_reachable.txt` - Expected reachability results for verification

## Build Process

The `build.rs` script generates code for certain benchmarks (e.g., fork_join patterns).

## Viewing Results

Criterion generates HTML reports in `target/criterion/`. Open the index.html files in a browser for detailed performance visualizations and statistical analysis.
