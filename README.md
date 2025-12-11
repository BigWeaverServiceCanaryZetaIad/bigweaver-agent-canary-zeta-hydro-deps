# bigweaver-agent-canary-zeta-hydro-deps

This repository contains external dependency benchmarks for the Hydro project, specifically benchmarks that compare Hydro/DFIR performance against timely-dataflow and differential-dataflow.

## Purpose

This repository was created to:
- Separate timely-dataflow and differential-dataflow dependencies from the main Hydro repository
- Maintain performance comparison capabilities without polluting the main repository's dependency graph
- Enable independent testing and benchmarking of Hydro against other dataflow systems

## Structure

```
benches/
├── Cargo.toml           # Benchmark configuration with timely/differential dependencies
├── README.md            # Detailed benchmark documentation
├── build.rs             # Build script for generating benchmark code
└── benches/             # Benchmark implementations
    ├── arithmetic.rs
    ├── fan_in.rs
    ├── fan_out.rs
    ├── fork_join.rs
    ├── identity.rs
    ├── join.rs
    ├── reachability.rs
    ├── upcase.rs
    └── reachability_*.txt  # Data files for reachability benchmark
```

## Running Benchmarks

Navigate to the benches directory and run:

```bash
cd benches
cargo bench
```

For detailed instructions, see [benches/README.md](benches/README.md).

## Performance Comparisons

To perform performance comparisons between Hydro and timely/differential-dataflow:

1. Run benchmarks in this repository to establish timely/differential baseline
2. Run equivalent Hydro benchmarks in the main `bigweaver-agent-canary-hydro-zeta` repository
3. Compare results using the Criterion HTML reports in `target/criterion/`

## Dependencies

This repository depends on:
- Main Hydro repository (`dfir_rs`, `sinktools`) - fetched via git
- `timely-dataflow` - for timely dataflow benchmarks
- `differential-dataflow` - for differential dataflow benchmarks
- `criterion` - for benchmark framework

## Related Repositories

- [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) - Main Hydro repository