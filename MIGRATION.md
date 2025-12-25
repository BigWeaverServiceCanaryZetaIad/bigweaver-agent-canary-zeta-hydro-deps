# Benchmark Migration Documentation

## Overview

This document describes the migration of timely-dataflow and differential-dataflow benchmarks from the `bigweaver-agent-canary-hydro-zeta` repository to the `bigweaver-agent-canary-zeta-hydro-deps` repository.

## Migration Date

December 25, 2025

## Reason for Migration

The benchmarks were migrated to:

1. **Reduce dependencies**: Remove timely-dataflow and differential-dataflow dependencies from the main codebase
2. **Improve build times**: Avoid compiling these heavy dependencies in the main repository during regular development
3. **Maintain comparison capability**: Retain the ability to run performance comparisons between different dataflow implementations
4. **Simplify development**: Keep the main repository focused on core functionality
5. **Isolate external dependencies**: Separate external dataflow system benchmarks from internal implementations

## Migrated Files

### Benchmark Source Files

The following benchmark files were migrated from `bigweaver-agent-canary-hydro-zeta/benches/benches/` to `timely-differential-benches/benches/`:

- `arithmetic.rs` - Arithmetic operations benchmark
- `fan_in.rs` - Fan-in pattern benchmark
- `fan_out.rs` - Fan-out pattern benchmark  
- `fork_join.rs` - Fork-join pattern benchmark
- `identity.rs` - Identity/passthrough benchmark
- `join.rs` - Join operations benchmark
- `reachability.rs` - Graph reachability benchmark
- `upcase.rs` - String uppercase transformation benchmark

### Data Files

- `reachability_edges.txt` - Edge data for reachability benchmark
- `reachability_reachable.txt` - Expected reachability results

### Configuration Files

- `Cargo.toml` - Created new configuration for timely-differential-benches
- `README.md` - Documentation for running the benchmarks

## Removed Dependencies from Source Repository

The following dependencies were removed from `bigweaver-agent-canary-hydro-zeta/benches/Cargo.toml`:

```toml
differential-dataflow = { package = "differential-dataflow-master", version = "0.13.0-dev.1" }
timely = { package = "timely-master", version = "0.13.0-dev.1" }
```

The following benchmark configurations were removed:
- `[[bench]] name = "arithmetic"`
- `[[bench]] name = "fan_in"`
- `[[bench]] name = "fan_out"`
- `[[bench]] name = "fork_join"`
- `[[bench]] name = "identity"`
- `[[bench]] name = "join"`
- `[[bench]] name = "reachability"`
- `[[bench]] name = "upcase"`

## Benchmarks Retained in Source Repository

The following benchmarks remain in `bigweaver-agent-canary-hydro-zeta/benches` as they do not depend on timely-dataflow or differential-dataflow:

- `micro_ops.rs` - Micro-operations benchmark
- `symmetric_hash_join.rs` - Symmetric hash join benchmark
- `words_diamond.rs` - Words diamond pattern benchmark
- `futures.rs` - Futures/async benchmark

## Repository Structure

### Source Repository (bigweaver-agent-canary-hydro-zeta)

After migration:
```
bigweaver-agent-canary-hydro-zeta/
├── benches/
│   ├── Cargo.toml (updated, removed timely/differential deps)
│   └── benches/
│       ├── futures.rs
│       ├── micro_ops.rs
│       ├── symmetric_hash_join.rs
│       ├── words_alpha.txt
│       └── words_diamond.rs
└── ... (other crates)
```

### Destination Repository (bigweaver-agent-canary-zeta-hydro-deps)

After migration:
```
bigweaver-agent-canary-zeta-hydro-deps/
├── README.md
├── MIGRATION.md (this file)
└── timely-differential-benches/
    ├── Cargo.toml
    ├── README.md
    └── benches/
        ├── arithmetic.rs
        ├── fan_in.rs
        ├── fan_out.rs
        ├── fork_join.rs
        ├── identity.rs
        ├── join.rs
        ├── reachability.rs
        ├── reachability_edges.txt
        ├── reachability_reachable.txt
        └── upcase.rs
```

## Running Benchmarks After Migration

### Standalone Benchmarks

To run only the timely/differential-dataflow benchmarks:

```bash
cd bigweaver-agent-canary-zeta-hydro-deps/timely-differential-benches
cargo bench
```

### Cross-Repository Performance Comparison

To compare performance between timely/differential-dataflow and other implementations:

1. Clone both repositories side-by-side:
   ```bash
   git clone <repo-url>/bigweaver-agent-canary-hydro-zeta.git
   git clone <repo-url>/bigweaver-agent-canary-zeta-hydro-deps.git
   ```

2. Edit `timely-differential-benches/Cargo.toml` and uncomment path dependencies:
   ```toml
   babyflow = { path = "../../bigweaver-agent-canary-hydro-zeta/babyflow" }
   dfir_rs = { path = "../../bigweaver-agent-canary-hydro-zeta/dfir_rs", features = [ "debugging" ] }
   hydroflow = { path = "../../bigweaver-agent-canary-hydro-zeta/hydroflow" }
   spinachflow = { path = "../../bigweaver-agent-canary-hydro-zeta/spinachflow" }
   sinktools = { path = "../../bigweaver-agent-canary-hydro-zeta/sinktools", version = "^0.0.1" }
   ```

3. Run benchmarks:
   ```bash
   cd timely-differential-benches
   cargo bench
   ```

## Script for Automated Comparison

A comparison script can be created to automate performance comparison across implementations. See `scripts/compare_benchmarks.sh` in the destination repository.

## Verification

After migration, verify:

1. ✅ Source repository builds without timely/differential-dataflow dependencies
2. ✅ Destination repository benchmarks run successfully standalone
3. ✅ Cross-repository benchmarks work with path dependencies configured
4. ✅ All benchmark files maintain their original functionality
5. ✅ Documentation is updated in both repositories

## Future Considerations

- Consider adding automated CI/CD workflows for benchmark comparison
- Potentially add scripts to automate repository setup for developers
- Consider publishing benchmark results to track performance trends over time
- May want to version benchmarks to track performance across releases

## Contact

For questions about this migration, please refer to the repository maintainers or open an issue in the respective repositories.
