# bigweaver-agent-canary-zeta-hydro-deps

This repository contains external dependencies and benchmarks for the Hydro project that were separated from the main `bigweaver-agent-canary-hydro-zeta` repository.

## Purpose

This repository serves as a companion to the main Hydro project, providing:

1. **Performance Benchmarks**: Comparison benchmarks between timely/differential-dataflow and Hydro implementations
2. **Dependency Isolation**: Keeps external dependencies (timely, differential-dataflow) separate from the core Hydro codebase

## Contents

### Benchmarks

The `benches/` directory contains performance benchmarks comparing:
- Timely dataflow
- Differential dataflow  
- Hydro implementations (referenced from the main repository)

These benchmarks allow for objective performance comparisons while keeping the main Hydro repository free from these external dependencies.

See [benches/README.md](benches/README.md) for more information on running the benchmarks.

## Usage

```bash
# Run all benchmarks
cd benches
cargo bench

# Run specific benchmark
cargo bench --bench arithmetic
```

## Relationship to Main Repository

This repository is designed to work alongside `bigweaver-agent-canary-hydro-zeta`. The benchmarks reference Hydro crates from the main repository via relative paths, allowing for performance comparisons without polluting the main repository's dependency tree.
