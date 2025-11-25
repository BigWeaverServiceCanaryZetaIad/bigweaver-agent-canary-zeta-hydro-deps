# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks for timely and differential-dataflow dependencies that were moved from the main `bigweaver-agent-canary-hydro-zeta` repository. By separating these benchmarks, we maintain clean separation of concerns and keep the main repository free from timely and differential-dataflow dependencies.

## Overview

This repository houses performance benchmarks that specifically test and compare the performance of dataflow patterns using timely and differential-dataflow packages. These benchmarks were originally part of the main hydro repository but were moved here to isolate dependencies and improve build times for the core project.

## Benchmarks

The following benchmarks are available:

### Timely Dataflow Benchmarks

- **arithmetic.rs** - Tests arithmetic operations through dataflow pipelines
- **fan_in.rs** - Benchmarks fan-in patterns where multiple streams merge
- **fan_out.rs** - Benchmarks fan-out patterns where streams split
- **fork_join.rs** - Tests fork-join patterns with parallel processing paths
- **identity.rs** - Benchmarks identity operations and basic dataflow overhead
- **join.rs** - Tests join operations between streams
- **upcase.rs** - String transformation benchmarks

### Differential Dataflow Benchmarks

- **reachability.rs** - Graph reachability algorithms using differential-dataflow operators

### Data Files

- **reachability_edges.txt** - Graph edge data for reachability benchmark
- **reachability_reachable.txt** - Expected reachable nodes for validation

## Running Benchmarks

### Run All Benchmarks

```bash
cargo bench
```

### Run Specific Benchmarks

```bash
cargo bench --bench arithmetic
cargo bench --bench fan_in
cargo bench --bench fan_out
cargo bench --bench fork_join
cargo bench --bench identity
cargo bench --bench join
cargo bench --bench reachability
cargo bench --bench upcase
```

### Run with Output

```bash
cargo bench --bench arithmetic -- --verbose
```

## Dependencies

This repository depends on:

- **timely** (timely-master 0.13.0-dev.1) - For timely dataflow operations
- **differential-dataflow** (differential-dataflow-master 0.13.0-dev.1) - For differential dataflow operations
- **dfir_rs** - Referenced from the main bigweaver-agent-canary-hydro-zeta repository
- **criterion** - For benchmark harness and reporting

## Performance Comparisons

These benchmarks are designed to compare performance across different dataflow implementations:

1. Raw Rust implementations (baseline)
2. Iterator-based approaches
3. Timely dataflow
4. Hydro/dfir_rs implementations

Results are generated in HTML format by Criterion and can be found in `target/criterion/` after running benchmarks.

## Repository Structure

```
.
├── Cargo.toml              # Package manifest with dependencies
├── README.md               # This file
├── BENCHMARK_GUIDE.md      # Detailed guide for running and interpreting benchmarks
├── MIGRATION_SUMMARY.md    # Details about migration from main repository
└── benches/                # Benchmark source files
    ├── arithmetic.rs
    ├── fan_in.rs
    ├── fan_out.rs
    ├── fork_join.rs
    ├── identity.rs
    ├── join.rs
    ├── reachability.rs
    ├── upcase.rs
    ├── reachability_edges.txt
    └── reachability_reachable.txt
```

## Related Repositories

- **bigweaver-agent-canary-hydro-zeta** - Main Hydro repository (required for dfir_rs and sinktools dependencies)

## Contributing

When adding new benchmarks:

1. Follow the existing benchmark structure using Criterion
2. Include comparison implementations where applicable (raw, timely, hydroflow)
3. Document the dataflow pattern being tested
4. Update this README with the new benchmark information

## References

- See `BENCHMARK_GUIDE.md` for detailed benchmarking instructions
- See `MIGRATION_SUMMARY.md` for information about the repository split
- See the main repository's `BENCHMARK_REMOVAL.md` for rationale behind the separation