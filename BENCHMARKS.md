# Microbenchmarks

Performance benchmarks for Hydro comparing it with timely and differential-dataflow implementations.

## Overview

These benchmarks were moved from the main Hydro repository to avoid adding `timely` and `differential-dataflow` as dependencies to the core project. They remain fully functional and provide valuable performance comparisons.

## Running Benchmarks

### Run all benchmarks:
```bash
cargo bench
```

### Run specific benchmarks:
```bash
cargo bench --bench reachability
cargo bench --bench micro_ops
cargo bench --bench arithmetic
```

### View Results

After running benchmarks, detailed HTML reports are generated in:
```
target/criterion/
```

Open the `index.html` file in your browser to view interactive performance reports with charts and historical comparisons.

## Available Benchmarks

| Benchmark | Description |
|-----------|-------------|
| `arithmetic` | Tests arithmetic operation performance |
| `fan_in` | Tests fan-in pattern (multiple sources to single sink) |
| `fan_out` | Tests fan-out pattern (single source to multiple sinks) |
| `fork_join` | Tests fork-join patterns |
| `futures` | Tests futures-based async operations |
| `identity` | Tests identity/passthrough operations |
| `join` | Tests join operations |
| `micro_ops` | Tests various micro-operations |
| `reachability` | Tests graph reachability algorithms |
| `symmetric_hash_join` | Tests symmetric hash join implementation |
| `upcase` | Tests string processing (uppercase transformation) |
| `words_diamond` | Tests diamond pattern with word processing |

## Data Files

Some benchmarks include data files:

- `reachability_edges.txt` - Edge data for graph reachability benchmark
- `reachability_reachable.txt` - Expected reachable nodes for validation
- `words_alpha.txt` - English word list for word processing benchmarks

The word list is from: https://github.com/dwyl/english-words/blob/master/words_alpha.txt

## Performance Comparison Methodology

To compare Hydro performance against timely/differential-dataflow:

1. Each benchmark typically implements the same algorithm in multiple ways:
   - Using Hydro/DFIR
   - Using timely directly
   - Using differential-dataflow

2. Criterion automatically compares the implementations and reports:
   - Throughput (operations/second)
   - Latency (time per operation)
   - Statistical significance of differences
   - Performance trends over time

3. The benchmarks use consistent data sets and workloads for fair comparison

## Dependencies

These benchmarks depend on:
- `dfir_rs` - The core Hydro DFIR runtime
- `timely-master` - Timely dataflow library
- `differential-dataflow-master` - Differential dataflow library
- `criterion` - Benchmarking framework
- `sinktools` - Helper utilities

The `dfir_rs` and `sinktools` dependencies are pulled from the main Hydro repository via git dependencies.

## Contributing

When adding new benchmarks:

1. Add the benchmark file to `benches/`
2. Update `Cargo.toml` with a new `[[bench]]` section
3. Follow the existing pattern of implementing the same algorithm in multiple frameworks
4. Include appropriate data files if needed
5. Update this documentation

## More Information

- Main Hydro repository: https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta
- Migration guide: See BENCHMARK_MIGRATION.md in the main repository
- Hydro documentation: https://hydro.run

