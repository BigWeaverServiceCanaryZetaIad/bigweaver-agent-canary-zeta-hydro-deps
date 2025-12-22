# bigweaver-agent-canary-zeta-hydro-deps

## Overview

This repository contains isolated timely-dataflow benchmarks that have been separated from the main `bigweaver-agent-canary-hydro-zeta` repository. This separation allows for performance comparisons without adding these dependencies to the main codebase.

## Repository Structure

```
.
├── Cargo.toml                           # Workspace configuration
├── README.md                            # This file
├── MIGRATION.md                         # Migration documentation
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
        └── upcase.rs
```

## Dependencies

This repository includes the following external dependencies:

- **timely-dataflow** (`timely`): A low-latency data-parallel dataflow system
- **differential-dataflow**: Incremental computation based on timely-dataflow
- **criterion**: Benchmarking framework
- Other supporting dependencies (lazy_static, rand, seq-macro, tokio)

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

### Cross-Repository Comparison

To compare performance between this repository and the main repository:

```bash
./scripts/compare_benchmarks.sh
```

This script will:
1. Run all timely/differential-dataflow benchmarks in this repository
2. Run benchmarks in the main repository (babyflow, hydroflow, spinachflow)
3. Generate comparison reports

## Migration Notes

These benchmarks were migrated from the main `bigweaver-agent-canary-hydro-zeta` repository to:

1. **Isolate dependencies**: Only timely-specific benchmark code is included here
2. **Maintain comparisons**: Allow performance comparisons between different dataflow implementations
3. **Reduce build time**: Avoid compiling these dependencies in the main repository
4. **Focused development**: Keep the main repository focused on its core functionality

**Important**: These benchmarks are **isolated** - they only test timely-dataflow implementations. The main repository retains benchmarks for babyflow, hydroflow, spinachflow, and baseline implementations.

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

## Benchmark Details

Each benchmark in this repository tests timely-dataflow's performance on specific patterns:

- **arithmetic**: Chain of arithmetic operations
- **fan_in**: Multiple inputs merging into one stream
- **fan_out**: One input fanning out to multiple outputs
- **fork_join**: Forking and joining streams with filtering
- **identity**: Identity operations (simple pass-through)
- **join**: Hash join operations on streams
- **reachability**: Graph reachability computation with feedback loops
- **upcase**: String manipulation operations

## License

See the main repository for license information.