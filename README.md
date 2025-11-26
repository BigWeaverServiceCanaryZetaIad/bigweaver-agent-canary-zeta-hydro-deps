# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks for Hydro with dependencies on timely-dataflow and differential-dataflow. These benchmarks are maintained separately from the main Hydro repository to keep the main repository free of these heavy dependencies.

## Purpose

This repository serves as a dedicated space for:
- Comparative benchmarks between Hydro (dfir_rs) and timely-dataflow
- Comparative benchmarks between Hydro and differential-dataflow
- Performance comparison testing across different dataflow systems
- Maintaining benchmark infrastructure that requires timely/differential-dataflow dependencies

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── benches/                      # Benchmark workspace
│   ├── benches/                  # Benchmark source files
│   │   ├── arithmetic.rs         # Arithmetic operations benchmark
│   │   ├── fan_in.rs            # Fan-in dataflow pattern benchmark
│   │   ├── fan_out.rs           # Fan-out dataflow pattern benchmark
│   │   ├── fork_join.rs         # Fork-join pattern benchmark
│   │   ├── futures.rs           # Futures and async operations benchmark
│   │   ├── identity.rs          # Identity operation benchmark
│   │   ├── join.rs              # Hash join implementation benchmark
│   │   ├── micro_ops.rs         # Micro-operations performance benchmark
│   │   ├── reachability.rs      # Graph reachability algorithm benchmark
│   │   ├── symmetric_hash_join.rs # Symmetric hash join benchmark
│   │   ├── upcase.rs            # String uppercase transformation benchmark
│   │   ├── words_diamond.rs     # Word processing diamond pattern benchmark
│   │   ├── reachability_edges.txt        # Graph data for reachability
│   │   ├── reachability_reachable.txt    # Expected results for reachability
│   │   └── words_alpha.txt      # Word list for word processing benchmarks
│   ├── build.rs                 # Build script
│   └── Cargo.toml              # Benchmark package configuration
├── Cargo.toml                   # Workspace configuration
└── README.md                    # This file
```

## Dependencies

This repository includes the following key dependencies:

- **timely-dataflow** (`timely-master` v0.13.0-dev.1) - For timely dataflow benchmarks
- **differential-dataflow** (`differential-dataflow-master` v0.13.0-dev.1) - For differential dataflow benchmarks
- **dfir_rs** - Referenced from `bigweaver-agent-canary-hydro-zeta` repository
- **sinktools** - Referenced from `bigweaver-agent-canary-hydro-zeta` repository
- **criterion** - For benchmark harness with async support

## Running Benchmarks

### Prerequisites

This repository requires the companion repository `bigweaver-agent-canary-hydro-zeta` to be present at `../bigweaver-agent-canary-hydro-zeta` relative to this repository for the dfir_rs and sinktools dependencies.

### Running All Benchmarks

```bash
cargo bench -p benches
```

### Running Specific Benchmarks

#### Timely Benchmarks
```bash
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench fan_in
cargo bench -p benches --bench fan_out
cargo bench -p benches --bench fork_join
cargo bench -p benches --bench identity
cargo bench -p benches --bench join
cargo bench -p benches --bench upcase
```

#### Differential-Dataflow Benchmarks
```bash
cargo bench -p benches --bench reachability
```

#### Hydro-Specific Benchmarks
```bash
cargo bench -p benches --bench micro_ops
cargo bench -p benches --bench futures
cargo bench -p benches --bench symmetric_hash_join
cargo bench -p benches --bench words_diamond
```

### Running with Filters

Filter dfir_rs benchmarks only:
```bash
cargo bench -p benches -- dfir
```

Filter timely benchmarks only:
```bash
cargo bench -p benches -- timely
```

Filter differential benchmarks only:
```bash
cargo bench -p benches -- differential
```

## Benchmark Descriptions

### Arithmetic Operations (`arithmetic.rs`)
Compares arithmetic operations performance between dfir_rs and timely-dataflow implementations.

### Fan-In Pattern (`fan_in.rs`)
Tests the performance of fan-in dataflow patterns where multiple input streams converge into a single output stream.

### Fan-Out Pattern (`fan_out.rs`)
Tests the performance of fan-out dataflow patterns where a single input stream is distributed to multiple output streams.

### Fork-Join Pattern (`fork_join.rs`)
Benchmarks fork-join patterns where computation is split into parallel branches and then rejoined.

### Futures (`futures.rs`)
Tests async/await and futures-based operations in Hydro's dataflow system.

### Identity Operation (`identity.rs`)
Simple pass-through operation benchmark to measure minimal overhead.

### Join Operation (`join.rs`)
Hash join implementation comparing dfir_rs with timely-dataflow.

### Micro Operations (`micro_ops.rs`)
Fine-grained micro-benchmarks of individual dataflow operations.

### Reachability (`reachability.rs`)
Graph reachability algorithm comparing dfir_rs, timely, and differential-dataflow implementations. Uses graph data from `reachability_edges.txt`.

### Symmetric Hash Join (`symmetric_hash_join.rs`)
Benchmark for symmetric hash join operations in streaming contexts.

### Upcase Transformation (`upcase.rs`)
String transformation benchmark (uppercase conversion) comparing different implementations.

### Words Diamond (`words_diamond.rs`)
Diamond-shaped dataflow pattern for word processing. Uses word list from `words_alpha.txt` (source: https://github.com/dwyl/english-words).

## Performance Comparison

These benchmarks enable:

1. **Cross-System Comparison**: Compare Hydro (dfir_rs) performance against timely-dataflow and differential-dataflow
2. **Performance Regression Detection**: Track performance over time for Hydro implementations
3. **Optimization Validation**: Verify that optimizations improve performance relative to baseline systems
4. **Pattern Analysis**: Understand which dataflow patterns perform better in different systems

## Integration with Main Repository

This repository is designed to work alongside `bigweaver-agent-canary-hydro-zeta`:

- Benchmarks reference dfir_rs and sinktools from the main repository via relative paths
- Changes to core Hydro functionality should be reflected in benchmark results here
- This separation keeps the main repository's dependency tree clean while preserving comparative benchmark capability

## Development Guidelines

### Adding New Benchmarks

1. Create a new `.rs` file in `benches/benches/`
2. Add a `[[bench]]` section in `benches/Cargo.toml`
3. Follow the existing pattern of implementing multiple implementations (dfir, timely, differential as applicable)
4. Use Criterion for the benchmark harness
5. Update this README with a description of the new benchmark

### Updating Dependencies

When updating timely or differential-dataflow versions:
1. Update version numbers in `benches/Cargo.toml`
2. Test all benchmarks to ensure compatibility
3. Document any API changes that affect benchmarks

### Cross-Repository Changes

When making changes that span both repositories:
1. Create companion PRs in both repositories
2. Link the PRs in their descriptions
3. Ensure both PRs are reviewed and merged together
4. Test benchmarks after merging to verify integration

## Building and Testing

### Build the benchmark package
```bash
cargo build -p benches
```

### Check for compilation errors
```bash
cargo check -p benches
```

### Run clippy for code quality
```bash
cargo clippy -p benches
```

### Format code
```bash
cargo fmt -p benches
```

## Troubleshooting

### Missing dfir_rs or sinktools

**Error**: `package not found`

**Solution**: Ensure `bigweaver-agent-canary-hydro-zeta` repository is cloned at `../bigweaver-agent-canary-hydro-zeta` relative to this repository.

### Timely/Differential Version Conflicts

**Error**: Version resolution errors with timely or differential-dataflow

**Solution**: Both packages use `-master` variants. Ensure you have the latest versions specified in Cargo.toml.

### Benchmark Data Files Missing

**Error**: Benchmarks fail to find `.txt` data files

**Solution**: Ensure all data files (`words_alpha.txt`, `reachability_edges.txt`, `reachability_reachable.txt`) are present in `benches/benches/`.

## Related Repositories

- [bigweaver-agent-canary-hydro-zeta](https://github.com/hydro-project/hydro) - Main Hydro repository
- [timely-dataflow](https://github.com/TimelyDataflow/timely-dataflow) - Timely dataflow framework
- [differential-dataflow](https://github.com/TimelyDataflow/differential-dataflow) - Differential dataflow framework

## License

Apache-2.0

## References

- Word list source: https://github.com/dwyl/english-words
- Benchmark methodology follows Criterion.rs best practices
- Performance comparison strategies based on timely-dataflow benchmarking approaches