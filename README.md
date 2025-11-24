# Timely and Differential-Dataflow Benchmarks

This repository contains performance benchmarks comparing Hydroflow/DFIR with Timely and Differential-Dataflow frameworks.

## Overview

These benchmarks were moved from the main `bigweaver-agent-canary-hydro-zeta` repository to:
- Maintain a cleaner main codebase focused on core Hydro functionality
- Isolate dependencies on `timely` and `differential-dataflow` frameworks
- Enable independent performance testing and comparison
- Reduce build times for the main repository

## Running Benchmarks

### Run All Benchmarks

```bash
cargo bench
```

### Run Specific Benchmarks

```bash
# Run a single benchmark
cargo bench --bench reachability

# Run benchmarks matching a pattern
cargo bench --bench arithmetic

# Run quick benchmarks (fewer iterations)
cargo bench -- --quick
```

### Available Benchmarks

The following benchmarks are available for performance comparison:

- **arithmetic**: Arithmetic operation benchmarks
- **fan_in**: Fan-in pattern benchmarks
- **fan_out**: Fan-out pattern benchmarks
- **fork_join**: Fork-join pattern benchmarks
- **identity**: Identity operation benchmarks
- **upcase**: String case transformation benchmarks
- **join**: Join operation benchmarks
- **reachability**: Graph reachability benchmarks
- **micro_ops**: Micro-operation benchmarks
- **symmetric_hash_join**: Symmetric hash join benchmarks
- **words_diamond**: Word processing diamond pattern benchmarks
- **futures**: Async futures benchmarks

## Performance Comparison

Each benchmark typically includes implementations for:
- **Raw Rust**: Baseline performance with minimal overhead
- **Hydroflow/DFIR**: The Hydro dataflow implementation
- **Timely**: Timely dataflow framework implementation
- **Differential-Dataflow**: Differential dataflow framework implementation

This allows for direct performance comparison between different dataflow approaches.

## Dependencies

This repository depends on:
- **dfir_rs** and **sinktools**: Referenced from the main Hydro repository
- **timely** and **differential-dataflow**: For comparative benchmarking
- **criterion**: For benchmark harness and reporting

### Using Local Development Versions

For local development, you can modify `Cargo.toml` to use a local path:

```toml
dfir_rs = { path = "../bigweaver-agent-canary-hydro-zeta/dfir_rs", features = [ "debugging" ] }
sinktools = { path = "../bigweaver-agent-canary-hydro-zeta/sinktools" }
```

## Benchmark Results

Benchmark results are generated in the `target/criterion` directory and include:
- HTML reports with visualizations
- Statistical analysis of performance
- Comparison with previous runs

## Data Files

Some benchmarks use data files located in the `benches/` directory:
- `words_alpha.txt`: Word list from https://github.com/dwyl/english-words/blob/master/words_alpha.txt
- `reachability_edges.txt`: Graph edges for reachability testing
- `reachability_reachable.txt`: Expected reachable nodes

## Contributing

When adding new benchmarks:
1. Add the benchmark file to `benches/`
2. Register it in `Cargo.toml` under `[[bench]]`
3. Include implementations for multiple frameworks when possible
4. Document the benchmark purpose and expected behavior
5. Update this README with the new benchmark information

## License

Apache-2.0
