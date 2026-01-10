# bigweaver-agent-canary-zeta-hydro-deps

This repository contains dependencies and benchmarks for the BigWeaver Hydro project.

## Benchmarks

The `benches/` directory contains microbenchmarks for Hydro and related crates, including benchmarks that use timely-dataflow and differential-dataflow operators.

### Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench join
cargo bench -p benches --bench fork_join
```

For more details, see [benches/README.md](benches/README.md).