# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies that were moved from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/hydro-project/hydro) repository to keep that repository focused on core functionality without heavy external dependencies.

## Contents

### Hydro Benchmarks (`hydro_benches`)

Performance benchmarks for timely and differential-dataflow dependencies. These benchmarks help track performance characteristics of Hydro when using timely dataflow and differential dataflow backends.

#### Available Benchmarks

- **arithmetic.rs** - Arithmetic operations benchmarks
- **fan_in.rs** - Fan-in pattern benchmarks
- **fan_out.rs** - Fan-out pattern benchmarks
- **fork_join.rs** - Fork-join pattern benchmarks
- **futures.rs** - Futures-based operations benchmarks
- **identity.rs** - Identity transformation benchmarks
- **join.rs** - Join operation benchmarks
- **micro_ops.rs** - Micro-operations benchmarks
- **reachability.rs** - Graph reachability benchmarks
- **symmetric_hash_join.rs** - Symmetric hash join benchmarks
- **upcase.rs** - String uppercase transformation benchmarks
- **words_diamond.rs** - Diamond pattern with word processing benchmarks

#### Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p hydro_benches
```

Run specific benchmarks:
```bash
cargo bench -p hydro_benches --bench reachability
cargo bench -p hydro_benches --bench arithmetic
cargo bench -p hydro_benches --bench join
```

#### Performance Comparison

To compare performance across versions:

1. Run benchmarks on the baseline version and save results
2. Make your changes
3. Run benchmarks again
4. Use criterion's comparison features to analyze differences

```bash
# Baseline
cargo bench -p hydro_benches -- --save-baseline baseline

# After changes
cargo bench -p hydro_benches -- --baseline baseline
```

## Data Files

- **words_alpha.txt** - English word list from https://github.com/dwyl/english-words/blob/master/words_alpha.txt
- **reachability_edges.txt** - Graph edges for reachability benchmarks
- **reachability_reachable.txt** - Expected reachable nodes for validation

## Migration Information

These benchmarks were moved from the main repository to:
1. Reduce the dependency footprint of the main repository
2. Improve build times for developers not working on performance optimization
3. Keep the main repository focused on core Hydro functionality
4. Maintain the ability to run performance comparisons when needed

For the main Hydro repository and core functionality, see: https://github.com/hydro-project/hydro

## Dependencies

This repository depends on:
- `timely-master` - Timely dataflow framework
- `differential-dataflow-master` - Differential dataflow library
- `dfir_rs` - From the main Hydro repository (referenced via git)
- `sinktools` - From the main Hydro repository (referenced via git)
- `criterion` - For benchmark harness

## Contributing

These benchmarks are part of the Hydro project ecosystem. For contribution guidelines, please see the main repository's [CONTRIBUTING.md](https://github.com/hydro-project/hydro/blob/main/CONTRIBUTING.md).
