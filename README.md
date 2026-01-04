# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for the Hydro project that use timely and differential-dataflow dependencies.

## Contents

### Benchmarks

The `benches/` directory contains performance benchmarks for distributed protocols including:

- **arithmetic.rs** - Arithmetic operations benchmarks
- **fan_in.rs** - Fan-in pattern benchmarks
- **fan_out.rs** - Fan-out pattern benchmarks
- **fork_join.rs** - Fork-join pattern benchmarks
- **futures.rs** - Futures-based benchmarks
- **identity.rs** - Identity operation benchmarks
- **join.rs** - Join operation benchmarks
- **micro_ops.rs** - Micro-operation benchmarks
- **reachability.rs** - Graph reachability benchmarks
- **symmetric_hash_join.rs** - Symmetric hash join benchmarks
- **upcase.rs** - String uppercase benchmarks
- **words_diamond.rs** - Word processing diamond pattern benchmarks

### Running Benchmarks

To run the benchmarks:

```bash
cargo bench -p benches
```

To run specific benchmarks:

```bash
cargo bench -p benches -- <benchmark_name>
```

### Dependencies

This repository maintains benchmarks that depend on:
- `timely` - Timely dataflow library
- `differential-dataflow` - Differential dataflow library
- `dfir_rs` - From the main hydro repository
- `sinktools` - From the main hydro repository

These dependencies are isolated in this repository to avoid adding them to the main production codebase.
