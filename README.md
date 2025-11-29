# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for the Hydro project that were separated from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository. The separation allows for cleaner dependency management and better isolation of performance testing infrastructure.

## Benchmarks

The `benches/` directory contains performance benchmarks comparing Hydro implementations with timely-dataflow and differential-dataflow alternatives.

### Available Benchmarks

- **arithmetic**: Arithmetic operations and dataflow patterns
- **fan_in**: Multiple inputs merging into a single stream
- **fan_out**: Single stream splitting into multiple outputs
- **fork_join**: Fork-join parallel computation patterns
- **identity**: Identity transformation benchmarks
- **join**: Join operation benchmarks
- **micro_ops**: Microbenchmarks of individual operations
- **reachability**: Graph reachability algorithms
- **symmetric_hash_join**: Symmetric hash join implementations
- **upcase**: String transformation operations
- **words_diamond**: Diamond-shaped dataflow patterns
- **futures**: Async futures-based implementations

### Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run a specific benchmark:
```bash
cargo bench -p benches --bench reachability
```

Run benchmarks with specific parameters:
```bash
cargo bench -p benches --bench micro_ops -- --sample-size 100
```

### Performance Comparison

The benchmarks allow for performance comparisons between:
- Hydro (dfir_rs) implementations
- Timely-dataflow implementations
- Differential-dataflow implementations

Results are generated in HTML format using Criterion and can be found in `target/criterion/` after running the benchmarks.

## Dependencies

This repository includes dependencies on:
- **timely-dataflow**: For comparative performance testing
- **differential-dataflow**: For comparative performance testing
- **dfir_rs**: The Hydro runtime (referenced from main repository)
- **criterion**: For benchmarking infrastructure

## Building

To build the benchmarks:
```bash
cargo build --workspace
```

To check the benchmarks compile without running them:
```bash
cargo check --workspace --benches
```

## Contributing

When adding new benchmarks:
1. Create a new `.rs` file in `benches/benches/`
2. Add a `[[bench]]` entry in `benches/Cargo.toml`
3. Follow existing patterns for comparing Hydro, timely, and differential implementations
4. Document the benchmark purpose and expected performance characteristics

## See Also

- [Main Hydro Repository](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)