# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for the Hydro project, separated from the main repository to maintain a cleaner codebase structure.

## Benchmarks

The `benches/` directory contains microbenchmarks for Hydro and other frameworks, including comparisons with timely-dataflow and differential-dataflow.

### Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench fork_join
```

### Benchmark Categories

- **DFIR Benchmarks**: Core Hydro/DFIR performance tests
- **Micro Operations**: Fine-grained operation benchmarks
- **Timely/Differential Comparisons**: Performance comparisons with timely-dataflow and differential-dataflow frameworks

For more information about the main Hydro project, see the [main repository](https://github.com/hydro-project/hydro).
