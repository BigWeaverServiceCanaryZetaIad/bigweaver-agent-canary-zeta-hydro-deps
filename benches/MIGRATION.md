# Benchmark Migration Guide

## Overview

The timely and differential-dataflow benchmarks have been moved from the main 
`bigweaver-agent-canary-hydro-zeta` repository to this separate 
`bigweaver-agent-canary-zeta-hydro-deps` repository.

## Reason for Migration

To maintain a clean dependency tree and avoid including timely and differential-dataflow
as dependencies in the main Hydro repository, comparison benchmarks have been relocated
to this dedicated repository.

## What Was Moved

All benchmark files from `bigweaver-agent-canary-hydro-zeta/benches/` have been moved here:

- `benches/benches/*.rs` - All benchmark source files
- `benches/benches/*.txt` - Benchmark data files
- `benches/Cargo.toml` - Benchmark package configuration
- `benches/build.rs` - Build script
- `benches/README.md` - Benchmark documentation

## Dependencies Updated

The moved benchmarks now reference `dfir_rs` and `sinktools` from the main repository
via git dependencies instead of path dependencies.

### Before (in main repo):
```toml
dfir_rs = { path = "../dfir_rs", features = [ "debugging" ] }
sinktools = { path = "../sinktools", version = "^0.0.1" }
```

### After (in deps repo):
```toml
dfir_rs = { git = "https://...", features = [ "debugging" ] }
sinktools = { git = "https://..." }
```

## Running Benchmarks

From the `bigweaver-agent-canary-zeta-hydro-deps` repository:

```bash
# Run all benchmarks
cargo bench

# Run specific benchmark
cargo bench --bench reachability

# Generate HTML reports
cargo bench -- --save-baseline my-baseline
```

## Cross-Repository Performance Comparison

To compare performance between repositories:

1. Run benchmarks in this repository and save baseline:
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps
   cargo bench -- --save-baseline timely-baseline
   ```

2. Run equivalent benchmarks in the main repository (if available):
   ```bash
   cd bigweaver-agent-canary-hydro-zeta
   cargo bench -- --save-baseline hydro-baseline
   ```

3. Compare results using criterion's comparison features or custom scripts.

## References

- Main repository: https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta
- This repository: https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps
