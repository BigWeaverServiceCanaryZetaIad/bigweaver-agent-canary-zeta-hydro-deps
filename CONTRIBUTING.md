# Contributing to Hydro Dependencies

This repository contains benchmark code that depends on external dataflow frameworks (timely and differential-dataflow) for performance comparison with Hydro.

## Running Benchmarks

The benchmarks compare Hydro's performance against Timely Dataflow and Differential Dataflow.

### Run all benchmarks:
```bash
cargo bench -p benches
```

### Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench join
```

### Available benchmarks:
- `arithmetic` - Arithmetic operations pipeline
- `fan_in` - Multiple inputs merging
- `fan_out` - Single input splitting
- `fork_join` - Fork-join patterns
- `identity` - Identity transformations
- `join` - Join operations with different data types
- `micro_ops` - Micro-operations (map, flat_map, union, tee, fold, sort)
- `reachability` - Graph reachability algorithms
- `symmetric_hash_join` - Symmetric hash join operations
- `upcase` - String transformation operations
- `words_diamond` - Word processing diamond patterns
- `futures` - Futures-based operations

## Dependencies

This repository depends on the main Hydro repository for:
- `dfir_rs` - The DFIR runtime
- `sinktools` - Utility tools

These dependencies are referenced via relative paths (`../../bigweaver-agent-canary-hydro-zeta/`).

## Benchmark Results

Benchmark results are generated using [Criterion](https://github.com/bheisler/criterion.rs) and include:
- Statistical analysis with confidence intervals
- HTML reports in `target/criterion/`
- Performance comparisons between runs

## Notes

The benchmarks use data files included in the repository:
- `reachability_edges.txt` - Graph edges for reachability tests
- `reachability_reachable.txt` - Expected reachability results
- `words_alpha.txt` - English word list from https://github.com/dwyl/english-words/

## Commit Messages

Follow [Conventional Commits specification](https://www.conventionalcommits.org/) for all commits.
