# bigweaver-agent-canary-zeta-hydro-deps

A dedicated repository for benchmarks comparing DFIR (Hydroflow) performance with timely and differential-dataflow frameworks.

## Overview

This repository contains performance benchmarks that compare Hydroflow/DFIR implementations with timely and differential-dataflow. Following the team's architectural pattern of clean separation of concerns, these benchmarks have been isolated from the main `bigweaver-agent-canary-hydro-zeta` repository to:

- **Reduce unnecessary dependencies** in the main codebase
- **Maintain cleaner dependency management**
- **Enable focused performance testing** across multiple frameworks
- **Prevent technical debt accumulation** in the main repository

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── Cargo.toml                    # Workspace configuration
├── README.md                     # This file
├── BENCHMARKS.md                 # Detailed benchmark documentation
├── PERFORMANCE_COMPARISON.md     # Guide for performance comparison
├── run_benchmarks.sh             # Convenience script to run benchmarks
└── benchmarks/
    ├── Cargo.toml                # Benchmark package configuration
    └── benches/
        ├── arithmetic.rs         # Pipeline arithmetic operations
        ├── fan_in.rs             # Multiple input stream merging
        ├── fan_out.rs            # Single stream broadcasting
        ├── fork_join.rs          # Parallel processing patterns
        ├── identity.rs           # Identity/passthrough operations
        ├── join.rs               # Join operations
        ├── reachability.rs       # Graph reachability algorithms
        ├── upcase.rs             # String transformations
        └── data/
            ├── reachability_edges.txt      # Graph edges data
            └── reachability_reachable.txt  # Expected reachability results
```

## Quick Start

### Prerequisites

- Rust toolchain (1.70+)
- Cargo

**Note:** Some benchmarks reference historical dependencies (babyflow) that may require additional configuration. See [SETUP_NOTES.md](SETUP_NOTES.md) for detailed setup information and troubleshooting.

### Running All Benchmarks

```bash
# From repository root
cargo bench -p hydro-deps-benchmarks

# Or use the convenience script
./run_benchmarks.sh all
```

### Running Specific Benchmarks

```bash
# Run a single benchmark
cargo bench -p hydro-deps-benchmarks --bench arithmetic

# Run multiple specific benchmarks
cargo bench -p hydro-deps-benchmarks --bench arithmetic --bench identity
```

### Available Benchmarks

- `arithmetic` - Pipeline arithmetic operations comparing framework overhead
- `fan_in` - Multiple input streams merging to a single output
- `fan_out` - Single stream broadcasting to multiple outputs
- `fork_join` - Parallel processing with fork/join patterns
- `identity` - Identity/passthrough operations (minimal overhead baseline)
- `join` - Join operations using timely dataflow operators
- `reachability` - Graph reachability using differential-dataflow's iterate/join
- `upcase` - String uppercase transformations

## Benchmark Results

Results are generated in `target/criterion/` with HTML reports for visualization.

```bash
# View results in browser
open target/criterion/report/index.html
```

## Dependencies

This repository includes dependencies on:

- **timely** (timely-master v0.13.0-dev.1) - Timely dataflow framework
- **differential-dataflow** (differential-dataflow-master v0.13.0-dev.1) - Differential computation
- **criterion** (v0.5.0) - Benchmarking framework

## Performance Comparison with Main Repository

For detailed guidance on comparing performance between this repository and DFIR implementations in the main repository, see [PERFORMANCE_COMPARISON.md](PERFORMANCE_COMPARISON.md).

## Documentation

- **[SETUP_NOTES.md](SETUP_NOTES.md)** - Setup instructions and troubleshooting
- **[BENCHMARKS.md](BENCHMARKS.md)** - Detailed documentation for each benchmark
- **[PERFORMANCE_COMPARISON.md](PERFORMANCE_COMPARISON.md)** - Performance comparison methodology
- **[CHANGELOG.md](CHANGELOG.md)** - Version history and changes

## Contributing

This repository follows the same coding standards and contribution guidelines as the main bigweaver-agent-canary-hydro-zeta repository. When adding new benchmarks:

1. Ensure proper structure with comparative implementations
2. Include comprehensive documentation
3. Add test data files to `benchmarks/benches/data/` if needed
4. Update this README and BENCHMARKS.md
5. Follow conventional commit message format

## Related Repositories

- **[bigweaver-agent-canary-hydro-zeta](../bigweaver-agent-canary-hydro-zeta)** - Main Hydroflow/DFIR repository

## Migration Notes

These benchmarks were migrated from the main repository to maintain clean separation of concerns. For historical context and migration details, see `MIGRATION_NOTES.md` in the main repository.

## License

Apache-2.0

## Questions or Issues?

For questions about:
- Running benchmarks - see [BENCHMARKS.md](BENCHMARKS.md)
- Performance comparison methodology - see [PERFORMANCE_COMPARISON.md](PERFORMANCE_COMPARISON.md)
- Benchmark implementations or results - create an issue in this repository
- DFIR implementations - refer to the main bigweaver-agent-canary-hydro-zeta repository