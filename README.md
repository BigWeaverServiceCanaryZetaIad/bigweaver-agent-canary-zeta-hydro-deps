# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks for timely and differential-dataflow dependencies, isolated from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to avoid unnecessary dependencies in the main codebase.

## Purpose

This repository maintains performance benchmarks that depend on:
- `timely-master` dataflow framework
- `differential-dataflow-master` dataflow framework

By keeping these benchmarks separate, we ensure that the main hydro repository remains lean and free of these heavy dependencies, while still maintaining the ability to run performance comparisons between different dataflow implementations.

## Benchmarks

The following benchmarks are included:

### Timely Dataflow Benchmarks
- **arithmetic.rs** - Pipeline arithmetic operations benchmark
- **fan_in.rs** - Fan-in pattern benchmark
- **fan_out.rs** - Fan-out pattern benchmark
- **fork_join.rs** - Fork-join pattern benchmark
- **identity.rs** - Identity operation benchmark
- **join.rs** - Join operation benchmark
- **upcase.rs** - String uppercase transformation benchmark

### Differential Dataflow Benchmarks
- **reachability.rs** - Graph reachability computation benchmark (uses both timely and differential-dataflow)

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run a specific benchmark:
```bash
cargo bench -p benches --bench reachability
```

Run a specific test within a benchmark:
```bash
cargo bench -p benches --bench arithmetic -- "arithmetic/timely"
```

## Performance Comparisons

These benchmarks allow performance comparisons between:
- Raw Rust implementations
- Iterator-based approaches
- Timely dataflow
- Differential dataflow
- Hydroflow (via cross-repository references)

To compare performance across repositories, you can run benchmarks in both repositories and compare the criterion results in the `target/criterion` directories.

## Data Files

Some benchmarks require data files:
- **reachability_edges.txt** - Graph edges for reachability benchmark
- **reachability_reachable.txt** - Expected reachable nodes for verification
- **words_alpha.txt** - English word list for string processing benchmarks

## Dependencies

This package maintains references to the main hydro repository for:
- `dfir_rs` - For comparative benchmarking against Hydroflow
- `sinktools` - For compiled Hydroflow benchmarks

These references are intentionally kept as path dependencies to ensure performance comparisons remain possible between the two repositories.

## Migration History

These benchmarks were migrated from the main bigweaver-agent-canary-hydro-zeta repository to isolate timely and differential-dataflow dependencies. The main repository retains benchmarks that only depend on Hydroflow components (futures.rs, micro_ops.rs, symmetric_hash_join.rs, words_diamond.rs).

For the complete benchmark history, see the commit history in the [main repository](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta).

## Contributing

This repository is part of the Hydro project. For contribution guidelines, see the main repository.

## License

Apache-2.0