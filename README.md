# bigweaver-agent-canary-zeta-hydro-deps

Performance benchmarks for Hydro/DFIR comparing against Timely and Differential-Dataflow frameworks.

## Overview

This repository contains microbenchmarks that compare the performance of the Hydro/DFIR dataflow runtime against:
- **Timely Dataflow** - A low-latency data-parallel dataflow system
- **Differential Dataflow** - An incremental data-parallel dataflow system built on Timely

## Repository Structure

```
benches/
├── Cargo.toml              # Benchmark package configuration
├── README.md               # Benchmark-specific documentation
├── build.rs                # Build script for generating test code
└── benches/                # Individual benchmark implementations
    ├── arithmetic.rs       # Arithmetic operations benchmark
    ├── fan_in.rs          # Fan-in pattern benchmark
    ├── fan_out.rs         # Fan-out pattern benchmark
    ├── fork_join.rs       # Fork-join pattern benchmark
    ├── futures.rs         # Futures resolution benchmark
    ├── identity.rs        # Identity operation benchmark
    ├── join.rs            # Join operation benchmark
    ├── micro_ops.rs       # Micro-operations benchmark
    ├── reachability.rs    # Graph reachability benchmark
    ├── symmetric_hash_join.rs  # Symmetric hash join benchmark
    ├── upcase.rs          # String uppercasing benchmark
    └── words_diamond.rs   # Word processing diamond pattern
```

## Benchmarks

### Core Benchmarks

1. **Reachability** - Graph reachability computation comparing iterative approaches
2. **Micro Operations** - Low-level operation performance comparison
3. **Join Operations** - Various join implementations (hash join, symmetric hash join)
4. **Fork-Join** - Parallel work distribution and aggregation patterns
5. **Fan-in/Fan-out** - Stream multiplexing and demultiplexing patterns
6. **Futures** - Asynchronous operation handling and resolution

### Performance Comparison

Each benchmark typically includes implementations for:
- **Timely** - Using the Timely dataflow framework
- **Differential** - Using Differential Dataflow
- **DFIR Scheduled** - Using DFIR's scheduled runtime
- **DFIR Compiled** - Using DFIR's compiled runtime (surface syntax)

This allows for direct performance comparisons across different dataflow systems and runtime strategies.

## Running Benchmarks

### Prerequisites

- Rust toolchain (stable)
- Cargo

### Run All Benchmarks

```bash
cargo bench -p benches
```

### Run Specific Benchmarks

```bash
# Run reachability benchmark
cargo bench -p benches --bench reachability

# Run micro operations benchmark
cargo bench -p benches --bench micro_ops

# Run join benchmark
cargo bench -p benches --bench join
```

### Run with Filtering

```bash
# Run only DFIR benchmarks
cargo bench -p benches -- dfir

# Run only micro operations
cargo bench -p benches -- micro/ops/
```

## CI/CD Integration

The repository includes a GitHub Actions workflow (`.github/workflows/benchmark.yml`) that:

1. **Runs automatically** on:
   - Scheduled runs (daily)
   - Push to main or feature branches with `[ci-bench]` in commit message
   - Pull requests with `[ci-bench]` in title or body
   - Manual workflow dispatch

2. **Generates results**:
   - HTML reports with interactive charts
   - JSON data for historical tracking
   - Uploads artifacts for PR review

3. **Publishes to gh-pages**:
   - Maintains historical benchmark data
   - Provides web-accessible performance reports

## Dependencies

The benchmarks depend on:

- **dfir_rs** - The DFIR runtime (from the main Hydro repository)
- **timely-master** - Latest Timely Dataflow development version
- **differential-dataflow-master** - Latest Differential Dataflow development version
- **criterion** - Benchmark harness with statistical analysis

## Configuration

### Workspace Configuration

The workspace is configured in `Cargo.toml` with:
- Edition 2024
- Apache-2.0 license
- Optimized release profiles for accurate benchmarking
- Lint rules for code quality

### Benchmark Configuration

Individual benchmarks can be configured by modifying:
- Dataset sizes in benchmark files
- Iteration counts via Criterion
- Warmup settings
- Measurement duration

## Data Files

Some benchmarks use test data files:
- `reachability_edges.txt` - Graph edges for reachability tests
- `reachability_reachable.txt` - Expected reachable nodes
- `words_alpha.txt` - English word list (from https://github.com/dwyl/english-words)

## Contributing

When adding new benchmarks:

1. Create a new `.rs` file in `benches/benches/`
2. Add a `[[bench]]` entry in `benches/Cargo.toml`
3. Include comparison implementations for multiple frameworks
4. Document the benchmark's purpose and expected behavior
5. Ensure the benchmark uses `harness = false` for Criterion

## Performance Insights

The benchmarks help answer questions like:
- How does DFIR's compiled runtime compare to its scheduled runtime?
- What is the overhead of Timely/Differential's change propagation?
- Which framework is best suited for specific dataflow patterns?
- How do different join strategies perform?

## License

Apache-2.0

## Related Repositories

- [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) - Main Hydro/DFIR repository
