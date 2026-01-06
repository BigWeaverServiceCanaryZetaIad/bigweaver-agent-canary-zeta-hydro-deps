# bigweaver-agent-canary-zeta-hydro-deps

This repository contains dependencies and benchmarks for the Hydro project that have been separated from the main repository to reduce dependency bloat.

## Contents

### Benchmarks (`benches/`)

The `benches` directory contains performance benchmarks comparing Hydro implementations with timely-dataflow and differential-dataflow. These benchmarks help track performance characteristics and ensure Hydro remains competitive with other dataflow frameworks.

#### Available Benchmarks

- **arithmetic.rs** - Basic arithmetic operations
- **fan_in.rs** - Fan-in patterns
- **fan_out.rs** - Fan-out patterns
- **fork_join.rs** - Fork-join parallelism patterns
- **futures.rs** - Async/futures-based operations
- **identity.rs** - Identity transformations
- **join.rs** - Join operations
- **micro_ops.rs** - Micro-operations benchmarks
- **reachability.rs** - Graph reachability algorithms
- **symmetric_hash_join.rs** - Symmetric hash join operations
- **upcase.rs** - String transformation operations
- **words_diamond.rs** - Diamond pattern with text processing

#### Running Benchmarks

```bash
cargo bench
```

To run specific benchmarks:
```bash
cargo bench --bench <benchmark_name>
```

For example:
```bash
cargo bench --bench arithmetic
cargo bench --bench reachability
```

## Dependencies

The benchmarks depend on:
- `dfir_rs` - Referenced from the main hydro repository
- `sinktools` - Referenced from the main hydro repository
- `timely-master` - Timely dataflow framework
- `differential-dataflow-master` - Differential dataflow framework
- `criterion` - Benchmarking framework

## Migration Note

These benchmarks were migrated from the main `bigweaver-agent-canary-hydro-zeta` repository to keep the core codebase focused and reduce specialized dependencies in the main project.