# bigweaver-agent-canary-zeta-hydro-deps

## Overview

This repository contains **timely-dataflow** and **differential-dataflow** benchmarks that have been separated from the main `bigweaver-agent-canary-hydro-zeta` repository. This separation allows for performance comparisons and testing without adding these dependencies to the main codebase.

### What's Included

This repository contains **only** the timely-dataflow and differential-dataflow implementations of the benchmarks. Other implementations (babyflow, spinachflow, hydroflow, baseline) remain in or have been moved to their appropriate repositories.

## Repository Structure

```
.
├── Cargo.toml                           # Workspace configuration
├── README.md                            # This file
├── scripts/
│   └── compare_benchmarks.sh           # Cross-repository benchmark comparison script
└── timely-differential-benches/
    ├── Cargo.toml                       # Benchmark package configuration
    ├── README.md                        # Benchmark documentation
    └── benches/                         # Benchmark implementations
        ├── arithmetic.rs
        ├── fan_in.rs
        ├── fan_out.rs
        ├── fork_join.rs
        ├── identity.rs
        ├── join.rs
        ├── reachability.rs
        ├── reachability_edges.txt       # Test data
        ├── reachability_reachable.txt   # Test data
        ├── upcase.rs
        └── zip.rs
```

## Dependencies

This repository includes only the essential dependencies for timely and differential-dataflow benchmarks:

- **timely-dataflow** (`timely = "0.12"`): A low-latency data-parallel dataflow system
- **differential-dataflow** (`differential-dataflow = "0.12"`): Incremental computation based on timely-dataflow
- **criterion** (`criterion = "0.3"`): Benchmarking framework with HTML report generation
- **lazy_static** (`lazy_static = "1.4.0"`): For loading test data files

All other framework dependencies (babyflow, spinachflow, hydroflow) have been removed to keep this repository focused solely on timely and differential-dataflow.

## Running Benchmarks

### Run All Benchmarks

```bash
cargo bench
```

### Run Specific Benchmark

```bash
cargo bench -p timely-differential-benches --bench <benchmark_name>
```

Available benchmarks:
- `arithmetic`
- `fan_in`
- `fan_out`
- `fork_join`
- `identity`
- `join`
- `reachability`
- `upcase`
- `zip`

### Cross-Repository Comparison

To compare performance between this repository and the main repository:

```bash
./scripts/compare_benchmarks.sh
```

This script will:
1. Run all timely/differential-dataflow benchmarks in this repository
2. Run any benchmarks in the main repository (if available)
3. Generate comparison reports

## Migration Notes

These benchmarks were migrated from the main `bigweaver-agent-canary-hydro-zeta` repository to:

1. **Separate dependencies**: Remove timely and differential-dataflow dependencies from the main codebase
2. **Maintain comparisons**: Allow performance comparisons between different dataflow implementations
3. **Reduce build time**: Avoid compiling these dependencies in the main repository
4. **Focused development**: Keep the main repository focused on its core functionality

## Development

### Building

```bash
cargo build
```

### Testing

```bash
cargo test
```

### Benchmarking

```bash
cargo bench
```

Results are saved in `target/criterion/` and can be viewed by opening `target/criterion/report/index.html` in a web browser.

## License

See the main repository for license information.