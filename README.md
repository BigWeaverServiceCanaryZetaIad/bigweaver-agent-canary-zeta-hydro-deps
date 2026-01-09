# bigweaver-agent-canary-zeta-hydro-deps

This repository contains performance benchmarks and other dependencies for the BigWeaver Hydro project.

## Benchmarks

The `benches` directory contains microbenchmarks for Hydro and other crates. These benchmarks have been separated from the main repository to avoid dependency issues while maintaining all functionality for performance comparisons.

### Running Benchmarks

Run all benchmarks:
```
cargo bench -p benches
```

Run specific benchmarks:
```
cargo bench -p benches --bench reachability
```

**Note:** The benchmarks depend on the main `bigweaver-agent-canary-hydro-zeta` repository being present as a sibling directory for access to `dfir_rs` and `sinktools` crates.