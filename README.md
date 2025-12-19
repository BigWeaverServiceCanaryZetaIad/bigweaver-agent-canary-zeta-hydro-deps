# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and performance comparison tests for timely-dataflow and differential-dataflow dependencies. These benchmarks were separated from the main `bigweaver-agent-canary-hydro-zeta` repository to isolate external dataflow dependencies.

## Contents

### Benchmarks (`benches/`)

Comparative benchmarks that measure performance across different dataflow implementations:

- **arithmetic.rs** - Arithmetic operation pipeline benchmarks
- **fan_in.rs** - Fan-in pattern benchmarks
- **fan_out.rs** - Fan-out pattern benchmarks  
- **fork_join.rs** - Fork-join parallelism benchmarks
- **identity.rs** - Identity/passthrough operation benchmarks
- **join.rs** - Join operation benchmarks
- **reachability.rs** - Graph reachability benchmarks (includes data files)
- **upcase.rs** - String transformation benchmarks

Each benchmark compares performance between:
- Timely dataflow implementation
- DFIR/Hydroflow implementation (from main repository)
- Baseline implementations (raw iterators, pipelines, etc.)

## Dependencies

These benchmarks depend on:
- **timely-dataflow** - A low-latency data-parallel dataflow system
- **differential-dataflow** - An implementation of differential dataflow
- **dfir_rs** (from main repository) - Referenced via git dependency

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p timely-differential-benches
```

Run specific benchmarks:
```bash
cargo bench -p timely-differential-benches --bench reachability
cargo bench -p timely-differential-benches --bench arithmetic
```

## Performance Comparison with Main Repository

To compare performance with the Hydroflow implementations in the main repository:

1. Ensure the main repository (`bigweaver-agent-canary-hydro-zeta`) is accessible at the git URL configured in `benches/Cargo.toml`
2. Run the benchmarks in this repository to measure timely/differential performance
3. The benchmarks automatically pull and compare against the DFIR/Hydroflow implementations from the main repository

Results will show comparative performance metrics across all implementations.

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── Cargo.toml                          # Workspace configuration
├── README.md                           # This file
└── benches/
    ├── Cargo.toml                      # Benchmark package configuration
    ├── benches/
    │   ├── arithmetic.rs
    │   ├── fan_in.rs
    │   ├── fan_out.rs
    │   ├── fork_join.rs
    │   ├── identity.rs
    │   ├── join.rs
    │   ├── reachability.rs
    │   ├── reachability_edges.txt      # Test data
    │   ├── reachability_reachable.txt  # Test data
    │   └── upcase.rs
    └── README.md
```

## Related Repositories

- [bigweaver-agent-canary-hydro-zeta](https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git) - Main Hydro/DFIR project

## Migration Notes

These benchmarks were migrated from the main `bigweaver-agent-canary-hydro-zeta` repository to:
1. Separate concerns between core Hydro development and external dataflow dependency benchmarks
2. Reduce compilation dependencies in the main repository
3. Allow independent versioning and benchmarking of timely/differential-dataflow

For historical context, see the git history in the main repository prior to the benchmark migration.