# bigweaver-agent-canary-zeta-hydro-deps

This repository contains performance benchmarks and external framework dependencies for the Hydro project.

## Purpose

This repository was created to separate benchmark-specific dependencies (timely, differential-dataflow) from the main Hydro repository. This separation:

- Reduces unnecessary dependencies in the core codebase
- Improves build times for the main repository
- Maintains clear boundaries between production code and performance testing infrastructure
- Allows independent evolution of benchmarking code and framework comparisons

## Contents

### Benchmarks (`benches/`)

Performance benchmarks for DFIR and comparison benchmarks against other dataflow frameworks:

- **fork_join.rs** - Fork-join pattern benchmarks comparing DFIR, timely, and raw implementations
- **fan_in.rs** - Fan-in pattern benchmarks comparing DFIR and timely
- **reachability.rs** - Graph reachability benchmarks using differential-dataflow
- **arithmetic.rs** - Arithmetic operation benchmarks
- **join.rs** - Join operation benchmarks
- **identity.rs** - Identity operation benchmarks
- **upcase.rs** - String uppercasing benchmarks
- **words_diamond.rs** - Diamond-shaped dataflow benchmarks
- **symmetric_hash_join.rs** - Symmetric hash join benchmarks
- **micro_ops.rs** - Micro-operation benchmarks
- **futures.rs** - Futures-based async benchmarks
- **fan_out.rs** - Fan-out pattern benchmarks

## Dependencies

The benchmarks depend on:

- **timely-master** (0.13.0-dev.1) - Timely dataflow framework for performance comparisons
- **differential-dataflow-master** (0.13.0-dev.1) - Differential dataflow framework for performance comparisons
- **dfir_rs** (from main repository) - The core Hydro/DFIR runtime
- **sinktools** (from main repository) - Sink utilities for DFIR

## Running Benchmarks

To run the benchmarks:

```bash
cargo bench
```

To run a specific benchmark:

```bash
cargo bench --bench fork_join
cargo bench --bench fan_in
cargo bench --bench reachability
```

## Related Repositories

- **bigweaver-agent-canary-hydro-zeta** - Main Hydro/DFIR repository containing the core runtime and language implementation
