# Timely and Differential-Dataflow Benchmarks

This repository contains benchmarks that depend on `timely` and `differential-dataflow` crates. These benchmarks were moved from the main `bigweaver-agent-canary-hydro-zeta` repository to avoid unnecessary dependencies in the core codebase.

## Purpose

These benchmarks enable performance comparisons between Hydro/dfir_rs implementations and their timely/differential-dataflow counterparts. By maintaining these benchmarks in a separate repository, we:

- Keep the main repository free from heavyweight dependencies (timely, differential-dataflow)
- Reduce build times for developers working on core functionality
- Maintain the ability to run performance comparisons when needed
- Provide a dedicated space for benchmarking against external dataflow systems

## Available Benchmarks

### Dataflow Pattern Benchmarks

1. **arithmetic.rs** - Arithmetic operations benchmark
   - Compares timely vs dfir_rs implementations
   - Tests basic mathematical transformations

2. **fan_in.rs** - Fan-in pattern benchmark
   - Tests multiple streams merging into one
   - Measures concatenation performance

3. **fan_out.rs** - Fan-out pattern benchmark
   - Tests one stream splitting into multiple
   - Measures distribution performance

4. **fork_join.rs** - Fork-join pattern benchmark
   - Tests splitting and rejoining streams
   - Measures coordination overhead

5. **identity.rs** - Identity transformation benchmark
   - Minimal overhead baseline measurement
   - Compares framework overhead

6. **join.rs** - Join operations benchmark
   - Tests binary join operations
   - Custom operator implementation

7. **upcase.rs** - String transformation benchmark
   - Tests map operations on strings
   - Uses words_alpha.txt dataset

8. **reachability.rs** - Graph reachability benchmark
   - Most comprehensive benchmark
   - Compares timely, differential, and multiple dfir_rs implementations
   - Uses graph data from reachability_edges.txt and reachability_reachable.txt

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p hydro-deps-benches
```

Run a specific benchmark:
```bash
cargo bench -p hydro-deps-benches --bench reachability
cargo bench -p hydro-deps-benches --bench arithmetic
```

Run benchmarks from the main repository:
```bash
# From bigweaver-agent-canary-hydro-zeta directory
cd ../bigweaver-agent-canary-zeta-hydro-deps
cargo bench -p hydro-deps-benches
```

## Data Files

- **words_alpha.txt** - English word list used by upcase benchmark
  - Source: https://github.com/dwyl/english-words/blob/master/words_alpha.txt
  
- **reachability_edges.txt** - Graph edges for reachability benchmark
  
- **reachability_reachable.txt** - Expected reachable nodes for verification

## Benchmark Output

Benchmarks use the Criterion framework and generate:
- HTML reports in `target/criterion/`
- Statistical analysis of performance
- Comparison against previous runs

## Dependencies

These benchmarks depend on:
- `timely` (timely-master 0.13.0-dev.1)
- `differential-dataflow` (differential-dataflow-master 0.13.0-dev.1)
- `dfir_rs` (from main hydro repository)
- `criterion` (for benchmark harness)

## Migration Information

These benchmarks were moved from `bigweaver-agent-canary-hydro-zeta/benches` to this repository to improve:
- Dependency management
- Build performance
- Repository modularity

For more information, see MIGRATION.md in the repository root.

## Contributing

When adding new benchmarks that compare against timely or differential-dataflow:
1. Place them in this repository
2. Add appropriate `[[bench]]` entries to Cargo.toml
3. Follow existing naming and structure conventions
4. Update this README with benchmark descriptions
