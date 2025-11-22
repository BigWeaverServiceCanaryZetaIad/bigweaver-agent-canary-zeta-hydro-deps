# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for comparing Hydro performance against Timely Dataflow and Differential Dataflow. These benchmarks have been separated from the main `bigweaver-agent-canary-hydro-zeta` repository to maintain clean architecture and prevent dependency creep in the main codebase.

## Purpose

The primary purpose of this repository is to:

1. **Performance Comparison**: Provide comprehensive benchmarks comparing Hydro implementations against Timely and Differential Dataflow
2. **Dependency Isolation**: Keep timely and differential-dataflow dependencies separate from the main Hydro codebase
3. **Independent Execution**: Allow benchmarks to be executed and maintained independently of the main development workflow

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── benches/                    # Benchmark package
│   ├── benches/               # Benchmark implementations
│   │   ├── arithmetic.rs      # Arithmetic operations benchmark
│   │   ├── fan_in.rs          # Fan-in pattern benchmark
│   │   ├── fan_out.rs         # Fan-out pattern benchmark
│   │   ├── fork_join.rs       # Fork-join pattern benchmark
│   │   ├── futures.rs         # Futures-based operations
│   │   ├── identity.rs        # Identity operation benchmark
│   │   ├── join.rs            # Join operation benchmark
│   │   ├── micro_ops.rs       # Micro-operations benchmark
│   │   ├── reachability.rs    # Reachability algorithm benchmark
│   │   ├── symmetric_hash_join.rs  # Symmetric hash join
│   │   ├── upcase.rs          # String uppercase benchmark
│   │   ├── words_diamond.rs   # Word processing diamond pattern
│   │   └── *.txt             # Test data files
│   ├── Cargo.toml            # Benchmark dependencies
│   ├── build.rs              # Build script
│   └── README.md             # Benchmark documentation
├── Cargo.toml                 # Workspace configuration
└── README.md                  # This file
```

## Dependencies

This repository depends on:

- **timely-master**: Timely Dataflow framework (v0.13.0-dev.1)
- **differential-dataflow-master**: Differential Dataflow framework (v0.13.0-dev.1)
- **dfir_rs**: Hydro's dataflow implementation (from main repository)
- **criterion**: Benchmarking framework with async support
- Additional supporting libraries (futures, rand, tokio, etc.)

## Setup

### Prerequisites

1. Rust toolchain (see `rust-toolchain.toml` for the specific version)
2. Access to the main `bigweaver-agent-canary-hydro-zeta` repository

### Configuration

The benchmarks reference the main Hydro repository for `dfir_rs` and `sinktools`. By default, the paths are configured as:

```toml
dfir_rs = { path = "../../bigweaver-agent-canary-hydro-zeta/dfir_rs" }
sinktools = { path = "../../bigweaver-agent-canary-hydro-zeta/sinktools" }
```

**If your repository layout is different**, update these paths in `benches/Cargo.toml`.

## Running Benchmarks

### Run All Benchmarks

```bash
cargo bench -p benches
```

### Run Specific Benchmarks

```bash
# Run reachability benchmark
cargo bench -p benches --bench reachability

# Run arithmetic benchmark
cargo bench -p benches --bench arithmetic

# Run join benchmark
cargo bench -p benches --bench join
```

### Available Benchmarks

- **arithmetic**: Arithmetic operations (Hydro vs Timely)
- **fan_in**: Fan-in pattern (Hydro vs Timely)
- **fan_out**: Fan-out pattern (Hydro vs Timely)
- **fork_join**: Fork-join pattern (Hydro vs Timely)
- **futures**: Futures-based operations
- **identity**: Identity operation (Hydro vs Timely)
- **join**: Join operation (Hydro vs Timely)
- **micro_ops**: Micro-operations benchmark
- **reachability**: Reachability algorithm (Hydro vs Timely vs Differential)
- **symmetric_hash_join**: Symmetric hash join benchmark
- **upcase**: String uppercase (Hydro vs Timely)
- **words_diamond**: Word processing diamond pattern

## Performance Comparison

The benchmarks produce HTML reports in `target/criterion/` showing:

- Execution time comparisons between frameworks
- Statistical analysis of performance variations
- Historical performance trends
- Detailed performance metrics

View the reports by opening `target/criterion/report/index.html` in a web browser.

## Relationship to Main Repository

This repository maintains a close relationship with `bigweaver-agent-canary-hydro-zeta`:

1. **Code Dependencies**: Benchmarks use `dfir_rs` and `sinktools` from the main repository
2. **Version Coordination**: When the main repository changes APIs, benchmarks may need updates
3. **Performance Tracking**: Results help track Hydro performance improvements over time

## Contributing

When adding new benchmarks:

1. Create a new `.rs` file in `benches/benches/`
2. Add the benchmark configuration to `benches/Cargo.toml`:
   ```toml
   [[bench]]
   name = "your_benchmark"
   harness = false
   ```
3. Follow the existing benchmark patterns for consistency
4. Include comparative implementations (Hydro vs Timely/Differential)
5. Add documentation explaining what is being tested

## Maintenance

### Updating Dependencies

To update timely or differential-dataflow versions:

1. Update version numbers in `benches/Cargo.toml`
2. Test all benchmarks to ensure compatibility
3. Document any API changes required

### Coordinating with Main Repository

When the main repository updates:

1. Check if `dfir_rs` or `sinktools` APIs have changed
2. Update benchmark code if necessary
3. Verify all benchmarks still compile and run
4. Update documentation to reflect any changes

## License

Apache-2.0

## Related Documentation

- [Main Repository](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)
- [Benchmarks README](benches/README.md)
- [Hydro Documentation](https://hydro-project.github.io/)