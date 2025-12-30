# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and other dependencies for the Hydro project that have been separated from the main repository to reduce dependency footprint.

## Contents

### Benchmarks

Performance benchmarks comparing Hydro with Timely Dataflow and Differential Dataflow implementations.

#### Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench join
cargo bench -p benches --bench micro_ops
```

#### Available Benchmarks

- **arithmetic** - Arithmetic operations performance
- **fan_in** - Fan-in pattern benchmarks
- **fan_out** - Fan-out pattern benchmarks
- **fork_join** - Fork-join pattern benchmarks
- **identity** - Identity transformation benchmarks
- **upcase** - String uppercase transformation
- **join** - Join operations
- **reachability** - Graph reachability algorithms
- **micro_ops** - Micro-operations (map, flat_map, union, tee, fold, sort)
- **symmetric_hash_join** - Symmetric hash join operations
- **words_diamond** - Word processing diamond pattern
- **futures** - Futures-based operations

## Purpose

This repository serves to:
- House benchmarks that require dependencies not needed by core Hydro users
- Maintain the ability to run performance comparisons
- Keep the main repository lean and focused on core functionality
- Prevent inclusion of timely and differential-dataflow dependencies in the main repository

## Dependencies

The benchmarks in this repository maintain path dependencies to the main `bigweaver-agent-canary-hydro-zeta` repository. Ensure both repositories are checked out in the same parent directory:

```
parent-directory/
  ├── bigweaver-agent-canary-hydro-zeta/
  └── bigweaver-agent-canary-zeta-hydro-deps/
```
