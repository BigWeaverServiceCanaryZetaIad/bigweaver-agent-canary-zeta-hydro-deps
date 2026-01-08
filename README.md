# bigweaver-agent-canary-zeta-hydro-deps

Companion repository for [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) containing benchmarks with timely and differential-dataflow dependencies.

## Overview

This repository contains benchmarks that compare Hydro implementations with timely and differential-dataflow implementations. These benchmarks were separated from the main repository to:

- Reduce build dependencies in the main repository
- Improve build times for core development
- Maintain performance comparison capabilities
- Provide clear architectural separation between core and comparative benchmarks

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── benches/
│   ├── Cargo.toml          # Benchmark package configuration
│   ├── README.md           # Benchmark documentation
│   ├── build.rs            # Build script for code generation
│   └── benches/
│       ├── arithmetic.rs   # Arithmetic operations benchmark
│       ├── fan_in.rs       # Fan-in pattern benchmark
│       ├── fan_out.rs      # Fan-out pattern benchmark
│       ├── fork_join.rs    # Fork-join pattern benchmark
│       ├── identity.rs     # Identity transformation benchmark
│       ├── join.rs         # Join operations benchmark
│       ├── reachability.rs # Graph reachability benchmark
│       ├── upcase.rs       # String transformation benchmark
│       ├── reachability_edges.txt       # Test data
│       └── reachability_reachable.txt   # Expected results
└── README.md              # This file
```

## Prerequisites

These benchmarks require access to the `dfir_rs` and `sinktools` crates from the main repository. Clone both repositories as siblings:

```bash
# Clone main repository
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git

# Clone this deps repository
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
```

Directory structure should be:
```
parent-directory/
├── bigweaver-agent-canary-hydro-zeta/
└── bigweaver-agent-canary-zeta-hydro-deps/
```

## Running Benchmarks

Run all benchmarks:
```bash
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench join
```

## Performance Comparison Workflow

1. **Run Hydro-native benchmarks** (from main repository):
   ```bash
   cd bigweaver-agent-canary-hydro-zeta
   cargo bench -p benches
   ```

2. **Run timely/differential-dataflow benchmarks** (from this repository):
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps
   cargo bench -p benches
   ```

3. **Compare results** to evaluate performance characteristics between implementations

## Dependencies

Major dependencies include:

- **timely-master** (v0.13.0-dev.1) - Timely dataflow framework
- **differential-dataflow-master** (v0.13.0-dev.1) - Differential dataflow framework
- **criterion** - Benchmarking framework with HTML reports
- **dfir_rs** - Hydroflow's DFIR implementation (from main repository)

## Migration Information

These benchmarks were migrated from the main repository to reduce build dependencies. For detailed migration information, see the [BENCHMARK_MIGRATION.md](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta/blob/main/BENCHMARK_MIGRATION.md) file in the main repository.

**Migration Date**: December 17, 2024

## Related Repositories

- **[bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)** - Main Hydro project repository with DFIR-native implementations and benchmarks

## Contributing

When adding new benchmarks that depend on timely or differential-dataflow, add them to this repository. Benchmarks that only depend on Hydro-native implementations should be added to the main repository.