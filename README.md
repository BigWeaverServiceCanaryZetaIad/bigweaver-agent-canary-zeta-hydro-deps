# Hydro Dependencies Benchmarks

This repository contains the timely and differential-dataflow benchmarks that were moved from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository. These benchmarks compare DFIR/Hydro performance against Timely Dataflow and Differential Dataflow frameworks.

## Purpose

This repository maintains:
- **Performance comparison benchmarks** between DFIR/Hydro and Timely/Differential Dataflow
- **Historical performance data** for tracking performance over time  
- **Independent benchmark execution** without adding dependencies to the main repository

By isolating these benchmarks in a separate repository, we maintain clean separation of concerns and prevent the main codebase from depending on external dataflow frameworks that are only needed for comparative benchmarking.

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── benches/                    # Benchmark implementations
│   ├── arithmetic.rs          # Arithmetic pipeline benchmarks (Timely)
│   ├── fan_in.rs              # Fan-in pattern benchmarks (Timely)
│   ├── fan_out.rs             # Fan-out pattern benchmarks (Timely)
│   ├── fork_join.rs           # Fork-join pattern benchmarks (Timely)
│   ├── futures.rs             # Futures-based benchmarks
│   ├── identity.rs            # Identity operation benchmarks (Timely)
│   ├── join.rs                # Join operation benchmarks (Timely)
│   ├── micro_ops.rs           # Micro-operations benchmarks
│   ├── reachability.rs        # Graph reachability (Differential Dataflow)
│   ├── symmetric_hash_join.rs # Symmetric hash join benchmarks
│   ├── upcase.rs              # String uppercase benchmarks (Timely)
│   ├── words_diamond.rs       # Words diamond pattern benchmarks
│   ├── reachability_edges.txt # Test data for reachability
│   ├── reachability_reachable.txt # Expected results
│   └── words_alpha.txt        # Word list for benchmarks
├── Cargo.toml                  # Package configuration
├── build.rs                    # Build script
├── README.md                   # This file
└── PERFORMANCE_COMPARISON.md   # Detailed performance comparison methodology

```

## Setup

### Prerequisites

- Rust toolchain (edition 2024)
- Git access to [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)

### Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
   cd bigweaver-agent-canary-zeta-hydro-deps
   ```

2. Build the benchmarks:
   ```bash
   cargo build --benches --release
   ```

## Running Benchmarks

### Run All Benchmarks

```bash
cargo bench
```

This will run all benchmarks and generate an HTML report in `target/criterion/`.

### Run Specific Benchmarks

Run a specific benchmark suite:
```bash
cargo bench --bench reachability     # Graph reachability (Differential Dataflow)
cargo bench --bench arithmetic       # Arithmetic operations (Timely)
cargo bench --bench join             # Join operations (Timely)
cargo bench --bench identity         # Identity operations (Timely)
```

### Quick Benchmark Run

For faster iteration during development:
```bash
cargo bench --bench reachability -- --quick
```

### Filter Specific Tests

Run only timely-specific benchmarks:
```bash
cargo bench -- timely
```

Run only differential-dataflow benchmarks:
```bash
cargo bench -- differential
```

## Benchmark Categories

### Timely Dataflow Comparisons
These benchmarks compare DFIR/Hydro against Timely Dataflow:
- **arithmetic**: Pipeline of arithmetic operations
- **fan_in**: Fan-in communication patterns
- **fan_out**: Fan-out communication patterns  
- **fork_join**: Fork-join parallelism patterns
- **identity**: Identity/passthrough operations
- **join**: Stream join operations
- **upcase**: String transformation operations

### Differential Dataflow Comparisons
- **reachability**: Graph reachability computation using incremental computation

### General Performance Benchmarks
- **futures**: Async/futures-based operations
- **micro_ops**: Micro-benchmark of basic operations
- **symmetric_hash_join**: Hash join implementations
- **words_diamond**: Diamond-shaped dataflow patterns

## Performance Comparison

Detailed methodology and interpretation of results can be found in [PERFORMANCE_COMPARISON.md](./PERFORMANCE_COMPARISON.md).

### Understanding Results

Benchmark results are generated using [Criterion.rs](https://github.com/bheisler/criterion.rs) and include:
- **Throughput measurements**: Operations per second
- **Latency statistics**: Mean, median, and percentiles
- **Historical comparison**: Performance trends over time
- **Statistical analysis**: Confidence intervals and regression detection

View HTML reports in `target/criterion/report/index.html` after running benchmarks.

## Relationship to Main Repository

This repository complements [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta):

- **Main Repository**: Core DFIR/Hydro implementation without external framework dependencies
- **This Repository**: Performance comparison benchmarks requiring Timely/Differential Dataflow

### Why Separate Repositories?

1. **Dependency Isolation**: Keeps Timely/Differential Dataflow dependencies out of the main codebase
2. **Build Performance**: Main repository builds faster without benchmark dependencies
3. **Clear Separation**: Distinguishes between core functionality and comparative analysis
4. **Maintainability**: Easier to maintain and update benchmark infrastructure independently

## Data Files

The repository includes test data for benchmarks:
- **words_alpha.txt**: 370,103 English words from [dwyl/english-words](https://github.com/dwyl/english-words/blob/master/words_alpha.txt)
- **reachability_edges.txt**: Graph edges for reachability testing
- **reachability_reachable.txt**: Expected reachable nodes

## Contributing

When adding new benchmarks:

1. Follow the existing benchmark structure using Criterion.rs
2. Include both DFIR/Hydro and Timely/Differential implementations for comparison
3. Add documentation explaining what the benchmark measures
4. Update this README with the new benchmark information
5. Document any new test data files

## Continuous Integration

Benchmarks can be run in CI to track performance over time. Configure your CI system to:

1. Run benchmarks on a consistent machine/environment
2. Store historical results for trend analysis
3. Alert on significant performance regressions
4. Compare against baseline measurements

## Notes

- Some benchmarks using `pusherator` (an internal API that was removed) have been commented out
- This repository focuses specifically on comparisons with external frameworks (Timely/Differential Dataflow)
- For internal DFIR/Hydro benchmarks, see the test infrastructure in the main repository

## License

Apache-2.0 - See LICENSE file in the main repository.

## References

- [Main Repository](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)
- [Criterion.rs Documentation](https://bheisler.github.io/criterion.rs/book/)