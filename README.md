# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for the Hydro project that depend on external dataflow libraries (timely-dataflow and differential-dataflow).

## Contents

### Benchmarks

The `benches` directory contains performance benchmarks comparing Hydro (dfir_rs) implementations with timely-dataflow and differential-dataflow implementations. These benchmarks were moved from the main bigweaver-agent-canary-hydro-zeta repository to isolate the heavy dependencies.

#### Available Benchmarks

- **arithmetic**: Pipeline arithmetic operations
- **fan_in**: Multiple input streams merging into one
- **fan_out**: Single stream splitting into multiple outputs
- **fork_join**: Fork-join pattern with filters
- **futures**: Async futures handling
- **identity**: Simple identity transformation
- **join**: Stream join operations
- **micro_ops**: Micro-operations performance
- **reachability**: Graph reachability algorithm (includes test data)
- **symmetric_hash_join**: Symmetric hash join implementation
- **upcase**: String uppercase transformation
- **words_diamond**: Diamond pattern with word processing

## Running Benchmarks

### Prerequisites

- Rust toolchain (see rust-toolchain.toml in the main repository if applicable)
- Cargo

### Run All Benchmarks

```bash
cargo bench -p benches
```

### Run Specific Benchmarks

To run a specific benchmark, use:

```bash
cargo bench -p benches --bench <benchmark_name>
```

For example:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench join
cargo bench -p benches --bench arithmetic
```

### Benchmark Output

Benchmarks use the Criterion framework and generate HTML reports in `target/criterion/`. Open `target/criterion/report/index.html` in a browser to view detailed performance reports with graphs and statistics.

## Dependencies

This repository depends on:
- **dfir_rs**: The main Hydro dataflow runtime (from bigweaver-agent-canary-hydro-zeta)
- **sinktools**: Utility tools (from bigweaver-agent-canary-hydro-zeta)
- **timely-dataflow**: Low-latency dataflow framework
- **differential-dataflow**: Incremental dataflow computation framework
- **criterion**: Benchmarking framework

## Development

### Repository Structure

```
.
├── benches/
│   ├── Cargo.toml          # Benchmark package configuration
│   ├── README.md           # Benchmark-specific documentation
│   ├── build.rs            # Build script for generated benchmarks
│   └── benches/            # Benchmark source files
│       ├── *.rs            # Benchmark implementations
│       ├── *.txt           # Test data files
│       └── .gitignore
├── .github/
│   └── workflows/
│       └── benchmark.yml   # CI benchmark workflow
├── Cargo.toml              # Workspace configuration
└── README.md               # This file
```

### Adding New Benchmarks

1. Add a new `.rs` file in `benches/benches/`
2. Add a `[[bench]]` entry in `benches/Cargo.toml`
3. Follow the existing benchmark patterns using Criterion
4. Run `cargo bench -p benches --bench <new_benchmark>` to test

## CI/CD

The `.github/workflows/benchmark.yml` file contains the CI configuration for running benchmarks automatically. This can be used to track performance over time.

## History

These benchmarks were originally part of the bigweaver-agent-canary-hydro-zeta repository but were moved to this separate repository to:
1. Isolate heavy dependencies (timely/differential-dataflow)
2. Keep the main repository focused on core Hydro functionality
3. Maintain the ability to run performance comparisons with other dataflow systems

The benchmarks were extracted from commit 484e6fdd (before commit b161bc10 which removed them from the main repository).

## Data Attribution

The word list used in word-processing benchmarks (`words_alpha.txt`) is from [dwyl/english-words](https://github.com/dwyl/english-words/blob/master/words_alpha.txt).