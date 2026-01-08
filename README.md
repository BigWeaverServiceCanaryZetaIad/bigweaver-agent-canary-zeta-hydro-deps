# bigweaver-agent-canary-zeta-hydro-deps

This repository contains dependencies and benchmarks for the Hydro project that have been separated from the main repository to maintain cleaner dependency management.

## Contents

### Benchmarks (`/benches`)

Performance benchmarks for DFIR and other frameworks, including:

- **fan_out.rs** - Fan-out pattern benchmarks
- **fan_in.rs** - Fan-in pattern benchmarks  
- **reachability.rs** - Graph reachability benchmarks
- **arithmetic.rs** - Arithmetic operations benchmarks
- **identity.rs** - Identity transformation benchmarks
- **join.rs** - Join operation benchmarks
- **fork_join.rs** - Fork-join pattern benchmarks
- **symmetric_hash_join.rs** - Symmetric hash join benchmarks
- **micro_ops.rs** - Micro-operations benchmarks
- **futures.rs** - Futures-based benchmarks
- **upcase.rs** - String uppercase benchmarks
- **words_diamond.rs** - Word processing diamond pattern benchmarks

### Running Benchmarks

```bash
cargo bench -p benches
```

To run specific benchmarks:

```bash
cargo bench -p benches -- <benchmark_name>
```

### Dependencies

The benchmarks depend on:
- `dfir_rs` (via git) - DFIR runtime with debugging features
- `sinktools` (via git) - Utility tools
- `timely-master` - Timely dataflow framework
- `differential-dataflow-master` - Differential dataflow framework
- `criterion` - Benchmarking framework

## Purpose

This repository enables:
- **Cleaner dependency management** - Main repository avoids benchmark dependencies
- **Focused scope** - Separates performance testing from core functionality  
- **Independent versioning** - Benchmarks can evolve independently
- **Maintained performance testing** - Ability to run performance comparisons is preserved