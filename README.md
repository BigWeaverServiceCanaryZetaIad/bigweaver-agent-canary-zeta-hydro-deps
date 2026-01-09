# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmark dependencies for the Hydro project, specifically benchmarks that compare Hydroflow performance with timely-dataflow and differential-dataflow.

## Contents

### Benches Directory

The `benches/` directory contains performance comparison benchmarks:

- **fan_out.rs** - Tests fan-out patterns across different dataflow systems
- **identity.rs** - Identity transformation benchmarks
- **reachability.rs** - Graph reachability algorithm benchmarks (includes data files)
- **arithmetic.rs** - Basic arithmetic operations
- **fan_in.rs** - Fan-in pattern tests
- **fork_join.rs** - Fork-join pattern benchmarks
- **futures.rs** - Async futures benchmarks
- **join.rs** - Join operation benchmarks
- **micro_ops.rs** - Micro-operation benchmarks
- **symmetric_hash_join.rs** - Symmetric hash join benchmarks
- **upcase.rs** - String transformation benchmarks
- **words_diamond.rs** - Diamond pattern word processing benchmarks

### Dependencies

This repository maintains dependencies on:
- `timely` (package: timely-master, version: 0.13.0-dev.1)
- `differential-dataflow` (package: differential-dataflow-master, version: 0.13.0-dev.1)

These dependencies are used for performance comparison testing with Hydroflow.

## Usage

To run the benchmarks:

```bash
cargo bench
```

To run a specific benchmark:

```bash
cargo bench --bench <benchmark_name>
```

For example:
```bash
cargo bench --bench fan_out
cargo bench --bench reachability
```

## Related Repositories

This repository works in conjunction with:
- [bigweaver-agent-canary-hydro-zeta](https://github.com/hydro-project/hydro) - Main Hydroflow repository

The benchmarks in this repository enable performance comparisons between Hydroflow and timely/differential-dataflow implementations.