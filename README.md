# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies that have been separated from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to keep the core repository focused and reduce dependency bloat.

## Contents

### Benchmarks

The `benches/` directory contains performance comparison benchmarks for Hydro/DFIR against Timely Dataflow and Differential Dataflow. These benchmarks allow us to:

- Compare the performance of Hydro/DFIR implementations against established streaming frameworks
- Track performance improvements and regressions over time
- Maintain performance comparison capabilities without adding heavyweight dependencies to the main repository

See [benches/README.md](benches/README.md) for detailed information about available benchmarks and how to run them.

## Purpose

This repository serves as a dedicated location for:
- **Performance benchmarks** comparing Hydro with Timely and Differential Dataflow
- **Heavy dependencies** (timely, differential-dataflow) that are only needed for comparison purposes
- **Tools and utilities** that support benchmarking but aren't needed in the core framework

By separating these concerns, we:
- Keep the main repository clean and focused on core functionality
- Reduce build times and dependency footprint for users of the main framework
- Maintain all benchmarking capabilities in an organized, accessible location
- Enable independent updates to benchmark code without affecting the main codebase

## Running Benchmarks

```bash
# Clone this repository
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps

# Run all benchmarks
cargo bench

# Run a specific benchmark
cargo bench --bench reachability
```

## Relationship to Main Repository

The benchmarks in this repository reference `dfir_rs` and `sinktools` from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository via git dependencies. This allows the benchmarks to always test against the latest version of Hydro/DFIR while keeping the heavy Timely and Differential Dataflow dependencies isolated.

## Migration History

These benchmarks were previously located in the `benches/` directory of the main repository. They were moved here to:
- Reduce the dependency footprint of the main repository
- Improve build times for developers working on core Hydro functionality
- Maintain a cleaner separation of concerns between core framework and performance comparisons