# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for the Hydro project that have been separated from the main repository to avoid unnecessary dependencies.

## Contents

### Benchmarks (`benches/`)

Microbenchmarks for Hydro (DFIR) comparing performance with timely-dataflow and differential-dataflow.

**Run all benchmarks:**
```bash
cargo bench -p benches
```

**Run specific benchmarks:**
```bash
cargo bench -p benches --bench reachability
```

Available benchmarks:
- `arithmetic` - Basic arithmetic operations
- `fan_in` - Fan-in patterns
- `fan_out` - Fan-out patterns
- `fork_join` - Fork-join patterns
- `futures` - Async futures handling
- `identity` - Identity operations
- `join` - Join operations
- `micro_ops` - Micro-operations
- `reachability` - Graph reachability
- `symmetric_hash_join` - Symmetric hash join
- `upcase` - String uppercase operations
- `words_diamond` - Word processing diamond pattern

### Dependencies

The benchmarks reference the main Hydro repository via git dependencies:
- `dfir_rs` - DFIR runtime for Rust
- `sinktools` - Utility tools
- `timely` - Timely dataflow framework
- `differential-dataflow` - Differential dataflow framework

## CI/CD

Benchmarks are automatically run via GitHub Actions workflow (`.github/workflows/benchmark.yml`) when:
- Pushed to main branch with `[ci-bench]` in commit message
- Pull requests with `[ci-bench]` in title or body
- Scheduled daily at 8:35 PM PDT / 7:35 PM PST
- Manually triggered via workflow dispatch

Results are published to the gh-pages branch and can be viewed in the benchmark history.