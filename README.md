# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks for performance testing of Hydro and related dataflow systems.

## Structure

- `benches/` - Benchmark workspace containing microbenchmarks comparing different dataflow frameworks

## Running Benchmarks

### Run all benchmarks:
```bash
cargo bench -p benches
```

### Run a specific benchmark:
```bash
cargo bench -p benches --bench <benchmark_name>
```

Available benchmarks:
- `arithmetic` - Basic arithmetic operations
- `fan_in` - Fan-in patterns
- `fan_out` - Fan-out patterns  
- `fork_join` - Fork-join patterns
- `futures` - Async/futures performance
- `identity` - Identity/passthrough operations
- `join` - Join operations
- `micro_ops` - Micro-operation benchmarks
- `reachability` - Graph reachability algorithms
- `symmetric_hash_join` - Symmetric hash join operations
- `upcase` - String transformation operations
- `words_diamond` - Diamond pattern with word processing

### Examples:
```bash
# Run identity benchmarks
cargo bench -p benches --bench identity

# Run reachability benchmarks
cargo bench -p benches --bench reachability
```

### Viewing Results

Benchmark results are automatically saved to `target/criterion/` with HTML reports that can be viewed in a browser.

## Dependencies

The benchmarks compare performance across multiple dataflow frameworks:
- **Hydro/DFIR** - The main dataflow framework being benchmarked
- **Timely Dataflow** - A mature dataflow system for comparison
- **Differential Dataflow** - An incremental dataflow computation framework
- **Criterion** - The benchmarking framework used for measurements

For more details about specific benchmarks, see the [benches/README.md](benches/README.md) file.