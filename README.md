# bigweaver-agent-canary-zeta-hydro-deps

This repository contains dependencies and benchmarks for the Hydro project that depend on external libraries like timely-dataflow and differential-dataflow.

## Contents

### Benchmarks

The `benches` directory contains microbenchmarks comparing Hydro/dfir_rs with timely-dataflow and differential-dataflow. These benchmarks were moved from the main hydro repository to avoid including heavy dependencies in the main codebase.

To run the benchmarks:
```bash
cargo bench -p benches
```

To run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench fan_in
cargo bench -p benches --bench arithmetic
```

For more information, see [benches/README.md](benches/README.md).