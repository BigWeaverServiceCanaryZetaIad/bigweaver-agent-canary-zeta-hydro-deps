# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and code that depends on timely and differential-dataflow, separated from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository.

## Purpose

The purpose of this repository is to:

1. **Keep the main repository clean**: By separating timely/differential-dataflow dependencies, the main repository remains focused on Hydro/dfir_rs without dependency bloat.

2. **Retain performance comparison capabilities**: This repository maintains benchmarks that compare Hydro's performance with timely and differential-dataflow implementations, enabling ongoing performance validation.

3. **Enable cross-repository integration**: Dependencies are referenced via git, allowing these benchmarks to use the latest versions of dfir_rs and related crates from the main repository.

## Structure

```
benches/
├── Cargo.toml          # Benchmark package with timely/differential dependencies
├── README.md           # Benchmark-specific documentation
├── build.rs            # Build script for code generation
└── benches/            # Benchmark implementations
    ├── arithmetic.rs
    ├── fan_in.rs
    ├── fan_out.rs
    ├── fork_join.rs
    ├── identity.rs
    ├── join.rs
    ├── reachability.rs
    ├── upcase.rs
    └── [data files]
```

## Running Benchmarks

Navigate to the benches directory and run:

```bash
cd benches
cargo bench
```

Or run specific benchmarks:

```bash
cargo bench --bench reachability
cargo bench --bench arithmetic
```

## Dependencies

These benchmarks depend on:
- **timely-master** (v0.13.0-dev.1)
- **differential-dataflow-master** (v0.13.0-dev.1)
- **dfir_rs** (referenced from main repository via git)
- **sinktools** (referenced from main repository via git)

## Integration with Main Repository

The benchmarks reference `dfir_rs` and `sinktools` from the main repository using git dependencies. This ensures that performance comparisons are always made against the current version of the code in the main repository.

## Contributing

When adding new benchmarks that require timely or differential-dataflow:
1. Add the benchmark files to `benches/benches/`
2. Update `benches/Cargo.toml` to include the new benchmark
3. Update documentation as needed

For general Hydro development, contribute to the [main repository](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta).