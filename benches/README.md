# Timely and Differential-Dataflow Benchmarks

This directory contains benchmarks for comparing Hydro implementations with Timely Dataflow and Differential Dataflow implementations.

## Overview

These benchmarks were migrated from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to isolate the Timely/Differential-Dataflow dependencies and improve build times for the core Hydro project.

## Available Benchmarks

### Arithmetic Operations
**File:** `arithmetic.rs`

Benchmarks basic arithmetic operations through a pipeline of operations, comparing:
- Sequential channel-based processing
- Timely Dataflow implementation
- DFIR (Hydro) implementation

### Fan-In Pattern
**File:** `fan_in.rs`

Tests the fan-in pattern where multiple input streams converge into a single output stream.

### Fan-Out Pattern
**File:** `fan_out.rs`

Tests the fan-out pattern where a single input stream is distributed to multiple output streams.

### Fork-Join Pattern
**File:** `fork_join.rs`

Benchmarks the fork-join pattern with dynamically generated code for different parallelism levels. The build script generates variations at compile time.

### Identity Transformation
**File:** `identity.rs`

Tests the overhead of passing data through the dataflow system without any transformations, measuring the baseline performance.

### Join Operations
**File:** `join.rs`

Benchmarks join operations between two streams, a fundamental operation in dataflow systems.

### Graph Reachability
**File:** `reachability.rs`

Complex benchmark that computes graph reachability using:
- Input graph: `reachability_edges.txt` (55,008 edges)
- Expected results: `reachability_reachable.txt` (7,855 reachable nodes)

Tests iterative computation capabilities of the dataflow systems.

### String Transformation
**File:** `upcase.rs`

Benchmarks string transformation operations (converting to uppercase), testing text processing performance.

## Running Benchmarks

### Run All Benchmarks
```bash
cargo bench -p benches
```

### Run Specific Benchmark
```bash
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench fan_in
cargo bench -p benches --bench fan_out
cargo bench -p benches --bench fork_join
cargo bench -p benches --bench identity
cargo bench -p benches --bench join
cargo bench -p benches --bench reachability
cargo bench -p benches --bench upcase
```

### Run with Specific Parameters
Some benchmarks accept parameters:
```bash
# Run reachability with custom parameters
cargo bench -p benches --bench reachability -- --verbose
```

## Dependencies

This benchmark suite requires:
- **timely-master** (0.13.0-dev.1) - Timely Dataflow framework
- **differential-dataflow-master** (0.13.0-dev.1) - Differential Dataflow framework
- **criterion** (0.5.0) - Benchmarking framework with async support

## Build Process

The `build.rs` script generates code for the fork_join benchmark at compile time, creating variations with different parallelism levels. Generated files follow the pattern `fork_join_*.hf` and are excluded from version control.

## Benchmark Output

Benchmarks generate HTML reports in the `target/criterion/` directory with:
- Performance measurements
- Comparison charts
- Statistical analysis
- Historical trend data

View reports by opening `target/criterion/report/index.html` in a browser.

## Performance Comparison Workflow

To compare Hydro-native implementations with these Timely/Differential-Dataflow benchmarks:

1. **Run Hydro-native benchmarks** in the main repository:
   ```bash
   cd bigweaver-agent-canary-hydro-zeta
   cargo bench -p benches
   ```

2. **Run Timely/Differential-Dataflow benchmarks** in this repository:
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps
   cargo bench -p benches
   ```

3. **Compare results** from both repositories to evaluate:
   - Throughput differences
   - Latency characteristics
   - Memory usage patterns
   - Scalability behavior

## Data Files

- `reachability_edges.txt` - Graph edge list for reachability benchmark
- `reachability_reachable.txt` - Expected reachable nodes for verification

## Notes

- These benchmarks are maintained separately to reduce build dependencies in the main Hydro repository
- The benchmarks use development versions of Timely and Differential-Dataflow for latest features and compatibility
- Build times can be significant due to the size of the Timely/Differential-Dataflow codebases
- For Hydro-native benchmarks without these dependencies, see the main repository

## Migration Information

See [BENCHMARK_MIGRATION.md](../BENCHMARK_MIGRATION.md) in the main repository for details about the migration from the main repository to this dependencies repository.
