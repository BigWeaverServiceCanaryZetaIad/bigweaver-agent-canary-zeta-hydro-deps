# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks for timely and differential-dataflow dependencies that were extracted from the main bigweaver-agent-canary-hydro-zeta repository.

## Contents

### Benchmarks

The `benches` directory contains performance benchmarks including:

- **Timely benchmarks**: identity.rs, fan_in.rs, fan_out.rs, and others
- **Differential-dataflow benchmarks**: reachability.rs and related test data
- **Comparison benchmarks**: Various benchmarks comparing Hydro with timely and other frameworks

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench identity
cargo bench -p benches --bench fan_in
cargo bench -p benches --bench reachability
```

## Purpose

This repository maintains the ability to run performance comparisons with timely and differential-dataflow while keeping these benchmarks separate from the main codebase. This avoids adding direct dependencies on timely and differential-dataflow to the main repository.
