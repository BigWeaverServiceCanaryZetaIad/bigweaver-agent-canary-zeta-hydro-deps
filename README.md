# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and other code that depends on `timely` and `differential-dataflow` packages.

These benchmarks were moved from the main `bigweaver-agent-canary-hydro-zeta` repository to isolate these dependencies and keep the main repository leaner and more maintainable.

## Quick Start

### Verify Setup
```bash
./verify_setup.sh
```

### Run Benchmarks
```bash
# Run all benchmarks
./run_benchmarks.sh

# Run specific benchmark
./run_benchmarks.sh reachability

# List available benchmarks
./run_benchmarks.sh --list
```

### View Results
```bash
open target/criterion/report/index.html
```

## Documentation

- **[QUICK_REFERENCE.md](QUICK_REFERENCE.md)** - Fast reference for common operations
- **[BENCHMARK_GUIDE.md](BENCHMARK_GUIDE.md)** - Comprehensive guide with detailed explanations
- **[CONTRIBUTING.md](CONTRIBUTING.md)** - Contributing guidelines and development setup
- **[INDEX.md](INDEX.md)** - Complete repository index and navigation
- **[CHANGELOG.md](CHANGELOG.md)** - Version history and changes

## Contents

- `benches/` - Microbenchmarks for DFIR and comparison with timely/differential-dataflow
  - 12 benchmark files covering various dataflow patterns
  - Graph operations (reachability, joins)
  - Data flow patterns (fan-in, fan-out, fork-join)
  - Real-world scenarios (word processing, string operations)
  - Micro-operations and async operations

## Prerequisites

For local development, you need to have the main `bigweaver-agent-canary-hydro-zeta` repository cloned alongside this repository:

```
/projects/sandbox/
├── bigweaver-agent-canary-hydro-zeta/      # Main repository
└── bigweaver-agent-canary-zeta-hydro-deps/ # This repository
```

**Verify your setup**: Run `./verify_setup.sh` to ensure everything is configured correctly.

## Running Benchmarks

### Using the Helper Script (Recommended)

```bash
# Run all benchmarks
./run_benchmarks.sh

# Run specific benchmark
./run_benchmarks.sh reachability

# List available benchmarks
./run_benchmarks.sh --list

# Get help
./run_benchmarks.sh --help
```

### Using Cargo Directly

```bash
# Run all benchmarks
cargo bench -p benches

# Run specific benchmarks
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic

# Quick test with fewer samples
cargo bench -p benches -- --sample-size 10
```

See the [benches/README.md](benches/README.md) for more details on available benchmarks.

## Available Benchmarks

| Benchmark | Description |
|-----------|-------------|
| **reachability** | Graph reachability algorithms |
| **join** | Join operations |
| **symmetric_hash_join** | Symmetric hash joins |
| **arithmetic** | Mathematical operations |
| **fan_in** | Multiple sources merging |
| **fan_out** | Single source splitting |
| **fork_join** | Fork-join parallelism |
| **identity** | Pass-through operations |
| **words_diamond** | Diamond pattern word processing |
| **upcase** | String transformations |
| **micro_ops** | Micro-operations |
| **futures** | Async/await operations |

For detailed descriptions, see [BENCHMARK_GUIDE.md](BENCHMARK_GUIDE.md).

## Performance Comparisons

These benchmarks allow performance comparisons between different implementations (DFIR vs timely/differential-dataflow). The results can be used to:
- Track performance regressions
- Compare implementation approaches
- Validate optimization efforts
- Understand performance characteristics

### Comparing Implementations

Each benchmark tests multiple implementations:
- **Timely-dataflow**: Pure timely implementation
- **Differential-dataflow**: Differential with incremental computation  
- **DFIR variants**: Different DFIR execution strategies (scheduled, surface syntax, etc.)

### Tracking Performance Over Time

```bash
# Save baseline
cargo bench -p benches -- --save-baseline main

# Compare with baseline
cargo bench -p benches -- --baseline main
```

Benchmark results are generated in `target/criterion/` with HTML reports for visualization.

## Configuration

The repository includes:
- **rust-toolchain.toml** - Rust 1.91.1 with required components
- **rustfmt.toml** - Code formatting configuration (matches main repository)
- **clippy.toml** - Linting rules (matches main repository)
- **Cargo.toml** - Workspace configuration with optimized build profiles

## Next Steps

1. **Verify Setup**: `./verify_setup.sh`
2. **Run Benchmarks**: `./run_benchmarks.sh`
3. **Read Guides**: [QUICK_REFERENCE.md](QUICK_REFERENCE.md) or [BENCHMARK_GUIDE.md](BENCHMARK_GUIDE.md)
4. **View Results**: `target/criterion/report/index.html`

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for detailed guidelines on:
- Adding new benchmarks
- Modifying existing benchmarks
- Performance comparison workflows
- Submitting changes

## Support

If you encounter issues:
1. Run `./verify_setup.sh` to check your setup
2. Review [QUICK_REFERENCE.md](QUICK_REFERENCE.md) for common commands
3. Check [BENCHMARK_GUIDE.md](BENCHMARK_GUIDE.md) for troubleshooting
4. See main repository's [BENCHMARK_REMOVAL.md](../bigweaver-agent-canary-hydro-zeta/BENCHMARK_REMOVAL.md)