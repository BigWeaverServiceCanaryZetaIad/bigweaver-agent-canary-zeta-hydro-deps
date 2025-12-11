# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and utilities that depend on timely-dataflow and differential-dataflow for performance comparison with the DFIR (Dataflow Intermediate Representation) system in [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta).

## Purpose

The benchmarks in this repository allow for performance comparisons between DFIR and established dataflow systems (timely-dataflow and differential-dataflow). By maintaining these benchmarks separately, we avoid adding unnecessary dependencies to the main bigweaver-agent-canary-hydro-zeta repository.

## Contents

- `benches/` - Performance benchmarks comparing DFIR with timely-dataflow and differential-dataflow implementations

## Running Benchmarks

```bash
cargo bench -p benches
```

For more details, see the [benches/README.md](benches/README.md).

## Performance Comparisons

To compare DFIR performance against timely/differential-dataflow:

1. Run benchmarks in this repository: `cargo bench -p benches`
2. Run DFIR-only benchmarks in bigweaver-agent-canary-hydro-zeta: `cargo bench -p benches`
3. Compare the criterion HTML reports in `target/criterion/` from both repositories

Both repositories use the same criterion version and configuration for consistency in performance measurements.