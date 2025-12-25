# bigweaver-agent-canary-zeta-hydro-deps

## Overview

This repository contains benchmarks and code that depend on Timely Dataflow and Differential Dataflow. These components were extracted from the main `bigweaver-agent-canary-hydro-zeta` repository to isolate dependencies and enable independent performance comparisons between Hydro and other dataflow frameworks.

## Contents

### Benchmarks (`benches/`)

Performance comparison benchmarks between:
- **Hydro (DFIR)**: The Dataflow Intermediate Representation used by the Hydro framework
- **Timely Dataflow**: Low-latency cyclic dataflow computational model
- **Differential Dataflow**: Incremental data processing framework

See [benches/README.md](benches/README.md) for detailed information on running benchmarks and comparing performance.

## Quick Start

### Run All Benchmarks
```bash
cargo bench
```

### Run Specific Benchmark
```bash
cargo bench --bench reachability
cargo bench --bench arithmetic
```

## Performance Comparison Workflow

To compare Hydro performance against Timely/Differential:

1. **Run timely/differential benchmarks** (this repository):
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps
   cargo bench -p timely-differential-benches
   ```

2. **Run Hydro-only benchmarks** (main repository):
   ```bash
   cd bigweaver-agent-canary-hydro-zeta
   cargo bench -p benches
   ```

3. **Compare results**: Criterion generates HTML reports in `target/criterion/` with detailed performance metrics and visualizations.

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── benches/                    # Benchmark package
│   ├── benches/               # Individual benchmark files
│   │   ├── arithmetic.rs      # Pipeline arithmetic operations
│   │   ├── fan_in.rs          # Multiple input merging
│   │   ├── fan_out.rs         # Stream splitting
│   │   ├── fork_join.rs       # Fork-join patterns
│   │   ├── identity.rs        # Pass-through operations
│   │   ├── join.rs            # Stream joins
│   │   ├── reachability.rs    # Graph reachability algorithms
│   │   ├── upcase.rs          # String transformations
│   │   └── *.txt              # Test data files
│   ├── Cargo.toml             # Benchmark dependencies
│   ├── build.rs               # Build script
│   └── README.md              # Benchmark documentation
├── Cargo.toml                 # Workspace configuration
└── README.md                  # This file
```

## Dependencies

### Core Dependencies
- `timely-master`: v0.13.0-dev.1 - Timely Dataflow framework
- `differential-dataflow-master`: v0.13.0-dev.1 - Differential Dataflow framework
- `criterion`: v0.5.0 - Benchmarking harness

## Related Repositories

- **bigweaver-agent-canary-hydro-zeta**: Main Hydro framework repository
  - Contains the core Hydro implementation
  - Includes Hydro-only benchmarks and tests
  - No timely/differential-dataflow dependencies

## License

Apache-2.0