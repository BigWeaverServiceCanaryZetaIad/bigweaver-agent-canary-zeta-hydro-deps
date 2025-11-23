# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies that rely on external packages like `timely` and `differential-dataflow`, which have been isolated from the main bigweaver-agent-canary-hydro-zeta repository to maintain a cleaner codebase and reduce compilation complexity.

## Quick Links

- 📚 **[QUICKSTART.md](QUICKSTART.md)** - Get started quickly with running benchmarks
- 🤝 **[CONTRIBUTING.md](CONTRIBUTING.md)** - Guidelines for adding new benchmarks
- 📋 **[MANIFEST.md](MANIFEST.md)** - Complete file listing and structure
- 🏗️ **[ARCHITECTURE.md](ARCHITECTURE.md)** - Architecture and design documentation
- 🔧 **[Helper Scripts](#helper-scripts)** - Convenient tools for running benchmarks

## Contents

### Benchmarks

Performance benchmarks for Hydro and related crates. These benchmarks compare Hydro implementations against timely-dataflow and differential-dataflow implementations.

#### Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench join
cargo bench -p benches --bench arithmetic
```

#### Available Benchmarks

- **arithmetic** - Basic arithmetic operations
- **fan_in** - Fan-in patterns
- **fan_out** - Fan-out patterns
- **fork_join** - Fork-join patterns
- **identity** - Identity transformations
- **upcase** - String uppercase operations
- **join** - Join operations
- **reachability** - Graph reachability (uses differential-dataflow)
- **micro_ops** - Micro-operations
- **symmetric_hash_join** - Symmetric hash join operations
- **words_diamond** - Word processing diamond pattern
- **futures** - Async futures operations

#### Performance Comparisons

The benchmarks provide performance comparison functionality between:
- Hydro (dfir_rs) implementations
- Timely-dataflow implementations
- Differential-dataflow implementations

This allows for data-driven performance evaluation and optimization of the Hydro framework.

## Helper Scripts

### run_benchmarks.sh

Convenient script for running benchmarks with various options:

```bash
./run_benchmarks.sh              # Run all benchmarks
./run_benchmarks.sh quick        # Run quick subset for validation
./run_benchmarks.sh reachability # Run specific benchmark
./run_benchmarks.sh list         # List all available benchmarks
./run_benchmarks.sh help         # Show usage information
```

### compare_benchmarks.sh

Analyze and compare benchmark results:

```bash
./compare_benchmarks.sh          # Show summary of results
./compare_benchmarks.sh reachability  # Detailed comparison for specific benchmark
```

## Repository Structure

```
.
├── benches/          # Benchmark suite
│   ├── benches/      # Benchmark implementations
│   └── Cargo.toml    # Benchmark dependencies
├── Cargo.toml        # Workspace configuration
├── README.md         # This file
├── QUICKSTART.md     # Quick start guide
├── CONTRIBUTING.md   # Contribution guidelines
├── MANIFEST.md       # Complete file listing
├── ARCHITECTURE.md   # Architecture documentation
├── run_benchmarks.sh # Benchmark runner script
└── compare_benchmarks.sh # Results comparison script
```

## Dependencies

The benchmarks depend on:
- `dfir_rs` - From the main bigweaver-agent-canary-hydro-zeta repository
- `sinktools` - From the main bigweaver-agent-canary-hydro-zeta repository
- `timely` (timely-master) - External timely-dataflow package
- `differential-dataflow` (differential-dataflow-master) - External differential-dataflow package

## Notes

This repository was created to isolate dependencies on `timely` and `differential-dataflow` from the main Hydro repository, following the principle of separating core functionality from external dependencies to improve maintainability and reduce compilation complexity.

## Additional Resources

- **Getting Started**: See [QUICKSTART.md](QUICKSTART.md) for setup and basic usage
- **Contributing**: See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines on adding benchmarks
- **File Structure**: See [MANIFEST.md](MANIFEST.md) for complete file documentation
- **Main Repository**: [bigweaver-agent-canary-hydro-zeta](../bigweaver-agent-canary-hydro-zeta/README.md)
- **Migration Details**: [MIGRATION_SUMMARY.md](../MIGRATION_SUMMARY.md)

## Support

For issues or questions:
1. Check the [QUICKSTART.md](QUICKSTART.md) for common setup issues
2. Review [CONTRIBUTING.md](CONTRIBUTING.md) for development guidelines
3. See benchmark source code in `benches/benches/` for implementation details
4. Refer to the main repository documentation for Hydro framework details