# Hydro Reference Benchmarks (Timely & Differential-Dataflow)

This repository contains reference benchmarks comparing Hydro's DFIR with timely-dataflow and differential-dataflow implementations. These benchmarks were separated from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to isolate the timely and differential-dataflow dependencies.

## Purpose

This repository maintains performance comparison benchmarks that help:
- Validate DFIR's performance characteristics against established dataflow systems
- Track performance improvements over time
- Provide reference implementations for common patterns
- Maintain historical context for design decisions

## Repository Structure

```
benches/
├── benches/
│   ├── arithmetic.rs          # Arithmetic operations benchmark
│   ├── fan_in.rs              # Fan-in pattern benchmark
│   ├── fan_out.rs             # Fan-out pattern benchmark
│   ├── fork_join.rs           # Fork-join pattern benchmark
│   ├── identity.rs            # Identity operation benchmark
│   ├── join.rs                # Join operation benchmark
│   ├── reachability.rs        # Graph reachability benchmark
│   ├── upcase.rs              # String uppercase benchmark
│   ├── reachability_edges.txt # Test data for reachability
│   ├── reachability_reachable.txt # Expected results
│   └── words_alpha.txt        # Word list for benchmarks
└── Cargo.toml
```

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p hydro-zeta-reference-benches
```

Run specific benchmarks:
```bash
cargo bench -p hydro-zeta-reference-benches --bench reachability
cargo bench -p hydro-zeta-reference-benches --bench join
cargo bench -p hydro-zeta-reference-benches --bench arithmetic
```

## Benchmark Descriptions

### Core Pattern Benchmarks

- **arithmetic** - Tests arithmetic operations across dataflow systems
- **fan_in** - Measures performance of merging multiple streams
- **fan_out** - Measures performance of broadcasting to multiple consumers
- **fork_join** - Tests parallel split-compute-merge patterns
- **identity** - Baseline benchmark for data flow overhead
- **upcase** - String transformation benchmark

### Advanced Benchmarks

- **join** - Relational join operations performance
- **reachability** - Graph traversal and reachability computation

## Performance Comparison

Each benchmark typically includes implementations for:
- **Timely-dataflow** - The underlying dataflow framework
- **Differential-dataflow** - Incremental computation framework
- **DFIR** (in main repo) - Hydro's declarative dataflow runtime

To compare DFIR benchmarks with these reference implementations, run the DFIR benchmarks in the main repository:

```bash
cd ../bigweaver-agent-canary-hydro-zeta
cargo bench -p benches
```

## Dependencies

This repository depends on:
- `timely-master` (0.13.0-dev.1) - Core dataflow framework
- `differential-dataflow-master` (0.13.0-dev.1) - Incremental computation
- `criterion` (0.5.0) - Benchmarking framework

## Migration History

These benchmarks were moved from the main Hydro repository to:
1. Remove timely/differential-dataflow dependencies from the core codebase
2. Simplify the main repository's dependency tree
3. Maintain clear separation between DFIR-native code and reference implementations
4. Preserve historical performance comparison data

For more details, see MIGRATION.md.

## Related Repositories

- [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) - Main Hydro repository with DFIR-native benchmarks

## License

Apache-2.0