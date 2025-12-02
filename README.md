# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies that depend on `timely` and `differential-dataflow` packages. These have been separated from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to:

- Reduce dependency bloat in the main repository
- Improve build times for the core codebase
- Maintain cleaner dependency management
- Preserve the ability to run performance comparisons

## Contents

### Benchmarks

The `benches/` directory contains performance benchmarks comparing Hydroflow with Timely Dataflow and Differential Dataflow implementations.

#### Running Benchmarks

To run all benchmarks:
```bash
cd benches
cargo bench
```

To run a specific benchmark:
```bash
cd benches
cargo bench --bench <benchmark_name>
```

Available benchmarks:
- `arithmetic` - Basic arithmetic operations
- `fan_in` - Fan-in dataflow patterns
- `fan_out` - Fan-out dataflow patterns  
- `fork_join` - Fork-join patterns
- `identity` - Identity operations
- `upcase` - String uppercase operations
- `join` - Join operations
- `reachability` - Graph reachability algorithms
- `micro_ops` - Micro-operation benchmarks
- `symmetric_hash_join` - Symmetric hash join operations
- `words_diamond` - Word processing diamond pattern
- `futures` - Future-based operations

#### Benchmark Results

Benchmark results are generated in `benches/target/criterion/` with HTML reports showing performance comparisons.

## Migration Information

These benchmarks were moved from the main repository to improve build performance and dependency management. For historical context, see the [migration guide](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta/blob/main/docs/BENCHMARKS_MIGRATION.md) in the main repository.

## Contributing

When adding new benchmarks that depend on `timely` or `differential-dataflow`, please add them to this repository rather than the main repository.