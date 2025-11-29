# Hydro Microbenchmarks

Performance benchmarks for Hydro comparing with Timely and Differential Dataflow.

## Overview

This repository contains benchmarks that were moved from the main `bigweaver-agent-canary-hydro-zeta` repository to keep the main repository free of timely and differential-dataflow dependencies. The benchmarks allow for performance comparisons between:
- Hydro (dfir_rs)
- Timely Dataflow
- Differential Dataflow

## Running Benchmarks

### Run all benchmarks:
```bash
cargo bench -p benches
```

### Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench join
```

### Available Benchmarks

- **arithmetic** - Basic arithmetic operations comparison
- **fan_in** - Multiple input streams merging
- **fan_out** - Stream splitting into multiple outputs
- **fork_join** - Fork-join pattern performance
- **futures** - Async futures-based operations
- **identity** - Simple identity transformation (baseline)
- **join** - Join operations between streams
- **micro_ops** - Micro-operations performance
- **reachability** - Graph reachability algorithm
- **symmetric_hash_join** - Symmetric hash join implementation
- **upcase** - String transformation (uppercase)
- **words_diamond** - Diamond pattern with word processing

## Benchmark Results

Results are generated in the `target/criterion` directory after running benchmarks. Open `target/criterion/report/index.html` in a browser to view detailed performance reports with graphs and statistics.

## Data Files

The benchmarks use several data files located in `benches/benches/`:
- `words_alpha.txt` - English word list from https://github.com/dwyl/english-words/
- `reachability_edges.txt` - Graph edge data for reachability tests
- `reachability_reachable.txt` - Expected reachability results

## Relationship to Main Repository

These benchmarks were originally part of the main `bigweaver-agent-canary-hydro-zeta` repository. They were moved here to:
1. Keep the main repository free of timely and differential-dataflow dependencies
2. Maintain performance comparison capabilities
3. Allow independent benchmarking without affecting the main codebase

The benchmarks still depend on `dfir_rs` and `sinktools` from the main repository via git dependencies.

## Dependencies

Key dependencies include:
- **criterion** - Benchmarking framework with statistics and HTML reports
- **dfir_rs** - Hydro's dataflow runtime (from main repository)
- **timely** - Timely Dataflow for comparison
- **differential-dataflow** - Differential Dataflow for comparison
- **sinktools** - Utility tools (from main repository)

## Contributing

When adding new benchmarks:
1. Create a new file in `benches/benches/` with your benchmark code
2. Add a corresponding `[[bench]]` entry in `Cargo.toml`
3. Follow the existing pattern using criterion and comparing across frameworks
4. Document what the benchmark measures and expected results

## Notes

- Benchmarks are compiled without harness (`harness = false`) to use criterion's framework
- Some benchmarks may take significant time to run due to large datasets
- The build script (`build.rs`) generates additional benchmark code at compile time
