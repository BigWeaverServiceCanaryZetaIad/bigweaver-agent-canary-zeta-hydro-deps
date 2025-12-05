# bigweaver-agent-canary-zeta-hydro-deps

This repository contains external dependencies and benchmarks for the Hydro project, including performance comparisons with timely-dataflow and differential-dataflow.

## Benchmarks

The `benches` directory contains microbenchmarks comparing Hydro (DFIR) with timely-dataflow and differential-dataflow implementations.

### Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench micro_ops
cargo bench -p benches --bench join
```

### Available Benchmarks

- **arithmetic** - Basic arithmetic operations
- **fan_in** - Fan-in patterns
- **fan_out** - Fan-out patterns  
- **fork_join** - Fork-join patterns
- **futures** - Async futures operations
- **identity** - Identity transformations
- **join** - Join operations
- **micro_ops** - Micro-operation benchmarks
- **reachability** - Graph reachability algorithms
- **symmetric_hash_join** - Symmetric hash join operations
- **upcase** - String transformation benchmarks
- **words_diamond** - Diamond pattern text processing

For more details, see [benches/README.md](benches/README.md).