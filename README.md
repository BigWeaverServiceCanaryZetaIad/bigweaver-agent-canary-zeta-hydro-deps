# bigweaver-agent-canary-zeta-hydro-deps

This repository contains performance benchmarks and dependencies for the BigWeaver Agent Canary Hydro project, specifically for timely and differential-dataflow related benchmarks.

## Overview

This repository was created to separate benchmarks that depend on timely and differential-dataflow from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository. This separation provides several benefits:

- **Reduced dependency footprint** in the main repository
- **Improved build times** for the core project
- **Better separation of concerns** between core functionality and performance testing
- **Maintained ability to run performance comparisons** with timely and differential-dataflow

## Benchmarks

The `benches` directory contains microbenchmarks comparing Hydro (DFIR) with other dataflow systems including timely and differential-dataflow.

### Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench identity
cargo bench -p benches --bench arithmetic
```

### Available Benchmarks

- **arithmetic** - Arithmetic operations performance
- **fan_in** - Fan-in operation patterns
- **fan_out** - Fan-out operation patterns
- **fork_join** - Fork-join patterns
- **futures** - Async futures benchmarks
- **identity** - Identity/passthrough operations
- **join** - Join operations
- **micro_ops** - Micro-operation benchmarks
- **reachability** - Graph reachability algorithms
- **symmetric_hash_join** - Symmetric hash join operations
- **upcase** - String transformation benchmarks
- **words_diamond** - Diamond-pattern word processing

See the [benches README](benches/README.md) for more details.

## Migration

These benchmarks were migrated from the main bigweaver-agent-canary-hydro-zeta repository to maintain performance testing capabilities while reducing the dependency burden on the core project.

For information about the migration process, refer to the commit history in the main repository.

## Dependencies

This repository depends on:
- **timely** (timely-master) - For timely dataflow benchmarks
- **differential-dataflow** (differential-dataflow-master) - For differential dataflow benchmarks
- **dfir_rs** - The core DFIR runtime from the main repository
- **criterion** - For benchmark harness and reporting

## Contributing

When adding new benchmarks:
1. Add the benchmark file to `benches/benches/`
2. Add a `[[bench]]` entry to `benches/Cargo.toml`
3. Update this README with a description of the benchmark
4. Ensure benchmarks use `harness = false` with criterion

## License

Apache-2.0