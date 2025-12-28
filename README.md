# Hydro Dependencies - Performance Comparison Benchmarks

This repository contains performance comparison benchmarks for Hydro (DFIR) against other dataflow frameworks, specifically Timely Dataflow and Differential Dataflow.

## Purpose

This repository was created to separate benchmarks that depend on external dataflow frameworks from the main Hydro repository. This separation:

- Reduces dependency sprawl in the main repository
- Isolates performance comparison code from core functionality
- Maintains the ability to benchmark Hydro against other frameworks
- Keeps the main repository focused on Hydro's core implementation

## Structure

```
benches/
├── Cargo.toml          # Benchmark dependencies including timely and differential-dataflow
├── build.rs            # Build script for generating benchmark code
└── benches/            # Benchmark implementations
    ├── arithmetic.rs
    ├── fan_in.rs
    ├── fan_out.rs
    ├── fork_join.rs
    ├── identity.rs
    ├── join.rs
    ├── reachability.rs
    ├── upcase.rs
    └── *.txt           # Data files for benchmarks
```

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
```

## Benchmarks Included

### Comparison Benchmarks
These benchmarks compare Hydro's performance against Timely Dataflow and/or Differential Dataflow:

- **arithmetic**: Basic arithmetic operations
- **fan_in**: Multiple input streams converging
- **fan_out**: Single stream splitting to multiple outputs
- **fork_join**: Fork-join pattern with filtering
- **identity**: Simple pass-through operations
- **join**: Join operations between streams
- **reachability**: Graph reachability algorithms (includes Differential Dataflow comparison)
- **upcase**: String transformation operations

## Related Repositories

- Main repository: [bigweaver-agent-canary-hydro-zeta](https://github.com/hydro-project/hydro)
  - Contains core Hydro implementation
  - Contains Hydro-only benchmarks (micro_ops, symmetric_hash_join, etc.)

## Data Sources

- Word list from: https://github.com/dwyl/english-words/blob/master/words_alpha.txt