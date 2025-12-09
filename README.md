# bigweaver-agent-canary-zeta-hydro-deps

This repository contains performance benchmarks and dependencies for the Hydro project that require external dataflow frameworks (timely-dataflow and differential-dataflow). These benchmarks have been separated from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to avoid dependency pollution in the core codebase.

## Purpose

The separation of benchmarks serves several goals:
- **Clean dependencies**: Keeps timely and differential-dataflow dependencies out of the main Hydro repository
- **Performance comparisons**: Maintains the ability to run comprehensive performance comparisons between Hydro and other dataflow frameworks
- **Modular architecture**: Allows independent versioning and maintenance of benchmark code
- **Faster builds**: Reduces build times for the main repository by isolating heavy dependencies

## Repository Structure

```
.
├── benches/              # Benchmark implementations
│   ├── benches/         # Individual benchmark files
│   │   ├── arithmetic.rs
│   │   ├── fan_in.rs
│   │   ├── fan_out.rs
│   │   ├── fork_join.rs
│   │   ├── futures.rs
│   │   ├── identity.rs
│   │   ├── join.rs
│   │   ├── micro_ops.rs
│   │   ├── reachability.rs
│   │   ├── symmetric_hash_join.rs
│   │   ├── upcase.rs
│   │   └── words_diamond.rs
│   ├── Cargo.toml       # Benchmark dependencies
│   ├── README.md        # Benchmark documentation
│   └── build.rs         # Build script for generated benchmarks
├── Cargo.toml           # Workspace configuration
└── README.md            # This file
```

## Running Benchmarks

### Prerequisites

- Rust toolchain (see `rust-toolchain.toml` for the required version)
- Cargo

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

- **arithmetic**: Basic arithmetic operations
- **fan_in**: Multiple streams merging into one
- **fan_out**: Single stream splitting into multiple
- **fork_join**: Fork-join parallel patterns
- **futures**: Async/await patterns
- **identity**: Identity transformations (baseline)
- **join**: Stream join operations
- **micro_ops**: Micro-operations performance
- **reachability**: Graph reachability algorithms
- **symmetric_hash_join**: Hash join implementations
- **upcase**: String transformation operations
- **words_diamond**: Diamond pattern with word processing

## Dependencies

### External Frameworks

- **timely-dataflow**: A low-latency data-parallel dataflow system
- **differential-dataflow**: An incremental data processing framework built on Timely

### Hydro Components (Git Dependencies)

The benchmarks depend on the following components from the main Hydro repository:
- `dfir_rs`: The DFIR runtime
- `sinktools`: Utility tools for data sinks

These dependencies are pulled from the main repository via Git to ensure benchmarks always test against the current Hydro implementation.

## Cross-Repository Benchmark Execution

To run benchmarks against specific versions of Hydro:

1. **Using a specific commit**:
   ```toml
   # In benches/Cargo.toml
   dfir_rs = { git = "https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta", rev = "COMMIT_SHA", features = [ "debugging" ] }
   ```

2. **Using a specific branch**:
   ```toml
   # In benches/Cargo.toml
   dfir_rs = { git = "https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta", branch = "feature/my-feature", features = [ "debugging" ] }
   ```

3. **Using a local checkout** (for development):
   ```toml
   # In benches/Cargo.toml
   dfir_rs = { path = "../../bigweaver-agent-canary-hydro-zeta/dfir_rs", features = [ "debugging" ] }
   ```

## Contributing

When adding new benchmarks that compare Hydro with external dataflow frameworks:

1. Add the benchmark file to `benches/benches/`
2. Register the benchmark in `benches/Cargo.toml` under `[[bench]]` sections
3. Follow the existing benchmark structure and naming conventions
4. Update this README with the new benchmark description

For benchmarks that test only core Hydro functionality without external framework dependencies, consider adding them to the main repository instead.

## Integration with Main Repository

This repository is coordinated with the main Hydro repository:
- Benchmarks pull Hydro components via Git dependencies
- Documentation in the main repository references this repository for performance testing
- CI/CD workflows can be configured to run benchmarks on pull requests or scheduled builds

## License

Apache-2.0

## Related Repositories

- [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta): Main Hydro repository