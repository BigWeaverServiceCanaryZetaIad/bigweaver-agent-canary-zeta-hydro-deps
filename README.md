# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks for performance comparison with Timely Dataflow and Differential Dataflow.

## Contents

- **benches/**: Benchmark suite comparing DFIR/Hydro performance against Timely and Differential Dataflow
  - Contains Cargo.toml with dependencies on timely-master (0.13.0-dev.1) and differential-dataflow-master (0.13.0-dev.1)
  - Benchmark source files in benches/benches/ including:
    - upcase.rs
    - fan_out.rs
    - fan_in.rs
    - reachability.rs
    - join.rs
    - micro_ops.rs
    - And more...

## Building and Running Benchmarks

To build the benchmarks:

```bash
cargo build --benches
```

To run a specific benchmark:

```bash
cargo bench --bench <benchmark_name>
```

For example:

```bash
cargo bench --bench upcase
cargo bench --bench fan_out
cargo bench --bench reachability
```