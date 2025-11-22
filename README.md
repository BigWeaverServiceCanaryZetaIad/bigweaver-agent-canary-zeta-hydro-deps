# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks for [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow) and [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow) to enable performance comparisons with the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository.

## Purpose

The benchmarks in this repository serve to:

1. **Enable Performance Comparisons**: Provide baseline performance metrics from established dataflow frameworks (Timely and Differential Dataflow) for comparison with Hydro's performance
2. **Maintain Dependency Separation**: Keep external framework dependencies separate from the main Hydro repository to avoid dependency bloat
3. **Support Research & Development**: Facilitate research by providing standardized benchmarks across different dataflow systems

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── Cargo.toml                           # Workspace configuration
├── README.md                            # This file
├── BENCHMARK_COMPARISON.md              # Guide for comparing with main repo
├── benches/
│   ├── timely/                          # Timely Dataflow benchmarks
│   │   ├── Cargo.toml
│   │   └── benches/
│   │       ├── arithmetic.rs            # Basic arithmetic operations
│   │       ├── identity.rs              # Identity/passthrough operations
│   │       ├── fan_in.rs                # Stream merging operations
│   │       ├── fan_out.rs               # Stream splitting operations
│   │       ├── micro_ops.rs             # Filter, map, and chain operations
│   │       └── reachability.rs          # Graph traversal patterns
│   └── differential/                    # Differential Dataflow benchmarks
│       ├── Cargo.toml
│       └── benches/
│           ├── arithmetic.rs            # Basic arithmetic operations
│           ├── identity.rs              # Identity/passthrough operations
│           ├── fan_in.rs                # Collection merging operations
│           ├── fan_out.rs               # Collection splitting operations
│           ├── micro_ops.rs             # Filter, map, and chain operations
│           └── reachability.rs          # Iterative graph traversal
```

## Getting Started

### Prerequisites

- Rust 1.70 or later
- Cargo

### Building the Benchmarks

Build all benchmarks:

```bash
cargo build --release
```

Build specific benchmark suite:

```bash
cargo build --release -p timely-benchmarks
cargo build --release -p differential-benchmarks
```

### Running the Benchmarks

Run all benchmarks (this will take some time):

```bash
cargo bench
```

Run benchmarks for a specific framework:

```bash
cargo bench -p timely-benchmarks
cargo bench -p differential-benchmarks
```

Run a specific benchmark:

```bash
cargo bench -p timely-benchmarks --bench arithmetic
cargo bench -p differential-benchmarks --bench reachability
```

### Benchmark Output

Benchmarks use [Criterion.rs](https://github.com/bheisler/criterion.rs) and generate:

- **Console output**: Summary statistics and comparisons
- **HTML reports**: Detailed reports in `target/criterion/`
- **Baseline comparisons**: Track performance changes over time

View HTML reports:

```bash
# After running benchmarks, open the generated HTML reports
open target/criterion/report/index.html
```

## Available Benchmarks

### 1. Arithmetic Operations

Tests basic arithmetic operations (multiplication, addition, division) on data streams/collections.

**Variants:**
- Different input sizes: 100, 1K, 10K, 100K elements

**Purpose:** Measures computational overhead and throughput for simple transformations.

### 2. Identity Operations

Tests the minimal overhead of passing data through the dataflow graph without transformations.

**Variants:**
- Different input sizes: 100, 1K, 10K, 100K elements

**Purpose:** Establishes baseline for framework overhead.

### 3. Fan-In Operations

Tests merging multiple streams/collections into a single output.

**Variants:**
- Different branch counts: 2, 4, 8, 16 branches
- 1K elements per branch

**Purpose:** Measures performance of stream/collection concatenation and merging.

### 4. Fan-Out Operations

Tests splitting a single stream/collection into multiple consumers.

**Variants:**
- Different branch counts: 2, 4, 8, 16 branches
- 10K elements total

**Purpose:** Measures performance of multi-consumer dataflow patterns.

### 5. Micro Operations

Tests common operations like `filter`, `map`, and chains of operations.

**Variants:**
- Filter only
- Map only  
- Chain of filters and maps
- Input sizes: 1K, 10K, 100K elements

**Purpose:** Measures performance of frequently used operators.

### 6. Reachability (Graph Traversal)

Tests iterative graph traversal patterns (computing reachable nodes from a starting set).

**Variants:**
- Different graph sizes: 100, 500, 1K nodes
- Linear chain with periodic cross-edges

**Purpose:** Measures performance of iterative computations and fixpoint algorithms.

## Comparing with Main Repository

See [BENCHMARK_COMPARISON.md](./BENCHMARK_COMPARISON.md) for detailed instructions on:

- Running equivalent benchmarks in the main Hydro repository
- Interpreting comparison results
- Understanding differences in programming models
- Analyzing performance characteristics

## Performance Considerations

### Timely Dataflow
- Low-level dataflow framework
- Supports asynchronous message passing
- Excellent for streaming data processing
- Fine-grained control over execution

### Differential Dataflow
- Built on top of Timely Dataflow
- Optimized for incremental computation
- Updates outputs based on input changes
- Best for iterative and recursive computations

### Hydro (Main Repository)
- High-level declarative programming model
- Compile-time optimizations via staging
- Choreographed distributed execution
- Zero-overhead abstractions

## Contributing

This repository is maintained as part of the BigWeaver Service Canary Zeta project. For questions or contributions, please refer to the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository.

## License

Apache-2.0

## Related Resources

- [Timely Dataflow Documentation](https://timelydataflow.github.io/timely-dataflow/)
- [Differential Dataflow Documentation](https://timelydataflow.github.io/differential-dataflow/)
- [Hydro Project](https://hydro.run/)
- [Criterion.rs Documentation](https://bheisler.github.io/criterion.rs/book/)