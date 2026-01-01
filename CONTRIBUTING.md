# Contributing to Hydro Benchmarks

This repository contains microbenchmarks for the Hydro project, including performance comparisons with Timely Dataflow and Differential Dataflow.

## Running Benchmarks

### Prerequisites

- Rust toolchain (see main [Hydro repository](https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) for version requirements)

### Execute Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench upcase
cargo bench -p benches --bench join
cargo bench -p benches --bench micro_ops
```

### View Results

Benchmark results are saved in HTML format in `target/criterion/`. Open `target/criterion/report/index.html` in a browser to view detailed performance reports.

## Available Benchmarks

### Core Operation Benchmarks
- **arithmetic.rs**: Arithmetic operation benchmarks
- **identity.rs**: Identity operation benchmarks
- **micro_ops.rs**: Micro-operations (map, flat_map, union, tee, fold, sort, etc.)

### Graph and Join Benchmarks
- **reachability.rs**: Graph reachability algorithm benchmarks
- **join.rs**: Join operation benchmarks
- **symmetric_hash_join.rs**: Symmetric hash join benchmarks

### Pattern Benchmarks
- **fan_in.rs** / **fan_out.rs**: Fan-in and fan-out pattern benchmarks
- **fork_join.rs**: Fork-join pattern benchmarks
- **words_diamond.rs**: Word processing diamond pattern benchmarks

### Other Benchmarks
- **upcase.rs**: String uppercase operation benchmarks
- **futures.rs**: Async futures benchmarks

## Benchmark Data Files

The `benches/benches` directory contains test data:
- `reachability_edges.txt`: Graph edges for reachability tests
- `reachability_reachable.txt`: Expected reachable nodes
- `words_alpha.txt`: English word list from [dwyl/english-words](https://github.com/dwyl/english-words/blob/master/words_alpha.txt)

## Dependencies

This repository depends on:
- **dfir_rs**: Main DFIR package from the Hydro repository
- **sinktools**: Utility tools from the Hydro repository
- **timely-master**: Timely Dataflow for comparison benchmarks
- **differential-dataflow-master**: Differential Dataflow for comparison benchmarks
- **criterion**: Statistics-driven benchmarking framework

These dependencies are automatically fetched from their respective repositories when building the benchmarks.

## Adding New Benchmarks

1. Create a new `.rs` file in `benches/benches/`
2. Add a corresponding `[[bench]]` section to `benches/Cargo.toml`
3. Follow the existing benchmark structure using Criterion
4. Ensure the benchmark includes comparisons with relevant frameworks (Timely, Differential Dataflow) when applicable

## Submitting Changes

Follow the same guidelines as the main Hydro repository:
- Use Conventional Commits for PR titles and bodies
- Ensure benchmarks run successfully before submitting
- Document any new benchmarks in the README.md
