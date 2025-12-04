# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and code related to external dependencies that have been separated from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to maintain clean dependency management.

## Contents

### Benchmarks

The `benches` directory contains microbenchmarks for Hydro that depend on:
- **timely-dataflow**: A low-latency cyclic dataflow computational model
- **differential-dataflow**: An implementation of differential dataflow over timely dataflow

These benchmarks were moved here to avoid including these heavy dependencies in the main repository's build and test cycles.

## Running Benchmarks

### Prerequisites

Ensure you have Rust and Cargo installed. This project uses the 2024 edition of Rust.

### Run All Benchmarks

```bash
cargo bench -p benches
```

### Run Specific Benchmarks

```bash
# Run the reachability benchmark
cargo bench -p benches --bench reachability

# Run the arithmetic benchmark
cargo bench -p benches --bench arithmetic

# Run the join benchmark
cargo bench -p benches --bench join
```

### Available Benchmarks

- **arithmetic**: Arithmetic operation benchmarks
- **fan_in**: Fan-in pattern benchmarks
- **fan_out**: Fan-out pattern benchmarks
- **fork_join**: Fork-join pattern benchmarks
- **futures**: Async futures benchmarks
- **identity**: Identity transformation benchmarks
- **join**: Join operation benchmarks
- **micro_ops**: Micro-operation benchmarks
- **reachability**: Graph reachability benchmarks
- **symmetric_hash_join**: Symmetric hash join benchmarks
- **upcase**: String uppercase transformation benchmarks
- **words_diamond**: Diamond pattern with word processing benchmarks

## Performance Comparison with Main Repository

To compare performance between implementations in this repository and the main Hydro repository:

1. Clone both repositories side by side:
   ```bash
   git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git
   git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
   ```

2. Run benchmarks in both repositories:
   ```bash
   # Run benchmarks in the deps repository
   cd bigweaver-agent-canary-zeta-hydro-deps
   cargo bench -p benches --bench <benchmark_name>
   
   # Check main repository for equivalent benchmarks
   cd ../bigweaver-agent-canary-hydro-zeta
   # Run any equivalent benchmarks that exist in the main repo
   ```

3. Compare the output reports located in `target/criterion/` directories

## Dependencies

This repository maintains the following key dependencies:

- `timely-master` (v0.13.0-dev.1): Core timely dataflow implementation
- `differential-dataflow-master` (v0.13.0-dev.1): Differential dataflow over timely
- `dfir_rs`: Referenced from the main hydro repository
- `sinktools`: Referenced from the main hydro repository
- `criterion`: For benchmarking framework

## Contributing

For contributing guidelines, please refer to the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository.

## License

Apache-2.0