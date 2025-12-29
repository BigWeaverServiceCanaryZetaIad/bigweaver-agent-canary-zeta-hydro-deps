# bigweaver-agent-canary-zeta-hydro-deps

This repository contains dependencies and benchmarks that depend on heavy external packages like `timely` and `differential-dataflow`. This separation helps keep the main repository cleaner and lighter.

## Contents

- `benches/` - Microbenchmarks for DFIR and other dataflow frameworks

## Running Benchmarks

The benchmarks require the main `bigweaver-agent-canary-hydro-zeta` repository to be present in the same parent directory.

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
```

For more details, see [benches/README.md](benches/README.md).