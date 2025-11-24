# Timely and Differential-Dataflow Benchmarks

This directory contains performance benchmarks comparing Hydroflow/dfir_rs with Timely Dataflow and Differential Dataflow frameworks.

## Overview

These benchmarks were migrated from the main Hydroflow repository to maintain separation of concerns and avoid including external framework dependencies in the core project. The benchmarks enable performance comparisons between different dataflow implementations across various patterns and operations.

## Benchmark Suite

The following benchmarks are available:

### Basic Dataflow Patterns

1. **arithmetic.rs** - Arithmetic operations benchmark
   - Compares performance of repeated arithmetic operations across different implementations
   - Tests: pipeline, raw copy, iterators, Hydroflow (compiled and surface), and Timely

2. **identity.rs** - Identity transformation benchmark
   - Tests throughput of identity (pass-through) operations
   - Compares Hydroflow and Timely implementations

3. **fan_in.rs** - Fan-in pattern benchmark
   - Tests multiple input streams merging into one
   - Uses concatenation operations

4. **fan_out.rs** - Fan-out pattern benchmark
   - Tests one input stream splitting into multiple outputs
   - Uses branching and mapping operations

5. **fork_join.rs** - Fork-join pattern benchmark
   - Tests splitting and rejoining dataflow streams
   - Combines filtering and union operations

### Advanced Operations

6. **join.rs** - Join operations benchmark
   - Tests hash join performance with different key/value types
   - Compares Hydroflow and Timely implementations
   - Supports both `usize` and `String` key types

7. **reachability.rs** - Graph reachability benchmark
   - Tests iterative graph reachability computation
   - Uses Differential Dataflow's iteration operators
   - Includes real graph data (reachability_edges.txt, reachability_reachable.txt)

8. **upcase.rs** - String transformation benchmark
   - Tests string uppercase transformation performance
   - Uses word dictionary data (words_alpha.txt)

## Running Benchmarks

### Prerequisites

Ensure you have Rust and Cargo installed. The benchmarks use the Criterion benchmarking framework.

### Run All Benchmarks

```bash
cd /path/to/bigweaver-agent-canary-zeta-hydro-deps
cargo bench -p timely-differential-benchmarks
```

### Run Specific Benchmark

```bash
cargo bench -p timely-differential-benchmarks --bench arithmetic
cargo bench -p timely-differential-benchmarks --bench join
cargo bench -p timely-differential-benchmarks --bench reachability
```

### Run Specific Test Within a Benchmark

```bash
# Run only the Timely implementation of arithmetic
cargo bench -p timely-differential-benchmarks --bench arithmetic -- timely

# Run only Hydroflow implementations
cargo bench -p timely-differential-benchmarks --bench arithmetic -- dfir_rs
```

## Performance Comparison

These benchmarks allow you to compare:

- **Timely Dataflow** - A low-latency cyclic dataflow computational model
- **Differential Dataflow** - An incremental data processing framework built on Timely
- **Hydroflow/dfir_rs** - The Hydro project's dataflow runtime

### Quick Comparison Commands

```bash
# Compare arithmetic performance across all implementations
cargo bench --bench arithmetic

# Compare join performance
cargo bench --bench join

# Test iterative computation (reachability) with Differential
cargo bench --bench reachability
```

## Understanding Results

Criterion generates detailed reports in `target/criterion/`:

```bash
# View HTML reports
open target/criterion/report/index.html

# View specific benchmark results
open target/criterion/arithmetic/report/index.html
```

Each benchmark produces:
- Throughput measurements
- Latency statistics
- Performance comparisons between runs
- Detailed plots and charts

## Data Files

The benchmark suite includes several data files:

- **words_alpha.txt** (3.7MB) - English word dictionary for string processing benchmarks
  - Source: https://github.com/dwyl/english-words
  
- **reachability_edges.txt** (520KB) - Graph edges for reachability testing
  - Format: space-separated pairs of node IDs
  
- **reachability_reachable.txt** (38KB) - Expected reachable nodes
  - Format: one node ID per line

## Build System

The `build.rs` script generates benchmark code at compile time:

- Generates `fork_join_20.hf` with parameterized fork-join patterns
- Uses environment variables for configuration
- Currently configured for NUM_OPS = 20

## Dependencies

### Core Benchmarking
- **criterion** - Statistical benchmarking framework

### Dataflow Frameworks
- **timely** (timely-master 0.13.0-dev.1) - Timely Dataflow
- **differential-dataflow** (differential-dataflow-master 0.13.0-dev.1) - Differential Dataflow
- **dfir_rs** - Hydroflow runtime (from main repository)
- **sinktools** - Hydroflow utilities

### Supporting Libraries
- **tokio** - Async runtime
- **futures** - Async abstractions
- **rand** - Random number generation
- **seq-macro** - Compile-time sequence generation

## Architecture

This repository follows the team's architectural pattern of separating benchmarks from core functionality:

```
bigweaver-agent-canary-zeta-hydro-deps/
├── benches/
│   ├── Cargo.toml                    # Package configuration
│   ├── README.md                      # This file
│   ├── build.rs                       # Build-time code generation
│   └── benches/
│       ├── arithmetic.rs              # Benchmark implementations
│       ├── fan_in.rs
│       ├── fan_out.rs
│       ├── fork_join.rs
│       ├── identity.rs
│       ├── join.rs
│       ├── reachability.rs
│       ├── upcase.rs
│       ├── reachability_edges.txt     # Test data
│       ├── reachability_reachable.txt
│       └── words_alpha.txt
└── README.md                          # Repository README
```

## Integration with Main Repository

These benchmarks reference the main Hydroflow repository for dfir_rs and related dependencies. This allows:

- Independent benchmark execution
- Performance regression testing
- Framework comparison studies
- Clean separation of concerns

To use local development versions of Hydroflow:

```toml
# In benches/Cargo.toml, replace git references with path:
dfir_rs = { path = "../../bigweaver-agent-canary-hydro-zeta/dfir_rs", features = [ "debugging" ] }
sinktools = { path = "../../bigweaver-agent-canary-hydro-zeta/sinktools", version = "^0.0.1" }
```

## Contributing

When adding new benchmarks:

1. Create a new `.rs` file in `benches/benches/`
2. Use the Criterion framework structure
3. Add a `[[bench]]` entry to `Cargo.toml`
4. Include comparisons across implementations when applicable
5. Document the benchmark purpose and usage
6. Update this README with the new benchmark information

## References

- [Hydroflow Project](https://github.com/hydro-project/hydro)
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)
- [Criterion Benchmarking](https://github.com/bheisler/criterion.rs)

## Troubleshooting

### Build Errors

If you encounter build errors:

1. Ensure you have the latest Rust toolchain
2. Check that git can access the referenced repositories
3. Verify network connectivity for dependency downloads

### Benchmark Failures

If benchmarks fail to run:

1. Check that data files are present in `benches/benches/`
2. Verify sufficient system resources (memory, CPU)
3. Review Criterion output for specific errors

### Performance Issues

If benchmarks run slowly:

1. Ensure running in release mode (Criterion does this automatically)
2. Close resource-intensive applications
3. Consider reducing iteration counts for quick testing

For more help, refer to the main repository documentation or create an issue.
