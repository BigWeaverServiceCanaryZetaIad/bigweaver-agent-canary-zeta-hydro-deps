# bigweaver-agent-canary-zeta-hydro-deps

This repository contains performance benchmarks comparing Hydroflow with timely-dataflow and differential-dataflow.

## Overview

These benchmarks were moved from the main `bigweaver-agent-canary-hydro-zeta` repository to:
- Reduce dependency footprint in the main repository
- Enable independent development and versioning of performance benchmarks
- Provide optional performance testing (clone only when needed)
- Maintain faster CI/CD builds in the main repository

## Benchmarks

The following benchmarks compare Hydroflow implementations with timely-dataflow and/or differential-dataflow:

- **arithmetic**: Simple arithmetic operations pipeline
- **fan_in**: Multiple input streams merging
- **fan_out**: Single stream splitting to multiple outputs
- **fork_join**: Fork-join pattern evaluation
- **identity**: Identity operation (baseline)
- **join**: Join operations
- **reachability**: Graph reachability computation (includes differential-dataflow)
- **upcase**: String uppercase transformation

## Running Benchmarks

To run all benchmarks:
```bash
cargo bench
```

To run a specific benchmark:
```bash
cargo bench --bench <benchmark_name>
```

For example:
```bash
cargo bench --bench reachability
```

## Benchmark Reports

Criterion generates HTML reports in `target/criterion/`. Open `target/criterion/report/index.html` in a browser to view detailed performance comparisons.

## Dependencies

This repository requires:
- **hydroflow**: Main Hydroflow framework (referenced from the main repository)
- **timely-dataflow** (timely-master 0.13.0-dev.1)
- **differential-dataflow** (differential-dataflow-master 0.13.0-dev.1)
- **criterion**: Benchmarking framework with HTML reports

## Performance Comparison Capabilities

All benchmarks retain the ability to:
✅ Compare Hydroflow against timely-dataflow implementations  
✅ Compare Hydroflow against differential-dataflow implementations  
✅ Generate detailed performance reports with Criterion  
✅ Track performance trends over time  
✅ Run in CI/CD for automated performance monitoring  

## Migration

These benchmarks were migrated from `bigweaver-agent-canary-hydro-zeta` to this repository to maintain a cleaner separation of concerns and reduce the dependency burden on the main codebase.