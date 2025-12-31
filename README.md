# bigweaver-agent-canary-zeta-hydro-deps

This repository contains performance benchmarks and dependencies for the Hydro project that depend on external dataflow frameworks such as Timely Dataflow and Differential Dataflow.

## Purpose

The benchmarks in this repository allow for performance comparisons between DFIR (Hydro's dataflow system) and other established dataflow frameworks like Timely Dataflow and Differential Dataflow. By separating these benchmarks from the main Hydro repository, we avoid direct dependencies on external dataflow frameworks in the core codebase while maintaining the ability to run comprehensive performance comparisons.

## Structure

- `benches/` - Performance benchmarks comparing DFIR with Timely/Differential Dataflow
  - Contains microbenchmarks for various operations (reachability, joins, micro-ops, etc.)
  - Includes benchmarks for both DFIR and Timely/Differential Dataflow implementations

## Running the Benchmarks

### Prerequisites

This repository depends on the main `bigweaver-agent-canary-hydro-zeta` repository being available at `../bigweaver-agent-canary-hydro-zeta` (relative to this repository). The benchmarks use `dfir_rs` and `sinktools` from the main repository.

### Run All Benchmarks

```bash
cargo bench -p benches
```

### Run Specific Benchmarks

To run a specific benchmark, use:

```bash
cargo bench -p benches --bench <benchmark_name>
```

Available benchmarks:
- `reachability` - Graph reachability algorithms
- `join` - Join operations with different data types
- `micro_ops` - Micro-operations (map, flat_map, union, tee, fold, sort, etc.)
- `fork_join` - Fork-join patterns
- `identity` - Identity operations
- `arithmetic` - Arithmetic operations
- `fan_in` / `fan_out` - Fan-in and fan-out patterns
- `symmetric_hash_join` - Symmetric hash join operations
- `words_diamond` - Diamond pattern with word processing
- `upcase` - Uppercase transformation operations
- `futures` - Future-based async operations

### Examples

```bash
# Run reachability benchmarks
cargo bench -p benches --bench reachability

# Run join benchmarks
cargo bench -p benches --bench join

# Run micro-operations benchmarks
cargo bench -p benches --bench micro_ops
```

## Benchmark Results

Benchmark results are generated using [Criterion.rs](https://github.com/bheisler/criterion.rs) and include:
- Statistical analysis of performance
- HTML reports with graphs
- Comparison with previous runs to detect performance regressions

Results are typically stored in `target/criterion/` after running benchmarks.

## Dependencies

The benchmarks depend on:
- **dfir_rs** - Hydro's dataflow runtime (from main repository)
- **timely-master** - Timely Dataflow framework
- **differential-dataflow-master** - Differential Dataflow framework
- **criterion** - Statistical benchmarking library
- **sinktools** - Utility tools (from main repository)

## Data Files

The benchmarks include several data files for testing:
- `reachability_edges.txt` - Graph edges for reachability tests
- `reachability_reachable.txt` - Expected reachable nodes
- `words_alpha.txt` - English word list from [dwyl/english-words](https://github.com/dwyl/english-words/blob/master/words_alpha.txt)

## Contributing

When adding new benchmarks:
1. Add the benchmark implementation in `benches/benches/`
2. Register the benchmark in `benches/Cargo.toml` using `[[bench]]` sections
3. Ensure benchmarks work with both DFIR and comparison frameworks where applicable
4. Update this README with information about the new benchmark