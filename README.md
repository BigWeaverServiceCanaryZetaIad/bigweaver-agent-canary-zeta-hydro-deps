# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks that depend on external dataflow frameworks (`timely` and `differential-dataflow`), which were migrated from the [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository.

## Purpose

The benchmarks in this repository enable performance comparisons between Hydro (DFIR) and established dataflow frameworks like Timely Dataflow and Differential Dataflow. By isolating these dependencies in a separate repository, we:

1. **Simplify the main repository's dependency graph** - Reduce complexity in the core Hydro repository
2. **Isolate external framework dependencies** - Keep timely and differential-dataflow separate from the main codebase
3. **Retain performance comparison capabilities** - Continue to measure and compare performance across frameworks

## Structure

```
.
├── benches/              # Benchmark package
│   ├── benches/          # Benchmark source files
│   │   ├── arithmetic.rs
│   │   ├── fan_in.rs
│   │   ├── fan_out.rs
│   │   ├── fork_join.rs
│   │   ├── identity.rs
│   │   ├── join.rs
│   │   ├── reachability.rs
│   │   ├── reachability_edges.txt
│   │   ├── reachability_reachable.txt
│   │   └── upcase.rs
│   ├── Cargo.toml       # Benchmark dependencies
│   └── README.md        # Benchmark documentation
├── Cargo.toml           # Workspace configuration
└── README.md            # This file
```

## Running Benchmarks

To run the benchmarks, you need to have Rust installed. Then:

```bash
# Run all benchmarks
cargo bench -p benches

# Run specific benchmarks
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench join
```

## Dependencies

This repository depends on:
- `timely` (timely-master v0.13.0-dev.1)
- `differential-dataflow` (differential-dataflow-master v0.13.0-dev.1)
- `dfir_rs` and `sinktools` from the main bigweaver-agent-canary-hydro-zeta repository (via git dependency)

## Migration History

These benchmarks were migrated from the main bigweaver-agent-canary-hydro-zeta repository to preserve performance testing capabilities while simplifying the main repository's dependencies. For detailed information about the migration, see the BENCHMARK_MIGRATION.md file in the main repository.

## Contributing

When adding new benchmarks that compare Hydro with external dataflow frameworks, please add them to this repository rather than the main bigweaver-agent-canary-hydro-zeta repository.