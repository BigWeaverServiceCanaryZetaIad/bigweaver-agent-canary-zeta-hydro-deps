# bigweaver-agent-canary-zeta-hydro-deps

This repository contains performance benchmarks and dependency testing for the BigWeaver Hydro project.

## Benchmarks

The `benches` directory contains microbenchmarks for DFIR and other frameworks, including:
- Timely benchmark implementations (identity, fork_join)
- Differential-dataflow benchmark implementations (reachability)
- Various performance comparison tests

### Running Benchmarks

To run all benchmarks:
```bash
cd benches
cargo bench
```

To run specific benchmarks:
```bash
cd benches
cargo bench --bench reachability
cargo bench --bench identity
cargo bench --bench fork_join
```

### Prerequisites

This repository requires the main `bigweaver-agent-canary-hydro-zeta` repository to be present as a sibling directory, as the benchmarks reference components from the main repository.

Repository structure should be:
```
parent-directory/
├── bigweaver-agent-canary-hydro-zeta/
└── bigweaver-agent-canary-zeta-hydro-deps/
```
