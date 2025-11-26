# Hydro Dependencies - Timely and Differential-Dataflow Benchmarks

This repository contains benchmarks that depend on external dataflow frameworks (timely and differential-dataflow). These benchmarks were moved from the main `bigweaver-agent-canary-hydro-zeta` repository to maintain clean separation of concerns and reduce the dependency footprint of the main codebase.

## Overview

This repository provides performance comparison benchmarks between Hydro's dataflow implementation and external frameworks like Timely Dataflow and Differential Dataflow. These benchmarks are essential for:

- Performance validation and comparison
- Regression testing against external implementations
- Understanding performance characteristics across different dataflow patterns

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── benches/                    # Benchmark workspace
│   ├── benches/               # Benchmark source files
│   │   ├── arithmetic.rs      # Arithmetic operations benchmark
│   │   ├── fan_in.rs          # Fan-in pattern benchmark
│   │   ├── fan_out.rs         # Fan-out pattern benchmark
│   │   ├── fork_join.rs       # Fork-join pattern benchmark
│   │   ├── identity.rs        # Identity transformation benchmark
│   │   ├── join.rs            # Join operations benchmark
│   │   ├── reachability.rs    # Graph reachability benchmark
│   │   ├── upcase.rs          # String uppercase transformation benchmark
│   │   ├── reachability_edges.txt      # Test data for reachability
│   │   ├── reachability_reachable.txt  # Expected results for reachability
│   │   └── words_alpha.txt    # Word list test data
│   └── Cargo.toml             # Benchmark dependencies
├── Cargo.toml                  # Workspace configuration
├── rust-toolchain.toml         # Rust toolchain specification
├── rustfmt.toml                # Code formatting configuration
├── clippy.toml                 # Linting configuration
└── README.md                   # This file
```

## Benchmarks

### Arithmetic (`arithmetic.rs`)
Compares arithmetic operation pipelines across different implementations:
- Pipeline-based channel processing
- Raw vector operations (baseline)
- Timely dataflow implementation
- Hydro implementation

### Fan-In (`fan_in.rs`)
Benchmarks the fan-in dataflow pattern where multiple input streams merge into one output.

### Fan-Out (`fan_out.rs`)
Benchmarks the fan-out dataflow pattern where one input stream splits into multiple outputs.

### Fork-Join (`fork_join.rs`)
Tests the fork-join pattern where data is split, processed in parallel, and then joined.

### Identity (`identity.rs`)
Benchmarks identity transformations to measure framework overhead.

### Join (`join.rs`)
Compares join operation implementations across frameworks.

### Reachability (`reachability.rs`)
Graph reachability algorithm using both Timely and Differential Dataflow.
- Uses `reachability_edges.txt` for graph structure
- Validates against `reachability_reachable.txt`

### Upcase (`upcase.rs`)
String transformation benchmark (uppercase conversion) across implementations.

## Dependencies

### External Dataflow Frameworks
- **timely** (timely-master v0.13.0-dev.1): Timely Dataflow framework
- **differential-dataflow** (differential-dataflow-master v0.13.0-dev.1): Differential Dataflow framework

### Hydro Components
These benchmarks reference the main `bigweaver-agent-canary-hydro-zeta` repository:
- **dfir_rs**: Core Hydro dataflow implementation
- **sinktools**: Utility tools for benchmarking

### Other Dependencies
- **criterion**: Benchmarking framework with async support and HTML reports
- **tokio**: Async runtime
- **rand**: Random number generation for test data
- **futures**: Async utilities

## Setup

### Prerequisites
1. Rust toolchain 1.91.1 (automatically installed via `rust-toolchain.toml`)
2. Access to the main `bigweaver-agent-canary-hydro-zeta` repository (sibling directory)

### Installation

1. Clone this repository:
   ```bash
   git clone <repository-url> bigweaver-agent-canary-zeta-hydro-deps
   cd bigweaver-agent-canary-zeta-hydro-deps
   ```

2. Ensure the main Hydro repository is in a sibling directory:
   ```bash
   cd ..
   git clone <hydro-repository-url> bigweaver-agent-canary-hydro-zeta
   cd bigweaver-agent-canary-zeta-hydro-deps
   ```

3. Build the workspace:
   ```bash
   cargo build --workspace
   ```

## Running Benchmarks

### Run All Benchmarks
```bash
cargo bench --workspace
```

### Run Specific Benchmark
```bash
cargo bench --bench arithmetic
cargo bench --bench fan_in
cargo bench --bench fan_out
cargo bench --bench fork_join
cargo bench --bench identity
cargo bench --bench join
cargo bench --bench reachability
cargo bench --bench upcase
```

### Benchmark Output
Criterion generates detailed HTML reports in `target/criterion/`:
```bash
# View results in browser
open target/criterion/report/index.html
```

## Performance Comparison

These benchmarks allow comparison between:
1. **Raw implementations**: Baseline performance using standard Rust primitives
2. **Timely Dataflow**: Industry-standard dataflow framework
3. **Differential Dataflow**: Incremental computation framework
4. **Hydro**: Our native implementation

Results help validate that Hydro's performance is competitive with established frameworks.

## Development

### Code Formatting
```bash
cargo fmt --all
```

### Linting
```bash
cargo clippy --workspace --all-targets
```

### Adding New Benchmarks
1. Create a new `.rs` file in `benches/benches/`
2. Add benchmark configuration to `benches/Cargo.toml`:
   ```toml
   [[bench]]
   name = "your_benchmark"
   harness = false
   ```
3. Follow the existing benchmark structure using Criterion
4. Document the benchmark purpose and methodology

## Migration Notes

These benchmarks were migrated from `bigweaver-agent-canary-hydro-zeta` to:
- Reduce the main repository's dependency footprint
- Maintain clean separation between core functionality and external comparisons
- Improve build times for the main repository
- Allow independent versioning of external framework dependencies

### Related Changes
- See `BENCHMARK_REMOVAL_SUMMARY.md` in the main repository
- Companion PRs maintain synchronized changes

## Testing

### Verify Benchmarks Compile
```bash
cargo check --workspace --all-targets
```

### Run Quick Benchmark Test
```bash
cargo bench --bench arithmetic -- --quick
```

## Troubleshooting

### Missing Main Repository
**Error**: Cannot find `dfir_rs` or `sinktools`
**Solution**: Ensure `bigweaver-agent-canary-hydro-zeta` is in the parent directory:
```bash
cd /projects/sandbox
ls -la bigweaver-agent-canary-hydro-zeta/
```

### Dependency Version Conflicts
**Error**: Version conflicts with timely or differential-dataflow
**Solution**: Update version in `benches/Cargo.toml` to match available versions

### Benchmark Data Files Missing
**Error**: Cannot find `reachability_edges.txt` or other data files
**Solution**: Ensure all data files are present in `benches/benches/`

## Contributing

1. Follow the team's code organization standards
2. Maintain consistent benchmark methodology
3. Update documentation when adding benchmarks
4. Run all benchmarks before submitting PRs
5. Include performance comparison results in PR descriptions

## License

Apache-2.0

## Contact

Part of the BigWeaverServiceCanaryZetaIad project.