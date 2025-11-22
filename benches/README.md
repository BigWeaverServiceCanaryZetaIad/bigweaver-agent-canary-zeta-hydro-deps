# Timely and Differential-Dataflow Benchmarks

Comparative microbenchmarks of Hydro with timely and differential-dataflow.

## Migration Notice

These benchmarks were migrated from the `bigweaver-agent-canary-hydro-zeta` repository to maintain separation of concerns and reduce dependencies in the main codebase. The benchmarks compare Hydro's performance with timely and differential-dataflow implementations.

## Prerequisites

This repository requires access to the main Hydro repository for `dfir_rs` and `sinktools` dependencies. Ensure you have cloned the `bigweaver-agent-canary-hydro-zeta` repository as a sibling directory:

```
/projects/
  ├── bigweaver-agent-canary-hydro-zeta/    # Main Hydro repository
  └── bigweaver-agent-canary-zeta-hydro-deps/    # This repository
```

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
# Graph reachability benchmark
cargo bench -p benches --bench reachability

# Identity/passthrough benchmark
cargo bench -p benches --bench identity

# Join operations benchmark
cargo bench -p benches --bench join
```

## Available Benchmarks

- `arithmetic` - Arithmetic operations comparing Hydro with timely
- `fan_in` - Fan-in pattern benchmark
- `fan_out` - Fan-out pattern benchmark
- `fork_join` - Fork-join pattern benchmark
- `futures` - Futures-based operations benchmark
- `identity` - Identity/passthrough operations benchmark
- `join` - Join operations benchmark
- `micro_ops` - Micro-operations benchmark
- `reachability` - Graph reachability benchmark
- `symmetric_hash_join` - Symmetric hash join benchmark
- `upcase` - String uppercase transformation benchmark
- `words_diamond` - Word processing diamond pattern benchmark

## Benchmark Data

- `reachability_edges.txt` - Graph edges data for reachability benchmark (533 KB)
- `reachability_reachable.txt` - Expected reachable nodes data (38 KB)
- `words_alpha.txt` - English wordlist from https://github.com/dwyl/english-words/blob/master/words_alpha.txt (3.9 MB)

## Performance Comparison

These benchmarks enable direct performance comparison between:
- **Hydro** (dfir_rs) implementations
- **Timely Dataflow** implementations
- **Differential Dataflow** implementations
- Baseline implementations (raw iterators, channels, etc.)

Each benchmark typically includes multiple variants to compare different approaches and frameworks.

## Development Notes

When running benchmarks:
1. Use release mode for accurate performance measurements
2. Close other applications to minimize interference
3. Results are saved in `target/criterion/` for historical comparison
4. HTML reports are generated in `target/criterion/*/report/index.html`

## Maintenance

These benchmarks are maintained separately from the main Hydro repository to:
- Keep the main repository focused on Hydro implementation
- Reduce build dependencies in the main repository
- Allow independent benchmark evolution and comparison studies
- Maintain cleaner dependency graphs

For issues or updates to these benchmarks, please coordinate with changes to the main `bigweaver-agent-canary-hydro-zeta` repository.
