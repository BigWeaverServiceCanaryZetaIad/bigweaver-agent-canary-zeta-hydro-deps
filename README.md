# bigweaver-agent-canary-zeta-hydro-deps

This repository contains performance benchmarks for timely and differential-dataflow packages.

## Overview

The benchmarks have been separated from the main codebase to maintain clean separation of concerns and avoid unnecessary dependencies in the main repository while preserving performance comparison capabilities.

## Benchmarks

The `benches/` directory contains benchmark suite for performance testing, including:

- **upcase.rs**: Timely dataflow operators for string transformations
- **fork_join.rs**: Timely operators for branching and joining data streams  
- **reachability.rs**: Differential-dataflow operators for graph reachability
- Additional benchmarks for comprehensive performance testing

## Running Benchmarks

**Note**: These benchmarks have dependencies on `dfir_rs` and `sinktools` packages from the main bigweaver-agent-canary-hydro-zeta repository. To run these benchmarks, you'll need to ensure those dependencies are available.

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
```

## Dependencies

The benchmarks use:
- `timely-master` (v0.13.0-dev.1)
- `differential-dataflow-master` (v0.13.0-dev.1)
- `dfir_rs` (from bigweaver-agent-canary-hydro-zeta)
- `sinktools` (from bigweaver-agent-canary-hydro-zeta)