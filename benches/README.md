# Timely and Differential-Dataflow Benchmarks

This repository contains benchmarks that depend on the timely and differential-dataflow libraries.

These benchmarks were moved from the main bigweaver-agent-canary-hydro-zeta repository to avoid unnecessary dependencies in the core codebase while maintaining the ability to run performance comparisons.

## Benchmarks

The following benchmarks are included:

- `arithmetic` - Arithmetic operations benchmark
- `fan_in` - Fan-in pattern benchmark
- `fan_out` - Fan-out pattern benchmark
- `fork_join` - Fork-join pattern benchmark
- `identity` - Identity operation benchmark
- `join` - Join operation benchmark
- `reachability` - Graph reachability benchmark
- `upcase` - Uppercase transformation benchmark

## Setup

These benchmarks compare implementations across different frameworks including Hydro (dfir_rs) and timely/differential-dataflow. To run them, you need access to the main bigweaver-agent-canary-hydro-zeta repository.

### Option 1: Clone repositories side-by-side (Recommended)

```bash
# Clone both repositories in the same parent directory
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git

cd bigweaver-agent-canary-zeta-hydro-deps
```

Then uncomment the path dependencies in `benches/Cargo.toml`:
```toml
dfir_rs = { path = "../../bigweaver-agent-canary-hydro-zeta/dfir_rs", features = [ "debugging" ] }
sinktools = { path = "../../bigweaver-agent-canary-hydro-zeta/sinktools", version = "^0.0.1" }
```

### Option 2: Custom path

If you have the repositories in a different location, adjust the paths in `benches/Cargo.toml` accordingly.

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench
```

Run specific benchmarks:
```bash
cargo bench --bench reachability
cargo bench --bench arithmetic
```

## Integration with Main Repository

To run performance comparisons across both repositories:

1. Clone both repositories side-by-side
2. Set up path dependencies as described above
3. Run benchmarks in this repository: `cargo bench`
4. Run benchmarks in the main repository: `cd ../bigweaver-agent-canary-hydro-zeta && cargo bench -p benches` (if benches package exists)
5. Compare results to assess performance differences

## Dependencies

This package depends on:
- `timely` (timely-master v0.13.0-dev.1)
- `differential-dataflow` (differential-dataflow-master v0.13.0-dev.1)
- `criterion` for benchmarking infrastructure
- `dfir_rs` (from main repository) for Hydro implementations
- `sinktools` (from main repository) for utilities

These dependencies are isolated to this repository to keep the main repository free of these heavyweight dependencies.
