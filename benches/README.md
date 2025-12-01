# Hydro Performance Benchmarks

This directory contains performance benchmarks comparing Hydroflow/DFIR implementations with equivalent timely-dataflow and differential-dataflow implementations.

## Purpose

These benchmarks help:
- Compare performance between Hydroflow/DFIR and timely/differential-dataflow
- Identify performance regressions
- Validate optimization efforts
- Guide architectural decisions

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench
```

Run specific benchmarks:
```bash
cargo bench --bench arithmetic
cargo bench --bench reachability
cargo bench --bench join
```

Run benchmarks matching a pattern:
```bash
cargo bench arithmetic
```

## Available Benchmarks

| Benchmark | Description |
|-----------|-------------|
| `arithmetic` | Basic arithmetic operations comparing raw, pipeline, timely, and DFIR |
| `fan_in` | Fan-in aggregation patterns |
| `fan_out` | Fan-out distribution patterns |
| `fork_join` | Fork-join parallelism |
| `futures` | Async futures handling |
| `identity` | Identity transformation (baseline overhead) |
| `join` | Join operations |
| `micro_ops` | Micro-operations (map, filter, etc.) |
| `reachability` | Graph reachability computation |
| `symmetric_hash_join` | Symmetric hash join implementation |
| `upcase` | String transformation operations |
| `words_diamond` | Diamond pattern with word processing |

## Interpreting Results

Criterion generates HTML reports in `target/criterion/`. After running benchmarks, open:
```
target/criterion/report/index.html
```

Lower numbers (time/throughput) are better. Pay attention to:
- Mean execution time
- Standard deviation (consistency)
- Throughput (operations per second)

## Data Files

- `words_alpha.txt` - English word list from [dwyl/english-words](https://github.com/dwyl/english-words/blob/master/words_alpha.txt)
- `reachability_edges.txt` - Graph edges for reachability benchmark
- `reachability_reachable.txt` - Expected reachable nodes

## Dependencies

These benchmarks require heavyweight dependencies:
- `timely-master` (timely-dataflow)
- `differential-dataflow-master`
- `dfir_rs` (from main Hydro repository)
- `sinktools` (from main Hydro repository)

The main Hydro repository no longer includes these dependencies to reduce build times and dependency footprint for core development.

## Contributing

When adding new benchmarks:
1. Create a new `.rs` file in `benches/`
2. Add corresponding `[[bench]]` entry in `Cargo.toml`
3. Follow existing benchmark structure and naming conventions
4. Include both Hydroflow/DFIR and timely/differential implementations for comparison
5. Document the benchmark purpose and expected results
