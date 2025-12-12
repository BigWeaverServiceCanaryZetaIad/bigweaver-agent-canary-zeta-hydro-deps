# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmark files and performance testing utilities that were moved from the main `bigweaver-agent-canary-hydro-zeta` repository. The benchmarks are separated to maintain clean dependency boundaries and avoid introducing unnecessary dependencies into the main codebase.

## Contents

This repository includes:

### Benchmark Files
- **`paxos_bench.rs`** - Benchmarking utilities for Paxos consensus protocol
- **`two_pc_bench.rs`** - Benchmarking utilities for Two-Phase Commit protocol

### Supporting Modules
- **`paxos.rs`** - Core Paxos implementation
- **`paxos_with_client.rs`** - Paxos implementation with client interface
- **`compartmentalized_paxos.rs`** - Compartmentalized Paxos variant
- **`two_pc.rs`** - Two-Phase Commit implementation
- **`kv_replica.rs`** - Key-value replica implementation used by benchmarks

### Examples
- **`paxos.rs`** - Example demonstrating Paxos benchmark execution
- **`compartmentalized_paxos.rs`** - Example demonstrating compartmentalized Paxos benchmark
- **`two_pc.rs`** - Example demonstrating Two-Phase Commit benchmark

## Prerequisites

This repository requires the main `bigweaver-agent-canary-hydro-zeta` repository to be present in the same parent directory, as it references dependencies from that repository.

```
parent-directory/
├── bigweaver-agent-canary-hydro-zeta/
└── bigweaver-agent-canary-zeta-hydro-deps/
```

## Running Benchmarks

### Building the Benchmarks

From the root of this repository:

```bash
cargo build --release
```

### Running Individual Benchmarks

#### Paxos Benchmark

Run the Paxos benchmark locally:

```bash
cargo run --release --example paxos
```

Run with GCP deployment:

```bash
cargo run --release --example paxos -- --gcp your-project-name
```

Generate visualization graphs:

```bash
cargo run --release --example paxos -- --graph-mermaid output.mmd
```

#### Compartmentalized Paxos Benchmark

Run locally:

```bash
cargo run --release --example compartmentalized_paxos
```

Run with GCP:

```bash
cargo run --release --example compartmentalized_paxos -- --gcp your-project-name
```

#### Two-Phase Commit Benchmark

Run locally:

```bash
cargo run --release --example two_pc
```

Run with GCP:

```bash
cargo run --release --example two_pc -- --gcp your-project-name
```

### Running Tests

Run all tests including benchmark tests:

```bash
cargo test
```

Run specific benchmark tests:

```bash
cargo test paxos_some_throughput
cargo test two_pc_some_throughput
```

## Performance Comparison

### Benchmark Configuration

The benchmarks can be configured with the following parameters:

- **`num_clients_per_node`** - Number of virtual clients per physical client node
- **`checkpoint_frequency`** - How many sequence numbers to commit before checkpointing (Paxos)
- **`f`** - Maximum number of faulty nodes (Paxos)
- **`num_replicas`** - Total number of replica nodes
- **`num_participants`** - Number of participant nodes (Two-PC)

### Measuring Throughput

All benchmarks output throughput measurements in the format:

```
Throughput: <lower> - <median> - <upper> requests/s
```

Where:
- **lower** - Lower bound of throughput
- **median** - Median throughput
- **upper** - Upper bound of throughput

### Comparing Against Main Repository

To compare performance between the main repository and this benchmarks repository:

1. Run benchmarks from the main repository (if they still exist there)
2. Run the same benchmarks from this repository
3. Compare the throughput measurements

Both should produce identical results, ensuring that the move did not affect benchmark accuracy.

## Integration with Main Repository

### Module References

The benchmarks reference modules from the main repository through Cargo path dependencies:

- `hydro_lang` - Core language constructs
- `hydro_std` - Standard library utilities (including `bench_client`)
- `hydro_deploy` - Deployment infrastructure
- `dfir_lang` - Dataflow IR for graph generation
- `hydro_build_utils` - Build utilities and snapshot testing

### Maintaining Compatibility

When updating the main repository, ensure:

1. API compatibility is maintained for modules used by benchmarks
2. Version numbers in `Cargo.toml` are updated if necessary
3. Benchmarks are re-run to verify continued functionality

## Development Guidelines

### Adding New Benchmarks

To add a new benchmark:

1. Create the benchmark module in `hydro_test/src/cluster/`
2. Add the module to `hydro_test/src/cluster/mod.rs`
3. Create an example in `hydro_test/examples/`
4. Add the example configuration to `Cargo.toml`
5. Update this README with documentation

### Code Organization

The directory structure mirrors the original structure in the main repository:

```
hydro_test/
├── src/
│   └── cluster/
│       ├── mod.rs
│       ├── paxos_bench.rs
│       ├── two_pc_bench.rs
│       ├── paxos.rs
│       ├── paxos_with_client.rs
│       ├── compartmentalized_paxos.rs
│       ├── two_pc.rs
│       ├── kv_replica.rs
│       └── kv_replica/
└── examples/
    ├── paxos.rs
    ├── compartmentalized_paxos.rs
    └── two_pc.rs
```

## Troubleshooting

### Build Errors

If you encounter build errors:

1. Verify the main repository is present at the correct path
2. Ensure both repositories are on compatible versions
3. Check that all path dependencies in `Cargo.toml` are correct
4. Run `cargo clean` and rebuild

### Runtime Errors

If benchmarks fail at runtime:

1. Check that required ports are available (for localhost deployments)
2. Verify GCP credentials are configured (for GCP deployments)
3. Ensure sufficient system resources (memory, network)
4. Review logs for specific error messages

## Contributing

When contributing to this repository:

1. Follow the existing code style and patterns
2. Add tests for new benchmarks
3. Update documentation as needed
4. Ensure benchmarks run successfully before submitting changes

## Related Documentation

- Main repository: `bigweaver-agent-canary-hydro-zeta`
- Hydro language documentation: See main repository docs
- Deployment guide: See `hydro_deploy` documentation in main repository