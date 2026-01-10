# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and code that depend on external packages like `timely` and `differential-dataflow`.

## Purpose

These benchmarks were separated from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to:

1. Keep the main repository clean from unnecessary dependencies
2. Retain the ability to run performance comparisons against timely/differential-dataflow
3. Maintain benchmark functionality while preventing dependency pollution

## Contents

- `benches/`: Timely and differential-dataflow benchmarks for Hydro

## Running Benchmarks

```bash
cargo bench -p hydro-timely-benchmarks
```

For more information, see the [benches README](benches/README.md).