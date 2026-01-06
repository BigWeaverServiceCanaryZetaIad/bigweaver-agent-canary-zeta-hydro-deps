# Contributing to Hydro Benchmarks

This repository contains benchmarks comparing DFIR/Hydro performance against Timely Dataflow and Differential Dataflow frameworks.

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench fan_in
cargo bench -p benches --bench micro_ops
```

## Benchmark Structure

The benchmarks are organized in the `benches/benches/` directory:

- `reachability.rs` - Graph reachability algorithms
- `fan_in.rs` / `fan_out.rs` - Dataflow fan-in/fan-out operations
- `join.rs` / `symmetric_hash_join.rs` - Join operations
- `micro_ops.rs` - Micro-operations (map, flat_map, union, tee, fold, sort, etc.)
- `arithmetic.rs` - Arithmetic operations
- `fork_join.rs` - Fork-join patterns
- `identity.rs` / `upcase.rs` - Simple transformation operations
- `words_diamond.rs` - Word processing with diamond patterns
- `futures.rs` - Async/futures-based operations

## Dependencies

The benchmarks depend on:
- `timely` (timely-master package) - Timely Dataflow framework
- `differential-dataflow` (differential-dataflow-master package) - Differential Dataflow framework
- `dfir_rs` - Hydro/DFIR runtime (from main Hydro repository)
- `sinktools` - Sink utilities (from main Hydro repository)
- `criterion` - Benchmarking framework with statistical analysis

## CI/CD

Benchmarks are run automatically via GitHub Actions workflow (`.github/workflows/benchmark.yml`) on:
- Scheduled runs (daily)
- Manual workflow dispatch
- Commits/PRs with `[ci-bench]` in the title or body

Results are published to the `gh-pages` branch for visualization.

## Rust Toolchain

This repository uses the same Rust toolchain as the main Hydro repository. The version is specified in `rust-toolchain.toml` and is automatically detected by `cargo`.
