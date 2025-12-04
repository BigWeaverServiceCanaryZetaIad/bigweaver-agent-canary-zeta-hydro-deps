# Timely and Differential-Dataflow Benchmarks

Performance comparison benchmarks between Hydro and the [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow) and [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow) frameworks.

These benchmarks have been moved to this separate repository to avoid adding timely and differential-dataflow as dependencies to the main Hydro repository at [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta).

## Overview

This repository contains benchmarks that compare:
- **Timely Dataflow** implementations - Using the Timely Dataflow framework
- **Differential Dataflow** implementations - Using the Differential Dataflow framework (for incremental computation benchmarks)
- **Baseline implementations** - Raw Rust implementations for speed-of-light comparisons

The corresponding Hydro/DFIR implementations remain in the main repository, allowing for independent performance testing and comparison.

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench
```

Run a specific benchmark:
```bash
cargo bench --bench reachability
```

Run a specific benchmark variant:
```bash
cargo bench --bench reachability -- reachability/timely
cargo bench --bench reachability -- reachability/differential
```

## Available Benchmarks

- **arithmetic** - Basic arithmetic operations (additions) over streams
- **fan_in** - Multiple streams being concatenated into one
- **fan_out** - One stream being split and processed multiple ways
- **fork_join** - Fork and join pattern with filtering
- **identity** - Identity transformation (no-op passthrough)
- **join** - Stream join operations on keyed data
- **reachability** - Graph reachability using differential dataflow (includes both timely and differential implementations)
- **upcase** - String uppercase transformation

Each benchmark typically includes:
- A timely/differential implementation
- One or more baseline implementations (raw Rust, iterators, etc.)

## Performance Comparisons

To compare performance between Hydro and Timely/Differential implementations:

1. Run benchmarks in this repository for the timely/differential baseline:
   ```bash
   cargo bench
   ```

2. Run the corresponding Hydro benchmarks in the main repository at [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)

3. Compare the criterion HTML reports generated in `target/criterion/`
   - Reports include detailed performance metrics, graphs, and statistical analysis
   - Look for reports in `target/criterion/<benchmark_name>/report/index.html`

## Dependencies

This repository depends on:
- `timely` (timely-master package) - Timely Dataflow framework
- `differential-dataflow` (differential-dataflow-master package) - Differential Dataflow framework
- `criterion` - Benchmarking harness
- `seq-macro` - For compile-time loop unrolling in baseline benchmarks

## Repository Structure

```
.
├── Cargo.toml          # Package configuration with benchmark definitions
├── README.md           # This file
└── benches/            # Benchmark implementations
    ├── arithmetic.rs
    ├── fan_in.rs
    ├── fan_out.rs
    ├── fork_join.rs
    ├── identity.rs
    ├── join.rs
    ├── reachability.rs
    ├── reachability_edges.txt      # Test data for reachability
    ├── reachability_reachable.txt  # Expected output for reachability
    └── upcase.rs
```

## License

Apache-2.0 (same as the main Hydro repository)
