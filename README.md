# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmark implementations and dependencies for the Hydro project that use timely and differential-dataflow.

## Contents

- `benches/` - Microbenchmarks for Hydro and other crates

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
```

For more details, see [benches/README.md](benches/README.md).
