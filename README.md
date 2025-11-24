# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmark code for comparing Hydro (DFIR/Hydroflow) performance against timely-dataflow and differential-dataflow frameworks.

## Overview

The benchmarks in this repository were separated from the main Hydro repository to maintain a cleaner dependency tree and reduce technical debt in the core project. This separation allows:

- **Cleaner dependency tree**: Eliminates unnecessary dependencies from the main codebase
- **Independent development**: Benchmarks can be maintained and versioned separately
- **Optional performance testing**: Clone only when needed for performance analysis
- **Reduced build times**: Faster CI/CD builds without heavy benchmark dependencies

## Repository Structure

```
.
├── benches/                    # Benchmark crate
│   ├── benches/               # Benchmark implementations
│   │   ├── arithmetic.rs      # Arithmetic operations benchmark
│   │   ├── fan_in.rs          # Fan-in dataflow pattern
│   │   ├── fan_out.rs         # Fan-out dataflow pattern
│   │   ├── fork_join.rs       # Fork-join pattern
│   │   ├── futures.rs         # Async futures benchmark
│   │   ├── identity.rs        # Identity transformation
│   │   ├── join.rs            # Join operations
│   │   ├── micro_ops.rs       # Micro-operations benchmark
│   │   ├── reachability.rs    # Graph reachability
│   │   ├── symmetric_hash_join.rs  # Symmetric hash join
│   │   ├── upcase.rs          # String uppercase transformation
│   │   ├── words_diamond.rs   # Word processing diamond pattern
│   │   ├── reachability_edges.txt      # Test data for reachability
│   │   ├── reachability_reachable.txt  # Expected reachability results
│   │   └── words_alpha.txt    # Word list test data (~3.7MB)
│   ├── Cargo.toml            # Benchmark dependencies
│   ├── build.rs              # Build script
│   └── README.md             # Benchmark-specific documentation
├── Cargo.toml                 # Workspace configuration
└── README.md                  # This file
```

## Dependencies

The benchmarks require the following dependencies:

- **timely-dataflow** (timely-master 0.13.0-dev.1): Core timely dataflow framework
- **differential-dataflow** (differential-dataflow-master 0.13.0-dev.1): Differential computation framework
- **dfir_rs**: DFIR/Hydroflow implementation from main Hydro repository
- **criterion**: Benchmarking framework with async support
- **sinktools**: Utility crate from main Hydro repository

## Usage

### Running All Benchmarks

```bash
cargo bench -p benches
```

### Running Specific Benchmarks

Run a single benchmark:
```bash
cargo bench -p benches --bench reachability
```

Run multiple specific benchmarks:
```bash
cargo bench -p benches --bench arithmetic --bench join
```

### Quick Performance Test

For quick testing during development:
```bash
cargo bench -p benches -- --quick
```

## Benchmark Descriptions

### Dataflow Patterns

- **arithmetic**: Tests basic arithmetic operations in a dataflow graph
- **fan_in**: Measures performance of multiple streams merging into one
- **fan_out**: Tests splitting a stream into multiple downstream paths
- **fork_join**: Evaluates fork-join pattern performance
- **identity**: Baseline benchmark for simple identity transformation
- **join**: Tests join operations between streams
- **symmetric_hash_join**: Specialized benchmark for symmetric hash joins

### Application Benchmarks

- **reachability**: Graph reachability computation using test data
- **words_diamond**: Word processing with diamond-shaped dataflow
- **upcase**: String transformation (uppercase) operations
- **micro_ops**: Collection of micro-operation benchmarks
- **futures**: Async futures handling in dataflow

## Performance Comparison

These benchmarks compare three implementations:

1. **DFIR/Hydroflow**: Compiled dataflow from the main Hydro repository
2. **Timely Dataflow**: Reference implementation using timely-dataflow
3. **Differential Dataflow**: Reference implementation using differential-dataflow

Each benchmark typically includes variants for:
- Compiled vs interpreted execution
- Different optimization levels
- Various input sizes

## Development

### Building

```bash
cargo build -p benches
```

### Testing

```bash
cargo test -p benches
```

### Benchmark Results

Benchmark results are generated as HTML reports in `target/criterion/` directory. Open the HTML files in a browser to view detailed performance metrics, graphs, and comparisons.

## Contributing

When adding new benchmarks:

1. Create a new `.rs` file in `benches/benches/`
2. Add the benchmark configuration to `benches/Cargo.toml`:
   ```toml
   [[bench]]
   name = "your_benchmark"
   harness = false
   ```
3. Implement benchmarks for all three frameworks (DFIR, timely, differential)
4. Include appropriate test data if needed
5. Update this README with benchmark description

## Data Files

Test data files are included in the repository:

- **reachability_edges.txt** (~521KB): Edge list for graph reachability tests
- **reachability_reachable.txt** (~38KB): Expected reachable nodes
- **words_alpha.txt** (~3.7MB): English word list from [dwyl/english-words](https://github.com/dwyl/english-words)

## Related Repositories

- [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta): Main Hydro project repository

## License

Apache-2.0

## Migration Notes

These benchmarks were migrated from the main Hydro repository to:
1. Reduce the dependency footprint of the main repository
2. Enable independent benchmark development and versioning
3. Maintain all performance comparison capabilities
4. Follow the team's architectural pattern of separating concerns

The migration preserves:
- ✅ All benchmark implementations
- ✅ Performance comparison functionality (DFIR vs timely vs differential)
- ✅ Test data files
- ✅ Benchmark configuration and metadata
- ✅ Build scripts and tooling