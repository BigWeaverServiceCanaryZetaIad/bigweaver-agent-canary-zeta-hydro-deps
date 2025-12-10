# Benchmark Migration Guide

## Overview

The timely and differential-dataflow benchmarks have been moved from the `bigweaver-agent-canary-hydro-zeta` repository to this dedicated `bigweaver-agent-canary-zeta-hydro-deps` repository.

## Motivation

This migration was performed to:
1. **Reduce dependency footprint** - The main repository no longer needs to include timely-master and differential-dataflow-master dependencies
2. **Improve build times** - Users of the main repository won't need to build these additional dependencies
3. **Maintain separation of concerns** - Benchmarks comparing with external frameworks are kept separate from the core codebase
4. **Preserve performance comparison capability** - All benchmarks remain available and functional in this repository

## What Was Moved

The following files were moved from `bigweaver-agent-canary-hydro-zeta`:

### Benchmark Files
- `benches/benches/arithmetic.rs`
- `benches/benches/fan_in.rs`
- `benches/benches/fan_out.rs`
- `benches/benches/fork_join.rs`
- `benches/benches/futures.rs`
- `benches/benches/identity.rs`
- `benches/benches/join.rs`
- `benches/benches/micro_ops.rs`
- `benches/benches/reachability.rs`
- `benches/benches/reachability_edges.txt`
- `benches/benches/reachability_reachable.txt`
- `benches/benches/symmetric_hash_join.rs`
- `benches/benches/upcase.rs`
- `benches/benches/words_alpha.txt`
- `benches/benches/words_diamond.rs`
- `benches/benches/.gitignore`

### Configuration Files
- `benches/Cargo.toml` (updated with git dependencies)
- `benches/README.md`
- `benches/build.rs`

## How to Run Benchmarks

### Prerequisites

1. Clone this repository:
   ```bash
   git clone https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps
   cd bigweaver-agent-canary-zeta-hydro-deps
   ```

2. Ensure you have Rust and Cargo installed

### Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run a specific benchmark:
```bash
cargo bench -p benches --bench arithmetic
```

Run benchmarks matching a pattern:
```bash
cargo bench -p benches --bench reachability
```

### Benchmark Output

Benchmark results are saved in `target/criterion/` with detailed HTML reports that can be viewed in a web browser.

## Dependencies

The benchmarks now reference the main repository dependencies via git:
- `dfir_rs` - Core Hydro dataflow library
- `sinktools` - Utility library for sinks
- `timely-master` - Timely Dataflow framework
- `differential-dataflow-master` - Differential Dataflow framework

## Notes

- The benchmarks compare Hydro (dfir_rs) performance against Timely Dataflow and Differential Dataflow
- Data files like `words_alpha.txt` are from https://github.com/dwyl/english-words
- The benchmarks use the Criterion benchmarking framework with HTML report generation enabled

## Questions or Issues

If you encounter any issues running the benchmarks, please check:
1. That you have network access to fetch the git dependencies
2. That you're using a compatible Rust version
3. That all required system dependencies are installed