# bigweaver-agent-canary-zeta-hydro-deps

This repository contains components that depend on `timely` and `differential-dataflow`, separated from the main `bigweaver-agent-canary-hydro-zeta` repository to maintain clean dependency management.

## Contents

### Benchmarks

The `benches` directory contains microbenchmarks for DFIR (Dataflow Intermediate Representation) and other dataflow frameworks, including comparisons with Timely Dataflow and Differential Dataflow.

To run all benchmarks:
```bash
cargo bench -p benches
```

To run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench identity
cargo bench -p benches --bench join
```

For more information, see [benches/README.md](benches/README.md).