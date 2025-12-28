# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks for Hydro that require external dependencies on `timely-dataflow` and `differential-dataflow`. These benchmarks have been separated from the main `bigweaver-agent-canary-hydro-zeta` repository to avoid adding unnecessary dependencies to the main service codebase.

## Purpose

By isolating benchmarks that compare Hydro against other dataflow frameworks, this repository enables:
- **Clean dependency management** - Main service remains free of external dataflow framework dependencies
- **Performance validation** - Comprehensive benchmarking against established frameworks
- **Focused testing** - Dedicated environment for performance comparison work
- **Independent execution** - Benchmarks can be run without affecting main development

## Benchmarks

The following benchmarks compare Hydro's performance against timely-dataflow and differential-dataflow:

### Core Operation Benchmarks

- **arithmetic**: Sequential arithmetic operations (20 map operations on 1M elements)
  - Compares: Timely, Hydroflow (compiled/surface), raw pipelines, iterators
- **identity**: Identity/no-op transformations to measure framework overhead
  - Useful for understanding baseline performance costs

### Stream Pattern Benchmarks

- **fan_in**: Multiple input streams merging into a single stream
  - Tests: Stream concatenation and merging efficiency
- **fan_out**: Single stream splitting into multiple output streams
  - Tests: Stream distribution and duplication
- **fork_join**: Fork-join pattern with filtering operations (20 levels)
  - Tests: Complex dataflow graphs with splits and joins

### Data Processing Benchmarks

- **join**: Hash join operations with different value types
  - Tests: `usize`/`usize`, `String`/`String`, and mixed joins on 100K pairs
- **upcase**: String uppercase transformation with different strategies
  - Tests: String processing in dataflow context
- **reachability**: Graph reachability using differential-dataflow iterative operators
  - Tests: Iterative computation and incremental processing
  - Uses: Real graph data for authentic workload

## Quick Start

### Prerequisites

Ensure both repositories are in the same parent directory:
```
parent-directory/
├── bigweaver-agent-canary-hydro-zeta/       # Main Hydro repository
└── bigweaver-agent-canary-zeta-hydro-deps/  # This repository
```

### Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p hydro-timely-differential-benches
```

Run specific benchmarks:
```bash
# Run single benchmark
cargo bench -p hydro-timely-differential-benches --bench reachability
cargo bench -p hydro-timely-differential-benches --bench arithmetic
cargo bench -p hydro-timely-differential-benches --bench join

# Run specific benchmark function
cargo bench -p hydro-timely-differential-benches --bench arithmetic -- "timely"
```

Generate HTML reports:
```bash
cargo bench -p hydro-timely-differential-benches -- --noplot
# Reports available in: target/criterion/
```

## Performance Comparisons

These benchmarks enable performance comparisons between:
- **Hydro (DFIR)** - Both compiled and surface syntax approaches
- **Timely-dataflow** - Low-level dataflow framework
- **Differential-dataflow** - Incremental computation framework
- **Raw implementations** - Direct pipeline and iterator approaches
- **Baseline measurements** - Theoretical performance limits

### Interpreting Results

- **Lower is better** - Execution times in microseconds/milliseconds
- **Overhead analysis** - Identity benchmarks show framework costs
- **Scalability** - Arithmetic benchmarks demonstrate operator chain handling
- **Real-world performance** - Join and reachability show practical workload behavior

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── README.md              # This file - repository overview
├── CONTRIBUTING.md        # Contribution guidelines
├── Cargo.toml            # Workspace configuration
└── benches/              # Benchmark package
    ├── Cargo.toml        # Benchmark dependencies and configuration
    ├── build.rs          # Build-time code generation
    ├── README.md         # Detailed benchmark documentation
    └── benches/          # Benchmark implementations
        ├── arithmetic.rs
        ├── fan_in.rs
        ├── fan_out.rs
        ├── fork_join.rs
        ├── identity.rs
        ├── join.rs
        ├── reachability.rs
        ├── upcase.rs
        ├── reachability_edges.txt      (~520 KB)
        ├── reachability_reachable.txt  (~38 KB)
        └── words_alpha.txt             (~3.7 MB)
```

## Dependencies

### External Framework Dependencies
- **timely-master** (v0.13.0-dev.1) - Timely dataflow framework
- **differential-dataflow-master** (v0.13.0-dev.1) - Differential dataflow framework

### Hydro Dependencies (Path Dependencies)
- **dfir_rs** - Hydro's DFIR runtime and API
  - Path: `../bigweaver-agent-canary-hydro-zeta/dfir_rs`
- **sinktools** - Sink utilities for streaming operations
  - Path: `../bigweaver-agent-canary-hydro-zeta/sinktools`

### Testing and Benchmarking
- **criterion** (v0.5.0) - Statistical benchmarking with async and HTML reports
- **tokio** (v1.29.0) - Async runtime for Hydroflow benchmarks
- **futures** (v0.3) - Async utilities
- **rand**, **rand_distr** - Random data generation
- **seq-macro** - Macro utilities for code generation
- **nameof**, **static_assertions** - Development utilities

## Cross-Repository Workflow

### Running Full Benchmark Suite

1. **Main repository benchmarks** (without external dependencies):
   ```bash
   cd bigweaver-agent-canary-hydro-zeta
   cargo bench -p benches
   ```

2. **Comparison benchmarks** (with external dependencies):
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps
   cargo bench -p hydro-timely-differential-benches
   ```

### Updating Dependencies

When the main Hydro repository APIs change:
1. Update code in `bigweaver-agent-canary-hydro-zeta`
2. Update benchmark code in this repository if needed
3. Verify benchmarks still compile and run
4. Update documentation to reflect any API changes

## Data Files

Located in `benches/benches/`:

- **reachability_edges.txt** - Graph edges for reachability benchmark
  - Format: `source_node target_node` (space-separated)
  - Size: ~520 KB
  
- **reachability_reachable.txt** - Expected reachable nodes
  - Format: One node ID per line
  - Size: ~38 KB
  
- **words_alpha.txt** - English word list
  - Source: https://github.com/dwyl/english-words
  - Size: ~3.7 MB
  - Used by: `upcase` benchmark

## Documentation

- **[benches/README.md](benches/README.md)** - Comprehensive benchmark documentation
  - Detailed descriptions of each benchmark
  - Running instructions and examples
  - Troubleshooting guide
  - Performance interpretation tips

- **[CONTRIBUTING.md](CONTRIBUTING.md)** - Contribution guidelines
  - Repository structure details
  - Benchmark development guidelines
  - Dependency management

## Troubleshooting

### Path Dependency Issues

**Error: "failed to load manifest for dependency `dfir_rs`"**

Solution: Verify repository structure:
```bash
# From this repository
ls -la ../bigweaver-agent-canary-hydro-zeta/dfir_rs
ls -la ../bigweaver-agent-canary-hydro-zeta/sinktools
```

Both paths must exist and contain valid Rust crates.

### Benchmark Execution Issues

**Benchmarks run too slowly:**
- Run specific benchmarks instead of entire suite
- Reduce sample size: `cargo bench -- --sample-size 10`
- Close resource-intensive applications

**Inconsistent results:**
- Ensure consistent system state (close background apps)
- Run with `--warm-up-time` and `--measurement-time` flags
- Check for thermal throttling on long benchmark runs

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for detailed guidelines on:
- Adding new benchmarks
- Updating existing benchmarks
- Testing changes
- Documentation standards

## Related Repositories

- **bigweaver-agent-canary-hydro-zeta** - Main Hydro repository
  - Contains core runtime, language, and remaining benchmarks
  - See its `benches/README.md` for information about benchmarks kept in the main repo

## References

- [Hydro Project Documentation](https://hydro.run/)
- [Criterion.rs Benchmarking Guide](https://bheisler.github.io/criterion.rs/book/)
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)