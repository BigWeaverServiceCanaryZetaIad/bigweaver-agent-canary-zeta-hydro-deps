# bigweaver-agent-canary-zeta-hydro-deps

This repository contains performance benchmarks that compare Hydro with timely-dataflow and differential-dataflow. These benchmarks are maintained separately from the main bigweaver-agent-canary-hydro-zeta repository to avoid including timely and differential-dataflow as dependencies in the core project.

## Benchmarks

The benchmarks reference the main bigweaver-agent-canary-hydro-zeta repository as a git dependency to ensure they test against the latest Hydro code while maintaining the ability to run performance comparisons.

### Running Benchmarks

Run all benchmarks:
```shell
cargo bench -p benches
```

Run specific benchmarks:
```shell
cargo bench -p benches --bench reachability
cargo bench -p benches --bench identity
cargo bench -p benches --bench join
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench fan_in
cargo bench -p benches --bench fan_out
cargo bench -p benches --bench fork_join
cargo bench -p benches --bench upcase
cargo bench -p benches --bench micro_ops
cargo bench -p benches --bench symmetric_hash_join
cargo bench -p benches --bench words_diamond
cargo bench -p benches --bench futures
```

### Available Benchmarks

- **arithmetic**: Basic arithmetic operations
- **fan_in**: Multiple streams merging into one
- **fan_out**: One stream splitting into multiple
- **fork_join**: Fork and join patterns
- **futures**: Async futures operations
- **identity**: Identity transformations
- **join**: Join operations
- **micro_ops**: Micro-operation benchmarks
- **reachability**: Graph reachability algorithms
- **symmetric_hash_join**: Symmetric hash join operations
- **upcase**: String case transformations
- **words_diamond**: Diamond-shaped dataflow patterns

## Repository Structure

```
benches/
├── Cargo.toml           # Benchmark package configuration
├── README.md            # Benchmark-specific documentation
├── build.rs             # Build script for generating benchmark code
└── benches/             # Individual benchmark files
    ├── arithmetic.rs
    ├── fan_in.rs
    ├── fan_out.rs
    ├── fork_join.rs
    ├── futures.rs
    ├── identity.rs
    ├── join.rs
    ├── micro_ops.rs
    ├── reachability.rs
    ├── symmetric_hash_join.rs
    ├── upcase.rs
    └── words_diamond.rs
```

## Dependencies

The benchmarks use:
- **criterion**: For benchmark harness and measurement
- **dfir_rs**: From the main bigweaver-agent-canary-hydro-zeta repository (via git dependency)
- **differential-dataflow-master**: For comparison benchmarks
- **timely-master**: For comparison benchmarks
- **sinktools**: From the main repository (via git dependency)

## Contributing

For information on contributing to these benchmarks, please see the main repository's [CONTRIBUTING.md](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta/blob/main/CONTRIBUTING.md).