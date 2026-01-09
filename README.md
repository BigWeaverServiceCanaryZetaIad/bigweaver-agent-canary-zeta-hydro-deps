# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmark dependencies for the Hydro project, separated from the main repository to isolate heavy dependencies.

## Contents

### Benchmarks
The `benches/` directory contains performance benchmarks for DFIR and other frameworks. These benchmarks have been relocated from the main `bigweaver-agent-canary-hydro-zeta` repository to keep heavy dependencies (timely, differential-dataflow) separate from the core codebase.

## Running Benchmarks

### Prerequisites
- Rust toolchain (see rust-toolchain.toml in main repository)
- Network access to clone dependencies

### Commands

```bash
# Run all benchmarks
cargo bench

# Run a specific benchmark
cargo bench --bench arithmetic
cargo bench --bench reachability
cargo bench --bench micro_ops

# Run benchmarks with output format
cargo bench -- --output-format bencher

# Generate HTML reports
cargo bench -- --save-baseline main
```

### Available Benchmarks

1. **arithmetic** - Basic arithmetic operations
2. **fan_in** - Fan-in pattern performance
3. **fan_out** - Fan-out pattern performance
4. **fork_join** - Fork-join pattern performance
5. **futures** - Async futures performance
6. **identity** - Identity transformation performance
7. **join** - Join operations performance
8. **micro_ops** - Micro-operations benchmarks
9. **reachability** - Graph reachability algorithms
10. **symmetric_hash_join** - Symmetric hash join performance
11. **upcase** - String transformation performance
12. **words_diamond** - Word processing in diamond pattern

## Dependencies

The benchmarks depend on:
- **dfir_rs** - Referenced from main repository via git
- **sinktools** - Referenced from main repository via git
- **criterion** - Benchmarking framework
- **differential-dataflow** - Dataflow framework
- **timely** - Timely dataflow
- Plus various supporting libraries

## Development

### Building
```bash
cargo build --workspace
```

### Checking
```bash
cargo check --workspace
```

### Testing
```bash
cargo test --workspace
```

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── Cargo.toml          # Workspace configuration
├── README.md           # This file
└── benches/            # Benchmarks workspace
    ├── Cargo.toml      # Benchmark dependencies
    ├── README.md       # Benchmark documentation
    ├── build.rs        # Build script
    └── benches/        # Benchmark source files
        ├── *.rs        # Benchmark implementations
        └── *.txt       # Benchmark data files
```

## Related Repositories

- **Main Repository**: [bigweaver-agent-canary-hydro-zeta](https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)
  - Contains core Hydro functionality
  - Benchmarks reference code from this repository

## Contributing

See CONTRIBUTING.md in the main repository for contribution guidelines.

## License

Apache-2.0 (see LICENSE in main repository)