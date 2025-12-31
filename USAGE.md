# Running Benchmarks

This repository contains performance benchmarks for the Hydro/DFIR project, including comparisons with Timely Dataflow and Differential Dataflow.

## Prerequisites

1. Rust toolchain (see `../bigweaver-agent-canary-hydro-zeta/rust-toolchain.toml` for version)
2. The main `bigweaver-agent-canary-hydro-zeta` repository must be located at `../bigweaver-agent-canary-hydro-zeta` relative to this repository

## Running All Benchmarks

From this repository root:

```bash
cargo bench -p benches
```

## Running Specific Benchmarks

### Graph Algorithms
```bash
cargo bench -p benches --bench reachability
```

### Join Operations
```bash
cargo bench -p benches --bench join
cargo bench -p benches --bench symmetric_hash_join
```

### Micro-operations
```bash
cargo bench -p benches --bench micro_ops
```

### Flow Patterns
```bash
cargo bench -p benches --bench fan_in
cargo bench -p benches --bench fan_out
cargo bench -p benches --bench fork_join
cargo bench -p benches --bench identity
cargo bench -p benches --bench upcase
cargo bench -p benches --bench words_diamond
```

### Other Benchmarks
```bash
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench futures
```

## Benchmark Output

Benchmark results are generated using Criterion and include:
- HTML reports in `target/criterion/`
- Statistical analysis of performance
- Comparison with previous runs (if available)

## Dependencies

Key external dependencies used for comparison:
- `timely-master` (v0.13.0-dev.1) - Timely Dataflow
- `differential-dataflow-master` (v0.13.0-dev.1) - Differential Dataflow

Key internal dependencies:
- `dfir_rs` - Main Hydro/DFIR runtime (from main repository)
- `sinktools` - Data sink utilities (from main repository)

## Troubleshooting

If benchmarks fail to compile:
1. Ensure the main repository is at `../bigweaver-agent-canary-hydro-zeta`
2. Ensure you're using the correct Rust toolchain version
3. Try running `cargo clean` and rebuilding

For path issues, check that:
- `../bigweaver-agent-canary-hydro-zeta/dfir_rs` exists
- `../bigweaver-agent-canary-hydro-zeta/sinktools` exists
