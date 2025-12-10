# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks that depend on timely-dataflow and differential-dataflow. These benchmarks were moved from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to avoid including these heavy dependencies in the main codebase.

## Purpose

The benchmarks in this repository allow for performance comparison between:
- Hydro/DFIR implementations
- Timely-dataflow implementations
- Differential-dataflow implementations

## Structure

- `benches/` - Contains microbenchmarks comparing different dataflow implementations

## Usage

See the [benches/README.md](benches/README.md) for instructions on running the benchmarks.

## Performance Comparison Workflow

To perform a complete performance comparison:

1. **Run DFIR-only benchmarks** from the main Hydro repository:
   ```bash
   cd /path/to/bigweaver-agent-canary-hydro-zeta
   cargo bench -p benches
   ```

2. **Run timely/differential benchmarks** from this repository:
   ```bash
   cd /path/to/bigweaver-agent-canary-zeta-hydro-deps
   cargo bench -p hydro-timely-differential-benches
   ```

3. **Compare results**: Criterion saves results in `target/criterion/` in each repository, allowing you to compare performance metrics across implementations.