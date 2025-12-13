# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks that depend on timely-dataflow and differential-dataflow packages, which have been moved from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/hydro-project/bigweaver-agent-canary-hydro-zeta) repository to reduce dependency complexity and build times.

## Overview

The benchmarks in this repository compare DFIR performance with timely-dataflow and differential-dataflow implementations across various operations:

- **arithmetic.rs** - Arithmetic operation benchmarks
- **fan_in.rs** - Multiple input streams merging benchmarks
- **fan_out.rs** - Single stream splitting benchmarks
- **fork_join.rs** - Fork-join pattern benchmarks
- **identity.rs** - Identity/passthrough operation benchmarks
- **join.rs** - Join operation benchmarks
- **micro_ops.rs** - Micro-benchmarks for basic operations
- **reachability.rs** - Graph reachability benchmarks (with test data files)
- **symmetric_hash_join.rs** - Symmetric hash join benchmarks
- **upcase.rs** - String transformation benchmarks
- **words_diamond.rs** - Word processing benchmarks

## Prerequisites

This repository requires both repositories to be cloned as siblings:

```
/projects/
  ├── bigweaver-agent-canary-hydro-zeta/      # Main repository
  └── bigweaver-agent-canary-zeta-hydro-deps/ # This repository
```

## Running Benchmarks

To run all benchmarks:

```bash
cd benches
cargo bench
```

To run a specific benchmark:

```bash
cd benches
cargo bench --bench arithmetic
```

To run benchmarks with specific features:

```bash
cd benches
cargo bench --bench identity -- --save-baseline my_baseline
```

## Benchmark Results

Results are stored in `target/criterion/` and can be viewed by opening the generated HTML reports.

## Comparing with Main Repository

These benchmarks allow you to compare the performance of DFIR implementations against timely-dataflow and differential-dataflow. This is useful for:

1. **Performance validation** - Ensuring DFIR maintains competitive performance
2. **Regression detection** - Identifying performance regressions in DFIR
3. **Optimization guidance** - Understanding where performance improvements can be made

## Why Separate Repository?

The timely-dataflow and differential-dataflow dependencies were moved to this separate repository to:

1. **Reduce build times** - Main repository builds faster without these dependencies
2. **Simplify dependencies** - Main repository has fewer transitive dependencies
3. **Maintain comparisons** - Performance comparisons can still be run when needed
4. **Separate concerns** - Benchmarking infrastructure is isolated from core implementation

## Contributing

When adding new benchmarks:

1. Add the benchmark file to `benches/benches/`
2. Add a `[[bench]]` entry in `benches/Cargo.toml`
3. Ensure the benchmark compares DFIR with timely/differential implementations
4. Update this README with benchmark description

## Documentation

For more information about DFIR and the main repository, see the [main repository README](https://github.com/hydro-project/bigweaver-agent-canary-hydro-zeta).