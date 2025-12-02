# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for the Hydro project that require heavyweight dependencies like `timely` and `differential-dataflow`.

## Benchmarks

The `benches/` directory contains microbenchmarks for Hydro and related crates. These benchmarks were moved from the main `bigweaver-agent-canary-hydro-zeta` repository to avoid introducing unwanted dependencies in the main codebase.

### Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
```

### Available Benchmarks

- **arithmetic**: Arithmetic operations benchmarking
- **fan_in**: Fan-in pattern performance
- **fan_out**: Fan-out pattern performance
- **fork_join**: Fork-join pattern performance
- **futures**: Futures-based async operations
- **identity**: Identity transformation performance
- **join**: Join operations benchmarking
- **micro_ops**: Micro-operations performance
- **reachability**: Graph reachability algorithms
- **symmetric_hash_join**: Symmetric hash join performance
- **upcase**: String transformation benchmarks
- **words_diamond**: Diamond pattern word processing

### Performance Comparisons

The benchmarks retain the ability to run performance comparisons between different implementations and optimizations. Each benchmark uses the Criterion framework which provides statistical analysis and comparison capabilities.

## Migration Information

These benchmarks were previously located in the `bigweaver-agent-canary-hydro-zeta` repository under the `benches/` directory. They were moved to this dedicated repository to:

1. **Isolate Dependencies**: Keep heavyweight dependencies (`timely`, `differential-dataflow`) separate from the main codebase
2. **Improve Build Times**: Reduce compilation time for the main repository
3. **Maintain Clean Architecture**: Follow the team's principle of dependency isolation
4. **Preserve Functionality**: All benchmark functionality and configuration has been preserved

### Related Repositories

- **Main Repository**: [bigweaver-agent-canary-hydro-zeta](https://github.com/hydro-project/hydro) - Core Hydro implementation
- **Benchmark Repository**: This repository - Performance benchmarks with heavy dependencies