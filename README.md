# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and performance comparison tools for the Hydro dataflow framework, specifically focusing on timely and differential-dataflow implementations.

## Overview

This repository was created to maintain benchmarks that compare Hydro's performance with timely-dataflow and differential-dataflow implementations. By isolating these benchmarks in a separate repository, we:

- **Reduce dependency complexity** in the main hydro repository
- **Maintain performance comparison capabilities** for different dataflow implementations
- **Follow separation of concerns** architectural pattern
- **Enable independent versioning** of benchmark tooling

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── benches/                    # Benchmark package
│   ├── benches/               # Benchmark source files
│   │   ├── arithmetic.rs      # Arithmetic operations benchmark
│   │   ├── fan_in.rs          # Fan-in pattern benchmark
│   │   ├── fan_out.rs         # Fan-out pattern benchmark
│   │   ├── fork_join.rs       # Fork-join pattern benchmark
│   │   ├── futures.rs         # Futures-based benchmark
│   │   ├── identity.rs        # Identity transformation benchmark
│   │   ├── join.rs            # Join operations benchmark
│   │   ├── micro_ops.rs       # Micro-operations benchmark
│   │   ├── reachability.rs    # Graph reachability benchmark
│   │   ├── symmetric_hash_join.rs # Symmetric hash join benchmark
│   │   ├── upcase.rs          # String uppercase benchmark
│   │   ├── words_diamond.rs   # Word processing diamond pattern benchmark
│   │   ├── reachability_edges.txt      # Graph edge data
│   │   ├── reachability_reachable.txt  # Expected reachable nodes
│   │   └── words_alpha.txt    # English word list
│   ├── Cargo.toml             # Benchmark package configuration
│   ├── README.md              # Benchmark documentation
│   └── build.rs               # Build script
├── Cargo.toml                 # Workspace configuration
└── README.md                  # This file
```

## Dependencies

This repository includes dependencies on:

- **timely-dataflow**: Distributed data-parallel compute platform
- **differential-dataflow**: Incremental dataflow framework
- **dfir_rs**: Hydro's dataflow IR (from main hydro repository)
- **criterion**: Benchmarking framework

## Running Benchmarks

### Prerequisites

Ensure you have Rust installed (version 1.75 or later recommended):

```bash
rustup update
```

### Running All Benchmarks

To run all benchmarks:

```bash
cargo bench
```

### Running Specific Benchmarks

To run a specific benchmark:

```bash
# Run arithmetic benchmark
cargo bench --bench arithmetic

# Run reachability benchmark
cargo bench --bench reachability

# Run join benchmark
cargo bench --bench join
```

### Quick Benchmark Run

For a quick test run with reduced iterations:

```bash
cargo bench -- --quick
```

### Benchmark Output

Benchmarks generate HTML reports in `target/criterion/`. Open the `index.html` file in a browser to view detailed performance metrics and visualizations.

## Available Benchmarks

### Dataflow Pattern Benchmarks

- **arithmetic**: Tests arithmetic operations in dataflow pipelines
- **fan_in**: Benchmarks fan-in dataflow patterns (multiple inputs, single output)
- **fan_out**: Benchmarks fan-out dataflow patterns (single input, multiple outputs)
- **fork_join**: Tests fork-join parallelism patterns
- **identity**: Benchmarks simple identity transformations
- **join**: Tests various join operations
- **symmetric_hash_join**: Specific benchmark for symmetric hash join implementation

### Application Benchmarks

- **reachability**: Graph reachability computation using real graph data
- **upcase**: String transformation benchmarks
- **words_diamond**: Complex word processing with diamond dependency pattern
- **micro_ops**: Fine-grained micro-operation benchmarks

### Async Benchmarks

- **futures**: Benchmarks for futures-based async operations

## Performance Comparison

These benchmarks typically compare performance across multiple implementations:

1. **Timely Dataflow**: Direct timely-dataflow implementation
2. **Differential Dataflow**: Differential-dataflow implementation
3. **Hydroflow (dfir_rs)**: Hydro's dataflow implementation
4. **Raw Rust**: Baseline Rust implementation (where applicable)

This allows for comprehensive performance analysis and identification of optimization opportunities.

## Benchmark Data Files

### Reachability Benchmark

- `reachability_edges.txt`: Contains edge definitions for graph reachability tests
- `reachability_reachable.txt`: Expected output for verification

### Words Benchmark

- `words_alpha.txt`: English word list from [dwyl/english-words](https://github.com/dwyl/english-words)

## Development

### Adding New Benchmarks

1. Create a new `.rs` file in `benches/benches/`
2. Add a benchmark entry in `benches/Cargo.toml`:
   ```toml
   [[bench]]
   name = "your_benchmark"
   harness = false
   ```
3. Use the criterion framework for consistent benchmarking
4. Follow the existing benchmark patterns for comparison implementations

### Updating Dependencies

To update the dfir_rs and sinktools dependencies from the main hydro repository:

```bash
cargo update
```

These dependencies are pulled from the main bigweaver-agent-canary-hydro-zeta repository via git.

## Related Repositories

- **bigweaver-agent-canary-hydro-zeta**: Main Hydro framework repository
  - URL: https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta

## Architecture

This repository follows the team's architectural pattern of:

- **Separation of concerns**: Benchmarks isolated from core functionality
- **Dependency isolation**: Heavy dependencies (timely, differential) kept separate from main codebase
- **Independent evolution**: Benchmarks can evolve independently of core framework
- **Performance focus**: Dedicated environment for performance testing and comparison

## CI/CD

(Note: CI/CD configuration should be added to automate benchmark runs and track performance over time)

### Suggested CI/CD Workflow

- Run benchmarks on pull requests
- Track performance metrics over time
- Alert on performance regressions
- Generate and publish performance reports

## Contributing

When contributing benchmarks:

1. Ensure benchmarks are deterministic and reproducible
2. Include multiple implementation variants for comparison
3. Document the benchmark purpose and expected behavior
4. Provide sample data files if needed
5. Follow the team's coding standards (rustfmt, clippy)

## Questions and Support

For questions about benchmarks or performance:

1. Check the `benches/README.md` for benchmark-specific documentation
2. Review the git history for context on specific benchmarks
3. Contact the team for guidance on performance analysis

## License

Apache-2.0

---

**Repository**: bigweaver-agent-canary-zeta-hydro-deps  
**Owner**: BigWeaverServiceCanaryZetaIad  
**Purpose**: Performance benchmarking and comparison for Hydro dataflow framework  
**Last Updated**: November 24, 2024