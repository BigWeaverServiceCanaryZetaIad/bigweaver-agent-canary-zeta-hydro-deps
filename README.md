# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and code that depend on heavyweight dependencies like `timely-dataflow` and `differential-dataflow`. These have been separated from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to:

- Reduce dependency footprint of the main repository
- Improve build times for core development
- Allow independent development and versioning of performance benchmarks
- Maintain clean separation of concerns

## Repository Structure

```
.
├── benches/          # Performance benchmarks comparing DFIR/Hydroflow with timely/differential
│   ├── benches/      # Individual benchmark implementations
│   ├── Cargo.toml    # Benchmark dependencies and configuration
│   ├── build.rs      # Build script
│   └── README.md     # Benchmark documentation
└── README.md         # This file
```

## Benchmarks

The `benches/` directory contains performance benchmarks that compare Hydroflow/DFIR implementations with equivalent timely-dataflow and differential-dataflow implementations. These benchmarks require the heavyweight dependencies:

- `timely-master` (timely-dataflow)
- `differential-dataflow-master`

See [benches/README.md](benches/README.md) for details on running the benchmarks and interpreting results.

## Getting Started

### Prerequisites

- Rust (latest stable or nightly)
- Cargo

### Running Benchmarks

```bash
# Clone this repository
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps

# Run all benchmarks
cargo bench

# Run specific benchmark
cargo bench --bench arithmetic
```

### Available Benchmarks

- `arithmetic` - Basic arithmetic operations
- `fan_in` - Fan-in pattern performance
- `fan_out` - Fan-out pattern performance  
- `fork_join` - Fork-join pattern
- `futures` - Futures handling
- `identity` - Identity transformation (baseline)
- `join` - Join operations
- `micro_ops` - Micro-operation benchmarks
- `reachability` - Graph reachability
- `symmetric_hash_join` - Symmetric hash join
- `upcase` - String transformation
- `words_diamond` - Diamond pattern with word processing

## Migration History

These benchmarks were moved from the main repository to improve build times and dependency management. The migration preserves all performance comparison capabilities while allowing the main repository to focus on core Hydro development.

For questions or issues related to benchmarks, please open an issue in this repository.

## License

Apache-2.0