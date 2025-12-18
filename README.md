# bigweaver-agent-canary-zeta-hydro-deps

## Overview

This repository contains benchmarks for performance comparisons with Timely Dataflow and Differential Dataflow implementations. These benchmarks were migrated from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to:

1. Reduce build dependencies in the main repository
2. Improve build times for core development
3. Enable performance comparisons between Hydro-native implementations and Timely/Differential Dataflow

## Purpose

This repository maintains benchmarks that can be implemented using Timely and Differential Dataflow libraries, allowing direct performance comparisons with the Hydro-native implementations in the main repository.

## Benchmarks

The following benchmarks are included:

- **micro_ops.rs** - Micro-operations benchmark testing basic dataflow operations
- **symmetric_hash_join.rs** - Symmetric hash join performance benchmark
- **words_diamond.rs** - Word processing diamond pattern benchmark
- **futures.rs** - Futures-based operations benchmark

### Supporting Data Files

- **words_alpha.txt** - Word list used by the words_diamond benchmark

## Running Benchmarks

### Prerequisites

- Rust toolchain (stable or nightly)
- Cargo

### Build and Run

To build the benchmarks:

```bash
cd benches
cargo build --release
```

To run all benchmarks:

```bash
cd benches
cargo bench
```

To run a specific benchmark:

```bash
cd benches
cargo bench --bench micro_ops
cargo bench --bench symmetric_hash_join
cargo bench --bench words_diamond
cargo bench --bench futures
```

### Benchmark Output

Criterion will generate HTML reports in `benches/target/criterion/`. Open `index.html` in a browser to view detailed performance metrics and graphs.

## Performance Comparison Workflow

### Comparing with Hydro-Native Implementations

1. Run benchmarks in the main repository:
   ```bash
   cd bigweaver-agent-canary-hydro-zeta
   cargo bench -p benches
   ```

2. Run benchmarks in this repository:
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps
   cargo bench -p benches
   ```

3. Compare the results from both repositories to evaluate performance characteristics

## Dependencies

This repository uses:

- **timely-master** (v0.13.0-dev.1) - Timely Dataflow library
- **differential-dataflow-master** (v0.13.0-dev.1) - Differential Dataflow library
- **criterion** (v0.5.0) - Benchmarking framework with HTML reports
- Standard supporting libraries (futures, rand, tokio, etc.)

## Contributing

When adding new benchmarks:

1. Place benchmark files in `benches/benches/`
2. Add benchmark entries to `benches/Cargo.toml`
3. Update this README with benchmark descriptions
4. Ensure benchmarks use `criterion` with `harness = false`

## Related Repositories

- [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) - Main Hydro implementation repository

## Notes

- These benchmarks are configured with Criterion's default 30-second measurement time for accurate results
- The benchmarks currently contain Hydro-native implementations (using `dfir_rs`) that will be adapted to use Timely/Differential Dataflow for performance comparisons
- For implementation details and migration history, see BENCHMARK_MIGRATION.md in the main repository