# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and code that depend on timely and differential-dataflow, separated from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository.

## Purpose

This repository serves to:
- Isolate timely and differential-dataflow dependencies from the main codebase
- Reduce build times for core development in the main repository
- Maintain performance comparison capabilities with alternative dataflow implementations
- Provide reference implementations for benchmarking against established frameworks

## Structure

- **benches/** - Benchmarks that use timely/differential-dataflow for performance comparison with Hydro (dfir_rs) implementations

## Key Features

### Comprehensive Performance Comparison
Each benchmark includes multiple implementations:
- **Timely/Differential-Dataflow** - Reference implementations using established dataflow libraries
- **Hydro (dfir_rs)** - Hydro-native implementations
- **Raw Rust/Pipeline** - Baseline implementations for context

This multi-implementation approach enables:
- Direct performance comparison between frameworks
- Identification of optimization opportunities
- Validation of Hydro's performance characteristics

### Complete Benchmark Suite
The repository includes benchmarks covering various dataflow patterns:
- Data flow patterns (fan-in, fan-out, fork-join)
- Operations (arithmetic, identity, join)
- Text processing (upcase)
- Graph algorithms (reachability)

## Getting Started

To run benchmarks:
```bash
cd benches
cargo bench
```

To run specific benchmarks:
```bash
cargo bench --bench arithmetic  # Run arithmetic benchmark
cargo bench --bench reachability  # Run reachability benchmark
```

To run specific implementations within a benchmark:
```bash
cargo bench --bench arithmetic timely  # Only timely implementations
cargo bench --bench arithmetic dfir_rs  # Only Hydro implementations
```

See the [benches/README.md](benches/README.md) for more details on available benchmarks and usage.

## Dependencies

This repository depends on:
- **timely-master** and **differential-dataflow-master** - Core dataflow libraries for comparison
- **dfir_rs** and **sinktools** - Pulled from the main repository via git dependencies
- **criterion** - Benchmarking framework with HTML report generation

## Relationship to Main Repository

This repository complements the main bigweaver-agent-canary-hydro-zeta repository by:
- Maintaining functionality that requires external dataflow dependencies
- Keeping the main repository lean and focused on Hydro-native implementations
- Preserving the ability to run performance comparisons
- Providing reference implementations for validation

The separation allows the main repository to:
- Build faster without timely/differential-dataflow dependencies
- Focus on Hydro-specific development
- Reduce technical debt from external dependencies

While this repository provides the comparative benchmarks for performance analysis.

## Performance Comparison Workflow

1. Run benchmarks in this repository for timely/differential-dataflow baselines
2. Run benchmarks in the main repository for Hydro-native implementations
3. Compare results using criterion's generated HTML reports

See [benches/README.md](benches/README.md) for detailed instructions.