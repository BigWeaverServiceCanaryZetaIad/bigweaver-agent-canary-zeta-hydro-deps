# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks comparing Hydro against Timely Dataflow and Differential Dataflow frameworks.

## Structure

- `benches/` - Performance comparison benchmarks

## Running Benchmarks

To run all benchmarks:
```bash
cargo bench -p benches
```

To run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench join
```

For more information, see the [benches README](benches/README.md).