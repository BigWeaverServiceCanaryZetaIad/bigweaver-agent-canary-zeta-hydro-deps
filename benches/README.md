# Timely and Differential-Dataflow Benchmarks

This repository contains benchmarks comparing Hydro/DFIR performance against Timely Dataflow and Differential Dataflow.

These benchmarks have been separated from the main Hydro repository to isolate the timely and differential-dataflow dependencies, reducing dependency conflicts and maintaining cleaner separation of concerns.

## Benchmarks

The following benchmarks compare Hydro/DFIR implementations against Timely/Differential implementations:

- **arithmetic** - Basic arithmetic operations
- **fan_in** - Multiple streams merging into one
- **fan_out** - Single stream splitting into multiple
- **fork_join** - Fork-join patterns with filtering
- **identity** - Identity transformation
- **join** - Join operations with different data types (usize, String)
- **reachability** - Graph reachability algorithm (Differential)
- **upcase** - String uppercase transformation

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench
```

Run a specific benchmark:
```bash
cargo bench --bench reachability
cargo bench --bench join
```

Run benchmarks for a specific pattern:
```bash
cargo bench --bench join -- "usize/usize"
```

## Requirements

These benchmarks require:
- Rust toolchain (see rust-toolchain.toml in the main Hydro repository)
- Criterion for benchmarking
- Timely and Differential-Dataflow dependencies (automatically fetched)

## Data Files

Some benchmarks use pre-generated data files:
- `reachability_edges.txt` - Graph edges for reachability benchmark
- `reachability_reachable.txt` - Expected reachable nodes for validation

## Integration with Main Repository

To reference these benchmarks from the main bigweaver-agent-canary-hydro-zeta repository, you can:

1. Clone this repository alongside the main repository
2. Run benchmarks from this directory
3. Compare results with the remaining non-timely/differential benchmarks in the main repository

For more information about Hydro and DFIR, see the main repository documentation.
