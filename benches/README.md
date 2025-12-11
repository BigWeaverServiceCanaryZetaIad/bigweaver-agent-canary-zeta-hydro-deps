# Timely/Differential-Dataflow Benchmarks

This repository contains benchmarks comparing Hydro/DFIR performance with timely-dataflow and differential-dataflow implementations.

These benchmarks have been separated from the main `bigweaver-agent-canary-hydro-zeta` repository to:
- Keep the main repository free of timely/differential-dataflow dependencies
- Maintain a clean dependency graph for the core Hydro project
- Enable performance comparisons when needed without affecting the main build

## Running Benchmarks

Run all benchmarks:
```bash
cd benches
cargo bench
```

Run a specific benchmark:
```bash
cd benches
cargo bench --bench reachability
cargo bench --bench arithmetic
cargo bench --bench join
```

Run with specific worker threads:
```bash
cd benches
cargo bench --bench reachability -- --workers 4
```

## Available Benchmarks

### Timely-Dataflow Benchmarks
- `arithmetic` - Simple arithmetic operations
- `fan_in` - Multiple inputs merging
- `fan_out` - Single input splitting to multiple outputs
- `fork_join` - Fork-join pattern
- `identity` - Pass-through operation
- `join` - Join operation
- `upcase` - String transformation

### Differential-Dataflow Benchmarks
- `reachability` - Graph reachability computation

## Performance Comparison

To compare Hydro/DFIR performance with timely/differential-dataflow:

1. Run the benchmarks in this repository to get baseline timely/differential numbers
2. Run equivalent benchmarks in the main `bigweaver-agent-canary-hydro-zeta` repository
3. Compare the results from both runs

The benchmark results are saved as HTML reports in `target/criterion/` directory for detailed analysis.

## Dependencies

This repository depends on:
- `dfir_rs` from the main Hydro repository
- `sinktools` from the main Hydro repository  
- `timely-dataflow` and `differential-dataflow` for comparison benchmarks

The dependencies on the main repository are configured to pull from git, ensuring the latest stable version is used for fair comparisons.
