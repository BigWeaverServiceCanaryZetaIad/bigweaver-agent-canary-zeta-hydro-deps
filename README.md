# bigweaver-agent-canary-zeta-hydro-deps

This repository contains performance benchmarks for Hydro, timely-dataflow, and differential-dataflow.

## Overview

This repository was created to separate performance benchmarks from the main Hydro repository, allowing:
- Reduced dependency footprint in the main Hydro repository
- Faster CI/CD builds without heavy benchmark dependencies
- Independent benchmark development and versioning
- Optional performance testing (clone only when needed)

## Repository Structure

```
benches/
├── Cargo.toml           # Benchmark project configuration
├── README.md            # Benchmark-specific documentation
├── build.rs             # Build script for generating test code
└── benches/             # Benchmark implementations
    ├── arithmetic.rs
    ├── fan_in.rs
    ├── fan_out.rs
    ├── fork_join.rs
    ├── futures.rs
    ├── identity.rs
    ├── join.rs
    ├── micro_ops.rs
    ├── reachability.rs
    ├── symmetric_hash_join.rs
    ├── upcase.rs
    ├── words_diamond.rs
    ├── reachability_edges.txt      # Test data
    ├── reachability_reachable.txt  # Test data
    └── words_alpha.txt             # Test data
```

## Prerequisites

To run these benchmarks, you need both repositories:

1. **This repository** (bigweaver-agent-canary-zeta-hydro-deps) - Contains the benchmarks
2. **Main Hydro repository** (bigweaver-agent-canary-hydro-zeta) - Contains dfir_rs and dependencies

The benchmarks reference dfir_rs and sinktools from the main Hydro repository using relative paths.

## Setup

Clone both repositories in the same parent directory:

```bash
cd /projects/sandbox
# Ensure you have both:
# - bigweaver-agent-canary-hydro-zeta
# - bigweaver-agent-canary-zeta-hydro-deps
```

## Running Benchmarks

Navigate to the benches directory:

```bash
cd /projects/sandbox/bigweaver-agent-canary-zeta-hydro-deps/benches
```

Run all benchmarks:
```bash
cargo bench
```

Run specific benchmarks:
```bash
cargo bench --bench reachability
cargo bench --bench arithmetic
cargo bench --bench join
```

## Benchmark Descriptions

### Core Benchmarks

- **arithmetic.rs** - Tests basic arithmetic operations across different frameworks
- **identity.rs** - Tests the overhead of identity transformations
- **fan_in.rs** - Tests many-to-one data flow patterns
- **fan_out.rs** - Tests one-to-many data flow patterns
- **fork_join.rs** - Tests parallel fork-join patterns
- **futures.rs** - Tests asynchronous operations integration

### Join Benchmarks

- **join.rs** - Tests standard two-way joins
- **symmetric_hash_join.rs** - Tests symmetric hash join performance
- **reachability.rs** - Tests graph reachability with joins (uses test data files)

### Complex Benchmarks

- **micro_ops.rs** - Comprehensive microbenchmark suite
- **words_diamond.rs** - Tests diamond-shaped dataflow patterns
- **upcase.rs** - Tests string transformation operations

## Performance Comparison

Each benchmark typically includes three implementations:
1. **Hydro (dfir_rs)** - The Hydro dataflow framework
2. **timely-dataflow** - Direct timely-dataflow implementation
3. **differential-dataflow** - Differential dataflow implementation

This allows for direct performance comparison across frameworks.

## Dependencies

The benchmarks depend on:
- `criterion` - Benchmarking framework
- `dfir_rs` - Hydro's dataflow runtime (from main repo)
- `sinktools` - Utility tools (from main repo)
- `timely-master` - Timely-dataflow framework
- `differential-dataflow-master` - Differential dataflow framework
- Various utility crates (futures, rand, tokio, etc.)

## Contributing

When adding new benchmarks:
1. Add the benchmark file to `benches/benches/`
2. Register it in `Cargo.toml` under `[[bench]]`
3. Include implementations for all three frameworks when possible
4. Update this README with a description
5. Ensure benchmarks can run independently

## Related Documentation

For more information about the benchmark migration and Hydro project:
- Main Hydro Repository: bigweaver-agent-canary-hydro-zeta
- Migration documentation: See BENCHMARK_MIGRATION.md in the main Hydro repository