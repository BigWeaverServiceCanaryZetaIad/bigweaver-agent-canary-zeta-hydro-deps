# bigweaver-agent-canary-zeta-hydro-deps

This repository contains dependencies and benchmarks for the Hydro project that depend on external dataflow frameworks.

## Contents

### Benchmarks (`benches/`)

Performance benchmarks comparing Hydro/DFIR with Timely Dataflow and Differential Dataflow. These benchmarks have been moved here to isolate dependencies on `timely-master` and `differential-dataflow-master` from the main repository.

The benchmarks include:
- **arithmetic.rs** - Arithmetic operation benchmarks
- **fan_in.rs** - Fan-in pattern benchmarks
- **fan_out.rs** - Fan-out pattern benchmarks
- **fork_join.rs** - Fork-join pattern benchmarks
- **futures.rs** - Futures-based benchmarks
- **identity.rs** - Identity operation benchmarks
- **join.rs** - Join operation benchmarks with different data types
- **micro_ops.rs** - Micro-operations (map, flat_map, union, tee, fold, sort, etc.)
- **reachability.rs** - Graph reachability algorithm benchmarks
- **symmetric_hash_join.rs** - Symmetric hash join benchmarks
- **upcase.rs** - String uppercase transformation benchmarks
- **words_diamond.rs** - Diamond pattern word processing benchmarks

### Running Benchmarks

From the `benches` directory:

```bash
cargo bench
```

Or to run a specific benchmark:

```bash
cargo bench --bench reachability
```

## Dependencies

This repository references components from the main `bigweaver-agent-canary-hydro-zeta` repository via relative paths:
- `dfir_rs` - Core DFIR implementation
- `sinktools` - Utility tools

External dependencies:
- `timely-master` (version 0.13.0-dev.1)
- `differential-dataflow-master` (version 0.13.0-dev.1)
