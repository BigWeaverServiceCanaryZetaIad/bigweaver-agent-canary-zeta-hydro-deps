# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and code that depend on `timely` and `differential-dataflow` packages. These components were separated from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to avoid unnecessary dependencies in the main codebase.

## Contents

### Benchmarks (`benches/`)

Performance benchmarks for Hydro operations using timely and differential-dataflow:

- **Timely benchmarks**: arithmetic, fan_in, fan_out, fork_join, identity, join, upcase
- **Differential-dataflow benchmarks**: reachability

See [benches/README.md](./benches/README.md) for detailed information on running the benchmarks.

## Purpose

This repository serves to:

1. **Isolate dependencies**: Keep timely and differential-dataflow dependencies separate from the main Hydro repository
2. **Maintain benchmarks**: Preserve performance comparison capabilities for Hydro operations
3. **Reduce build complexity**: Allow the main repository to have fewer dependencies and faster build times

## Running Benchmarks

```bash
# Run all benchmarks
cargo bench

# Run specific benchmark
cargo bench --bench reachability

# Run with baseline comparison
cargo bench -- --baseline my-baseline
```

## Migration Details

These benchmarks were moved from the main repository to avoid dependency bloat. The main repository retains benchmarks that don't depend on timely/differential-dataflow (micro_ops, symmetric_hash_join, words_diamond, futures).

For migration details and historical context, see [benches/MIGRATION.md](./benches/MIGRATION.md).

## Development

This repository uses Cargo workspaces. The workspace is defined in the root `Cargo.toml` file.

```bash
# Build all crates
cargo build

# Run tests
cargo test

# Run benchmarks
cargo bench
```

## Related Repositories

- [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) - Main Hydro repository
