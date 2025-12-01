# Hydro Dependencies and Benchmarks

This repository contains benchmarks and heavy dependencies that have been separated from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository. This separation helps:

- Reduce compilation time for the main repository
- Avoid unnecessary dependencies on packages like `timely` and `differential-dataflow` for core development
- Maintain performance comparison benchmarks without impacting main development workflow

## Contents

### Benchmarks

The `benches` directory contains microbenchmarks for Hydro and related dataflow systems, including benchmarks that compare Hydro with `timely` and `differential-dataflow`.

#### Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench micro_ops
```

View benchmark results:
Criterion will generate HTML reports in `target/criterion/` with detailed performance metrics and comparisons.

## Dependencies

This repository depends on:
- `dfir_rs` and `sinktools` from the main Hydro repository (referenced via git)
- `timely` and `differential-dataflow` for comparative benchmarking
- `criterion` for benchmark harness

## Contributing

For general Hydro development and contribution guidelines, see [CONTRIBUTING.md](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta/blob/main/CONTRIBUTING.md) in the main repository.