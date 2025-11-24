# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for timely and differential-dataflow that were separated from the main `bigweaver-agent-canary-hydro-zeta` repository to maintain clean dependency separation.

## Purpose

The main Hydro repository should not have dependencies on timely and differential-dataflow packages. This companion repository allows for:

1. **Performance Comparisons**: Benchmark Hydroflow/dfir_rs against timely and differential-dataflow
2. **Clean Separation**: Keep external framework dependencies isolated
3. **Maintainability**: Easier to manage and update framework-specific code

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── benches/                    # Benchmark suite
│   ├── benches/               # Benchmark implementations
│   │   ├── arithmetic.rs      # Arithmetic pipeline benchmark
│   │   ├── fan_in.rs         # Fan-in pattern benchmark
│   │   ├── fan_out.rs        # Fan-out pattern benchmark
│   │   ├── fork_join.rs      # Fork-join pattern benchmark
│   │   ├── identity.rs       # Identity operation benchmark
│   │   ├── join.rs           # Join operation benchmark
│   │   ├── reachability.rs   # Graph reachability benchmark
│   │   ├── upcase.rs         # String uppercase benchmark
│   │   ├── reachability_edges.txt        # Graph data
│   │   └── reachability_reachable.txt    # Expected results
│   ├── build.rs              # Build script for code generation
│   ├── Cargo.toml            # Benchmark dependencies
│   └── README.md             # Benchmark documentation
├── Cargo.toml                # Workspace configuration
└── README.md                 # This file
```

## Getting Started

### Prerequisites

- Rust (latest stable version recommended)
- Cargo

### Building

```bash
# Check that everything compiles
cargo check

# Build benchmarks
cargo build --release -p benches
```

### Running Benchmarks

```bash
# Run all benchmarks
cargo bench -p benches

# Run specific benchmark
cargo bench -p benches --bench arithmetic

# Run benchmarks matching a pattern
cargo bench -p benches -- timely
cargo bench -p benches -- dfir
```

See [benches/README.md](benches/README.md) for detailed benchmark documentation.

## Dependencies

This repository includes dependencies on:

- **timely** (timely-master 0.13.0-dev.1) - Timely dataflow framework
- **differential-dataflow** (differential-dataflow-master 0.13.0-dev.1) - Differential dataflow framework
- **dfir_rs** - Hydroflow dataflow implementation (from main repository)
- **criterion** - Benchmarking framework

## Performance Comparison

The benchmarks enable direct comparison between:

1. **Timely Dataflow** - Original timely-dataflow implementations
2. **Differential Dataflow** - Incremental computation implementations
3. **Hydroflow/DFIR** - Hydro project's dataflow implementations

Results are generated in HTML format in `target/criterion/` for detailed analysis.

## Relationship to Main Repository

This repository is a companion to [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta). 

The benchmarks here were moved from the main repository to:
- Eliminate timely/differential-dataflow dependencies from the main codebase
- Reduce build times for the main repository
- Maintain ability to run performance comparisons
- Keep focused separation of concerns

## Contributing

When adding or modifying benchmarks:

1. Ensure all benchmark implementations are included (timely, differential, dfir)
2. Update benchmark documentation in `benches/README.md`
3. Add appropriate `[[bench]]` entries in `benches/Cargo.toml`
4. Verify benchmarks compile and run successfully
5. Include any required data files in `benches/benches/`

## License

Apache-2.0

## Related Links

- [Hydroflow Project](https://hydro.run/)
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)