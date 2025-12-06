# bigweaver-agent-canary-zeta-hydro-deps

This repository contains dependencies and benchmarks for the Hydro project that have been separated from the main repository to reduce dependency overhead.

## Benchmarks

The `benches` directory contains performance benchmarks for Hydro that compare against timely-dataflow and differential-dataflow implementations.

### Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
```

### Available Benchmarks

- **arithmetic**: Basic arithmetic operations
- **fan_in**: Fan-in pattern benchmark
- **fan_out**: Fan-out pattern benchmark
- **fork_join**: Fork-join pattern benchmark
- **futures**: Async futures benchmark
- **identity**: Identity operation benchmark
- **join**: Join operation benchmark
- **micro_ops**: Micro-operations benchmark
- **reachability**: Graph reachability benchmark
- **symmetric_hash_join**: Symmetric hash join benchmark
- **upcase**: String uppercase operation benchmark
- **words_diamond**: Diamond pattern with word processing

### Repository Structure

This repository is designed to be cloned as a sibling to `bigweaver-agent-canary-hydro-zeta`. The benchmarks reference the main Hydro repository through relative paths:

```
projects/
├── bigweaver-agent-canary-hydro-zeta/
└── bigweaver-agent-canary-zeta-hydro-deps/
    └── benches/
```

## Performance Comparisons

These benchmarks allow performance comparisons between Hydro and timely/differential-dataflow implementations, helping to track performance improvements and regressions over time.