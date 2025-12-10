# Benchmark Migration from bigweaver-agent-canary-hydro-zeta

## Overview

This repository contains benchmarks that were moved from the [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to avoid including unnecessary dependencies (timely and differential-dataflow) in the main project.

## Why This Repository Exists

The main bigweaver-agent-canary-hydro-zeta repository aims to minimize dependencies to:
- Reduce build times for users who don't need these specific benchmarks
- Simplify the dependency tree
- Avoid pulling in timely and differential-dataflow for all users

By separating these benchmarks into this repository, we maintain the ability to run performance comparisons while keeping the main repository lean.

## Benchmarks in This Repository

### Timely Dataflow Benchmarks
All of these benchmarks use the timely dataflow library:
- `arithmetic.rs` - Tests arithmetic operations in a dataflow pipeline
- `fan_in.rs` - Tests fan-in patterns where multiple inputs converge
- `fan_out.rs` - Tests fan-out patterns where data is distributed to multiple outputs
- `fork_join.rs` - Tests fork-join parallel execution patterns
- `identity.rs` - Tests identity/passthrough operations
- `join.rs` - Tests join operations between streams
- `upcase.rs` - Tests string transformation (uppercase) in dataflow

### Differential Dataflow Benchmarks
These benchmarks use the differential-dataflow library:
- `reachability.rs` - Graph reachability computation using differential dataflow
  - Data files: `reachability_edges.txt` and `reachability_reachable.txt`

## Dependencies

This repository includes:
- `timely` (package: timely-master, version 0.13.0-dev.1)
- `differential-dataflow` (package: differential-dataflow-master, version 0.13.0-dev.1)
- `dfir_rs` and `sinktools` from the main repository (via git dependency)
- `criterion` for benchmarking framework

## Running Benchmarks

Run all benchmarks:
```bash
cd benches
cargo bench
```

Run a specific benchmark:
```bash
cd benches
cargo bench --bench arithmetic
cargo bench --bench reachability
```

## Performance Comparison Workflow

To compare performance between the original dfir_rs implementation and timely/differential implementations:

1. **Run benchmarks in this repository:**
   ```bash
   cd /path/to/bigweaver-agent-canary-zeta-hydro-deps/benches
   cargo bench
   ```

2. **Run benchmarks in the main repository:**
   ```bash
   cd /path/to/bigweaver-agent-canary-hydro-zeta
   cargo bench -p benches
   ```

3. **Compare results:**
   - Results are in `target/criterion/` in each repository
   - Open `target/criterion/report/index.html` in a browser for visual comparison
   - Both repositories use the same criterion version and configuration

## Migration History

- **Original location:** `bigweaver-agent-canary-hydro-zeta/benches/benches/`
- **New location:** `bigweaver-agent-canary-zeta-hydro-deps/benches/benches/`
- **Reason:** Separate timely/differential-dataflow dependencies from main repository
- **Date:** Migration documented in main repository commit b161bc10

## Files Moved

```
benches/benches/arithmetic.rs              -> benches/benches/arithmetic.rs
benches/benches/fan_in.rs                  -> benches/benches/fan_in.rs
benches/benches/fan_out.rs                 -> benches/benches/fan_out.rs
benches/benches/fork_join.rs               -> benches/benches/fork_join.rs
benches/benches/identity.rs                -> benches/benches/identity.rs
benches/benches/join.rs                    -> benches/benches/join.rs
benches/benches/reachability.rs            -> benches/benches/reachability.rs
benches/benches/reachability_edges.txt     -> benches/benches/reachability_edges.txt
benches/benches/reachability_reachable.txt -> benches/benches/reachability_reachable.txt
benches/benches/upcase.rs                  -> benches/benches/upcase.rs
```

## Contributing

When adding new benchmarks:
- If they depend on timely or differential-dataflow, add them to this repository
- If they only depend on dfir_rs or other standard dependencies, add them to the main repository
- Update documentation in both repositories when changes affect the benchmark structure
