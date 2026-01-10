# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for the BigWeaver Canary Zeta Hydro project.

## Setup

This repository depends on `bigweaver-agent-canary-hydro-zeta` being cloned as a sibling directory. The expected directory structure is:

```
parent-directory/
├── bigweaver-agent-canary-hydro-zeta/
└── bigweaver-agent-canary-zeta-hydro-deps/
```

Clone both repositories:
```bash
git clone <bigweaver-agent-canary-hydro-zeta-repo-url>
git clone <bigweaver-agent-canary-zeta-hydro-deps-repo-url>
```

## Benchmarks

The `benches/` directory contains microbenchmarks for Hydro and related crates, including:
- Benchmarks using timely dataflow
- Benchmarks using differential-dataflow
- Performance comparison tests

### Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench upcase
cargo bench -p benches --bench fork_join
```

## Dependencies

This repository includes the following key dependencies:
- `timely` (timely-master) - For timely dataflow benchmarks
- `differential-dataflow` (differential-dataflow-master) - For differential dataflow benchmarks
- `criterion` - For benchmark infrastructure

## Relationship to Main Repository

This repository is a companion to `bigweaver-agent-canary-hydro-zeta`, containing benchmarks that were separated to reduce build times and maintenance overhead of heavy benchmark dependencies in the main repository.