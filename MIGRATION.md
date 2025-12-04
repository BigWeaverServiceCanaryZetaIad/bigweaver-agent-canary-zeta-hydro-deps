# Benchmark Migration Guide

## Overview

The timely-dataflow and differential-dataflow benchmarks have been moved from the main Hydro repository (`bigweaver-agent-canary-hydro-zeta`) to this separate dependencies repository (`bigweaver-agent-canary-zeta-hydro-deps`).

## What Was Moved

### Benchmark Files
All benchmark code from the `benches/` directory in the main repository has been moved here:
- `benches/Cargo.toml` - Benchmark package configuration
- `benches/README.md` - Benchmark documentation
- `benches/build.rs` - Build script
- `benches/benches/*.rs` - All benchmark implementations:
  - `arithmetic.rs` - Basic arithmetic operations
  - `fan_in.rs` - Fan-in data flow patterns
  - `fan_out.rs` - Fan-out data flow patterns
  - `fork_join.rs` - Fork-join patterns
  - `futures.rs` - Futures-based operations
  - `identity.rs` - Identity operations (baseline)
  - `join.rs` - Join operations
  - `micro_ops.rs` - Micro-operations
  - `reachability.rs` - Graph reachability computation
  - `symmetric_hash_join.rs` - Symmetric hash join operations
  - `upcase.rs` - String uppercase transformation
  - `words_diamond.rs` - Diamond-shaped word processing
- Data files:
  - `reachability_edges.txt` - Test data for reachability benchmarks
  - `reachability_reachable.txt` - Expected results for reachability
  - `words_alpha.txt` - Word list for text processing benchmarks

### Dependencies Removed from Main Repository
The following dependencies have been removed from the main Hydro repository:
- `timely` (package: `timely-master`)
- `differential-dataflow` (package: `differential-dataflow-master`)
- Associated timely dependencies:
  - `timely-bytes-master`
  - `timely-communication-master`
  - `timely-container-master`
  - `timely-logging-master`

## Why This Change Was Made

1. **Reduce Dependency Footprint**: The timely and differential-dataflow dependencies are substantial and not needed for normal Hydro development.

2. **Faster Builds**: Removing these dependencies speeds up compilation times for the main repository.

3. **Cleaner Separation**: Comparative benchmarking is a specialized use case that doesn't need to be in the core repository.

4. **Maintain Benchmarking Capability**: The benchmarks are still available for performance comparisons, just in a dedicated location.

## How to Run Benchmarks

### From the Dependencies Repository

1. Clone the dependencies repository:
   ```bash
   git clone https://github.com/hydro-project/hydro-deps bigweaver-agent-canary-zeta-hydro-deps
   cd bigweaver-agent-canary-zeta-hydro-deps
   ```

2. Run all benchmarks:
   ```bash
   cargo bench -p benches
   ```

3. Run specific benchmarks:
   ```bash
   cargo bench -p benches --bench arithmetic
   cargo bench -p benches --bench reachability
   cargo bench -p benches --bench join
   ```

4. View results:
   - HTML reports are generated in `target/criterion/`
   - Open `target/criterion/report/index.html` in a browser for detailed visualizations

### Cross-Repository Performance Comparisons

To compare Hydro performance against the timely/differential baselines:

1. Run benchmarks from this repository (as shown above)
2. The criterion framework will track performance over time
3. Compare Hydro implementations (from `dfir_rs`) against baseline implementations

The benchmarks include implementations using:
- **Hydro/DFIR**: Using `dfir_rs` from the main repository (via git dependency)
- **Timely Dataflow**: Direct timely-dataflow implementations
- **Differential Dataflow**: Differential-dataflow implementations
- **Raw/Baseline**: Simple Rust implementations for comparison

## Dependencies

The benchmarks now reference the main Hydro repository via git dependencies:

```toml
[dev-dependencies]
dfir_rs = { git = "https://github.com/hydro-project/hydro", features = [ "debugging" ] }
sinktools = { git = "https://github.com/hydro-project/hydro" }
```

This means:
- Benchmarks always use the latest version from the main repository
- No need to keep synchronized copies of code
- Easy to update by running `cargo update`

## For Contributors

### Adding New Benchmarks

To add a new benchmark to this repository:

1. Create a new file in `benches/benches/your_benchmark.rs`
2. Add the benchmark entry to `benches/Cargo.toml`:
   ```toml
   [[bench]]
   name = "your_benchmark"
   harness = false
   ```
3. Follow the existing benchmark structure using criterion
4. Include implementations for comparison (Hydro, timely, differential)

### Updating Benchmarks

To update existing benchmarks:

1. Modify the benchmark files in `benches/benches/`
2. Update git dependencies if needed: `cargo update`
3. Run benchmarks to verify changes: `cargo bench -p benches`

## Migration Timeline

- **Before**: Benchmarks were in `bigweaver-agent-canary-hydro-zeta/benches/`
- **Now**: Benchmarks are in `bigweaver-agent-canary-zeta-hydro-deps/benches/`
- **Main Repository**: Updated documentation points to this repository

## Support

For questions about:
- **Benchmarks**: See this repository's README.md
- **Hydro Development**: See the main repository's CONTRIBUTING.md
- **Performance Issues**: Run benchmarks and check criterion reports
