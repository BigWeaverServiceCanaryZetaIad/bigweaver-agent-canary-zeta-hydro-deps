# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks comparing Hydro framework performance against Timely Dataflow and Differential Dataflow.

## Overview

This repository was created to maintain clean separation of dependencies in the Hydro project. The benchmarks here depend on:
- `timely-master` (Timely Dataflow)
- `differential-dataflow-master` (Differential Dataflow)

These benchmarks enable performance comparisons between Hydro and these established dataflow frameworks.

## Structure

```
benches/
├── benches/           # Benchmark implementations
│   ├── arithmetic.rs
│   ├── fan_in.rs
│   ├── fan_out.rs
│   ├── fork_join.rs
│   ├── identity.rs
│   ├── join.rs
│   ├── reachability.rs
│   └── upcase.rs
└── README.md         # Benchmark documentation
```

## Running Benchmarks

To run all benchmarks:
```bash
cargo bench -p benches
```

To run a specific benchmark:
```bash
cargo bench -p benches --bench reachability
```

For more details, see [benches/README.md](benches/README.md).

## Related Repositories

- Main Hydro repository: Contains the core framework and other benchmarks that don't require Timely/Differential dependencies