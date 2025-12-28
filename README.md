# bigweaver-agent-canary-zeta-hydro-deps

This repository contains dependencies and benchmarks that depend on external dataflow frameworks for the Hydro project.

## Contents

### Benchmarks

The `benches` directory contains performance comparison benchmarks between Hydro and other dataflow frameworks:
- **Timely Dataflow** - A low-latency cyclic dataflow framework
- **Differential Dataflow** - An incremental dataflow framework built on Timely

These benchmarks were separated from the main `bigweaver-agent-canary-hydro-zeta` repository to isolate the dependencies on these external packages.

## Running Benchmarks

To run all benchmarks:
```bash
cargo bench -p benches
```

To run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
```

See the [benches/README.md](benches/README.md) for more details on available benchmarks.

## Dependencies

This repository requires access to the `bigweaver-agent-canary-hydro-zeta` repository, as the benchmarks depend on:
- `dfir_rs` - The Hydro dataflow runtime
- `sinktools` - Utility tools for Hydro

These dependencies are referenced via relative paths in the Cargo.toml files.

## Related Repositories

- [bigweaver-agent-canary-hydro-zeta](../bigweaver-agent-canary-hydro-zeta) - Main Hydro project repository