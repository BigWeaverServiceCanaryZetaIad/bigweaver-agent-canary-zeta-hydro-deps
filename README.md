# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks for timely and differential-dataflow that were separated from the main `bigweaver-agent-canary-hydro-zeta` repository to maintain a cleaner dependency structure.

## Purpose

This repository serves as a dedicated location for:
- Performance comparison benchmarks using timely and differential-dataflow
- External dependency isolation from the core hydro project
- Historical performance tracking and comparisons

## Repository Structure

```
.
├── benches/               # Benchmark crate
│   ├── benches/          # Benchmark source files
│   ├── Cargo.toml        # Benchmark dependencies
│   └── build.rs          # Build script for generated benchmarks
├── Cargo.toml            # Workspace configuration
└── README.md             # This file
```

## Benchmarks

This repository contains the following benchmarks:

### Timely Dataflow Benchmarks
- **arithmetic** - Performance comparison of arithmetic operations across different dataflow systems
- **identity** - Identity operation benchmarks comparing timely with other approaches
- **fan_in** - Tests multiple input stream convergence patterns
- **fan_out** - Tests single input to multiple output stream patterns
- **fork_join** - Complex dataflow patterns with branching and joining

### Differential Dataflow Benchmarks
- **join** - Join operation performance comparisons
- **upcase** - String transformation benchmarks
- **reachability** - Graph reachability analysis using differential dataflow

## Running Benchmarks

To run all benchmarks:
```bash
cargo bench
```

To run a specific benchmark:
```bash
cargo bench --bench arithmetic
cargo bench --bench identity
cargo bench --bench fan_in
cargo bench --bench fan_out
cargo bench --bench fork_join
cargo bench --bench join
cargo bench --bench upcase
cargo bench --bench reachability
```

## Requirements

- Rust toolchain 1.91.1 or later (see rust-toolchain.toml)
- Cargo with benchmark support

## Dependencies

Key dependencies include:
- `timely` (timely-master v0.13.0-dev.1) - Timely dataflow framework
- `differential-dataflow` (differential-dataflow-master v0.13.0-dev.1) - Differential computation framework
- `criterion` - Benchmarking framework
- `dfir_rs` - Hydro dataflow implementation (from parent repository)

## Development

### Building
```bash
cargo build --release
```

### Testing
```bash
cargo test
```

### Code Quality
This repository follows the same code quality standards as the parent hydro project:
- Format code with: `cargo fmt`
- Lint code with: `cargo clippy`

## Migration Information

These benchmarks were moved from the `bigweaver-agent-canary-hydro-zeta` repository to:
1. Reduce build times for the core project
2. Isolate external dependencies (timely and differential-dataflow)
3. Maintain clearer separation between core functionality and performance testing
4. Improve overall repository organization and maintainability

For more details, see `MIGRATION.md`.

## Related Projects

- [bigweaver-agent-canary-hydro-zeta](https://github.com/hydro-project/hydro) - Main hydro project repository

## License

Apache-2.0 (same as parent project)