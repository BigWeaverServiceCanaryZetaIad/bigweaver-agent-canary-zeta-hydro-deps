# Microbenchmarks

Performance benchmarks comparing Hydro/DFIR with Timely Dataflow and Differential Dataflow implementations.

## Quick Reference

### Run All Benchmarks
```bash
cargo bench -p benches
```

### Run Benchmarks by Framework
```bash
# Hydro/DFIR implementations
cargo bench -p benches -- dfir

# Timely Dataflow implementations
cargo bench -p benches -- timely

# Differential Dataflow implementations
cargo bench -p benches -- differential
```

### Run Specific Benchmarks
```bash
# Graph algorithms (includes Timely + Differential)
cargo bench -p benches --bench reachability

# Pipeline operations (includes Timely)
cargo bench -p benches --bench arithmetic

# Stream patterns (includes Timely)
cargo bench -p benches --bench fan_in
cargo bench -p benches --bench fan_out
cargo bench -p benches --bench fork_join
```

## Benchmark Categories

### 📊 Core Operation Benchmarks (with Timely)
- `arithmetic` - Sequential map operations
- `identity` - Minimal transformation overhead
- `join` - Stream join operations
- `upcase` - String transformations

### 🔀 Flow Pattern Benchmarks (with Timely)
- `fan_in` - Multiple streams merge to one
- `fan_out` - One stream splits to multiple
- `fork_join` - Parallel branches with merge

### 🔄 Iterative Benchmarks (with Timely + Differential)
- `reachability` - Graph reachability with incremental computation

### ⚡ Hydro-Specific Benchmarks
- `futures` - Async operation handling
- `micro_ops` - Individual operator performance
- `symmetric_hash_join` - Optimized join variants
- `words_diamond` - Complex dataflow patterns

## Data Files

- `words_alpha.txt` - English word list (370K+ words)
  - Source: https://github.com/dwyl/english-words/blob/master/words_alpha.txt
  - Used by: `words_diamond` benchmark

- `reachability_edges.txt` - Graph edge list
  - Used by: `reachability` benchmark

- `reachability_reachable.txt` - Expected reachable nodes
  - Used by: `reachability` benchmark validation

## Output

Benchmark results are saved to:
- **Console**: Statistical summary with comparisons
- **HTML Reports**: `target/criterion/*/report/index.html`
- **Historical Data**: `target/criterion/*/base/` for tracking trends

## Performance Comparison

These benchmarks enable direct performance comparisons between:
- **Hydro/DFIR** - The framework under development
- **Timely Dataflow** - Low-level dataflow baseline
- **Differential Dataflow** - Incremental computation

Use these to validate that Hydro optimizations maintain or improve performance relative to established frameworks.

## More Information

See [BENCHMARK_IMPLEMENTATIONS.md](../BENCHMARK_IMPLEMENTATIONS.md) for detailed documentation of each benchmark's implementations.
