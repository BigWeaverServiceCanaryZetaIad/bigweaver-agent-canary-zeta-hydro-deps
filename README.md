# bigweaver-agent-canary-zeta-hydro-deps

Timely and Differential-Dataflow Benchmarks Repository

## Overview

This repository contains performance benchmarks for **Timely Dataflow** and **Differential-Dataflow** frameworks. These benchmarks were separated from the main `bigweaver-agent-canary-hydro-zeta` repository to:

1. **Reduce dependency footprint** in the main repository
2. **Maintain clean separation of concerns** between core functionality and external framework comparisons
3. **Enable independent performance evaluation** of different dataflow systems
4. **Facilitate performance comparisons** with the main Hydroflow/DFIR implementation

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── Cargo.toml                    # Workspace configuration
├── README.md                     # This file
├── GETTING_STARTED.md            # Quick start guide
├── PERFORMANCE_COMPARISON.md     # Performance comparison guide
├── RELATIONSHIP_TO_MAIN_REPO.md  # Connection to main repository
└── benches/                      # Benchmark implementations
    ├── Cargo.toml                # Benchmark dependencies
    ├── build.rs                  # Build script
    └── benches/                  # Benchmark files
        ├── arithmetic.rs         # Arithmetic operations benchmark
        ├── fan_in.rs             # Fan-in pattern benchmark
        ├── fan_out.rs            # Fan-out pattern benchmark
        ├── fork_join.rs          # Fork-join pattern benchmark
        ├── identity.rs           # Identity transformation benchmark
        ├── join.rs               # Join operations benchmark
        ├── upcase.rs             # String manipulation benchmark
        ├── reachability.rs       # Graph reachability benchmark
        ├── reachability_edges.txt     # Test data for reachability
        ├── reachability_reachable.txt # Expected results
        └── words_alpha.txt       # Test data for string operations
```

## Dependencies

This repository includes the following key dependencies:

- **timely** (`timely-master` v0.13.0-dev.1) - Timely Dataflow framework
- **differential-dataflow** (`differential-dataflow-master` v0.13.0-dev.1) - Differential computation framework
- **criterion** (v0.5.0) - Benchmarking framework with statistical analysis

## Quick Start

### Prerequisites

- Rust toolchain (edition 2024 or later)
- Cargo build system

### Running Benchmarks

```bash
# Run all benchmarks
cargo bench

# Run specific benchmark
cargo bench --bench identity

# Run benchmark for reachability (includes both timely and differential)
cargo bench --bench reachability

# Run with specific criterion features
cargo bench -- --verbose
```

### Viewing Results

Criterion generates HTML reports with detailed statistical analysis:

```bash
# View benchmark results
open target/criterion/report/index.html
```

## Available Benchmarks

### 1. Identity (`identity.rs`)
Tests simple data transformation through multiple operators.
- **Framework**: Timely Dataflow
- **Pattern**: Map operations chain
- **Scale**: 1,000,000 items through 20 operations

### 2. Arithmetic (`arithmetic.rs`)
Evaluates arithmetic computation performance.
- **Framework**: Timely Dataflow
- **Pattern**: Mathematical operations
- **Scale**: 1,000,000 random integers

### 3. Fan-In (`fan_in.rs`)
Tests stream merging performance.
- **Framework**: Timely Dataflow
- **Pattern**: Multiple streams → single stream
- **Scale**: 20 streams, 1,000,000 items each

### 4. Fan-Out (`fan_out.rs`)
Tests stream branching performance.
- **Framework**: Timely Dataflow
- **Pattern**: Single stream → multiple consumers
- **Scale**: 1 stream with 20 consumers, 1,000,000 items

### 5. Fork-Join (`fork_join.rs`)
Tests parallel branch and merge pattern.
- **Framework**: Timely Dataflow
- **Pattern**: Split → parallel processing → merge
- **Scale**: 1,000,000 items

### 6. Join (`join.rs`)
Tests relational join operations.
- **Framework**: Timely Dataflow
- **Pattern**: Two-way equijoin
- **Scale**: 100,000 items per side

### 7. Upcase (`upcase.rs`)
Tests string manipulation performance.
- **Framework**: Timely Dataflow
- **Pattern**: String transformation
- **Scale**: 100,000 words

### 8. Reachability (`reachability.rs`)
Tests graph reachability computation.
- **Frameworks**: Timely Dataflow AND Differential-Dataflow
- **Pattern**: Iterative graph traversal
- **Scale**: Real graph data (~500KB edges)

## Performance Comparison

For detailed instructions on comparing these benchmarks with the main Hydroflow/DFIR implementation, see [PERFORMANCE_COMPARISON.md](PERFORMANCE_COMPARISON.md).

## Integration with Main Repository

This repository is designed to work alongside the main `bigweaver-agent-canary-hydro-zeta` repository. For details on how these repositories relate and coordinate, see [RELATIONSHIP_TO_MAIN_REPO.md](RELATIONSHIP_TO_MAIN_REPO.md).

## Documentation

- **[GETTING_STARTED.md](GETTING_STARTED.md)** - Detailed setup and usage guide
- **[PERFORMANCE_COMPARISON.md](PERFORMANCE_COMPARISON.md)** - How to run comparative performance analysis
- **[RELATIONSHIP_TO_MAIN_REPO.md](RELATIONSHIP_TO_MAIN_REPO.md)** - Repository coordination details

## Development

### Running Individual Tests

```bash
# Run specific benchmark with extra output
cargo bench --bench identity -- --verbose --nocapture

# Run with sampling parameters
cargo bench --bench reachability -- --sample-size 20
```

### Modifying Benchmarks

1. Edit the relevant benchmark file in `benches/benches/`
2. Maintain the existing Criterion structure
3. Ensure benchmark functions follow the naming convention
4. Run benchmarks to verify changes

### Adding New Benchmarks

1. Create a new `.rs` file in `benches/benches/`
2. Add the benchmark to `benches/Cargo.toml`:
   ```toml
   [[bench]]
   name = "your_benchmark"
   harness = false
   ```
3. Follow the established patterns in existing benchmarks
4. Document the new benchmark in this README

## Contributing

When contributing benchmarks:

1. Ensure code follows Rust 2024 edition standards
2. Use the workspace lints configuration
3. Include appropriate test data if needed
4. Document benchmark parameters and expectations
5. Verify benchmarks compile and run successfully

## License

Apache-2.0

## Related Resources

- **Main Repository**: `bigweaver-agent-canary-hydro-zeta`
- **Timely Dataflow**: https://github.com/TimelyDataflow/timely-dataflow
- **Differential-Dataflow**: https://github.com/TimelyDataflow/differential-dataflow
- **Criterion.rs**: https://github.com/bheisler/criterion.rs