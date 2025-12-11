# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies that were moved from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to avoid including heavy dependencies like timely-dataflow and differential-dataflow in the main codebase.

## Structure

- `benches/` - Microbenchmarks comparing Hydro/DFIR with timely-dataflow and differential-dataflow implementations

## Benchmarks

The benchmarks in this repository allow performance comparison between DFIR (Hydro's dataflow runtime) and timely-dataflow/differential-dataflow implementations.

### Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p hydro-timely-differential-benches
```

Run specific benchmarks:
```bash
cargo bench -p hydro-timely-differential-benches --bench arithmetic
cargo bench -p hydro-timely-differential-benches --bench identity
cargo bench -p hydro-timely-differential-benches --bench join
cargo bench -p hydro-timely-differential-benches --bench reachability
```

### Available Benchmarks

- **arithmetic** - Pipeline of arithmetic operations
- **fan_in** - Multiple sources merging into one sink
- **fan_out** - One source splitting to multiple sinks
- **fork_join** - Fork-join pattern with filtering
- **identity** - Simple identity operation (passthrough)
- **join** - Join operations between two streams
- **reachability** - Graph reachability analysis
- **upcase** - String uppercase transformation

### Performance Comparison with Main Repository

To compare performance between DFIR-only benchmarks (in the main repository) and timely/differential implementations (in this repository):

1. Run benchmarks from the main repository:
   ```bash
   cd bigweaver-agent-canary-hydro-zeta
   cargo bench -p benches
   ```

2. Run benchmarks from this repository:
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps
   cargo bench -p hydro-timely-differential-benches
   ```

Criterion will save results in `target/criterion/` allowing comparison across different implementations and repositories.

## Dependencies

This repository includes the following major dependencies:
- `timely-dataflow` (timely-master) - For timely dataflow benchmarks
- `differential-dataflow` (differential-dataflow-master) - For differential dataflow benchmarks
- `dfir_rs` - Hydro's DFIR runtime for comparison benchmarks
- `criterion` - For benchmark harness and reporting