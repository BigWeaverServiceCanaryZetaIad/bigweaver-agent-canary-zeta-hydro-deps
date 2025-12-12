# bigweaver-agent-canary-zeta-hydro-deps

This repository contains performance comparison benchmarks and external dependency tests for the Hydro project. By separating these components from the main repository, we maintain a clean dependency structure in the core codebase while preserving the ability to run comprehensive performance comparisons.

## Repository Contents

### Benchmarks (`benches/`)

Performance comparison benchmarks that test Hydro/DFIR against `timely-dataflow` and `differential-dataflow`. These benchmarks include:

- **arithmetic** - Basic arithmetic operations
- **fan_in** - Multiple inputs converging to a single operator
- **fan_out** - Single input distributed to multiple operators
- **fork_join** - Fork-join pattern performance
- **identity** - Baseline performance for data passthrough
- **join** - Join operation performance
- **reachability** - Graph reachability algorithms
- **upcase** - String transformation operations

See [`benches/README.md`](benches/README.md) for detailed documentation on running and contributing to benchmarks.

## Purpose

This repository serves to:

1. **Isolate External Dependencies**: Keep `timely-dataflow` and `differential-dataflow` dependencies out of the main Hydro repository
2. **Enable Performance Comparisons**: Maintain the ability to benchmark Hydro against established dataflow frameworks
3. **Preserve Functionality**: Ensure performance comparison capabilities are retained even as benchmarks are separated
4. **Clean Architecture**: Support the team's preference for clean dependency management and modular code organization

## Quick Start

### Running Benchmarks

```bash
# Clone this repository
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps

# Run all benchmarks
cargo bench

# Run a specific benchmark
cargo bench --bench reachability

# View results
open target/criterion/report/index.html
```

## Cross-Repository Workflow

For complete performance testing:

1. **Main Repository** ([bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)): Contains Hydro-native benchmarks without external dependencies
2. **This Repository** (bigweaver-agent-canary-zeta-hydro-deps): Contains comparison benchmarks with timely and differential-dataflow

### Comparing Performance

```bash
# Run Hydro-native benchmarks
cd bigweaver-agent-canary-hydro-zeta
cargo bench -p benches

# Run comparison benchmarks
cd ../bigweaver-agent-canary-zeta-hydro-deps
cargo bench

# Compare results using Criterion's HTML reports
```

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── benches/              # Performance comparison benchmarks
│   ├── benches/         # Individual benchmark implementations
│   ├── Cargo.toml       # Dependencies including timely & differential
│   ├── README.md        # Benchmark documentation
│   └── build.rs         # Build configuration
├── Cargo.toml           # Workspace configuration
└── README.md            # This file
```

## Contributing

When contributing to this repository:

1. Follow the patterns established in existing benchmarks
2. Ensure benchmarks are fair and comparable
3. Document any implementation differences or assumptions
4. Update relevant README files
5. Test that benchmarks compile and run successfully

## Related Resources

- **Main Hydro Repository**: [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)
- **Timely Dataflow**: [https://github.com/TimelyDataflow/timely-dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- **Differential Dataflow**: [https://github.com/TimelyDataflow/differential-dataflow](https://github.com/TimelyDataflow/differential-dataflow)
- **Criterion Benchmarking**: [https://github.com/bheisler/criterion.rs](https://github.com/bheisler/criterion.rs)

## License

Apache-2.0