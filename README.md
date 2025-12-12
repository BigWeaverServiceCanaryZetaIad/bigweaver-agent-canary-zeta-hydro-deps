# bigweaver-agent-canary-zeta-hydro-deps

Performance comparison benchmarks for Hydro/DFIR against timely-dataflow and differential-dataflow.

## Overview

This repository contains benchmarks that compare the performance of Hydro/DFIR implementations against reference implementations using timely-dataflow and differential-dataflow. These benchmarks were moved to a separate repository to avoid including heavyweight external framework dependencies in the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository while maintaining the ability to run performance comparisons.

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── benches/              # Benchmark implementations
│   ├── benches/          # Individual benchmark files
│   │   ├── arithmetic.rs
│   │   ├── fan_in.rs
│   │   ├── fan_out.rs
│   │   ├── fork_join.rs
│   │   ├── identity.rs
│   │   ├── join.rs
│   │   ├── micro_ops.rs
│   │   ├── reachability.rs
│   │   ├── symmetric_hash_join.rs
│   │   └── upcase.rs
│   └── Cargo.toml
└── README.md
```

## Prerequisites

1. **Rust toolchain**: This project requires Rust. The exact version is specified in the main repository's `rust-toolchain.toml`.

2. **Main repository**: These benchmarks depend on the `dfir_rs` crate from the main repository. Clone both repositories side by side:

```bash
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
```

The directory structure should look like:
```
parent_directory/
├── bigweaver-agent-canary-hydro-zeta/
└── bigweaver-agent-canary-zeta-hydro-deps/
```

## Running Benchmarks

### Run All Benchmarks

```bash
cd bigweaver-agent-canary-zeta-hydro-deps/benches
cargo bench
```

### Run Specific Benchmark

```bash
cd bigweaver-agent-canary-zeta-hydro-deps/benches
cargo bench --bench arithmetic
cargo bench --bench reachability
# etc.
```

### Available Benchmarks

- **arithmetic**: Simple arithmetic operations (map operations)
- **fan_in**: Merging multiple streams
- **fan_out**: Splitting streams
- **fork_join**: Fork-join pattern
- **identity**: Identity operation (passthrough)
- **join**: Stream joins
- **micro_ops**: Microbenchmarks for various operators
- **reachability**: Graph reachability computation (uses differential-dataflow)
- **symmetric_hash_join**: Symmetric hash join implementation
- **upcase**: String transformation benchmark

## Benchmark Results

Benchmark results are saved to `target/criterion/` and can be viewed by opening `target/criterion/report/index.html` in a web browser.

## Dependencies

### External Framework Dependencies

- **timely-dataflow**: Stream processing framework
- **differential-dataflow**: Incremental computation framework

These dependencies are only included in this repository to enable performance comparisons.

### Main Repository Dependencies

- **dfir_rs**: The Dataflow Intermediate Representation runtime from the main repository

## Maintaining Cross-Repository Compatibility

When the main repository's `dfir_rs` API changes, these benchmarks may need to be updated accordingly. The path dependency in `benches/Cargo.toml` points to the sibling directory:

```toml
dfir_rs = { path = "../../bigweaver-agent-canary-hydro-zeta/dfir_rs", features = ["debugging"] }
```

## Contributing

Changes to these benchmarks should maintain compatibility with both:
1. The current APIs of timely-dataflow and differential-dataflow
2. The current API of dfir_rs from the main repository

When making changes, ensure all benchmarks still compile and run successfully.

## Related Documentation

- Main repository: [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)
- Hydro documentation: [hydro.run](https://hydro.run/)
- Timely dataflow: [github.com/TimelyDataflow/timely-dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- Differential dataflow: [github.com/TimelyDataflow/differential-dataflow](https://github.com/TimelyDataflow/differential-dataflow)

## License

Apache-2.0 (same as the main repository)