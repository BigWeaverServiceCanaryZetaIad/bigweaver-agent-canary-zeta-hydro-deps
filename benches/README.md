# Comparative Benchmarks

Benchmarks comparing Hydro (dfir_rs) performance with timely-dataflow and differential-dataflow.

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench fan_in
cargo bench -p benches --bench fan_out
cargo bench -p benches --bench fork_join
cargo bench -p benches --bench identity
cargo bench -p benches --bench join
cargo bench -p benches --bench upcase
cargo bench -p benches --bench reachability
cargo bench -p benches --bench micro_ops
cargo bench -p benches --bench futures
cargo bench -p benches --bench symmetric_hash_join
cargo bench -p benches --bench words_diamond
```

## Available Benchmarks

### Timely Comparative Benchmarks
- **arithmetic** - Arithmetic operations comparing dfir_rs with timely
- **fan_in** - Fan-in dataflow pattern benchmark
- **fan_out** - Fan-out dataflow pattern benchmark
- **fork_join** - Fork-join pattern benchmark
- **identity** - Identity operation benchmark
- **join** - Hash join implementation benchmark
- **upcase** - String uppercase transformation benchmark

### Differential-Dataflow Comparative Benchmarks
- **reachability** - Graph reachability algorithm comparing dfir_rs, timely, and differential-dataflow

### Hydro-Specific Benchmarks
- **micro_ops** - Micro-operations performance benchmark
- **futures** - Futures and async operations benchmark
- **symmetric_hash_join** - Symmetric hash join implementation benchmark
- **words_diamond** - Word processing diamond pattern benchmark

## Notes

- Wordlist is from https://github.com/dwyl/english-words/blob/master/words_alpha.txt
- Graph data for reachability benchmark is included in this directory
- All benchmarks use Criterion for consistent measurement and reporting
- Benchmarks with multiple implementations compare performance across dfir_rs, timely, and differential-dataflow

## Dependencies

These benchmarks require:
- `timely-dataflow` - For timely implementations
- `differential-dataflow` - For differential implementations
- `dfir_rs` - From the main Hydro repository (referenced via relative path)
- `sinktools` - From the main Hydro repository (referenced via relative path)

## Performance Comparison

The benchmarks are structured to allow direct comparison:
1. Each benchmark may have multiple functions (e.g., `benchmark_dfir`, `benchmark_timely`, `benchmark_differential`)
2. Criterion generates comparison reports showing relative performance
3. HTML reports are generated in `target/criterion/` for detailed analysis
4. Results can be tracked over time to detect regressions

## Adding New Benchmarks

To add a new comparative benchmark:
1. Create a new `.rs` file in this directory
2. Implement benchmark variants for the systems you want to compare
3. Add a `[[bench]]` entry in `Cargo.toml`
4. Use `criterion` with the `harness = false` configuration
5. Follow naming conventions: `benchmark_<system>` for each variant
