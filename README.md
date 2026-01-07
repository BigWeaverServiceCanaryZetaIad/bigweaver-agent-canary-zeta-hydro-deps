# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmark code and dependencies migrated from the bigweaver-agent-canary-hydro-zeta repository.

## Contents

- **benches/**: Performance benchmarks for Hydro and related crates, including:
  - `arithmetic.rs` - Arithmetic operations benchmark
  - `identity.rs` - Identity operation benchmark
  - `fork_join.rs` - Fork-join pattern benchmark
  - `upcase.rs` - Uppercase transformation benchmark
  - `fan_out.rs` - Fan-out pattern benchmark
  - `fan_in.rs` - Fan-in pattern benchmark
  - `join.rs` - Join operation benchmark
  - `reachability.rs` - Reachability algorithm benchmark
  - Additional benchmarks: `micro_ops.rs`, `symmetric_hash_join.rs`, `words_diamond.rs`, `futures.rs`

- **dfir_rs/**: Dataflow Intermediate Representation (DFIR) runtime
- **dfir_lang/**: DFIR language implementation
- **dfir_macro/**: DFIR macro support
- **sinktools/**: Stream sink utilities
- **hydro_build_utils/**: Build utilities for Hydro

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
```

## Dependencies

The benchmarks depend on:
- `timely` - Timely dataflow framework
- `differential-dataflow` - Differential dataflow framework
- `criterion` - Benchmarking framework

This separation maintains the ability to run performance comparisons while keeping the main repository free of these heavyweight dependencies.
