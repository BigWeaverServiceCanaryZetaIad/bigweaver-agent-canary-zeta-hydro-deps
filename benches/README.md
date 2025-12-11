# Timely and Differential-Dataflow Benchmarks

This directory contains microbenchmarks comparing Hydro/DFIR implementations with timely-dataflow and differential-dataflow.

## Background

These benchmarks were moved from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to avoid including timely-dataflow and differential-dataflow as dependencies in the main codebase. This separation helps keep the main repository focused and reduces dependency bloat.

## Running Benchmarks

From the repository root:

```bash
# Run all benchmarks
cargo bench -p hydro-timely-differential-benches

# Run specific benchmark
cargo bench -p hydro-timely-differential-benches --bench arithmetic
```

From this directory:

```bash
# Run all benchmarks
cargo bench

# Run specific benchmark
cargo bench --bench identity
```

## Benchmarks

### arithmetic.rs
Pipeline of arithmetic operations (+1) repeated multiple times. Compares:
- Raw single-threaded pipeline
- Channel-based pipeline
- Timely dataflow
- DFIR implementation

### fan_in.rs
Multiple independent sources merging into a single sink. Tests how well each framework handles multiple input streams.

### fan_out.rs
Single source splitting to multiple independent sinks. Tests how well each framework handles multiple output streams.

### fork_join.rs
Fork-join pattern with filtering (even/odd split and rejoin). Tests conditional routing and merging.

### identity.rs
Simple identity/passthrough operation. Measures baseline overhead of each framework.

### join.rs
Join operations between two streams. Compares:
- Nested loop join
- Timely dataflow join
- Differential dataflow join
- DFIR join

### reachability.rs
Graph reachability analysis using fixed-point iteration. Uses actual graph data from text files. Compares:
- Sequential algorithm
- Timely dataflow
- Differential dataflow
- DFIR implementation

### upcase.rs
String uppercase transformation. Tests string processing overhead in each framework.

## Data Files

- `reachability_edges.txt` - Graph edges for reachability benchmark
- `reachability_reachable.txt` - Expected reachable nodes for validation

## Performance Comparison

Criterion saves benchmark results in `target/criterion/`. To compare with DFIR-only benchmarks from the main repository:

1. Run DFIR benchmarks in main repository:
   ```bash
   cd bigweaver-agent-canary-hydro-zeta
   cargo bench -p benches
   ```

2. Run these benchmarks:
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps
   cargo bench -p hydro-timely-differential-benches
   ```

3. Compare results in `target/criterion/` directories

## Build Requirements

- Rust toolchain (see `../rust-toolchain.toml`)
- The build script (`build.rs`) generates code for the fork_join benchmark
