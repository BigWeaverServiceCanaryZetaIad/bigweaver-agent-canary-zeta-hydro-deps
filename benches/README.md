# Hydro Benchmarks

This directory contains all benchmarks for the Hydro project, including those with timely and differential-dataflow dependencies.

## Overview

As of December 18, 2024, all benchmarks have been migrated to this repository to avoid pulling in timely and differential-dataflow dependencies for the core Hydro development workflow in the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository.

## Available Benchmarks

### Micro-Operations and Core Patterns
- **micro_ops** - Micro-operations benchmark testing basic dataflow operations
- **symmetric_hash_join** - Symmetric hash join benchmark
- **futures** - Futures-based operations benchmark
- **identity** - Identity transformation benchmark

### Complex Patterns
- **words_diamond** - Word processing diamond pattern benchmark
- **fork_join** - Fork-join pattern benchmark
- **fan_in** - Fan-in pattern benchmark
- **fan_out** - Fan-out pattern benchmark

### Data Processing
- **join** - Join operations benchmark
- **arithmetic** - Arithmetic operations benchmark
- **upcase** - String transformation benchmark
- **reachability** - Graph reachability benchmark

## Dependencies

This benchmark suite includes:
- `timely` (package: timely-master, version: 0.13.0-dev.1)
- `differential-dataflow` (package: differential-dataflow-master, version: 0.13.0-dev.1)
- `dfir_rs` (Hydro's DFIR implementation, path reference to main repository)
- `criterion` for benchmarking framework
- Supporting libraries (futures, rand, tokio, etc.)

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench
```

Run specific benchmarks:
```bash
cargo bench --bench micro_ops
cargo bench --bench symmetric_hash_join
cargo bench --bench words_diamond
cargo bench --bench futures
cargo bench --bench arithmetic
cargo bench --bench join
cargo bench --bench reachability
```

Run a specific benchmark within a benchmark file:
```bash
cargo bench --bench micro_ops -- micro/ops/identity
cargo bench --bench words_diamond -- dfir_rs_diamond
```

## Performance Analysis

Criterion generates detailed HTML reports in `target/criterion/` that include:
- Performance measurements with statistical analysis
- Comparison with previous runs
- Graphs and charts for visual analysis
- Detailed timing information

## Data Files

- `words_alpha.txt` - Wordlist from https://github.com/dwyl/english-words/blob/master/words_alpha.txt (used by words_diamond benchmark)
- `reachability_edges.txt` - Test data for reachability benchmark
- `reachability_reachable.txt` - Expected results for reachability benchmark

## Build Configuration

Some benchmarks require code generation at build time:
- The `fork_join` benchmark uses `build.rs` to generate Hydro code variants
- Generated files are excluded from version control via `.gitignore`

## Migration Notes

These benchmarks were migrated from the main repository in two phases:
- **December 17, 2024**: Initial migration of timely/differential-dataflow specific benchmarks
- **December 18, 2024**: Migration completed with all remaining benchmarks

For more information about the benchmark migration, see [BENCHMARK_MIGRATION.md](../../bigweaver-agent-canary-hydro-zeta/BENCHMARK_MIGRATION.md) in the main repository.

## Benefits of Separate Repository

1. **Reduced Build Dependencies**: Main repository no longer needs timely/differential-dataflow
2. **Faster Build Times**: Core development is faster without external dependencies
3. **Maintained Functionality**: All performance comparison capabilities preserved
4. **Clear Separation**: Clean boundary between core implementation and benchmarks
5. **Consolidated Benchmarks**: All benchmarks maintained in a single location

## Development Workflow

This repository references the main repository's `dfir_rs` via path dependency. Ensure both repositories are cloned as siblings:

```
workspace/
├── bigweaver-agent-canary-hydro-zeta/
│   └── dfir_rs/
└── bigweaver-agent-canary-zeta-hydro-deps/
    └── benches/
```

The path reference in `Cargo.toml`:
```toml
dfir_rs = { path = "../../bigweaver-agent-canary-hydro-zeta/dfir_rs", features = [ "debugging" ] }
```
