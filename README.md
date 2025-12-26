# bigweaver-agent-canary-zeta-hydro-deps

This repository contains performance benchmarks that compare Hydroflow implementations with Timely Dataflow and Differential Dataflow.

## Contents

### Benchmarks (`benches/`)

Performance microbenchmarks comparing Hydroflow with Timely and Differential Dataflow implementations:

- **arithmetic.rs** - Arithmetic operation chains
- **fan_in.rs** - Fan-in dataflow patterns
- **fan_out.rs** - Fan-out dataflow patterns
- **fork_join.rs** - Fork-join patterns
- **futures.rs** - Async futures benchmarks
- **identity.rs** - Identity operation benchmarks
- **join.rs** - Join operation benchmarks
- **micro_ops.rs** - Micro-operation benchmarks
- **reachability.rs** - Graph reachability algorithms
- **symmetric_hash_join.rs** - Symmetric hash join benchmarks
- **upcase.rs** - String transformation benchmarks
- **words_diamond.rs** - Diamond-pattern word processing

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
```

## Dependencies

This repository includes benchmarks that depend on:
- `timely` (timely-master) - Timely Dataflow framework
- `differential-dataflow` (differential-dataflow-master) - Differential Dataflow framework
- `dfir_rs` - Hydroflow implementation (referenced from main hydro repository)
- `criterion` - Benchmarking framework

## Migration Note

These benchmarks were migrated from the `bigweaver-agent-canary-hydro-zeta` repository to maintain timely and differential-dataflow dependencies separately from the main Hydroflow codebase. The main repository now focuses on Hydroflow-only benchmarks for performance comparison purposes.