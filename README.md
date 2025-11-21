# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks comparing Hydroflow/DFIR with Timely and Differential Dataflow implementations. These benchmarks were moved from the main `bigweaver-agent-canary-hydro-zeta` repository to maintain clean dependency boundaries and reduce complexity in the main codebase.

## Contents

### Benchmarks
The `benchmarks/` directory contains microbenchmarks that compare the performance of Hydroflow/DFIR with Timely and Differential Dataflow implementations across various operations.

## Running Benchmarks

### Prerequisites
- Rust toolchain (compatible with the Hydro project)
- Git access to the main Hydro repository for dependencies

### Run All Benchmarks
```bash
cargo bench -p benchmarks
```

### Run Specific Benchmarks
```bash
# Run reachability benchmark
cargo bench -p benchmarks --bench reachability

# Run join benchmark
cargo bench -p benchmarks --bench join

# Run micro operations benchmark
cargo bench -p benchmarks --bench micro_ops
```

### Available Benchmarks
- **arithmetic** - Basic arithmetic operations
- **fan_in** - Fan-in patterns
- **fan_out** - Fan-out patterns
- **fork_join** - Fork-join patterns
- **futures** - Async/futures operations
- **identity** - Identity transformations
- **join** - Join operations
- **micro_ops** - Micro-level operations
- **reachability** - Graph reachability algorithms
- **symmetric_hash_join** - Symmetric hash join operations
- **upcase** - String transformation operations
- **words_diamond** - Diamond pattern with word processing

## Performance Comparison

Each benchmark typically includes implementations for:
1. **Timely Dataflow** - The timely dataflow engine
2. **Differential Dataflow** - Incremental dataflow computation
3. **Hydroflow/DFIR** - Scheduled and compiled implementations

The benchmarks use [Criterion.rs](https://github.com/bheisler/criterion.rs) for statistical analysis and provide HTML reports with detailed performance metrics.

### Viewing Results
After running benchmarks, results are available in:
- Console output with statistical summaries
- HTML reports in `target/criterion/` directory

## Dependencies

This repository depends on:
- **dfir_rs** - Referenced from the main hydro repository via git
- **sinktools** - Referenced from the main hydro repository via git
- **timely-master** - Timely dataflow framework
- **differential-dataflow-master** - Differential dataflow framework
- **criterion** - Benchmarking framework
- Various utility crates (futures, rand, tokio, etc.)

## Architecture

The benchmarks are structured to:
1. **Preserve functionality** - All performance comparison capabilities are maintained
2. **Isolate dependencies** - Timely and Differential Dataflow dependencies are isolated to this repository
3. **Reference upstream** - Core Hydroflow/DFIR code is referenced from the main repository
4. **Enable CI/CD** - Can be integrated with continuous benchmarking pipelines

## Contributing

When adding new benchmarks:
1. Create a new `.rs` file in `benchmarks/benches/`
2. Add the benchmark entry to `benchmarks/Cargo.toml`
3. Follow the existing pattern of comparing implementations
4. Include appropriate test data if needed
5. Update this README with the new benchmark description

## Relationship to Main Repository

This repository complements the main [bigweaver-agent-canary-hydro-zeta](https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository by:
- Maintaining benchmark code separate from core functionality
- Isolating timely/differential-dataflow dependencies
- Providing performance comparison data without bloating the main codebase
- Enabling independent benchmark updates and CI/CD workflows

## License

Apache-2.0

## References

- Main Hydro Repository: https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta
- Hydro Project: https://github.com/hydro-project/hydro
- Timely Dataflow: https://github.com/TimelyDataflow/timely-dataflow
- Differential Dataflow: https://github.com/TimelyDataflow/differential-dataflow