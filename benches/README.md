# Timely and Differential-Dataflow Benchmarks

This directory contains microbenchmarks comparing performance between:
- Hydroflow (dfir_rs)
- Timely Dataflow
- Differential Dataflow
- Raw Rust implementations

## Overview

These benchmarks were moved from the main `bigweaver-agent-canary-hydro-zeta` repository to isolate dependencies on `timely` and `differential-dataflow` packages. This separation follows the team's architectural principle of maintaining clean dependency boundaries and reducing complexity in the main repository.

## Dependencies

The benchmarks depend on:
- **timely** (package: "timely-master", version: "0.13.0-dev.1")
- **differential-dataflow** (package: "differential-dataflow-master", version: "0.13.0-dev.1")
- **dfir_rs** (from main repository via git)
- **sinktools** (from main repository via git)

## Running Benchmarks

### Run All Benchmarks
```bash
cargo bench
```

### Run Specific Benchmark
```bash
cargo bench --bench reachability
cargo bench --bench arithmetic
cargo bench --bench join
```

### Quick Performance Comparison
Run a subset of benchmarks to quickly compare performance:
```bash
cargo bench --bench arithmetic --bench identity --bench join
```

## Available Benchmarks

The benchmarks are organized by dataflow patterns:

### Basic Operations
- **arithmetic**: Chain of arithmetic operations (add operations)
- **identity**: Simple pass-through operations
- **upcase**: String transformation operations

### Dataflow Patterns
- **fan_in**: Multiple inputs converging to one output
- **fan_out**: One input splitting to multiple outputs  
- **fork_join**: Fork and join pattern
- **join**: Join operations on two streams
- **symmetric_hash_join**: Symmetric hash join implementation

### Complex Workloads
- **reachability**: Graph reachability computation using differential dataflow
- **words_diamond**: Diamond-shaped dataflow on word processing
- **micro_ops**: Micro-operations benchmarks

### Async Operations
- **futures**: Async operations and futures handling

## Benchmark Data Files

Some benchmarks use pre-generated data files:
- `reachability_edges.txt`: Graph edges for reachability benchmark
- `reachability_reachable.txt`: Expected reachable nodes
- `words_alpha.txt`: English word list from https://github.com/dwyl/english-words/blob/master/words_alpha.txt

## Performance Comparison

Each benchmark typically compares multiple implementations:
1. **Raw Rust**: Baseline performance with minimal overhead
2. **Timely Dataflow**: Performance using timely dataflow primitives
3. **Differential Dataflow**: Performance using differential dataflow operators
4. **Hydroflow/dfir_rs**: Performance using the Hydroflow framework

This allows for direct performance comparison and helps track performance characteristics across different abstractions.

## Interpreting Results

Benchmark results are generated using Criterion.rs and include:
- Mean execution time
- Standard deviation
- Throughput measurements (where applicable)
- HTML reports (located in `target/criterion/`)

To view detailed HTML reports after running benchmarks:
```bash
open target/criterion/report/index.html
```

## Migration Notes

These benchmarks were moved from the main repository to maintain:
- ✅ **Reduced Dependency Complexity**: Isolates timely/differential dependencies
- ✅ **Faster Main Repository Builds**: Reduces compilation time for the main codebase
- ✅ **Independent Versioning**: Benchmark dependencies can evolve independently
- ✅ **Cleaner Architecture**: Maintains separation of concerns

## Contributing

When adding new benchmarks:
1. Place benchmark source files in `benches/` directory
2. Follow the existing naming conventions (lowercase with underscores)
3. Add the benchmark entry to `Cargo.toml` under `[[bench]]`
4. Include both baseline and comparative implementations
5. Document the benchmark purpose and expected behavior
6. Add any required data files to the `benches/` directory

## Running in CI/CD

For automated performance testing, use:
```bash
# Quick benchmark suite (faster, for CI)
cargo bench --bench arithmetic --bench identity --bench fan_in

# Full benchmark suite (comprehensive)
cargo bench
```

## Troubleshooting

### Long Compilation Times
The timely and differential-dataflow dependencies can take a while to compile. Consider:
- Using `cargo build --release` first to cache dependencies
- Running only specific benchmarks you're interested in

### Out of Memory
Some benchmarks (especially reachability) can use significant memory. If you encounter OOM errors:
- Close other applications
- Run benchmarks individually
- Adjust benchmark parameters if needed

## Related Documentation

- Main repository: `bigweaver-agent-canary-hydro-zeta`
- Benchmark removal documentation: `BENCHMARK_REMOVAL.md` in main repository
- Hydroflow documentation: https://docs.rs/dfir_rs/
