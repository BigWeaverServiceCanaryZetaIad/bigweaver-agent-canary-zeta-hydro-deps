# bigweaver-agent-canary-zeta-hydro-deps

This repository contains performance comparison benchmarks and dependencies for the Hydro distributed programming framework. These benchmarks compare Hydro's performance with other dataflow frameworks like timely and differential-dataflow.

## Purpose

This repository was created to:
- Maintain performance comparison benchmarks separate from the main Hydro repository
- Reduce the dependency footprint of the main Hydro codebase
- Preserve the ability to run performance comparisons when needed
- Keep timely and differential-dataflow dependencies isolated

## Contents

### `benches/`
Comparison benchmarks that test Hydro against timely and differential-dataflow:
- `arithmetic.rs` - Arithmetic operations benchmark
- `fan_in.rs` - Fan-in pattern benchmark
- `fan_out.rs` - Fan-out pattern benchmark
- `fork_join.rs` - Fork-join pattern benchmark
- `futures.rs` - Futures-based benchmark
- `identity.rs` - Identity operation benchmark
- `join.rs` - Join operation benchmark
- `micro_ops.rs` - Micro-operations benchmark
- `reachability.rs` - Graph reachability benchmark
- `symmetric_hash_join.rs` - Symmetric hash join benchmark
- `upcase.rs` - String uppercase benchmark
- `words_diamond.rs` - Words diamond pattern benchmark

### `hydro_benchmarks/`
Hydro-specific benchmarks that were originally in the `hydro_test` package:
- `paxos_bench` module - Paxos consensus protocol benchmark
- `two_pc_bench` module - Two-phase commit protocol benchmark

These benchmarks reference the main Hydro repository for the core implementations and provide benchmark harnesses.

## Running Benchmarks

### Run all benchmarks:
```bash
cargo bench -p benches
```

### Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench join
```

### Run with baseline comparison:
```bash
# Establish a baseline
cargo bench -p benches -- --save-baseline main

# After making changes to Hydro, compare against baseline
cargo bench -p benches -- --baseline main
```

## Dependencies

This repository depends on:
- **Hydro**: Referenced as a git dependency from the main repository
- **timely**: Master branch of the timely dataflow framework
- **differential-dataflow**: Master branch of differential dataflow

## Migration Information

These benchmarks were moved from the main Hydro repository. For details about the migration, see the [BENCHMARKS_MIGRATION.md](https://github.com/hydro-project/hydro/blob/main/BENCHMARKS_MIGRATION.md) file in the main Hydro repository.

## Contributing

When adding new performance comparison benchmarks:
1. Add the benchmark file to `benches/benches/`
2. Register it as a `[[bench]]` section in `benches/Cargo.toml`
3. Ensure it compares Hydro with timely/differential-dataflow where appropriate
4. Document the benchmark purpose in this README

## Questions or Issues

For issues specific to these benchmarks, open an issue in this repository. For general Hydro issues, use the [main Hydro repository](https://github.com/hydro-project/hydro).