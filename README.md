# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks for timely and differential-dataflow performance comparisons with Hydro. These benchmarks were moved from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to avoid including timely and differential-dataflow dependencies in the main codebase.

## Microbenchmarks

Of Hydro and other crates.

Run all benchmarks:
```bash
cargo bench
```

Run specific benchmarks:
```bash
cargo bench --bench reachability
cargo bench --bench arithmetic
cargo bench --bench join
```

## Available Benchmarks

### Benchmarks with Timely/Differential Comparisons

These benchmarks include implementations for both Hydro and timely/differential-dataflow, allowing direct performance comparisons:

- **arithmetic** - Arithmetic operation benchmarks (Hydro vs Timely)
- **fan_in** - Fan-in pattern benchmarks (Hydro vs Timely)
- **fan_out** - Fan-out pattern benchmarks (Hydro vs Timely)
- **fork_join** - Fork-join pattern benchmarks (Hydro vs Timely)
- **identity** - Identity transformation benchmarks (Hydro vs Timely)
- **join** - Join operation benchmarks (Hydro vs Timely)
- **reachability** - Graph reachability benchmarks (Hydro vs Timely vs Differential)
- **upcase** - String transformation benchmarks (Hydro vs Timely)

### Hydro-Specific Benchmarks

These benchmarks focus on Hydro-specific features and optimizations:

- **futures** - Async futures benchmarks
- **micro_ops** - Micro-operations benchmarks
- **symmetric_hash_join** - Symmetric hash join benchmarks
- **words_diamond** - Diamond pattern word processing benchmarks

## Performance Comparison

The benchmarks with timely/differential comparisons allow for performance analysis between:
- **Hydro (dfir_rs)** - The Hydro dataflow system
- **Timely Dataflow** - Frank McSherry's timely dataflow system
- **Differential Dataflow** - Incremental computation framework built on Timely

Results are generated in HTML format and can be found in the `target/criterion` directory after running the benchmarks.

## Dependencies

This repository depends on:
- `dfir_rs` and `sinktools` from the main Hydro repository (via git)
- `timely-master` and `differential-dataflow-master` packages

## Data Files

- `reachability_edges.txt` - Edge data for graph reachability benchmarks
- `reachability_reachable.txt` - Expected reachable nodes for validation
- `words_alpha.txt` - Wordlist from https://github.com/dwyl/english-words